Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E31C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E972721783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbeLQWgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeLQWgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:36:47 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43A2F214C6;
        Mon, 17 Dec 2018 22:36:46 +0000 (UTC)
Date:   Mon, 17 Dec 2018 17:36:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181217173644.391c2070@gandalf.local.home>
In-Reply-To: <20181217213126.lsqhyszoulel6uq6@treble>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
        <20181217173900.ygifx7khwmzn2gv2@treble>
        <20181217180434.GS25620@tassilo.jf.intel.com>
        <20181217181638.dfexg6mkmbfyzfli@treble>
        <20181217192938.GF2218@hirez.programming.kicks-ass.net>
        <20181217213126.lsqhyszoulel6uq6@treble>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 15:31:26 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Dec 17, 2018 at 08:29:38PM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 17, 2018 at 12:16:38PM -0600, Josh Poimboeuf wrote:
> >   
> > > > Yes LTO causes the to be treated like static functions.
> > > > 
> > > > I guess noclone is unlikely to be really needed here because these
> > > > functions are unlikely to be cloned.
> > > > 
> > > > So as a workaround it could be removed.
> > > > 
> > > > But note we have other noclone functions in the tree (like in KVM)
> > > > which actually need it.  
> > > 
> > > How about we just use the __used attribute then?  It seems to have the
> > > same result of preventing IPA optimizations (without the weird side
> > > effect of missing frame pointers).  
> > 
> > AFAIK we don't have any in-tree LTO, so it can all go in the bin.
> > 
> > When/if we get the LTO trainwreck sorted -- which very much includes
> > getting that memory-order-consume fixed -- we can revisit all that.  
> 
> Ok, then if there are no objections I'll just send a revert of:
> 
>   dd3dad0d716d ("ftrace: Mark function tracer test functions noinline/noclone")
> 

Should it be reverted, or just remove the noclone, and keep the
noinline?

-- Steve
