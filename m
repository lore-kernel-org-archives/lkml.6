Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D36C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C9120578
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ABFxu0l3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfAIM7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:59:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35326 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbfAIM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lQr2MMBoooeIZvC1sUfkR9ACXBzS1/uLXOD1DM7niPs=; b=ABFxu0l3NG6E2RiEmgS9ME/NS
        RNmjfbTNoRRikIdd52//Me9ROpFO2MG7QwNNRQjGsmkPtL+pE0E6aC6etQvOmgZZhS66b15weNXQd
        W1+6ELlKxmq+GS8nVzqL7DI2QNnRox9WwPmcl150gK3y9CgYpxJESbIAOHK5mXkte6F8edFUdR7+J
        cDdRyIgeXAZ19rdXBtJr0ZSuh7Ons364DEKgM1iEYEfjC6+A6eL4EqUSs9jzTSB1JRnkBgi04QsOJ
        d2Zmw4j9X19Xn7OX8qYhnd6/ESqntBWBtOzO4uPsw5fXECHy4P5w7TQwM66bg+ZDplwtfSFXQHz2I
        DZgWXHpQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghDSN-0000db-LI; Wed, 09 Jan 2019 12:59:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7170520281DDA; Wed,  9 Jan 2019 13:59:38 +0100 (CET)
Date:   Wed, 9 Jan 2019 13:59:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20190109125938.GJ1900@hirez.programming.kicks-ass.net>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108184116.GC30894@hirez.programming.kicks-ass.net>
 <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
 <20190108194310.GD1900@hirez.programming.kicks-ass.net>
 <A0C713E9-6ACE-4235-87C2-2653A8F22F7B@fb.com>
 <20190109101808.GG1900@hirez.programming.kicks-ass.net>
 <924AE46C-B2B9-4E17-A6FC-C678FEADC03B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924AE46C-B2B9-4E17-A6FC-C678FEADC03B@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 11:32:50AM +0000, Song Liu wrote:
> I was thinking about modifying the text in-place scenario. In this case, 
> we can use something like
> 
> struct perf_record_text_modify {
>     u64 addr;
>     u_big_enough old_instr;
>     u_big_enough new_instr;

char[15] for x86 ;-)

Also, I don't think we need old, we should already have the old text,
either from a previous event or from the initial kcore snapshot.

>     timestamp ;

that lives in struct sample_id.

> };
> 
> It is a fixed size record, and we don't need process it immediately 
> in user space. At the end of perf run, a series of these events will 
> help us reconstruct exact text at any time. 

That works for text_poke users, see also:

  https://lkml.kernel.org/r/20190109103544.GH1900@hirez.programming.kicks-ass.net

But is useless for module / bpf / ftrace dynamic text.

> > All we need is some means of ensuring the symbol is still there by the
> > time we see the event and do the copy.
> > 
> > I think we can do this with a new ioctl() on /proc/kcore itself:
> > 
> > - when we have kcore open, we queue all text-free operations on list-1.
> > 
> > - when we close kcore, we drain all (text-free) list-* and perform the
> >   pending frees immediately.
> > 
> > - on ioctl(KCORE_QC) we perform the pending free of list-3 and advance
> >   list-2 to list-3 and list-1 to list-2.
> > 
> > Perf would then open kcore at the start of the record, make a complete
> > copy and keep the FD open. At the end of every buffer process, we issue
> > KCORE_QC IFF we observed a ksym unreg in that buffer.
> 
> Does this mean we need to scan every buffer before writing it to perf.data 
> during perf-record? 

Just like the BPF events, yes. Now for PT most of the actual data is not
in the regular buffer, so it shouldn't be too horrible, but just like
the BPF event, it can get its own buffer if it does become a problem.

> Also, if we need ksym unreg here, I guess it is NOT really modifying text 
> in-place, but creating new version and swap? Then can we include something 
> like this in perf.data:
> 
> struct perf_record_text_modify {
>     u64 old_addr;
>     u64 new_addr;
>     u32 old_len; /* up to MAX_SIZE */
>     u32 new_len; /* up to MAX_SIZE */
>     u8 old_text[MAX_SIZE];
>     u8 new_text[MAX_SIZE];
>     timestamp ;
> };
> 
> In this way, this record is embedded in perf.data, and doesn't require
> extra processing during perf-record (only at the end of perf-record). 
> This would work for text modifying case, as modifying text is simply
> old-text to new-text.
>  
> Similar solution would not work for BPF case, as bpf_prog_info is 
> getting a lot more members in the near future. 
> 
> Does this make sense...?

I don't think we actually need old_text here either. We're creating a
new text mapping, there was nothing there before.

But still, perf events are limited to 64k, so that means we cannot
support symbols larger than that (although I suppose that would be
fairly rare).

Something like that could work, but I'm not sure it is actually better.
Some PT person would have to play with things I suppose.


