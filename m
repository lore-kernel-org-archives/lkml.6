Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70C0ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD4F20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD4F20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeKIADT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:03:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47020 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKIADS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:03:18 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so26641590qkf.13;
        Thu, 08 Nov 2018 06:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyjuq/8U2SGKpRpAtM8Miu0qn8XN8Az5x6n7rc+yPzw=;
        b=gNvLb9ZUpcYV+qbvoe9pWkGUKsScAeC/6nMjU0ghavPzy/RjeN30aK7KenWbnpS9VL
         pdeGN1vvcvtZkfvV1XKc138AXpLniYbIxLwn+rmXSUBZAZ68oa2Io4Zttdj6ovlcs0gY
         dVyb4uJs4RLwMiOuixphLVwDzyT//BoqSPdOi79Dy/L11Ha6kh7vMeF1r7le6xXEX3kn
         BhlFqk1vQ+CKhie4+yL/F+cbffnY8us/dJvuhyOcCwppURoOwMCYTkVIZ1odNl2uVqJn
         v3nIvpyFOlgb/gBGxmGfr8xGWTlnbjYl8suAk6WpykSJ3VIYYk/3C9MMnsh4/P+f8Ly4
         raWA==
X-Gm-Message-State: AGRZ1gIi29xEaG8+OB5GqCvQN0pywMRphQ99HLVjOoIaQg4Cd45/06lm
        xFcByDWtEBMgJHqSk/Pfu8952dlOp2x6Gdc1g3M=
X-Google-Smtp-Source: AJdET5dAXkRmKqAa4ruQA/G11T037lqFuheZd26Z20RQpIhDN2LSFwukW0iRqXI4vLftdJEMn98IQ8jUVeol3YaNrKY=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr4417085qtl.343.1541687254085;
 Thu, 08 Nov 2018 06:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-6-TheSven73@googlemail.com> <CAK8P3a1ZUaxJzfzYoqAK+_ZBazHzF6nG1V2aiZSoiQr6nDhiSQ@mail.gmail.com>
 <CAGngYiW5=oc486wq15yLbRLvO243PNALmouTDEh7QpO6GLO9Mg@mail.gmail.com>
In-Reply-To: <CAGngYiW5=oc486wq15yLbRLvO243PNALmouTDEh7QpO6GLO9Mg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Nov 2018 15:27:17 +0100
Message-ID: <CAK8P3a3QvQrOKeUs-9sFjDdzfesK27VP6fH7KVUjMW-gkmq-=Q@mail.gmail.com>
Subject: Re: [PATCH anybus v3 5/6] dt-bindings: anybuss-host: document
 devicetree binding
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

On Thu, Nov 8, 2018 at 3:21 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Hi Arnd, thank you for the review and the feedback !
>
> >
> > To allow describing connected devices, I think we need a #address-cells
> > and #size-cells property here, with fixed values.
>
> I'm not sure I understand. Connected devices aren't described in the
> devicetree. The anybus specification defines an id register, which is
> then used to load the client driver automatically, in the manner of
> pci/usb.
>
> In case I have misinterpreted your feedback, could you clarify a bit?

This is related to my reply on another patch of this series. I think it's
likely that you need to be able to describe anybus devices in DT
for additional properties in some cases, even if the common case
doesn't need it.

We do the same thing on PCI and USB, where normally everything
is probed through hardware access, but a device driver can look
at dev->of_node to see if that contains any further properties.

       Arnd
