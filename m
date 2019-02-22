Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50158C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8722070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tuxAZXU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfBVQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:27:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44678 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfBVQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:27:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id g2so2147742lfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l19pKONo/b6gaUhpK5PpDAiYwVcRzbPDi3lJiQabGfY=;
        b=tuxAZXU8M900LfGxNfDmgRE+fDvKrFZKMdkobtgjJe9pXNFGJsja4SsmGf7WMHf+nc
         w5E8o75PhAyTwHbwqOGwog0p1ge/0boVG9nrhCuqyssoh9qfjt5GQ0gQl13YtKHeycI8
         WLrXB3K4DfKWquxIehoiwEDgfwx4wn1xyB4KvNjZfy8cw308W490aCk+Y2yxaYpwHgmR
         TG/SHO3g/MRxiwNyWVwixctiv6QZyvpQfA/rPLlBAaEIWzT/gJWgc6/KizT6YwMimR00
         lRVaQfnDzSnZlnVbfj3Z0AQD/0zeNLdSqTP+4pF9rQFnwgm4ZJqnyNKVr/9AerZd02p+
         Z4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l19pKONo/b6gaUhpK5PpDAiYwVcRzbPDi3lJiQabGfY=;
        b=QQ7iKt64zTMivQx++uFXSID1JghKWQF+Ube2oqiWGvLJR7bO4ZMrtK98fVtVpD6f5B
         rXWkFBMQNoGCgMIuWtOcyLmKTbC0rPK5hE7fn3/CR/3q5DIiVA1/hBzYRh4dcYX5G4WU
         8x86d4hy1urYdFSqqm2tUUUlg4aHU3IU8osqgnDmRWkxWJI7IliQOkzUlfB8K5bgtIog
         bOgCDF4nveKOBMMD5MIivEFxnIXdyk5GGlYb8OSUy5UNNNPeXtoGPgm01z6dfj/LB7ND
         1DrSkZUDI14CvieQeeWQZZUmvGFB6Vj54iB+AQeBzBQzLNDE2u8V72JPFiwVikw8zbCb
         JCXA==
X-Gm-Message-State: AHQUAuY+RE31emw01KQxlFF3xJhF2tvrAL6R+jPSMjwIGoynCU/BnpSe
        Zvo6/n5Q7NmWWw0g4IR0U1V+ERAuL1m0p3fMgSeGiw==
X-Google-Smtp-Source: AHgI3IZFsXohzzjd2Z6RBkZ7AResUH83xagxQVzg8KfedGZ9BuGakHupNLdovPG2hQIajG4hp7auUoCa0hdp98ivhY0=
X-Received: by 2002:a19:5209:: with SMTP id m9mr2816737lfb.51.1550852861315;
 Fri, 22 Feb 2019 08:27:41 -0800 (PST)
MIME-Version: 1.0
References: <1550181897-2596-1-git-send-email-info@metux.net>
 <1550829256-8831-1-git-send-email-info@metux.net> <1550829256-8831-2-git-send-email-info@metux.net>
In-Reply-To: <1550829256-8831-2-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Feb 2019 17:27:29 +0100
Message-ID: <CACRpkdbseJatwvK1BAwRpmGP6ZsabufvVwETPmD3RpuTBKg9Sg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: AMD G-Series PCH gpio driver
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:54 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> GPIO platform driver for the AMD G-series PCH (eg. on GX-412TC)
>
> This driver doesn't registers itself automatically, as it needs to
> be provided with platform specific configuration, provided by some
> board driver setup code.
>
> Didn't implement oftree probing yet, as it's rarely found on x86.
>
> Cc: linux-gpio@vger.kernel.org
> Cc: linus.walleij@linaro.org
> Cc: bgolaszewski@baylibre.com
> Cc: dvhart@infradead.org
> Cc: andy@infradead.org
> Cc: platform-driver-x86@vger.kernel.org
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
