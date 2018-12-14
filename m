Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A1FC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF3220675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544795342;
	bh=w5N0boArZ7VqKFNylj/9lGoZPJywDqoVelh3nPDAnwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nMNVDCniQGURuAzVtBhwjo9PVsnIbw5/d/dTAlQeGmA6TAOYaR+BFJ1PW7Yl0fa/m
	 xGUn7j+mOQGjfAn3YPUnqaYsObUHvjPxyBuD+JEvK71kS0M+gYlU0IB7IH3N6yQ1yv
	 Lhqg1uof2ldWDsE2iZR7r0XChTuv5E96rScPNR18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbeLNNtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeLNNtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:49:03 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.100.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C8B20656;
        Fri, 14 Dec 2018 13:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544795339;
        bh=w5N0boArZ7VqKFNylj/9lGoZPJywDqoVelh3nPDAnwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t69FOh+iWT4BSTtpbDNx9KiNS/1K6PLz0RNX5GZWndU1VeBgMtFKXiZem9/9br4Wj
         mUQhANco+a6wpyHHXn/6Xd5HGlUy48h/0b0hEKcw1CeiJjx5NdTAa5d/vYVVaOrrAq
         snoV55Onbw9V0lAMux84BfBV6olHRhaqM7xkZGzw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E7AE341B1D; Fri, 14 Dec 2018 10:48:57 -0300 (-03)
Date:   Fri, 14 Dec 2018 10:48:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20181214134857.GR21027@kernel.org>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
 <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
 <20181212180553.GC5289@hirez.programming.kicks-ass.net>
 <20181212133320.75d5cad8@gandalf.local.home>
 <20181213184546.GM5289@hirez.programming.kicks-ass.net>
 <3FC2A5A4-9502-4B33-A944-BEB14B520E23@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC2A5A4-9502-4B33-A944-BEB14B520E23@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 13, 2018 at 09:48:57PM +0000, Song Liu escreveu:
> 
> 
> > On Dec 13, 2018, at 10:45 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Dec 12, 2018 at 01:33:20PM -0500, Steven Rostedt wrote:
> >> On Wed, 12 Dec 2018 19:05:53 +0100
> >> Peter Zijlstra <peterz@infradead.org> wrote:
> >> 
> >>> On Wed, Dec 12, 2018 at 05:09:17PM +0000, Song Liu wrote:
> >>>>> And while this tracks the bpf kallsyms, it does not do all kallsyms.
> >>>>> 
> >>>>> .... Oooh, I see the problem, everybody is doing their own custom
> >>>>> kallsym_{add,del}() thing, instead of having that in generic code :-(
> >>>>> 
> >>>>> This, for example, doesn't track module load/unload nor ftrace
> >>>>> trampolines, even though both affect kallsyms.  
> >>>> 
> >>>> I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload. 
> >>>> That could be separate sets of patches.   
> >>> 
> >>> So I would actually like to move bpf_lock/bpf_kallsyms/bpf_tree +
> >>> bpf_prog_kallsyms_*() + __bpf_address_lookup() into kernel/kallsyms.c
> >>> and also have ftrace use that.
> >>> 
> >>> Because currently the ftrace stuff is otherwise invisible.
> >>> 
> >>> A generic kallsym register/unregister for any JIT.
> >> 
> >> That's if it needs to look up the symbols that were recorded when init
> >> was unloaded.
> >> 
> >> The ftrace kallsyms is used to save the function names of init code
> >> that was freed, but may have been recorded. With out the ftrace
> >> kallsyms the functions traced at init time would just show up as hex
> >> addresses (not very useful).
> >> 
> >> I'm not sure how BPF would need those symbols unless they were executed
> >> during init (module or core) and needed to see what the symbols use to
> >> be).
> > 
> > Aah, that sounds entirely dodgy and possibly quite broken. We freed that
> > init code, so BPF or your trampolines (or a tiny module) could actually
> > fit in there and insert their own kallsyms, and then we have overlapping
> > symbols, which would be pretty bad.
> > 
> > I thought the ftrace kallsym stuff was for the trampolines, which would
> > be fairly similar to what BPF is doing. And why I'm trying to get a
> > generic dynamic kallsym thing sorted. There's bound the be other
> > code-gen things at some point.
> 
> Hi Peter, 
> 
> I guess you are looking for something for all ksym add/delete events, like;
> 
>       /*
>        * PERF_RECORD_KSYMBOL
>        *
>        * struct {
>        *      struct perf_event_header header;
>        *      u64                             addr;
>        *      u32                             len;
>        *      u16                             ksym_type;
>        *      u16                             flags;
>        *      char                            name[];
>        *      struct sample_id                sample_id;
>        * };
>        */

Can't this reuse PERF_RECORD_MMAP2 with some bit in the header to mean
that the name is the symbol name, not a path to some ELF/whatever? The
ksym type could be encoded in the prot field, PROT_EXEC for functions,
PROT_READ for read only data, PROT_WRITE for rw data.

If we do it that way older tools will show the DSO name and an
unresolved symbol, and even an indication if its a function or data,
which is better than not showing anything when processing a new
PERF_RECORD_KSYMBOL.

New tools, seeing the perf_event_attr.header bit will know that this is
a "map" with just one symbol and will show that for both DSO name and
symbol.
 
> We can use ksym_type to encode BPF_EVENT, trampolines, or other type of ksym.
> We can use flags or header.misc to encode ksym add/delete. Is this right?
> 
> If we go this direction, shall we reserve a few more bytes in it for different
> types to use, like:
> 
>       /*
>        * PERF_RECORD_KSYMBOL
>        *
>        * struct {
>        *      struct perf_event_header header;
>        *      u64                             addr;
>        *      u32                             len;
>        *      u16                             ksym_type;
>        *      u16                             flags;
>        *      u64                             data[2];
>        *      char                            name[];
>        *      struct sample_id                sample_id;
>        * };
>        */
> 
> Thanks,
> Song
> 

-- 

- Arnaldo
