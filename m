Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137A020C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBklJPaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfBTOUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:20:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38832 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBTOUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:20:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id n15so17702879lfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 06:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d10T8Qb8T6YqSJQjLCtarTiTa1wnyyWwawmdGjebrZw=;
        b=HBklJPafqUxctVmPTVB1OpZXMZgvTvaXbmBDAjGUlGzg0yqvZX82OZ1L3aW+Y8UAxE
         dyn+r4iXwfGRB5DDexI3nL9OHzOpaL+CSTp4YQGFnkF7woUL0J5arwM5irNcn6A8SrFe
         OYAsNcMs5bgaW3PvLvghuW+Xnd7FS9aDUqDfYoVrdQYxFmfBkikEX1NPi3TC+mFlfksL
         qTs/fuIPd/G1LVShsmjpGbk1rVjSAm41Omv9Kj1ACne7XKn3q43yBn6FVNlYKN8aeOw5
         /EVltXMtmU5J4VkNO6Ajbocw1DRb0Bl1hmFa7uXTmtPhc+qo3p1JcPjHHaKde/RU2Qy9
         qwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d10T8Qb8T6YqSJQjLCtarTiTa1wnyyWwawmdGjebrZw=;
        b=rAn7W+QJ/LYvnzJZmBrXqqHYE/EkbLJ9okWmlJqnLgbhFie1QS9L0pl9F90CfJkZmt
         jbxrvlyCUzADLQmRhld5Ru9AXnV8LoHTSDSbzUSBuntrUeBBSBT4ZQU6zq2EJs+HIb/4
         L4LCRbyWJWJXykWw8mW1pwEVBquEU2xUsngU6+6iP6Ax2yU3okTiXhVFiFHh8z6wPgdz
         pX6lI2cqbNQR573NZr5PVoMYF8xB6gc1++eYCPRFgydEGz3JBvX/tG4cy7/cHZKS8Pdf
         wP4jbV68n0keVp5vhwrA76uzldjBKF+2j+mkeIrAVjnJsPOtDG12bVrUeBiqv8QXRpPQ
         UNvA==
X-Gm-Message-State: AHQUAuajFpEiP70DP9LlaBZmY7NmM1xUbtEKVthFrmTnvzlO9xS0EKvM
        JJTfIom/SJV/DobrOH4w7WE=
X-Google-Smtp-Source: AHgI3IZCI6fswKvMjDs+EUX37p3H1Kvcay3iLKE3/cuBKssCAcrVOOQagkXfxYyl22ZD8Y5WryqBFg==
X-Received: by 2002:ac2:52ad:: with SMTP id r13mr6627564lfm.50.1550672450730;
        Wed, 20 Feb 2019 06:20:50 -0800 (PST)
Received: from localhost ([188.162.52.148])
        by smtp.gmail.com with ESMTPSA id p5sm5048450ljg.44.2019.02.20.06.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 06:20:49 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
Date:   Wed, 20 Feb 2019 17:20:48 +0300
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] lib/test_bitmap: switch test_bitmap_parselist to
 ktime_get()
Message-ID: <20190220142048.GA20929@yury-thinkpad>
References: <20190220083705.14050-1-ynorov@marvell.com>
 <20190220083705.14050-5-ynorov@marvell.com>
 <20190220135101.GU9224@smile.fi.intel.com>
 <20190220135236.GV9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220135236.GV9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:52:36PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 20, 2019 at 03:51:01PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 20, 2019 at 11:37:03AM +0300, Yury Norov wrote:
> > > test_bitmap_parselist currently uses get_cycles which is not
> > > implemented on some platforms, so use ktime_get() instead.
> > 
> > This sounds like a fix that should go first in the series.
> 
> Ah, okay, it's already first for test module.
> Perhaps Fixes tag and actually one or more examples of such architectures?

Hi Andy, thanks for your time on it.

Only arm, arm64, openrisc, riscv and sparc64 #define get_cycles.
So IIUC, others take stub from include/asm-generic/timex.h.

sparc32, xtensa, m68k, um, and in some cases x86, mips and nios2
provide zero-stubs explicitly.

Yury

> -- 
> With Best Regards,
> Andy Shevchenko
> 
