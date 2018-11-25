Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83EDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B88C2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqhFshsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B88C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeKZJ43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:56:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46435 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKZJ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:56:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so14812848ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 15:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6tdxicPRa56vTj0tDvdANVtSG9NmMxY6tDM/G5qC8g=;
        b=BqhFshsD4EPjK9Q7lbsP5g2/Uq2FhuuxOOSsq57qmHee44OHKqHmvGigHL1PSwPBDP
         T3VGqpeGz1TqTMLmCnwpK7iKPn/zIREI8n+f3ohW5oQqmDrrOxjhGFSuMiiG34i5HTS1
         SZiGZSrFkKw4ChzHbIxvp/Uietb7XtqeOMxf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6tdxicPRa56vTj0tDvdANVtSG9NmMxY6tDM/G5qC8g=;
        b=lMjwuzy8wNrc/ft4GFw/x9/g8HHkRl0PGpwfF7h11BK4iLDr+onM23Ysb7pYUDg378
         Zzs5tkzhNil6Asd7Do01DJGfrcJBtu7J6M3HXuw/bDcs6g6tqbYS4rzXTUnBdcPEfrEY
         GyPrA2p7dOBFvfeXxi+OUPYya5eMmN70oARzUY1eBIYiarX5f6CmCZS0wzeeb4AcC+JU
         xJqtciXy8F1ChH5n4xX1htJKC6EHwsrMz6EGqTJYmcmzToRg0K2tFPmV16+9bm4H0AYL
         LB6Ar0vb1L+hMU2CL7dUA7Sph0p5go0SPTD8t72xkLmsZFjIqG8W8nKkHuu/PuaGP0Ht
         0qsA==
X-Gm-Message-State: AA+aEWacjrwhakgXXtr5aN0DCtVz+Yb8T79DYUaUqj97G6D9W2ISURCg
        DcQDM1LPWwm8x8hPtEVa08mBIRp5T0okons618+bhA==
X-Google-Smtp-Source: AFSGD/XchXR7RdrXO04mG+7au/PJZrELuY0GwgsGJImAxcoFpvw+OLOxWg7I26x2Bx2iBb3NmBIQfAgLg011LtsZP3E=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr15100744ljk.4.1543187055036;
 Sun, 25 Nov 2018 15:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20181122135901.31849-1-vz@mleia.com>
In-Reply-To: <20181122135901.31849-1-vz@mleia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 26 Nov 2018 00:04:02 +0100
Message-ID: <CACRpkdYROOnn03WbqTf+8X_JKWbT9yXHLFkzr-fsJoBr5sUmEQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: restore original GPLv2+ license of gpiolib-of.c sources
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 2:59 PM Vladimir Zapolskiy <vz@mleia.com> wrote:

> It's easy to verify that the change of drivers/gpio/gpiolib-of.c license
> header to SPDX standard changes the license from GPLv2+ to GPLv2, and
> this change corrects it.
>
> Fixes: dae5f0afcfc3 ("gpio: Use SPDX header for core library")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Whoops my mistake.

Patch applied!

Yours,
Linus Walleij
