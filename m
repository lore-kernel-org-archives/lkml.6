Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EA8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2113C2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF2m0x6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfBOSQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:16:13 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:33465 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfBOSQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:16:13 -0500
Received: by mail-pg1-f170.google.com with SMTP id h11so2803665pgl.0;
        Fri, 15 Feb 2019 10:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuD4AKQzqKKNxB8Rx1ir9zMQnSLyEtyxzB3QyoXxCJ0=;
        b=hF2m0x6nQ39fLA5zD8D6GD8hQeLJmMGnpoKj2nnpqdnKkQxIaVhBEGCLqWFukyg0RA
         6Abv6dCqptSqet+uVxKR3i7WF/I/mu1mIMvDxjV+yiIQs1wQUbJ77T+ZDzYc/CPCGNSd
         3i1A8fYNp4Mfh8QZhzIirHacuRZPAcf+CwTU0SnmFLcJhgPQRjzch27MZcD4K6nBYu1l
         3rnILl7kQR0tQQ080XvtqzsLJsgHNneGlma8xGgxs5gbKPo7BAb58bTUT+ShHr3sdg/a
         NZCerDtTcBMQsA5jFnXDf5jUt9yDV+8y8a8Hq+Agec4neG6LXcql1Z03k+qBNVmxm+U2
         aYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuD4AKQzqKKNxB8Rx1ir9zMQnSLyEtyxzB3QyoXxCJ0=;
        b=dK96dMpZDdr7GEJ6EDt479iqZZWpnlPTAG6SyeOja8a4R0AFIcN8D2Xwr8rkq+3Mub
         SFG8nKmeikiv7gXhsWXWk8e7M8r1Ad5I3PJj7HzMHFgAMRNDa21gBx2YPH99rtSrwu5R
         jvMg257W5PMBjfeYefR2yOCTb4KYoOymRBdWQqS2ILJvnJfRz12FbTzTN1vqqTalW3xY
         nCsQfSSqyW3Mp7tyli9mHaoE8+vOGaZuerUZdS54io2hPBXSaFSQ/Vuoon5vVHf2vyhW
         7MKLdkOhWe9Hiw9qWZbaajMhW9n+oiFR/Wr+kchYm299GCjOPlGcQZ93yFfcqltLeFVB
         vp9g==
X-Gm-Message-State: AHQUAuYvlgJ8ChdsOE1Rp36QfR8RZ92dPQWx6Qxd+r6ecXRyDhpsXOCP
        ew1O3W9kUQPxi5CjWdlzPAASt+8bRwDBjrfmoZPgEYNW
X-Google-Smtp-Source: AHgI3IbcJjEv7/zgTu3vCmMs3C7SVptKb3sunprUBg++Rf/4i8eduOBEMpBI+NaEgw90l8JdhCxRTBOCNr0vL4bCGuE=
X-Received: by 2002:a63:1c42:: with SMTP id c2mr6532685pgm.265.1550254571982;
 Fri, 15 Feb 2019 10:16:11 -0800 (PST)
MIME-Version: 1.0
References: <1550091448-28578-1-git-send-email-info@metux.net> <1550181897-2596-1-git-send-email-info@metux.net>
In-Reply-To: <1550181897-2596-1-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Feb 2019 20:16:00 +0200
Message-ID: <CAHp75VfgzGQ7O-AjwQ1R=OZTiRwxRx_q9Yo1MOVjko7D-Wz14w@mail.gmail.com>
Subject: Re: APUv2/v3 board support V3
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:05 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Hi folks,
>
>

Thanks for an update.

Linus, this one looks good enough, though some style minors can be addressed:
- redundant parens (and actually I prefer to see x = readl(); x |=
...; writel(); in three lines)
- useless blank lines
- style of parameters where one per line (it's not needed in this drivers)

In any case, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> this is version 3 of my APUv2/APUv3 series.
>
> change in V3:
>
>  * gpio driver
>    * drop unncessary gpio id checks
>    * cleanup amd_fch_gpio_set()
>    * move iores outside probe()
>    * shorter NULL checks and correct error in probe()
>  * apu board driver
>    * drop unneeded init.h
>    * drop unnecessary comments
>    * clean up logging
>    * dont need to depend on KEYBOARD_GPIO
>
>
> --mtx



-- 
With Best Regards,
Andy Shevchenko
