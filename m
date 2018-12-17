Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316C1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C022133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K56wb980"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbeLQPtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:49:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387609AbeLQPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uwnvl7ibgs9vIPRtuEFL0loce14hraIIGz/WJkdjbpk=; b=K56wb980c9QVOfstUhF6CqHH3
        uLvXQKDREHBigRe7LIPrwMCopLLhCRsa4dvGAti0tOvSOCQUc9PWozr7ndTRD+Xo7dAVqzoAukuJt
        WzvjGXxs6vEcMyrc541cgW+TVzqIHkOCG9+2SPTKhq0PcEsIsAiDUO+HtLtGS984HNd0Q8Etov/T5
        Qbqx6YgyqFzgB+26ZY5243AI5wLoqK5ng7gDFTnxO7+I+R/NF8L8sJx7Dm6oak7+gFvtzIiMhOPei
        DtfnWfKEsIkYQ4hAbMrQl2ySu/mE8B3h+QbbSbOTwvh00a6j68ptJ5UnZSpIBP5KEcwgSIl8FiBzj
        dMtWNrXKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYv8i-0003fz-DB; Mon, 17 Dec 2018 15:49:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 071F12027DA8E; Mon, 17 Dec 2018 16:48:59 +0100 (CET)
Date:   Mon, 17 Dec 2018 16:48:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20181217154858.GA14122@hirez.programming.kicks-ass.net>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
 <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
 <20181212180553.GC5289@hirez.programming.kicks-ass.net>
 <20181212133320.75d5cad8@gandalf.local.home>
 <20181213184546.GM5289@hirez.programming.kicks-ass.net>
 <3FC2A5A4-9502-4B33-A944-BEB14B520E23@fb.com>
 <20181214134857.GR21027@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214134857.GR21027@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:48:57AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 13, 2018 at 09:48:57PM +0000, Song Liu escreveu:

> > I guess you are looking for something for all ksym add/delete events, like;
> > 
> >       /*
> >        * PERF_RECORD_KSYMBOL
> >        *
> >        * struct {
> >        *      struct perf_event_header header;
> >        *      u64                             addr;
> >        *      u32                             len;
> >        *      u16                             ksym_type;
> >        *      u16                             flags;
> >        *      char                            name[];
> >        *      struct sample_id                sample_id;
> >        * };
> >        */

Yes, something like that.

> Can't this reuse PERF_RECORD_MMAP2 with some bit in the header to mean
> that the name is the symbol name, not a path to some ELF/whatever? The
> ksym type could be encoded in the prot field, PROT_EXEC for functions,
> PROT_READ for read only data, PROT_WRITE for rw data.
> 
> If we do it that way older tools will show the DSO name and an
> unresolved symbol, and even an indication if its a function or data,
> which is better than not showing anything when processing a new
> PERF_RECORD_KSYMBOL.
> 
> New tools, seeing the perf_event_attr.header bit will know that this is
> a "map" with just one symbol and will show that for both DSO name and
> symbol.

That confuses me; the DSO for ksyms is [kernel|$modname] after all. And
BPF would like to have multiple symbols per 'program', so I can imagine
it would want to do something like:

	[bpf-progname1] function1
	[bpf-progname1] function2
	[bpf-progname2] progname2

The first being an bpf proglet with multiple functions, the second a
'legacy' bpf proglet with only a single function.

Trouble is; both PERF_RECORD_KSYM and MMAP* only have a single name[]
field. Now, I suppose we could add:

	char modname[MODULE_NAME_LEN]

or:

	u16 modlen;
	char modname[modlen];

or something along those lines.

Similarly; I would not expect the ftrace trampolines to all have a
different module name.

> > We can use ksym_type to encode BPF_EVENT, trampolines, or other type of ksym.
> > We can use flags or header.misc to encode ksym add/delete. Is this right?
> > 
> > If we go this direction, shall we reserve a few more bytes in it for different
> > types to use, like:
> > 
> >       /*
> >        * PERF_RECORD_KSYMBOL
> >        *
> >        * struct {
> >        *      struct perf_event_header header;
> >        *      u64                             addr;
> >        *      u32                             len;
> >        *      u16                             ksym_type;
> >        *      u16                             flags;
> >        *      u64                             data[2];
> >        *      char                            name[];
> >        *      struct sample_id                sample_id;
> >        * };
> >        */

Right; elsewhere you proposed keeping PERF_RECORD_BPF_EVENT for that;
which I think is clearer.

I think you can keep much of the current patches for that in fact.
