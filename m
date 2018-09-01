Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C203FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6036020843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaZX18Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6036020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeIAOBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 10:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeIAOBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 10:01:46 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26DF2083C;
        Sat,  1 Sep 2018 09:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535795419;
        bh=f4vy5kd4FJ2ufc8eO90qGSTy27Q9Jtxw1pvhXhP0cWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XaZX18RnDsnaH+CKwtIJVxzlGgoICpvOjLTYbl4JZzIiI3w9vWtn2G8OA+5kzU5Ah
         oob2DBkZiyAkSwW5U4HqZfwKQP6vlkvAAYWvy6DanRteZGfHZE5jBzvfMTtTJL7nBq
         ljZdobbY2hvSQN0A50qfNMOW8yXIJ+poQF6NlFEg=
Date:   Sat, 1 Sep 2018 18:50:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-Id: <20180901185017.0a81bc3e61f5d021664f13f3@kernel.org>
In-Reply-To: <CAK8P3a1fsQUbUB4fEgTxm6voKjPFV0_RaBhuPBVxhnaRWBnC_g@mail.gmail.com>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <CAK8P3a0LXxq8tgsz9YL3hT47dB6nKeBdip3gFA5w0dgRGDwCMQ@mail.gmail.com>
        <20180826035323.254463c8b183e6912c5b9a13@kernel.org>
        <CAK8P3a1fsQUbUB4fEgTxm6voKjPFV0_RaBhuPBVxhnaRWBnC_g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Sat, 25 Aug 2018 21:53:17 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Sat, Aug 25, 2018 at 8:53 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > On Fri, 24 Aug 2018 14:46:16 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Aug 24, 2018 at 10:23 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Fri, 24 Aug 2018 13:32:06 +1000
> > > > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > > Hi all,
> > > > >
> > > > > After merging the origin tree, today's linux-next build (powerpc
> > > > > allyesconfig) produced these warnings:
> > > > >
> > > > > Maybe introduced by commit
> > > > >
> > > > >   6b7dca401cb1 ("tracing: Allow gcov profiling on only ftrace subsystem")
> > > > >
> > > > > I am guessing, but that is the only new thing that affects all of
> > > > > kernel/trace ...
> > > >
> > > > Yes, I agree. But I just followed Documentation/dev-tools/gcov.rst
> > > > to enable profiling in kernel/trace. Hmm, doesn't ppc64 support
> > > > GCOV_PROFILE?  (But as far as I can see, ARCH_HAS_GCOV_PROFILE_ALL
> > > > is enabled in arch/powerpc/Kconfig)
> > > >
> > > > Anyway, I'll try to reproduce it.
> > >
> > > Thje same commit causes a link failure on ARM with a randconfig
> > > kernel (see https://pastebin.com/KspjpyKG for the .config):
> >
> > OK, I confirmed that this happened with both gcc-7.3.0 and gcc-8.1.0
> > with your config.
> > I also confirmed that CONFIG_GCOV_PROFILE_ALL causes same issue.
> > (Note that CONFIG_GCOV_PROFILE_ALL depends on !CONFIG_COMPILE_TEST,
> >  so allyesconfig disables it always)
> >
> > Hmm, now gcov kernel itself might have a problem on arm and
> > powerpc(on gcc-8)?
> 
> Yes, that is very possible. I always force CONFIG_COMPILE_TEST=y
> in my randconfig tests, so I miss that kind of problem.

Finally, I've found that this issue (on arm) can be reproduced
with a combination of config options.

When CONFIG_BUG=n and CONFIG_GCOV_PROFILE_ALL|FTRACE=y on arm,
this happened. If I set CONFIG_BUG=y, I could build the kernel
without these errors.

I also built on x86-64 with CONFIG_BUG=n & CONFIG_GCOV_PROFILE_FTRACE=y,
but it succeeded. I guess arm kernel need to embed a counter near the
code section. So if it is in .text.exit, it caused the error.

On arch/arm/kernel/vmlinux.lds.h:

#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
        defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
#define ARM_EXIT_KEEP(x)        x
#define ARM_EXIT_DISCARD(x)
#else
#define ARM_EXIT_KEEP(x)
#define ARM_EXIT_DISCARD(x)     x
#endif

So I think we have to add CONFIG_GCOV_KERNEL to there.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
