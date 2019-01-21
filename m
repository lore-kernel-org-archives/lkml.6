Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89100C2F3C0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A7C20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqyfWeGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfAUNlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:41:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32845 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfAUNlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:41:45 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so15559597lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SF4M7AhekxLOzHWpvb8yq1aEWAWnL64H6PmvyFaKAok=;
        b=OqyfWeGegB0OedjBiVjJ5WWuEvlf0dltJPq5DwoC65MylV0PL5sENyax/ga9qgST21
         pdzWdYH5yoHG6/sDOjGAcX15F/T4+Td6xlzep2f6PYg04qVXLWYMfTavMtB9czI3/3OI
         1AzypkOmQ+RNOex8/jsXxMsO/eOY5x5+7s1Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SF4M7AhekxLOzHWpvb8yq1aEWAWnL64H6PmvyFaKAok=;
        b=gRr58Ou+uLhnHT5ZG0aaWIdBa1FoTavU9FeouLQUaX6vwpEi+YhvM84jPd9wTyYOvd
         2sszz2nPvuRTg+VApcOZOp4V4bY/UkRbAC9DD+Gwk8wFkzf8ySigOBNeww1jwkfXRgxt
         8QBLuORm6XhN/6nctutuBR9XckDsyVCfEuK/sIkH1aF92a8208yKqn0heYLIgnY0fS52
         AB38l4UanTzdbqFUinlqPwadgB3r+/EkDVtKQJ7MX5Tpz1oBGd5cgGcbJ32oBU02u48T
         2z+eApI8CmrxVgL9xgdPb2B5lc2HrOu4pb7hZYdoKGCpX04ty2CGuYOJDfiAZRfq/q1x
         eVnA==
X-Gm-Message-State: AJcUukcRWXy37vKDeu5iNZ0pfmK2Air8uE8uybuPBN+w/VcL8Fu0ZSl3
        +Jg6ZTvI6gg7go32FyryXiE0iQnlAJJx3EuKKkmgrqf6
X-Google-Smtp-Source: ALg8bN45WhP5pXFSIfwUYg29unYStWXKMtUMqsRB+js5Ti+Opwq+G2v+mZ/dq+/vlDoml70MHBOszZKwev38kZHyoVE=
X-Received: by 2002:a19:4849:: with SMTP id v70mr17874393lfa.62.1548078103250;
 Mon, 21 Jan 2019 05:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20190115024543.12928-1-wens@csie.org>
In-Reply-To: <20190115024543.12928-1-wens@csie.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 14:41:31 +0100
Message-ID: <CACRpkdYkmsf00=Bws=Kf9_8zYo5k4_fyEHoGamvDA5PN-1PmyQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: Correct number of IRQ banks on H6 main
 pin controller
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 3:45 AM Chen-Yu Tsai <wens@csie.org> wrote:

> The H6 main pin controller has four banks of interrupt-triggering pins.
> The driver as originally submitted only specified three, but had pin
> descriptions referencing a fourth bank. This results in a out-of-bounds
> access into .irq_array of struct sunxi_pinctrl. This however did not
> result in a crash until v4.20, with commit a66d972465d1 ("devres: Align
> data[] to ARCH_KMALLOC_MINALIGN"), which changed the alignment of memory
> region returned by devm_kcalloc(). The increase likely moved the
> out-of-bounds access into the next, unmapped page.

Nice work rootcausing this!

Patch applied for fixes with the tested-by and ACK.

Yours,
Linus Walleij
