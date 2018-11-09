Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B65920827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B65920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeKJEYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:24:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeKJEYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:24:33 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5044E2081C;
        Fri,  9 Nov 2018 18:42:43 +0000 (UTC)
Date:   Fri, 9 Nov 2018 13:42:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-ID: <20181109134241.5f4ce3be@gandalf.local.home>
In-Reply-To: <20181109164137.5cngbfrkm4ihj4ra@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
        <20181109072811.GB86700@gmail.com>
        <CALCETrU3tPPOiuTaLqUy-L4sPvZRU8BLYML-BgQH_LZhA4bzSQ@mail.gmail.com>
        <20181109152139.zig45f6gp24btfbc@treble>
        <20181109164137.5cngbfrkm4ihj4ra@treble>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 10:41:37 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Fri, Nov 09, 2018 at 09:21:39AM -0600, Josh Poimboeuf wrote:
> > On Fri, Nov 09, 2018 at 07:16:17AM -0800, Andy Lutomirski wrote:  
> > > On Thu, Nov 8, 2018 at 11:28 PM Ingo Molnar <mingo@kernel.org> wrote:  
> > > >
> > > >
> > > > All other usecases are bonus, but it would certainly be interesting to
> > > > investigate the impact of using these APIs for tracing: that too is a
> > > > feature enabled everywhere but utilized only by a small fraction of Linux
> > > > users - so literally every single cycle or instruction saved or hot-path
> > > > shortened is a major win.  
> > > 
> > > For tracing, we'd want static_call_set_to_nop() or something like that, right?  
> > 
> > Are we talking about tracepoints?  Or ftrace?  
> 
> Since ftrace changes calls to nops, and vice versa, I assume you meant
> ftrace.  I don't think ftrace is a good candidate for this, as it's
> inherently more flexible than this API would reasonably allow.
> 

Not sure what Andy was talking about, but I'm currently implementing
tracepoints to use this, as tracepoints use indirect calls, and are a
prime candidate for static calls, as I showed in my original RFC of
this feature.

-- Steve
