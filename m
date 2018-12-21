Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318D6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16F021906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWPzdsjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbeLUJ5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:57:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40647 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388930AbeLUJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:57:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so4182212lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7YKGAkjxUIo6TZyT8S5jO0gVM/z67R7qDqWLXKFnOM=;
        b=fWPzdsjz/d2mgU4kuLHefDE53G7AfoUyzM5X+ZX2hzCzDVzKtEffKJI4rCHcCO0R0n
         UdadU6wtqP5VWw/hPnLTWzJg/BIG5Q6IFEbmii9XBaxzaYYN46C0lzVSPYdwtTmR7WKF
         He4P136CL8WTKoj+K3/Z4FEe6oYgpqZL1FWII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7YKGAkjxUIo6TZyT8S5jO0gVM/z67R7qDqWLXKFnOM=;
        b=e3C7TDF3qwNWb4akcLMfq7foiszYfPpsKtPsAMnDywiCAPFK08Q6K+FxnPvjrHRiES
         0AhQfsK+ncpOl9fxyjXnsqyCViKPmcSI69RnYfAqctf33Mfwyei0IykeiX/ZMo/d+Dh5
         b8545kAAxW5KpUHcbREXKjmw8AH+VjD4FBvzPlbMM+sjPzVpiU52XpRtSn726EAzB0ld
         8NHeLIFotJ7+mDh3tCnqJAgD+f8dhOVRG0LXPK/ZPXGNEg6AYLax899SCGXeB/3E4oxL
         CM2CM9zfqY3354x9bqm0s6/2QFuEToZXjbgjWJeMdSTrO42n33jOvrBRzuKZExHXc8M0
         C5eQ==
X-Gm-Message-State: AJcUukeOk1GlDfJUgzSjB8b8KH7LbabJhR47WAXNAJC5fmajy+FcFYHe
        abxrbuK/pav61cpJpTi1uXbdSRfTwfqNxLabghl8Ow==
X-Google-Smtp-Source: ALg8bN6qFxjhl1txPozLGekSIBi4HLDvdAl89Hoi49dt0XAW3v0tSxgBaxLpCSNI6/wYOKJbc29FhIE3f88TY4l28n0=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr1157048ljc.66.1545386235773;
 Fri, 21 Dec 2018 01:57:15 -0800 (PST)
MIME-Version: 1.0
References: <1544615784-29331-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544615784-29331-3-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544615784-29331-3-git-send-email-andrei.stefanescu@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 10:57:03 +0100
Message-ID: <CACRpkdaeyHOhGDR4HAJR6sSVFA-fGXNwY63rzicER-GFoBQtPA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: add driver for SAMA5D2 PIOBU pins
To:     Andrei.Stefanescu@microchip.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Cristian.Birsan@microchip.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:57 PM <Andrei.Stefanescu@microchip.com> wrote:

> PIOBU pins do not lose their voltage during Backup/Self-refresh.
> This patch adds a simple GPIO controller for them and a
> maintainer for the driver.
>
> This driver adds support for using the pins as GPIO
> offering the possibility to read/set the voltage.
>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>

Patch applied for v4.21, sorry for taking so long to reply!

Good work on this driver Andrei, it looks really nice now.

Yours,
Linus Walleij
