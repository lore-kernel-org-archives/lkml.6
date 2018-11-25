Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB0DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 12:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A4C2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 12:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqgJ4WeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A4C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeKYXlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 18:41:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38065 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeKYXlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 18:41:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id p86so11550927lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 04:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgKdsQBuKUgq5aJ4Gauhtd25HWjQ3W/6tZZcT1TNouM=;
        b=KqgJ4WeUzCdietKa1HLTBnwqrtvgHQYzu5YNbX2c8F1oSVaOMiho0kXPYfd5ZZ/dOd
         9dQUbkau+6F8lS2HCBJyqVJ9k5clnJGEQGEmMGC+Y1LES9GvkQYaJsek6/t+S6+Xb+7e
         RGfFuOW2cb6BAYpnX36+rW5xNeho84lgJnWbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgKdsQBuKUgq5aJ4Gauhtd25HWjQ3W/6tZZcT1TNouM=;
        b=cF38VWgoPsfffyzcOkbTH1TouXzL6OuboxiGd6sYxuy6uFFwmM7n70VQ9mEZyP91/f
         5Iy9fyO+DUFlhYd2LPAEYIemq4dZ/ooCiZJbt89YdIRw9WOZcWzAtECrQS27QS7TovCq
         KtIrqbIZn00sbMYo3NhA8fbyruUHV80ploLwOf3dS+KEfjd9RkL+GaL9B2oLUgmZO8h3
         Fn0Ft5sA7aujqgHB1qM79Wh/J1ScSS1ubZmIdE6BJmDlnTqO6qLsF4thfi9/vN5i1vnB
         VxdicRkYJgfHsAnOPGzkKQvQuWLbkyc0MJwOEFoAIfQs7hJ/x7LAI3H6dvrxWq4qtJh6
         fZAg==
X-Gm-Message-State: AGRZ1gI2qzPHgkH72e0Bf6EMroDz9xgeawwCsiUnQ+lq7ZdYG1ZcM7SK
        HLDEn7CYgHldYGHgFtU1uuyVN/CJaXagKaSTn1hGBg==
X-Google-Smtp-Source: AJdET5fmTiDIZprkDHy8Zec+rjjB4ADDeodBOpglW0ANT93mLh0pWboPlYhy9b/LRWLchCdkimfb/l1JzGeEp5dO4Y4=
X-Received: by 2002:a19:5154:: with SMTP id f81mr14406017lfb.96.1543150205471;
 Sun, 25 Nov 2018 04:50:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543131714.git.mesihkilinc@gmail.com> <233099b6384217ddaf5147e54859359acd56be0e.1543131714.git.mesihkilinc@gmail.com>
In-Reply-To: <233099b6384217ddaf5147e54859359acd56be0e.1543131714.git.mesihkilinc@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 25 Nov 2018 13:49:53 +0100
Message-ID: <CACRpkdb6dbGMdLznm8F_jV2zj9dJfiwTK5w-8YShxwiPALE3+g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 11/17] pinctrl: sunxi: add support for suniv
 F1C100s (newer F-series SoCs)
To:     mesihkilinc@gmail.com
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>, julian.calaby@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 8:44 AM Mesih Kilinc <mesihkilinc@gmail.com> wrote:

> The suniv F1C100s chip (several new F-series SoCs) of Allwinner has a
> pin
> controller like other SoCs from Allwinner.
>
> Add support for it.
>
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Patch applied to the pin control tree for v4.21.

Yours,
Linus Walleij
