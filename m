Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BCBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94AA20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8C5s5zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfBUMzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:55:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47075 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:55:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id v16so23865142ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=58z1a8XjpYpJMOkBbFxwfuiRL7Plx4f9fYklUx/AJAI=;
        b=Y8C5s5zG8nwBtt9kjvu17JWDIqJji6K0TVemSQ9NfwNO+0xRdiF0tvcnN/e18kUiED
         7JMVvyWbHLJC0dL7ULWyS81DElX3Ic/Cw/7rm8es4AbXHIK7/zASsl7RoPxU/vqtQZOZ
         2c+ILq6B9FBmrF3E74LFLyFlhJBD6FHDD3FlgUdhyBf4DFAowopk02QPxOcnX1qZMbHK
         +XcQoE/biL4pvpzPYb5vFAKu6Pt4crFuypMo8aoHP7wvKk3ViOnk+i81EUthWsM7eew0
         h2ytx2IYARMRbsXgnEfp+UkS03FheFEZmaorEzG1dyEF8FZPjiScacNWLaN43+rX9Y8O
         LF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=58z1a8XjpYpJMOkBbFxwfuiRL7Plx4f9fYklUx/AJAI=;
        b=oWcfMl4xCvHX627Od0PZKYiM8mhzjWlf2ZKkumMYHx20IHo8TmLl0cEvQPRCOLlFd0
         hm5S9oo8xV1M8ClXEhCIjeEy95Fi7ySFLnrHFcKeBTta1Cf1QwyPvZfuxPIiWaTvXVCs
         U44sKddviR8AK4V6hPVilXGNzsp7A4S6BO8ByQZNBMVVm/q66os9bu0WtVUv4POOR47K
         iAJB4zEpatoDlqZ1EH1zHiIUCzZ/fXKpj2mH0mRcv6/GNWasoqoULoSHY3EzP/wKEfX4
         9E6NmAJnCMCrruqb7eu8noSBaCVOWoTHSMJCHkKGPyPuuQ3S8S6Z10Cjg9CZ4jgPeY34
         tW7A==
X-Gm-Message-State: AHQUAuYx/IlqLWl3599IW8x4QGmwf1ogknGoLXEj2ZNPHiWIL6RJ0MrE
        JeGDkjK+zA3bnRsdx/ZHWMo=
X-Google-Smtp-Source: AHgI3IZ2BbO8rQqCk45bCk5Jj/hzUsW7K8QTAwxaG+MZnsZDVIIm2tdiH2Hhy07JdO3R4TygIaLlwg==
X-Received: by 2002:a2e:1510:: with SMTP id s16mr2837816ljd.62.1550753735639;
        Thu, 21 Feb 2019 04:55:35 -0800 (PST)
Received: from localhost ([188.162.52.7])
        by smtp.gmail.com with ESMTPSA id q10-v6sm6001307ljh.72.2019.02.21.04.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 04:55:34 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
Date:   Thu, 21 Feb 2019 15:55:32 +0300
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20190221125532.GA6934@yury-thinkpad>
References: <20190220083705.14050-1-ynorov@marvell.com>
 <20190220083705.14050-5-ynorov@marvell.com>
 <20190220135101.GU9224@smile.fi.intel.com>
 <20190220135236.GV9224@smile.fi.intel.com>
 <20190220142048.GA20929@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220142048.GA20929@yury-thinkpad>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 05:20:48PM +0300, Yury Norov wrote:
> On Wed, Feb 20, 2019 at 03:52:36PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 20, 2019 at 03:51:01PM +0200, Andy Shevchenko wrote:
> > > On Wed, Feb 20, 2019 at 11:37:03AM +0300, Yury Norov wrote:
> > > > test_bitmap_parselist currently uses get_cycles which is not
> > > > implemented on some platforms, so use ktime_get() instead.
> > > 
> > > This sounds like a fix that should go first in the series.
> > 
> > Ah, okay, it's already first for test module.
> > Perhaps Fixes tag and actually one or more examples of such architectures?
> 
> Hi Andy, thanks for your time on it.
> 
> Only arm, arm64, openrisc, riscv and sparc64 #define get_cycles.
> So IIUC, others take stub from include/asm-generic/timex.h.
> 
> sparc32, xtensa, m68k, um, and in some cases x86, mips and nios2
> provide zero-stubs explicitly.

I forgot about Fixes tag:
Fixes: 6df0d464dbcc1a5 ("lib/test_bitmap.c: add test for bitmap_parselist()")

If it comes to v3, I'll add the tag and explanations above to the
patch message.
