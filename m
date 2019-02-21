Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B820C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFCC20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFOKjWte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfBUIxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:53:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46372 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfBUIxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:53:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id v16so23256202ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 00:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yGx0zil6yj1oC8ODCBCtzEQX/NhRvGXa2b8pEHdk1gA=;
        b=lFOKjWteRFOgtiQf50M8NxaZ55EHY9sVIXlwAbZcIyevZ/E2x5jWloSXpTcFLR0C0v
         srat2zbdFHSq1VIy/3dJF4FXyZ8QNXjAtstWuDXjaxzgA04YSA9sphtMGZVcrDj/g2/b
         GoSCGfKBZCpyfaI2G6RNSFV18ra5SDwcpwpcD1fRd7kOggeLIYaq6c0/y5/BGjKluKY1
         TToOLSJYWIfU8MjgxvCwaMfD/hIaLbYV+Goq/LnGqzH1luttTNfDILTvIKt2/D+BBaHU
         gUCwwGUnh19V7ej/jP3M/Qdy0Lle/MJDxcC+XHXvYSgpZGITkzwTOke6nvnqiJ1TJFSN
         UBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yGx0zil6yj1oC8ODCBCtzEQX/NhRvGXa2b8pEHdk1gA=;
        b=DnpraME0nccoP339UwB89t9CWcQ2UnOaF6hIj2wGnBJ+u+b32B4me6oiqDY2JiWhbW
         36Cc5rcTkVIu0SUUO6aNPIR6JQJgEO2OtjICnU3gHL6x2XaHStFEceC7FwQ9rmqcCrrE
         +C+PLERRldKCX+HRumvL+YlIXo8WMMKGFNgQCv8iopEFUV3jHjfg7AOtzBEg2GzxIh1C
         RD08Ygj0ox1xAzokkyRoXxQ7aydN+ssLHZwue1HxyC73VPglrbyqa5VlNlsfROjs7JVR
         QYv/wF4NylGAQ11Ce67ph2ds/R8yf38Q4aTMEtLdoKuA2JePbMKeKoP4oUc8I/QM76MX
         Kvpw==
X-Gm-Message-State: AHQUAuYk3h15zHwchDGE4EMmj8FLU2sPNy1AzqZ5pECDx+BsXastsNmk
        ng2c5sbEKEMhr4NIfqldDis=
X-Google-Smtp-Source: AHgI3Ibp0C0952O0jpOKzEzl1nV9ZgM8k64eiX7Zgujsf7sCD3h/+s6hH+VZ6BFfeHSX8j4hBapN+g==
X-Received: by 2002:a2e:2d11:: with SMTP id t17-v6mr23215205ljt.159.1550739214373;
        Thu, 21 Feb 2019 00:53:34 -0800 (PST)
Received: from localhost ([188.162.52.7])
        by smtp.gmail.com with ESMTPSA id d70sm6062852lfe.14.2019.02.21.00.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 00:53:33 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
Date:   Thu, 21 Feb 2019 11:53:31 +0300
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        akpm@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        dmitry.torokhov@gmail.com, keescook@chromium.org,
        willy@infradead.org, mpe@ellerman.id.au, linux@rasmusvillemoes.dk,
        penguin-kernel@I-love.SAKURA.ne.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] lib/test_bitmap: switch test_bitmap_parselist to
 ktime_get()
Message-ID: <20190221085331.GA2666@yury-thinkpad>
References: <20190220142048.GA20929@yury-thinkpad>
 <mhng-e872dce6-2abe-467b-b1c1-82a59d4c93e2@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-e872dce6-2abe-467b-b1c1-82a59d4c93e2@palmer-si-x1c4>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:10:44PM -0800, Palmer Dabbelt wrote:
> On Wed, 20 Feb 2019 06:20:48 PST (-0800), yury.norov@gmail.com wrote:
> > On Wed, Feb 20, 2019 at 03:52:36PM +0200, Andy Shevchenko wrote:
> > > On Wed, Feb 20, 2019 at 03:51:01PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Feb 20, 2019 at 11:37:03AM +0300, Yury Norov wrote:
> > > > > test_bitmap_parselist currently uses get_cycles which is not
> > > > > implemented on some platforms, so use ktime_get() instead.
> > > >
> > > > This sounds like a fix that should go first in the series.
> > > 
> > > Ah, okay, it's already first for test module.
> > > Perhaps Fixes tag and actually one or more examples of such architectures?
> > 
> > Hi Andy, thanks for your time on it.
> > 
> > Only arm, arm64, openrisc, riscv and sparc64 #define get_cycles.
> > So IIUC, others take stub from include/asm-generic/timex.h.
> 
> Should we (RISC-V) be doing something else?  It seems odd to be in such a
> minority here, but we do have a ISA-mandated timer so the get_cycles()
> implementation is super easy.

I think you are completely fine because you are one of those who
implement get_cycles().

get_cycles() is the problem for those who use it in generic code
because their code surprisingly gets broken on some machines while
works OK on others. This is not a problem of any specific arch.

For long term, we should inspect the non-arch code and replace 
get_cycles() with ktime_get() where appropriate, and avoid
introducing new get_cycles() uses.
 
> > sparc32, xtensa, m68k, um, and in some cases x86, mips and nios2
> > provide zero-stubs explicitly.
> > 
> > Yury
> > 
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > > 
