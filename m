Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4D3218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeLRXkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeLRXkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:40:15 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB4BB2184C;
        Tue, 18 Dec 2018 23:40:13 +0000 (UTC)
Date:   Tue, 18 Dec 2018 18:40:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Martin Jambor <mjambor@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218184012.10495779@gandalf.local.home>
In-Reply-To: <20181218232636.GM25620@tassilo.jf.intel.com>
References: <20181217213126.lsqhyszoulel6uq6@treble>
        <20181217173644.391c2070@gandalf.local.home>
        <20181218000618.GA25620@tassilo.jf.intel.com>
        <20181218024916.vmfnyqzouhfxhyvc@treble>
        <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
        <ri6h8fbqbdf.fsf@suse.cz>
        <20181218211501.GD25620@tassilo.jf.intel.com>
        <20181218165713.4309797a@gandalf.local.home>
        <20181218221338.GK25620@tassilo.jf.intel.com>
        <20181218171620.365c1c51@gandalf.local.home>
        <20181218232636.GM25620@tassilo.jf.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 15:26:36 -0800
Andi Kleen <ak@linux.intel.com> wrote:

> > I thought that someone said that "used" would also prevent inlining.  
> 
> that's not correct. You need noinline

Sure, whatever. That's besides the point.

The thing is, I don't need noclone. Just remove that and keep the
noiniline, and if that keeps the functions in that file still able to
be function traced, then I'm happy.

I was only explaining why I mentioned "used" in the previous email. If
you read the part that you cut off in your reply, I said "But
regardless, whatever it takes to not let the functions be inlined is
indeed good enough."

I don't care if that's "used" on "noinline", you didn't need to waste
your time to post the assembly.

-- Steve
