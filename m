Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52794C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065C0204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf/JzGRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065C0204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeIJOLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:11:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39438 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:11:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so20649007wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w0LCplrOhHERZ5DUzeh8Jos8NhRlJcNRnyd5+44KLXo=;
        b=Bf/JzGRld5FoONQkY8E3hRlfl3k+WUrrWn+aD25NFxE8vE/CZaRR9mMZ4t8pTa+EZT
         WPdVHornK1BeCh83CHX/dZZ11zIK4XDWwsJ2YKR2zPe4ctvv2TQ020VAKOSF4/DoSvbd
         rSGFHO9M16idy0lM1ck2Wkkqr8Nx0MZ/3UEq3XC5RcNkqmGwjEKssRp5/joVRPalu/CM
         nbP8L/46v4exVoODmVH79L9I7L0dERaEl2dArfHxc2zCp52RTaXAFmzN+Fbs+JTYoO2R
         KKxOVLFY2vzJd1t6Djqk4Zg7ZlUCEcFIMKjlC24ZmpxVlYIiplJknsNDSwmPZ02+QhPE
         lmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0LCplrOhHERZ5DUzeh8Jos8NhRlJcNRnyd5+44KLXo=;
        b=Wqez6nYHjVFI+FsAePfFWdThBeuVuoKwPO37megHQT5IqJB6rnI80BkCaJ3TEKM6Aa
         yNk77084TtG4Jum9ubfxQ8p2dLCxz6ztgE9J6BqdsxihXQtPFLUnWNdipP0Hs8Wd7pVG
         uNM7OzEZFUfhdLEYcH+u6K2o4B4a4bcbeGb0aGIYSO9AUMBCMEjTNp9ujktoXQNYKl10
         IFpHkqfEYUGUmFMrOay2s4hKleWRTnVfnfAXPlA01DUkd+Z93+uoHOeKjykQpMMkVcch
         Zjl2Szfwfh5WtV7FsyGK0UUrMNPRs+HapRPZHrh9oGcaZ429LRW7sUoWD3FKZB8A45R9
         bAbA==
X-Gm-Message-State: APzg51AwNPwtKlu8OcpedRX/al+bzBf8nVhq22i2G4+yeLwrd3o4vccu
        NPdlZrS1tUsW58Uzq9F8Mgw=
X-Google-Smtp-Source: ANB0VdaOJWeuN+urL1vvmmUAmhzVH40o7bovlwmkok3CZqS6gNtK0xZ1T7STUSLdZrmZZqqbRiwsSQ==
X-Received: by 2002:a1c:c3:: with SMTP id 186-v6mr46510wma.126.1536571124367;
        Mon, 10 Sep 2018 02:18:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j66-v6sm20637400wrj.28.2018.09.10.02.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 02:18:43 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:18:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180910091841.GA4664@gmail.com>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Budankov <alexey.budankov@linux.intel.com> wrote:

> 
> Currently in record mode the tool implements trace writing serially. 
> The algorithm loops over mapped per-cpu data buffers and stores 
> ready data chunks into a trace file using write() system call.
> 
> At some circumstances the kernel may lack free space in a buffer 
> because the other buffer's half is not yet written to disk due to 
> some other buffer's data writing by the tool at the moment.
> 
> Thus serial trace writing implementation may cause the kernel 
> to loose profiling data and that is what observed when profiling 
> highly parallel CPU bound workloads on machines with big number 
> of cores.

Yay! I saw this frequently on a 120-CPU box (hw is broken now).

> Data loss metrics is the ratio lost_time/elapsed_time where 
> lost_time is the sum of time intervals containing PERF_RECORD_LOST 
> records and elapsed_time is the elapsed application run time 
> under profiling.
> 
> Applying asynchronous trace streaming thru Posix AIO API
> (http://man7.org/linux/man-pages/man7/aio.7.html) 
> lowers data loss metrics value providing 2x improvement -
> lowering 98% loss to almost 0%.

Hm, instead of AIO why don't we use explicit threads instead? I think Posix AIO will fall back 
to threads anyway when there's no kernel AIO support (which there probably isn't for perf 
events).

Per-CPU threading the record session would have so many other advantages as well (scalability, 
etc.).

Jiri did per-CPU recording patches a couple of months ago, not sure how usable they are at the 
moment?

Thanks,

	Ingo
