Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84E0C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7165420861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I96EHk/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfAUNoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:44:10 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39636 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfAUNoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:44:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so15525461lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ralGJWswd1TGtJaKt0bea0r26/pHuHMB0v/9X22Diww=;
        b=I96EHk/ncc3VBmOVUJL3KGS98g8IAyKqu2LuLuVKMPlIZRX5h0XthcO4V6nyY2NUvF
         UKMR+XtJ2HAprjqgzVI/jAkJ4atKirmnVo9OR9BzfRWiiwGnNW9pdyoybpcKkam0bQi+
         FiFeMQnfN5Np2BDet21OGgZTm4i8M89ublADY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ralGJWswd1TGtJaKt0bea0r26/pHuHMB0v/9X22Diww=;
        b=O2z7X9vj86y75335U6SPwmAeyTegjaFjZSGR25BH/h8NCz9KRl1uQLzV2svRrB9RQV
         pWBwY6eHltl5W/lXnb4NWiNLW/+7bX59N0etDyS0HvyAIJo0xGM5Zb3nxLuyygp15nZr
         p1SH77Dyy413P0bbPJd9Biwqc5olJFjLOzSq/7wq7J/PzPaRpifzv3ZwDmS6CQUrK3oX
         NtO5z6iwASH3a/e2JwdDbLxTPtMkOhW5naNpyKcSMZP0Th8SpyhKVZZFR+qIBoutcsdo
         OsqmC6y/CASx/hu4axGpsQcqAJNgr6K4D2bhwz34K0THOAGT1fr9EZeOI22/GEvgzY7q
         2blw==
X-Gm-Message-State: AJcUukd4kDqU1Q2hUoewrt0Aw643N3nMVk0YFGFFNCi4TzMJw67IVVQQ
        BFE0y7eenSx+7jf5cPfQEfNxthHvqE5kl6fmF+Y5fA==
X-Google-Smtp-Source: ALg8bN4av/J9eySUCzLNc5WL1DbXEijnajHS5mYVUr97SnXAodt01p2TWOxvaUVDfj5Z1gXJEOnIyTMFFWKMSOIwCdA=
X-Received: by 2002:a19:4849:: with SMTP id v70mr17879386lfa.62.1548078248449;
 Mon, 21 Jan 2019 05:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20190107171908.GA5246@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190107171908.GA5246@jordon-HP-15-Notebook-PC>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 14:43:56 +0100
Message-ID: <CACRpkdbKuAgG95ZB7-nuqPE4-gVdRix0tq0L8_u9UhS5G8xFGA@mail.gmail.com>
Subject: Re: [PATCH] arm/mach-sa1100/simpad.c: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        brajeswar.linux@gmail.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 6:15 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Remove linux/gpio/machine.h which is included more than once.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Patch applied as random cleanup to the GPIO tree.

Yours,
Linus Walleij
