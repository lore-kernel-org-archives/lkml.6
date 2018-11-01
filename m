Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B0FC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61C3205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61C3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeKASW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:22:57 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:44820 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727516AbeKASW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:22:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C749A1806221D;
        Thu,  1 Nov 2018 09:20:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: goat79_602640f0dc33
X-Filterd-Recvd-Size: 3546
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Nov 2018 09:20:41 +0000 (UTC)
Message-ID: <02085d90af8a81b69cb38e0fdd6a018f151a58d8.camel@perches.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Biener <rguenther@suse.de>,
        Michael Matz <matz@suse.de>, gcc@gcc.gnu.org,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 01 Nov 2018 02:20:40 -0700
In-Reply-To: <20181101090114.GE3159@hirez.programming.kicks-ass.net>
References: <20181009145330.GT29268@gate.crashing.org>
         <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
         <20181010072240.GB103159@gmail.com>
         <20181010080324.GV29268@gate.crashing.org> <20181010081906.GA5533@zn.tnic>
         <20181010185432.GB29268@gate.crashing.org> <20181010191427.GF5533@zn.tnic>
         <20181013193335.GD31650@zn.tnic>
         <20181031125526.GA13219@hirez.programming.kicks-ass.net>
         <5f987ecbb4962b4796615928d9d71f2cf9b21a3b.camel@perches.com>
         <20181101090114.GE3159@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-01 at 10:01 +0100, Peter Zijlstra wrote:
> On Wed, Oct 31, 2018 at 10:20:00PM -0700, Joe Perches wrote:
> > On Wed, 2018-10-31 at 13:55 +0100, Peter Zijlstra wrote:
> > > Anyway, with the below patch, I get:
> > > 
> > >    text    data     bss     dec     hex filename
> > > 17385183        5064780 1953892 24403855        1745f8f defconfig-build/vmlinux
> > > 17385678        5064780 1953892 24404350        174617e defconfig-build/vmlinux
> > > 
> > > Which shows we inline more (look for asm_volatile for the actual
> > > changes).
> > []
> > >  scripts/checkpatch.pl                              |  8 ++---
> > >  scripts/genksyms/keywords.c                        |  4 +--
> > >  scripts/kernel-doc                                 |  4 +--
> > 
> > I believe these should be excluded from the conversions.
> 
> Probably, yes. It compiled, which was all I cared about :-)
> 
> BTW, if we do that conversion, we should upgrade the checkpatch warn to
> an error I suppose.

More like remove altogether as __inline and __inline__
will no longer be #defined

$ git grep -P 'define\s+__inline'
include/linux/compiler_types.h:#define __inline__ inline
include/linux/compiler_types.h:#define __inline   inline

