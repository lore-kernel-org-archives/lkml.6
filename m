Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A708C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63F42087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITsXeRgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63F42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeIJPGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:06:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46059 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:06:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so21251631wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YOXCKotjxOOdZ9FqN3It1xDQqaRgjVaJuy02OPwNEgY=;
        b=ITsXeRgXuKkHicVsTSQm2fNgXKBoI5WehnJeK2gD4ip/YlroUk3kWmtMaQtnyjcjfY
         xNy+Zz1+DyMNQ5QrKFSv2ofhqQ6KuFqEDKMHA9amD4w/l5eJfDG9GTpU9khw0aDbyVtt
         NXzEcbAjrCZoRia+eqA/YM2Fia16xZH5znYFRg1QgwiV/Imuq6X0irBTsEmKcxDuU/k1
         mnimDdPVzuXD9bXRHlpXC8thDr/CqwfK31e4DMm4kPXOSL/1JC29wvhU52SePDBlFXKf
         HeFwuTz+RxrYz/0AVKo3ssPF3vpwRsyi//gOkP2wHiSz++LnMeUSkvjN6OZ+IY9qqoRN
         6RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YOXCKotjxOOdZ9FqN3It1xDQqaRgjVaJuy02OPwNEgY=;
        b=g6QUcfJ0JxfZTKVq0qBFbGbQUidDL12bbpncR4wGlMyrNh2vVMPj0XZpnFg02KlHEX
         uvax4BWZGHuWBplOKc+P2dJPVuIVRuchWhcvb6cUoKNhRRfWN1TAgeeb5VrEvywRTPqx
         nfFndF/9SO3aPBcbHtCXb8PlvksHet8K9cG7iJnDoQdwrLG0ng6u/Z85A/gKllSw9EbJ
         +a/dsbEM2ExgCcy8TwQn5ADZWFkqTTa98eMrFwhlxbyP2waVjPSaFSyTT7BxsPIjuN3E
         QW8g27pvga8+SAiGWJkxL3Ardsv3/yNFLeTxnIK5lOvzem+SHlLwEJWIx3NPia5l7o/b
         YwFg==
X-Gm-Message-State: APzg51DXDA9XEivSuedQRf9wjijmM/wdtqDCoE2cuRt/dxCc+j/EuyR7
        Vz4wWXe5wFxWjrQp0C7+53M=
X-Google-Smtp-Source: ANB0VdbIvtdolWIFZpcTIe+BjzQ9DXKk/iZfwfFz1Q36dZ8a3c/62rqXECUNHPOA8Yy7nuKxsMPaqw==
X-Received: by 2002:a5d:6b8d:: with SMTP id n13-v6mr5511601wrx.149.1536574408085;
        Mon, 10 Sep 2018 03:13:28 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 72-v6sm20057038wrb.48.2018.09.10.03.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 03:13:27 -0700 (PDT)
Date:   Mon, 10 Sep 2018 12:13:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180910101325.GA5544@gmail.com>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
 <20180910095909.GA15548@krava>
 <20180910100303.GA101776@gmail.com>
 <20180910100841.GB15548@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910100841.GB15548@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Olsa <jolsa@redhat.com> wrote:

> On Mon, Sep 10, 2018 at 12:03:03PM +0200, Ingo Molnar wrote:
> > 
> > * Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > > > Per-CPU threading the record session would have so many other advantages as well (scalability, 
> > > > etc.).
> > > > 
> > > > Jiri did per-CPU recording patches a couple of months ago, not sure how usable they are at the 
> > > > moment?
> > > 
> > > it's still usable, I can rebase it and post a branch pointer,
> > > the problem is I haven't been able to find a case with a real
> > > performance benefit yet.. ;-)
> > > 
> > > perhaps because I haven't tried on server with really big cpu
> > > numbers
> > 
> > Maybe Alexey could pick up from there? Your concept looked fairly mature to me
> > and I tried it on a big-CPU box back then and there were real improvements.
> 
> too bad u did not share your results, it could have been already in ;-)

Yeah :-/ Had a proper round of testing on my TODO, then the big box I'd have tested it on
broke ...

> let me rebase/repost once more and let's see

Thanks!

> I think we could benefit from both multiple threads event reading
> and AIO writing for perf.data.. it could be merged together

So instead of AIO writing perf.data, why not just turn perf.data into a directory structure 
with per CPU files? That would allow all sorts of neat future performance features such as 
mmap() or splice() based zero-copy.

User-space post-processing can then read the files and put them into global order - or use the 
per CPU nature of them, which would be pretty useful too.

Also note how well this works on NUMA as well, as the backing pages would be allocated in a 
NUMA-local fashion.

I.e. the whole per-CPU threading would enable such a separation of the tracing/event streams 
and would allow true scalability.

Thanks,

	Ingo
