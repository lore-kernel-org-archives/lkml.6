Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DB1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652CD21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZ8K3LSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390277AbfBOPfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:35:22 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:40047 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390114AbfBOPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:35:19 -0500
Received: by mail-it1-f169.google.com with SMTP id i2so24215333ite.5;
        Fri, 15 Feb 2019 07:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9OMXfTecjnMTcRmrRQJcFu8mpWNxQK6DFzlJ2wdDnqc=;
        b=vZ8K3LSUUzkuGEiplfz8mEDElieQwcpFMi49Rokq5+o1xTGtVrYJfpO34miWQ+Qk9n
         9R9K+D9zvd359dlW3pU1wth2U41b2FuMA9rt5MGSc+t85JeJJdwGWBWB0I29AvxCUxCj
         xNbWadE86WSfTBTAp10Y47pevWDO6izDlZrQYOkwJGeyvlb0GdvLfoXhdi9/9xA5VSov
         gZrS+Ix+D6ey9s8CN39zZKWt78jvYXqGeVqfgRZhauK7bnbTM+qVcuLK00KqcHVGtpIz
         M6HjjzC2JxrYdQqWZfIYQt9Wp92fydk96neK4aGoH6xOjHp0ZSq0UdutuDGgl283vw65
         KZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9OMXfTecjnMTcRmrRQJcFu8mpWNxQK6DFzlJ2wdDnqc=;
        b=lCdQBf+MIsSB5msu67Pnt9gwLXjmO2yBR04T5xYGuQLnklyMj1MmLlrlH/5LoeGJPQ
         eyYlopEzN15XEy/LD3AzATIyy8keFEqcm2CC/U9tbbLdxCfvWcB4yrrEe84/7aPQRTQW
         1QXJdRTcxYm3IRIO9LRNbHuT4f5usjj+9K5apNVwaKhUYUOfgNGKCqc4fTjXdVP2TmDM
         Mk0enwHjtNE8Iv4egJQqJ9pVirz4Ib0Zmvf80cVFFogPdzoB7a4orBEqBv/8z3kOBu44
         QonJD4icm/7wdmK2fXyCSRjv5jlTCXQo/hmSPtxuqp8Xe63UUmC1f9er8vOoRD4xhGYp
         FdZA==
X-Gm-Message-State: AHQUAuaTOnfuHpbmWZawZzDJ9CDbCAwZZKCf3YlaOjFcR2DGiLV6vaXY
        VaMN3Z4Aorttoi2xoG7h3864ekEn902D2EHpOg9rTbnY4KI=
X-Google-Smtp-Source: AHgI3IbCcHTsrN5N2AoyPWm6fAz1oBG0ELVAG7pJm7PvQPQYYfgCHwcLvVrJNRbum/pa1O29+ct3/0dZrDbE/Jv1Fus=
X-Received: by 2002:a6b:c545:: with SMTP id v66mr5826554iof.40.1550244918198;
 Fri, 15 Feb 2019 07:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20190215134937.10259-1-tiny.windzz@gmail.com> <20190215151357.noovkx3r6ia4boag@flea>
In-Reply-To: <20190215151357.noovkx3r6ia4boag@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 15 Feb 2019 23:35:20 +0800
Message-ID: <CAEExFWs2VuOpZu=Mw221Gp3RDbw=Q24eh8Y=pWdfh-c+mPvwuw@mail.gmail.com>
Subject: Re: [PATVH v2 0/4] arm64: dts: allwinner: h6: Enable CPU
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:13 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Fri, Feb 15, 2019 at 08:49:33AM -0500, Yangtao Li wrote:
> > Add the cpufreq support of h6, source of information is as follows.
> >
> > h6 cpu opp info:
> > https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi
> >
> > axp805 spec:
> > http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf
>
> Was that tested on the two H6 boards this time?
I tested two boards for about two hours.
>
> Adding a changelog between version is nice as well so that we can see
> what you changed.
Yes, sorry, I forgot.

Yours,
Yangtao
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
