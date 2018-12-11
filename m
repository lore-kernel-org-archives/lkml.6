Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B07AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8732082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjJmRXUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8732082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeLKKoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:44:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46393 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKKoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:44:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so10362190lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0G90vwj8/M2LQveuNJTC8/U5GntaUn0knA/ecTeIaE=;
        b=RjJmRXUU4hamnaLJWRoQiOn+nRhPotTZ9eFXCIZa3EK0i357llUZBnF6zFrKzvm04D
         ntzEEUr2bncefwcXRMwqYcWgywl1ozCPJfQ+XMuSey/xl1sJjAmbVXztg/9q1baeHUnW
         2VOzM2fL8j665C4H47x9ciADMF4nFKfL3KP2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0G90vwj8/M2LQveuNJTC8/U5GntaUn0knA/ecTeIaE=;
        b=pcVZBuspQrb+/85PmVLboCt/M9SNfmAItM1b5mupO6kIyOxGCD+pqNhHSEfilWQusB
         YozWWwUmlKAFz/6iXRc3nBtyOT5y6tGHYUfYkqYHvJY95jJJV9yx6CAT/hUcFbU7qSeq
         Q6QsHMtRF6xvYgE98m5Ki9H4BOxd6KmbGphCEMJ+CkSCZ+KLLHpsFI/E+ESgC82Tr5Py
         dahgmmPzNX9/GhgbMmBkgJyas4TUA6ed341+M49GbJT5hQ4C60j6Aycodpf+fIfbMxWr
         DQ+4EXdAYDn5A9mrPhv83PGZcJCIECLf5TnplkZAiVGPIWcy3C3VxlyXi4zN6VtMeuDW
         Z1EA==
X-Gm-Message-State: AA+aEWbctyWTya2mvoyHAIpuooSoI9fU4bKFFBC741svoqfizZ4vxtNo
        kIe076nTiRAEIws1Lu79aoIwzPZ8UGzY87AyGF1eVA==
X-Google-Smtp-Source: AFSGD/UqW65rfQAPCrdE8ppZ6uMm4xnPWyXgJ8tTJPnhrMQv3eXa8514icTBWFvLi9oNa6lbcqTeyTl7si8fPsKFB3E=
X-Received: by 2002:a19:4849:: with SMTP id v70mr8806384lfa.62.1544525060909;
 Tue, 11 Dec 2018 02:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20181210215856.2238253-1-arnd@arndb.de> <20181210215856.2238253-4-arnd@arndb.de>
 <CAPDyKFogJv0OeaqdXBUyVAtmFqNTxDOJU_EMgMO7tFYdoQMY4A@mail.gmail.com>
In-Reply-To: <CAPDyKFogJv0OeaqdXBUyVAtmFqNTxDOJU_EMgMO7tFYdoQMY4A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 11 Dec 2018 11:44:07 +0100
Message-ID: <CACRpkdb_JnC13q2qMdFQ93MyDCSTmpP9L6_g8EK3m=6LZ4be4w@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: pxa: avoid section mismatch warning
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Igor Grinberg <grinberg@compulab.co.il>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:40 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Mon, 10 Dec 2018 at 23:00, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > WARNING: vmlinux.o(.text+0x19f90): Section mismatch in reference from the function littleton_init_lcd() to the function .init.text:pxa_set_fb_info()
> > The function littleton_init_lcd() references
> > the function __init pxa_set_fb_info().
> > This is often because littleton_init_lcd lacks a __init
> > annotation or the annotation of pxa_set_fb_info is wrong.
> >
> > WARNING: vmlinux.o(.text+0xf824): Section mismatch in reference from the function zeus_register_ohci() to the function .init.text:pxa_set_ohci_info()
> > The function zeus_register_ohci() references
> > the function __init pxa_set_ohci_info().
> > This is often because zeus_register_ohci lacks a __init
> > annotation or the annotation of pxa_set_ohci_info is wrong.
> >
> > WARNING: vmlinux.o(.text+0xf95c): Section mismatch in reference from the function cm_x300_init_u2d() to the function .init.text:pxa3xx_set_u2d_info()
> > The function cm_x300_init_u2d() references
> > the function __init pxa3xx_set_u2d_info().
> > This is often because cm_x300_init_u2d lacks a __init
> > annotation or the annotation of pxa3xx_set_u2d_info is wrong.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I have queued a bunch of pxa changes via my mmc tree for gpio
> descriptor conversions, by Linus Walleij.
>
> Are those causing this problem? Should I queue this one via mmc tree as well?

Nopes just correlation without causation...

I also made a bunch of patches to PXA through the regulator tree,
those are not related either.

It *seems* they touch so different code lines that it shouldn't
be a problem to merge orthogonally in ARM SoC.

Yours,
Linus Walleij
