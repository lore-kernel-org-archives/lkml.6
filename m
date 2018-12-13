Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF98DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741C520870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="171aqW0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741C520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbeLMP0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:26:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbeLMP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bBoWsBAd6c+oO3kNPmsMZYpOJ3GRF09AaluDtAZFk9E=; b=171aqW0th24muI1/YD0j3q4xq
        10UFKfjRuBJbnraXPEGnu9ONCGJ6cO9vjhYFni5O8TCXk33Du4Y0TAI1vy+GNpQu562kP1+PCPyn9
        oVh/SWHBhMv/XIzkLlO7fie9lg2NuxcBz9/B20DDptCJPY7wnmuiGpcCSCkly45EdUuNVTN8qrVqK
        KCqTL6I8WVmUo8n/ZVyUcKS8h16j+e/Ieo87yH0McProD91BhzmMPkTxVXXvp8QQbXzxZPZMPfHTu
        PmlircRY2xU4AcRikGDJnPlpGvJjU5Tyh8rLw7tjjBkdhqY9ucQNgDMB4s/1vivBqsIkI5K1iVuaP
        DF2k2Vbjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXSs5-00057Y-Pt; Thu, 13 Dec 2018 15:25:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A440207264EB; Thu, 13 Dec 2018 16:25:51 +0100 (CET)
Date:   Thu, 13 Dec 2018 16:25:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20181213152551.GL5289@hirez.programming.kicks-ass.net>
References: <20181211233351.4036381-1-songliubraving@fb.com>
 <20181211233351.4036381-2-songliubraving@fb.com>
 <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
 <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
 <20181212180553.GC5289@hirez.programming.kicks-ass.net>
 <3D79DAF3-0746-41A2-B902-E1D99F098AF9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D79DAF3-0746-41A2-B902-E1D99F098AF9@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 06:56:11PM +0000, Song Liu wrote:
> 
> 
> > On Dec 12, 2018, at 10:05 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Dec 12, 2018 at 05:09:17PM +0000, Song Liu wrote:
> >>> And while this tracks the bpf kallsyms, it does not do all kallsyms.
> >>> 
> >>> .... Oooh, I see the problem, everybody is doing their own custom
> >>> kallsym_{add,del}() thing, instead of having that in generic code :-(
> >>> 
> >>> This, for example, doesn't track module load/unload nor ftrace
> >>> trampolines, even though both affect kallsyms.
> >> 
> >> I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload. 
> >> That could be separate sets of patches. 
> > 
> > So I would actually like to move bpf_lock/bpf_kallsyms/bpf_tree +
> > bpf_prog_kallsyms_*() + __bpf_address_lookup() into kernel/kallsyms.c
> > and also have ftrace use that.
> > 
> > Because currently the ftrace stuff is otherwise invisible.
> > 
> > A generic kallsym register/unregister for any JIT.
> 
> I guess this is _not_ a requirement for this patchset? BPF program has
> special data (id, sub_id, tag) that we need PERF_RECORD_BPF_EVENT. So 
> this patchset should be orthogonal to the generic kallsym framework?

Well, it is a question of ABI. I don't like mixing the kallsym updates
with the BPF updates.
