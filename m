Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1554EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59B7213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547149929;
	bh=5AvJezT9hX+Sf2TVBg9FMct1q3FOwWN0xMvrugCZDLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XAtJHtJtmfv1QzZcIgHNxU8YMt1x+CI1ZS1yXrXs2h5Az3uDMaza4CQP4apRvfACr
	 R6x0p0eviqN92hXcpOjunRl/ewG2bKupcWUz/t5SXyt1KOF8PwXTb1CNt2uo8b3GJf
	 3XhGE9YkQN9f4nwKzFQhvGYWYsbw0TVGkl2Aa0D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfAJTwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfAJTwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:52:08 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E3D720879;
        Thu, 10 Jan 2019 19:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547149926;
        bh=5AvJezT9hX+Sf2TVBg9FMct1q3FOwWN0xMvrugCZDLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pqx99ed2VdryJL5MjIH+Hi/LLNtjb3O4Q70wcF63mR2WQVJZI+Ez+Qx/r1J0zgW5T
         F+Hk9E/md34RWrIec7oyL7ep5QF69r4v8Uvve4eDg5kxrMIgM+WU4U0xhUkhu8ykjQ
         hPm499KOGM429BKlSGii+qUwUownBz3hWyVcgQi4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F13041AB5; Thu, 10 Jan 2019 16:52:03 -0300 (-03)
Date:   Thu, 10 Jan 2019 16:52:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Message-ID: <20190110195203.GP22483@kernel.org>
References: <20190109192111.130995-1-songliubraving@fb.com>
 <20190109192111.130995-2-songliubraving@fb.com>
 <20190110182403.GN22483@kernel.org>
 <064FBBA4-A0D0-4335-BCE7-902724CE2988@fb.com>
 <20190110185524.GO22483@kernel.org>
 <CCB26BF8-9FF5-4BBF-84BE-878CF0D3882A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CCB26BF8-9FF5-4BBF-84BE-878CF0D3882A@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 10, 2019 at 07:30:22PM +0000, Song Liu escreveu:
> 
> 
> > On Jan 10, 2019, at 10:55 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Thu, Jan 10, 2019 at 06:40:37PM +0000, Song Liu escreveu:
> >> 
> >> 
> >>> On Jan 10, 2019, at 10:24 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>> 
> >>> Em Wed, Jan 09, 2019 at 11:21:05AM -0800, Song Liu escreveu:
> >>>> For better performance analysis of dynamically JITed and loaded kernel
> >>>> functions, such as BPF programs, this patch introduces
> >>>> PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
> >>>> register/unregister information to user space.
> >>>> 
> >>>> The following data structure is used for PERF_RECORD_KSYMBOL.
> >>>> 
> >>>>   /*
> >>>>    * struct {
> >>>>    *      struct perf_event_header        header;
> >>>>    *      u64                             addr;
> >>>>    *      u32                             len;
> >>>>    *      u16                             ksym_type;
> >>>>    *      u16                             flags;
> >>>>    *      char                            name[];
> >>>>    *      struct sample_id                sample_id;
> >>>>    * };
> >>>>    */
> >>> 
> >>> So, I couldn't find where this gets used, the intention here is just to
> >>> add the interfaces and afterwards is that you will wire this up? I would
> >>> like to test the whole shebang to see it working.
> >> 
> >> I guess you meant PERF_RECORD_BPF_EVENT not being used? 
> >> 
> >> PERF_RECORD_KSYMBOL is used by BPF in 3/7 and 5/7. I tested 
> > 
> > Oops, I didn't look at 3/7, just read its cset summary line and as it
> > says:
> > 
> > Subject: [PATCH v6 perf, bpf-next 3/7] perf, bpf: introduce PERF_RECORD_BPF_EVENT
> > 
> > I didn't thought it was related, perhaps break it down into one that
> > states that it is wiring up PERF_RECORD_KSYMBOL, and at that point we
> > could just test it, getting the notifications for new kallsyms related
> > to BPF?
> 
> Good idea! I will split it into two patches as:
> 
> [3/8] perf, bpf: generate PERF_RECORD_KSYMBOL for BPF program 
> [4/8] perf, bpf: introduce PERF_RECORD_BPF_EVENT

Thanks! I'm juggling a lot of stuff right now, so I didn't read all
patches in the series, just the first one and when I couldn't find where
perf_event_ksymbol() was being called in that patch nor by looking at
just the Subject for the others, I gave up and got back to pahole day :-)
 
> >> PERF_RECORD_BPF_EVENT with dump_trace. As we separate RECORD_KSYMBOL from
> >> RECORD_BPF_EVENT, user space won't use BPF_EVENT until annotation support.  
> > 
> > Right, so why not just introduce PERF_RECORD_KSYMBOL, make it be used by
> > tooling, etc, then move on to PERF_RECORD_BPF_EVENT?
> 
> I'd like to make sure we all agree on the new ABI for RECORD_KSYMBOL and 
> RECORD_BPF_EVENT. Multiple user space tools dependent on RECORD_BPF_EVENT,
> for example, bcc and auditing. Finalizing RECORD_BPF_EVENT will unblock the 
> development of these tools. On perf side, it will take us quite some time 
> to finish annotation. Ideally, I don't want to block the development of 
> other tools for so long. 

With that 3/7 split I guess we can go on with what is in this patchset
if PeterZ is happy with it.

- Arnaldo
