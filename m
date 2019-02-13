Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD54DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2AE222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P70ZZXgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390575AbfBMIQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:16:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46601 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732965AbfBMIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:16:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so1039755lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrKn2KdK4JmuaDzbCdyuOPGreCc4R75qvrlolZikEMo=;
        b=P70ZZXgFZuNb6gQgjagUWFITQuj8jmKaDQ4yqO9oefH1yzGyNc2+A+r8d1bv2jld8q
         C0MLKgXCLpokeiFLC/b4b4bQxEGToxCsDAooQMU3h1fxF021cE+dSSmq1q9wCtpJqqqz
         2zzgaESXY2AJkOsRBv7MfV8DaOZoI4xKyHNLexDyFVCLqjlG1vlSDv95wpn3FlWuzK+R
         mZ8NCFBb25uJz7FGcEnKBUF2rdyTNhgtt1N6rTPui/iBgqpzBsmMh2bjiJXI0Ttkjn+1
         Dxzb4/jD/TR1xHc/FQPSkdM6R6ypwm2lSpmJ074jK/+S3u+5vWx7LC1WHhJzQ+RhHQ5t
         gLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrKn2KdK4JmuaDzbCdyuOPGreCc4R75qvrlolZikEMo=;
        b=osnJj2bbBOunatrDrN3QrQEVwhdbkWtO63UBBouZu5A7dslfi+DBA9s9QXF7IF7nUj
         FM/7S073JLKn9hsLixhymcO76B6/k1yjWQMsqL+1741CjfLX1Y1/rlv0wGa73eMssTzC
         Nu9mDaVTBsb3LVpt6ANLsvUhpeMSaXBrIP7cVGvyVBmhYTSej2vyULuhc2Aj/nssWLvb
         eIpGkBOfuv2mYSX2aiT4raal38h7lEWdzG0sCI5ABqQiR0+NQzANf/BOmjnGQL7hfxwJ
         oBkJMASQlLjisoeS0V5RFb28k7b4C6F058dlTSKbEPokobtb/5Vfmk5RIdKqlDXvbTHs
         jJbg==
X-Gm-Message-State: AHQUAuYXmcX4hAKtV59+jHiV82VuWuLAIHtMh3501B4rSe1U7IDJ1OSK
        5smYCD1vlyacv07A5zk0S66WcwykFr+/qZkAgxeq8w==
X-Google-Smtp-Source: AHgI3Ia1oZpb0KpziQIyCAoSpqCUqlBj6s5ru5uDVgQEKOfrwZKIC8SKvsYWswQRJTl8JV+l67Xo5+8dPhLjhgNen28=
X-Received: by 2002:a19:7b0e:: with SMTP id w14mr5017789lfc.8.1550045760488;
 Wed, 13 Feb 2019 00:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Feb 2019 09:15:49 +0100
Message-ID: <CACRpkdbcuERqOvR-5gknTKcq0BeQU2r2U12zFyVXZXWwDMAWAA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] gpio: add support for pull-up/pull-down configuration
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 5:29 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> As we started discussing in [1], it would be useful to have a way to
> configure pull-up/pull-down resistors for simple GPIO controllers that
> don't have any pinmuxing capability, and therefore no interaction with
> the pinctrl subsystem.
>
> This is a second iteration of the patches (the v1 was posted at
> https://patchwork.ozlabs.org/cover/1020392/).

I don't see any problem with this patch set so I have merged it
into an immutable branch in my GPIO tree, and if it builds fine
I will merge it for devel (for-v5.1).

Notably we do not add a userspace ABI in this patch series.

I guess that is fine for now, but I think we might see userspace
support requests soon. But that can be a different patch
and should be driven by actual need for that.

Yours,
Linus Walleij
