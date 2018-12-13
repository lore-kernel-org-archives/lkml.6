Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66812C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CD820851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qdDGzgm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CD820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeLMSp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:45:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52356 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLMSp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xgs3EcOadYV+Qewa6SO0rYOJK8l5HD9i5bO5aVWIznk=; b=qdDGzgm+fi5wLLhnyKWf8Aw+1
        IjeteiAGzQUPBQ4I7g1STBFYl74/DVrW4biwRsuHwnuTIlUgKrkI5kguAhU50X7xPyFXsvV6oyBrP
        vWKONKDwvJTKAlmso0Gqrp9Zw+rNJXWyw+Un6NBtK/wguMLXy0xT+yoU6sviPX+rGTmWoFGrb368L
        NmBx4vsUIsXZWDP9ZzfbKroX/LZQuelKjpONbDZrCwbHp58Dq/G7+BvmkjwqkI91cm4qnj34HmDDw
        m9o/UZmFrAbk9ROTj8hl2P/h2r/mhVbovFNVxxlYjiQzeFj46GTOqMMfqMVM48u7onNlhoVp4/O/Y
        54kn20Sbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXVzY-0006bL-Pe; Thu, 13 Dec 2018 18:45:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4091D207264F1; Thu, 13 Dec 2018 19:45:46 +0100 (CET)
Date:   Thu, 13 Dec 2018 19:45:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20181213184546.GM5289@hirez.programming.kicks-ass.net>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
 <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
 <20181212180553.GC5289@hirez.programming.kicks-ass.net>
 <20181212133320.75d5cad8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212133320.75d5cad8@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 01:33:20PM -0500, Steven Rostedt wrote:
> On Wed, 12 Dec 2018 19:05:53 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Dec 12, 2018 at 05:09:17PM +0000, Song Liu wrote:
> > > > And while this tracks the bpf kallsyms, it does not do all kallsyms.
> > > > 
> > > > .... Oooh, I see the problem, everybody is doing their own custom
> > > > kallsym_{add,del}() thing, instead of having that in generic code :-(
> > > > 
> > > > This, for example, doesn't track module load/unload nor ftrace
> > > > trampolines, even though both affect kallsyms.  
> > > 
> > > I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload. 
> > > That could be separate sets of patches.   
> > 
> > So I would actually like to move bpf_lock/bpf_kallsyms/bpf_tree +
> > bpf_prog_kallsyms_*() + __bpf_address_lookup() into kernel/kallsyms.c
> > and also have ftrace use that.
> > 
> > Because currently the ftrace stuff is otherwise invisible.
> > 
> > A generic kallsym register/unregister for any JIT.
> 
> That's if it needs to look up the symbols that were recorded when init
> was unloaded.
> 
> The ftrace kallsyms is used to save the function names of init code
> that was freed, but may have been recorded. With out the ftrace
> kallsyms the functions traced at init time would just show up as hex
> addresses (not very useful).
> 
> I'm not sure how BPF would need those symbols unless they were executed
> during init (module or core) and needed to see what the symbols use to
> be).

Aah, that sounds entirely dodgy and possibly quite broken. We freed that
init code, so BPF or your trampolines (or a tiny module) could actually
fit in there and insert their own kallsyms, and then we have overlapping
symbols, which would be pretty bad.

I thought the ftrace kallsym stuff was for the trampolines, which would
be fairly similar to what BPF is doing. And why I'm trying to get a
generic dynamic kallsym thing sorted. There's bound the be other
code-gen things at some point.
