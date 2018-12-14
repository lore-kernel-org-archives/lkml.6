Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00281C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396DD2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TabdiH0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbeLNWCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:02:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40010 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbeLNWCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:02:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so6154706lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxYzVNiwSAkHGjYcHiLG6oEBhPwaFNv5M04gEhRAcY0=;
        b=TabdiH0gjHoirY/YyrSGzBw+N1560lI+wGc2TG0ocN81nkHIIwK+cumbPOIwgZ4KFN
         oPshWoxZh823b0xvorTOGI9MqjQuNNgOUzF7vYeweEZwkTDIoXMh+3UY4Q8mzOuE9Rjk
         cN3NtAhOCrfG6OvgGwEzOfm1md6Hg8TBl476c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxYzVNiwSAkHGjYcHiLG6oEBhPwaFNv5M04gEhRAcY0=;
        b=XP98KHemFtkpBgi5ZwG38yLrgEGY31LattjdD6Vt5l8f1BIKxP2cJNcUbhuzt46xds
         7YOWyEv/Gqt3ug+KqA/TNCbIV/twPqGzmc9RYbckghStB2hqO75V0Ju5rGnl4aujDbCY
         fD/jMmn2gw3vnZVE1RJuJIKXPuNEBAZHafqUIzqzFf+h9ls9dovY/IOiXG0Ltq8ULIQ0
         QC2I+BYd2Sj5nxwa8D3XW6f4J+TxAUVIqTqGFpFxErIoG8r7c+pHur9Ql4++yd1qONBE
         OFerNgM+jgq2Xm/IvWOg4h1pOQTK+2eoH2xtm5xaC5suwHzRz2ic4PSryWDIg4mwooSI
         QA4Q==
X-Gm-Message-State: AA+aEWbtU4Hs8et+QxAqpHObPEhXk7iWpMU+iH+2wzjdt/hiIJU7/5Ik
        AyLm+vaSNtd8qRSw1tcZ5oUzmoJANQEwo0ri1b3VfA==
X-Google-Smtp-Source: AFSGD/U1zxJLcVjsQSSJNeWHZNknuEmzmgD+PXg0yNt8WGjJaLZMSVStroECZ60aDHMok9jeQ5iWfnD5c4LrzqK4ev0=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr2768265ljp.12.1544824971400;
 Fri, 14 Dec 2018 14:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20181214194822.lvavgczxq4cy7v64@arbad>
In-Reply-To: <20181214194822.lvavgczxq4cy7v64@arbad>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 23:02:40 +0100
Message-ID: <CACRpkdbWevcW+3yCoRNrggFNPFykQtbJe_rv_n+ypWg-V_Owzg@mail.gmail.com>
Subject: Re: [PATCH] gpio-omap.txt: add reg and interrupts properties
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 8:48 PM Andreas Klinger <ak@it-klinger.de>
wrote:> Document properties reg and interrupts for OMAP GPIO
controller bindings
>
> Also add unit address in node name of the example
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
