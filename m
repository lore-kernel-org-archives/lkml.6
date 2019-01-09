Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212C3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58AD2064C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FzbfNtiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfAIKSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:18:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfAIKSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4d+RGFz8Y4hV9bW1JAmHj60DlCEqv+/hXst1XUbRiy4=; b=FzbfNtiHaFbehfw1Nhc5qdLlV
        BIokaetRf6ZK59XLCzINMtSNsYfqLUX+iJdisLEUVqcrRT9UdzdhCMRXbpj+P2cxsWIeDGkKzQu1r
        lX87oF6Fnfp7kZ7640isIx6kEPEKKTzvttG0pCibStGRYPQ3PrBqpJioheZRqQI4Dez72eliEgBEr
        n1FYe7Vy/4LErwzYzS+iNz6hJMf1Rp6sHlFDaOhKxJMO9PQujJX5Q/e6Ns24JrB42WDYOOEZ+MJFh
        dgpI7O4x+YvETF5Zl5Uv43PXMEVjEFDNO5DCJAeJebKuKwvsOASZ+wTFEuF3aMtmfm8YylboerNX2
        0fpXUWLVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghAw7-000239-FY; Wed, 09 Jan 2019 10:18:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D79CA2028A2D4; Wed,  9 Jan 2019 11:18:08 +0100 (CET)
Date:   Wed, 9 Jan 2019 11:18:08 +0100
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
Message-ID: <20190109101808.GG1900@hirez.programming.kicks-ass.net>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108184116.GC30894@hirez.programming.kicks-ass.net>
 <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
 <20190108194310.GD1900@hirez.programming.kicks-ass.net>
 <A0C713E9-6ACE-4235-87C2-2653A8F22F7B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A0C713E9-6ACE-4235-87C2-2653A8F22F7B@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 11:54:04PM +0000, Song Liu wrote:

> I think Intel PT case is at instruction granularity (instead of ksymbol
> granularity)? 

Yes.

> If this is true, modules, BPF, and PT could still share
> the ksymbol record for basic profiling. And advanced use cases like 
> annotation will depend on user space to record BPF_EVENT (and equivalent
> for other cases) timely. But at least, the ksymbol is already there. 
> 
> Does this make sense?  

I'm not sure I follow; the idea was that on ksym events we copy out the
instructions using kcore. The ksym event already has addr+len.

All we need is some means of ensuring the symbol is still there by the
time we see the event and do the copy.

I think we can do this with a new ioctl() on /proc/kcore itself:

 - when we have kcore open, we queue all text-free operations on list-1.

 - when we close kcore, we drain all (text-free) list-* and perform the
   pending frees immediately.

 - on ioctl(KCORE_QC) we perform the pending free of list-3 and advance
   list-2 to list-3 and list-1 to list-2.

Perf would then open kcore at the start of the record, make a complete
copy and keep the FD open. At the end of every buffer process, we issue
KCORE_QC IFF we observed a ksym unreg in that buffer.

We use 3 lists instead of 2 to guard against races, if there was a
reg+unreg en-route but not yet visible in the buffer, then we don't want
that free to be processed. The next buffer (read) will have the event(s)
and all should be well.
