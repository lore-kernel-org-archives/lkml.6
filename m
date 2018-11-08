Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4948ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C8E20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C8E20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeKHX43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:56:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37180 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHX42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:56:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id 131so26682154qkd.4;
        Thu, 08 Nov 2018 06:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3aqMzW0nayNxNAIXEpud7dXkuHdaOiq0ACUJjY1Pvw=;
        b=CUT6rPRYpJS7UnGC4Ef+3N+UACOMgy5pqZ/z1FY7U1zYw8EgLUR1sGcVodR0xBQr0T
         YXXHpVH+w1UXetKhha7vLAD3jics00jGYXXnjjICn5tXRAZsoxq4v+QUm2UQuVMREW1n
         frtj3TJp2MIw42YY7Nq/L2vaCOq6LbdSMQp58aTx3s/6GmvJWW42P/J30YRBA2Ajx5wL
         iY7QODJRhd78x/VPYpTOAdSXicqGFtlOqbM5fWD0GNPSLIxBzdCjd1H3L4Ll7VMgiQzK
         dXw8WHLN2J5Mh7XGUMMFabdfYhwjr/LyeMrPPkE+sUtgM1REDG4+qwUhZ39SO6pT100R
         1crg==
X-Gm-Message-State: AGRZ1gIYBVkDiKiW+VBVdRNDyQXubxyqbgsgI+qzs3TNCjBzJRxeVH1D
        tBMl01QJOrczph/RnGCMCwFvZKjLbo2T/thf6NM=
X-Google-Smtp-Source: AJdET5ff6AeguPLMwYbrlxPe6CITr3Ex6KT/lncV5bLzq+5gUfqb1nvvW72kzazB4rIsmtFysAl6oKeHyJGROHEkR6k=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr4391822qtr.319.1541686845212;
 Thu, 08 Nov 2018 06:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com> <20181104155501.14767-7-TheSven73@googlemail.com>
In-Reply-To: <20181104155501.14767-7-TheSven73@googlemail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Nov 2018 15:20:29 +0100
Message-ID: <CAK8P3a3apbxNa2FpADvdLCe-GzV+2xv2kO1_tosOZrUpY6xWtA@mail.gmail.com>
Subject: Re: [PATCH anybus v3 6/6] misc: support HMS Profinet IRT industrial controller
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>, noralf@tronnes.org,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 4:55 PM <thesven73@gmail.com> wrote:

> +
> +struct msgEthConfig {
> +       u32 ip_addr, subnet_msk, gateway_addr;
> +} __packed;

The __packed attribute makes it slower to access but doesn't
change the layout, so better drop it.

> +struct msgMacAddr {
> +       u8 addr[6];
> +} __packed;
> +
> +struct msgStr {
> +       char    s[128];
> +} __packed;
> +
> +struct msgShortStr {
> +       char    s[64];
> +} __packed;
> +
> +struct msgHicp {
> +       char    enable;
> +} __packed;

The __packed on these ones has no effect, and can just be dropped
for readability.

> +static ssize_t mac_addr_show(struct device *dev,
> +                               struct device_attribute *attr,
> +                               char *buf)
> +{
> +       struct profi_priv *priv = dev_get_drvdata(dev);
> +       struct msgMacAddr response;
> +       int ret;
> +
> +       ret = anybuss_recv_msg(priv->client, 0x0010, &response,
> +                                               sizeof(response));
> +       if (ret)
> +               return ret;
> +       return snprintf(buf, PAGE_SIZE, "%02X:%02X:%02X:%02X:%02X:%02X\n",
> +               response.addr[0], response.addr[1],
> +               response.addr[2], response.addr[3],
> +               response.addr[4], response.addr[5]);
> +}
> +
> +static DEVICE_ATTR_RO(mac_addr);

> +static ssize_t ip_addr_show(struct device *dev,
> +                               struct device_attribute *attr,
> +                               char *buf)
> +{

I don't understand much about field bus, but I have a general feeling
that if you configure a mac address and IP address, this should
be connect ed to the network layer in some form, possibly being
exposed as a network device and manipulated using netlink
instead of sysfs or ioctl.

Can you explain how this fits together and why you got the the
sysfs interface?

> +struct ProfinetConfig {

The CamelCase naming seems odd here.

> +       struct {
> +               /* addresses IN NETWORK ORDER! */
> +               __u32 ip_addr;
> +               __u32 subnet_msk;
> +               __u32 gateway_addr;
> +               __u8  is_valid:1;
> +       } eth;

This is where packing might make sense, since you have
padding fields in a user space structure ;-) . It would be better
to just avoid the implicit padding though and name all fields.

Overall, this structure feels too complex for an ioctl interface,
with the nested structures. If we end up keeping that
ioctl, maybe at least make it a flat structure without padding,
or alternatively make it a set of separate ioctls.

      Arnd
