Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A7AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB98214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB98214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeHVHzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 03:55:53 -0400
Received: from nautica.notk.org ([91.121.71.147]:60768 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbeHVHzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 03:55:53 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 90627C009; Wed, 22 Aug 2018 06:32:45 +0200 (CEST)
Date:   Wed, 22 Aug 2018 06:32:30 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
Message-ID: <20180822043230.GA26654@nautica>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
 <20180821123832.GA19034@nautica>
 <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
 <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
 <CAKwvOdkLGhdQxx3oV=R2kv290NOv_w8qQ_yHWCVpvmofp7+ivQ@mail.gmail.com>
 <20180822041646.GA21716@nautica>
 <78396ba82562326f4b3a395a63e3e8dc38d608b2.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78396ba82562326f4b3a395a63e3e8dc38d608b2.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches wrote on Tue, Aug 21, 2018:
> On Wed, 2018-08-22 at 06:16 +0200, Dominique Martinet wrote:
> > I think that could work, but at the point making a separate
> > compiler-common.h and not including compiler-gcc.h for clang sounds
> > better to me... More importantly here, either solution sound complex
> > enough to require more than a few days and proper testing for all archs
> > etc when compared to the partial revert we have here.
> 
> The immediate need for a partial revert seems unnecessary as
> clang hasn't really worked for a couple releases now.

Sorry for repeating myself, clang is used by bcc for compiling BPF
programs (e.g. bpf_module_create_c_from_string() or any similar function
will use the clang libs to compile the bpf program with linux headers),
and this has always been working because it's not using our makefiles.

This broke today in master and I only joined this thread after looking
at why the build started failing today and noticing this patch, it
definitely hasn't been broken for two releases, or I wouldn't be here
with this timing :)


> The separate compiler file changes are much more sensible,
> even if it takes a few days.

A few days are fine, but I think some form of fix in 4.19-rc1 would be
good.

I'll stop taking your time now, but I think you are/were underestimating
how many people use clang with the linux kernel headers indirectly.
BPF is a well-used tool :)


Thanks,
-- 
Dominique Martinet

