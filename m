Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6915C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C8320869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfIbHpk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C8320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbeKGALk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:11:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39420 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388680AbeKGALj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:11:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id 192-v6so10135363oii.6;
        Tue, 06 Nov 2018 06:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/UUpQewR+dDq7MlNMnOVquSBzqTdHQKb55EkcRSZOc=;
        b=qfIbHpk92IvYlxrhFQglKbtNy98DuSzcdPgqEn+zADvbECsTZzjmFyVqAwnregnVoW
         SCuH+Y3SUSRCd/pOTXRwx+7fgEuu11YgQKLvUTVP28mwHdljDHySHX3/WQDbSW0vKnne
         NereEN8hAqJtYuV1OkoQ2+7e369uQ3g1v66v8CN5bwnPX3FMcuXVdtrIEcS56/LVS1z1
         25zSBreJbJiPfDrBUY59Ljd8SQJzhE9ehY4kP8BCJcbJWk84zXXJEAY+Ry9G3vFTV8K6
         Q99jgnaFHNYGrScKDDxNd/kMb4A9URSKWSRPMFptju/uuEADrZGxzPySgu6+hJXt3VrO
         8YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/UUpQewR+dDq7MlNMnOVquSBzqTdHQKb55EkcRSZOc=;
        b=Tc9DsDCKlAvnTmatSe/zC8Hw1NE/zm2Sy+TQORwYichQwfKpSF2Gxq9U4vXRl+oxEn
         rSr0EkRZW+jXaA1g5VIGaubdwih96UkDg9C5JSntl/paeO1F6bbI6SwR45WjVLTvvnMt
         3+c5FxjzCDFr01a71ks+6hHb/j+ogZjWlOJVhUKYDT/GJkLsaONS1CmqkfFfrlomVjR2
         UtYOQcaelHYb/0cWgHrxDuXWtx0UmBLpL83xBIrmG4Qi2cUp1vCDofJ848g09g2lFQW9
         +BAGDx1Bhl8tmvXZ6XWPYOyW4/izHAvllxdcf2NnCApZTQYTtOGt35QNRdj3h5YoIl0B
         V/fg==
X-Gm-Message-State: AGRZ1gJCu0p40yHeWHNC4RToqscyFPXvvCUwiY6BnporPcYjbexAF+Yb
        8aDq4+8WcrlXemDH/o8O7g9pDMYe2s4esZny2eA=
X-Google-Smtp-Source: AJdET5dMNAE0BnlV9dl2nvIVpH1Dyjo5aNCs/PE7ZQsCmr4cn2LAgC7I7hc2xpax30WADNSmkBZ2naZy8cyfYVvTUG8=
X-Received: by 2002:aca:4e55:: with SMTP id c82-v6mr14772142oib.254.1541515566644;
 Tue, 06 Nov 2018 06:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-2-TheSven73@googlemail.com> <20181105212049.GA320@bogus>
 <CAGngYiUZTm-r0KJ07tKsPmgKCUWcqAOx2S82iLPRjkcDiw0R3g@mail.gmail.com> <CAL_JsqLgz9Z3J0x+QFU6jHOoHn6A1KASc+HbVLnW1=ow0RHv6w@mail.gmail.com>
In-Reply-To: <CAL_JsqLgz9Z3J0x+QFU6jHOoHn6A1KASc+HbVLnW1=ow0RHv6w@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 6 Nov 2018 09:45:55 -0500
Message-ID: <CAGngYiXczK6dsfyDGxe1ym-vQQfH5XS0jeEkuWW_og23JmTAZg@mail.gmail.com>
Subject: Re: [PATCH anybus v3 1/6] misc: support the Arcx anybus bridge
To:     Rob Herring <robh@kernel.org>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 8:58 AM Rob Herring <robh@kernel.org> wrote:

> It doesn't really sound like the host should be in DT. The bridge
> should register itself as an anybus provider and that should in turn
> enable the anybus host protocol.

Very good point. Just to make sure we're on the same page, could you point
me to a relevant example where something registers as a provider?

v1 of this patch did not have the host in DT. The host just required platform
data with a regmap and a reset (the interrupt was passed via resources):

struct anybuss_host_pdata {
    struct regmap *regmap;
    void (*reset)(struct device *dev, bool reset);
};

But there were problems with this approach.

The review feedback told me that my self-rolled reset callback should really
be a reset controller. I looked for ways to pass a handle to a reset controller
via platform data. This has recently been introduced via:

reset_controller_add_lookup()

This binds a client device to a reset controller, without using the devicetree,
so the device can grab its controller via (devm_)reset_control_get*. Great!
But... to make the binding, you have to specify the full device names of the
controllers and client devices. See this example from psc-da850.c:

static struct reset_control_lookup da850_psc0_reset_lookup_table[] = {
    RESET_LOOKUP("da850-psc0", 15, "davinci-rproc.0", NULL),
};

I very quickly found myself in ida_simple_get() hell, trying to second-guess
what the devices I was creating, would be called !

So instead I put the host in DT, then I could easily connect the reset
controller. This also greatly simplified the bridge driver, a lot of boilerplate
would simply disappear.

Suggestions are very welcome :)

Sven
