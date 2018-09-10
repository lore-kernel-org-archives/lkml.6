Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7B2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D90E20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj6d/tFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D90E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeIJRAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:00:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41092 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeIJRAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:00:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so21654033wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i4oYvPpyhGbaZbTzF7HKhVMHFDnPFFErzh4WQuUMuOM=;
        b=lj6d/tFxWuzPLxeZXMqyAyxWweb65ycSgZvB/oQ+Z7ExQf8eFgz5PqasKyK14/pLT0
         ooeS9tGP02LO+uCD2cYae4atEIuulQJj3QLmGO4W7K2CWgYU11NRnFelAb7OOoXLGLfe
         iltV9os0ZEY5UZ8LBROuXvUO9BamB0+TsUdtmyJ0UVioCg3i0jy2Z1MQMwIaXMZO6gF6
         TeqBHeFeuuqqvH/THwr+e5zTfJaBALRtQXSNS6t4znTpLBuWtPngKFmn2SVyutgHQ3Fk
         qAQgqGhJSAQmSb0i6n74FEiZFqXRfhjpxSfTUM7UuRSbcXZtzp8SyxyUv+6VlQjw48xu
         L8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4oYvPpyhGbaZbTzF7HKhVMHFDnPFFErzh4WQuUMuOM=;
        b=M0KO5yLPv4bs77iCl1nRlCtz1kOy0kALwoMk621h2YR/dqCPDJwR7BgIhrGd2hhagP
         UBKY47pR5lAcvOcyI5EuLvujuDwdfAidAo3o/MSGK5pw2T1N4eOeicrb7y1vyfgkcnBa
         NcPrUgfdsApBTR/md8TLavc45auB+90JY6PKNgttzykVRQPl0SGDiYzwjXh7djQDya2W
         pOkDr+A43czJwvDPxg75SJdxFsbOze87gYvV5noa+z3yk2H3LP0TEbopOUlKiErGWGaY
         +9pdoxJEiQ3GOU0aUjVBEfsUMV/xqAnVMmhH8i834N5DKdt3P84PQ+Nm/2hUfpV47EsW
         7nqQ==
X-Gm-Message-State: APzg51BaMkVGnaIHeSMG7r0lIwOzK/Dsv50Bq6DxSiZKWaMkSPT7OGIe
        yaIffxPCvW80g/pNJmWLZb0=
X-Google-Smtp-Source: ANB0VdZ3sDa/uEFGTqwSAL+snkArlNGVZXlGwTvdXx2z0q4F/LOq5NTtQYvAud6siPd3j2qMrOWN6g==
X-Received: by 2002:adf:c08c:: with SMTP id d12-v6mr14571212wrf.268.1536581206620;
        Mon, 10 Sep 2018 05:06:46 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 200-v6sm28084860wmv.6.2018.09.10.05.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 05:06:45 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:06:43 +0200
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
Message-ID: <20180910120643.GA4217@gmail.com>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
 <2c5d4b01-0eb8-f97e-6a70-44be7961d7f8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5d4b01-0eb8-f97e-6a70-44be7961d7f8@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Budankov <alexey.budankov@linux.intel.com> wrote:

> Hi Ingo,
> 
> On 10.09.2018 12:18, Ingo Molnar wrote:
> > 
> > * Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> > 
> >>
> >> Currently in record mode the tool implements trace writing serially. 
> >> The algorithm loops over mapped per-cpu data buffers and stores 
> >> ready data chunks into a trace file using write() system call.
> >>
> >> At some circumstances the kernel may lack free space in a buffer 
> >> because the other buffer's half is not yet written to disk due to 
> >> some other buffer's data writing by the tool at the moment.
> >>
> >> Thus serial trace writing implementation may cause the kernel 
> >> to loose profiling data and that is what observed when profiling 
> >> highly parallel CPU bound workloads on machines with big number 
> >> of cores.
> > 
> > Yay! I saw this frequently on a 120-CPU box (hw is broken now).
> > 
> >> Data loss metrics is the ratio lost_time/elapsed_time where 
> >> lost_time is the sum of time intervals containing PERF_RECORD_LOST 
> >> records and elapsed_time is the elapsed application run time 
> >> under profiling.
> >>
> >> Applying asynchronous trace streaming thru Posix AIO API
> >> (http://man7.org/linux/man-pages/man7/aio.7.html) 
> >> lowers data loss metrics value providing 2x improvement -
> >> lowering 98% loss to almost 0%.
> > 
> > Hm, instead of AIO why don't we use explicit threads instead? I think Posix AIO will fall back 
> > to threads anyway when there's no kernel AIO support (which there probably isn't for perf 
> > events).
> 
> Explicit threading is surely an option but having more threads 
> in the tool that stream performance data is a considerable 
> design complication.
> 
> Luckily, glibc AIO implementation is already based on pthreads, 
> but having a writing thread for every distinct fd only.

My argument is, we don't want to rely on glibc's choices here. They might
use a different threading design in the future, or it might differ between
libc versions.

The basic flow of tracing/profiling data is something we should control explicitly,
via explicit threading.

BTW., the usecase I was primarily concentrating on was a simpler one: 'perf record -a', not 
inherited workflow tracing. For system-wide profiling the ideal tracing setup is clean per-CPU 
separation, i.e. per CPU event fds, per CPU threads that read and then write into separate 
per-CPU files.

Thanks,

	Ingo
