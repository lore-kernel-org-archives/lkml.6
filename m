Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A11C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1A421871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeLRWQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:16:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeLRWQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:16:23 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E537218A4;
        Tue, 18 Dec 2018 22:16:22 +0000 (UTC)
Date:   Tue, 18 Dec 2018 17:16:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Martin Jambor <mjambor@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218171620.365c1c51@gandalf.local.home>
In-Reply-To: <20181218221338.GK25620@tassilo.jf.intel.com>
References: <20181217181638.dfexg6mkmbfyzfli@treble>
        <20181217192938.GF2218@hirez.programming.kicks-ass.net>
        <20181217213126.lsqhyszoulel6uq6@treble>
        <20181217173644.391c2070@gandalf.local.home>
        <20181218000618.GA25620@tassilo.jf.intel.com>
        <20181218024916.vmfnyqzouhfxhyvc@treble>
        <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
        <ri6h8fbqbdf.fsf@suse.cz>
        <20181218211501.GD25620@tassilo.jf.intel.com>
        <20181218165713.4309797a@gandalf.local.home>
        <20181218221338.GK25620@tassilo.jf.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 14:13:38 -0800
Andi Kleen <ak@linux.intel.com> wrote:

> > Again, that's not the ftrace case. It doesn't care about more than one
> > out of line instance. Thus, for this particular use, "used" should be
> > good enough.  
> 
> You mean noinline used? 

I thought that someone said that "used" would also prevent inlining.
But regardless, whatever it takes to not let the functions be inlined
is indeed good enough.

-- Steve

> 
> Inlining would certainly break the test.
