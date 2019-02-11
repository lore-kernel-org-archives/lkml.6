Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05799C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BDB21B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rj8S/DNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfBKNdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:33:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36009 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfBKNdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:33:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so8791410ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBGtD0uMSZ+O3pw0iAV+0M3sgw3htsTlG9lzSpnaWik=;
        b=rj8S/DNkdRUbww2wtpClUMv+3syjU+EjP6AqRGzgZhIlDVXM8lwbD3MfXPLw1MFFpL
         9EdH/h9RcxwvqX5kfgeFQcNr2ahVO1xw7IMnN+L3xDz7OWjd7x+W9BXF43ZPa9nOLjFN
         qfBn5SsIP0f311uGccknIEqfsCVrthioPej/rFg2eG787i9MQX293nw3R3+16T18Lzhc
         6Joxbq2Ed1AmWC5prkB4qjXUEeYCJduLS+/5FQIyRQjncFGbdDWbkDkBByKLCrqxHO5n
         Ko6Ml2XusTs2ZOJFaVx+ZIBBAPWcunx+9jRcNRovs0mDwbQPncB+ihz8MoR9LOQBifiU
         sWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBGtD0uMSZ+O3pw0iAV+0M3sgw3htsTlG9lzSpnaWik=;
        b=uAAq+Y+PjQkg70stc2AbMuuZYVqF+VaKeLYbx5ODnsHHUUQLIGp5EEZUBPj2qD/zkj
         lwGAzbgrAf+IyN5V65YwMSbDjt5CGF2AqLJPdZ0u6Z9IaqAd2hBtyBlY3p+oTPEIjIqg
         Fvmb1Iqc0eb9pavdx87qRnOWI+h32ViR8BkGR8jfa5ZQJ465V6HZVpBbHmKEzVFD6pxs
         gmSPU38HSkb9rbsE4rzRRLZipi4H3Dv6N5MKLKIU+HOJ9VV4PSEq9e3OqGDzpMwbwiQP
         kTO8I9j9i1jDffPu4Z6QsejqljGCGBdROSQBqLbB4sGd1g/1Hq1vwmIhzf3v2Bl9EwqB
         ZFog==
X-Gm-Message-State: AHQUAuYoRO/iLK+PVh8LfWRAUq0aNPhhJdlib/u+Yllx+bL9BF/f1xWL
        Wuo9wWrgJoOiFRZnfgQkgnWKrn2sGNtrLdL6i/FWDw==
X-Google-Smtp-Source: AHgI3Iaq162R9SUb7kI3l6i07GWKvEoVFxeMIvp9gvXBc5Nuo5LwGHh7MuPkBsnu188tiZnRHQ4dQEAUWkHPO1gMJeE=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr21527980ljh.135.1549892012855;
 Mon, 11 Feb 2019 05:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20190208021631.30252-1-masneyb@onstation.org>
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Feb 2019 14:33:21 +0100
Message-ID: <CACRpkdbJJ-cCVDYf-Rkna=y1Yf6DsAP4AEN9RA0qpFXdCt+J=w@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] qcom: ssbi-gpio: add support for hierarchical
 IRQ chip
To:     Brian Masney <masneyb@onstation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 3:16 AM Brian Masney <masneyb@onstation.org> wrote:

> This patch series adds hierarchical IRQ chip support to ssbi-gpio so
> that device tree consumers can request an IRQ directly from the GPIO
> block rather than having to request an IRQ from the underlying PMIC.

This looks good and work for me, I'd like to get a nod from one of the
Qualcomm maintainers if possible, then I can merge the whole
thing through the GPIO tree like with the previous patch set.

Yours,
Linus Walleij
