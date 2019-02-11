Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE50C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECFA20811
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549871201;
	bh=YrbAkeDvFkjDWtb7fSCnwXbLF6yD8kW1PONllRZcYTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wTVcIPI7l2xpTp1+71c+sbWXVsjd0Gsw0a3BD8bU4XY1EBOaQyihHK9gr4pVQ1i+Z
	 kiII2/Xkr39HYR8thLwzKFxqcHVO7fY7dwDdsrcIu/9uSOUcDPQXsFIxHZ1Y5pgAZA
	 Lfx85XCUZphlAG7lUatyyKR0AfzxLWhsdPHoMbZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfBKHqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:46:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54826 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:46:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so15530391wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 23:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/do4ZA2SXNxDw3qOu7acglKIihonTePc/+hUqoAOiA=;
        b=j5ftAT0hOgXVCKQSb3p7i3QB9fjs5pD4rnoVuKrYnTPusRYXa0OXZYkT/kiVSoc2Ms
         bEax/KrPnma6SwxzJIbgMEofxm1bTVshwVHfR6tBQhFsNhVcEXK5NdDPcpogErIR2N5k
         o7Jmq12FAKQ41vew6w+5Un0S1PQep4ixL0pDYJAgfgAUxzaTYnvQmKPUklnenYn8uKcd
         P7Pe+oq2g07T5no1p92SIUbjMDut1rJHC44ZHm/NRDpu5RTLiYV7DlSD3RPGM/TheoYG
         a3YmUZTVc1lSIIwVTr7lWExkrO2/3QkwgxKX2jKh8YwlsHlUZNvKjPuXCL2CHTNUuGbJ
         sHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/do4ZA2SXNxDw3qOu7acglKIihonTePc/+hUqoAOiA=;
        b=QrF8wVY7G+gheR6f/YyITQSnBeWwxgT7sVvkHKVQY+xxVzuDSNYvlt7s6blrPXtoVQ
         B2+ELgVbKg9KrlTgIj8orOx0iR+itwnep2A7tljPvemkEkqr3jAzCbU2Hy9aezoTkDAS
         nToRU1eaR3DKuYwMqvBRk6Gzbe3qSc2gyJ08sqtFeXcGwQHdaE3shMZJNILDCwChJZKt
         h2wstG6MlDushBGYSrOOCupiYwW/h10d9rlm5lO+ahdPQQtzSrXxudbqbns+QfdLTtho
         Dr0gu7wuhKp+SWEmAOEVhpH5K5nUOpo/xu1DHsbAM3vPCAzz2x2CBdLb3Yk4vf7kAEDe
         wvzQ==
X-Gm-Message-State: AHQUAuYiuskySKnE8aNK1UksARJpZkIKCx315PceZ7OFOmKfvORVqg+j
        s5w7sFB7ZeNveRNejroTlEY=
X-Google-Smtp-Source: AHgI3Ib0yit5nDr6/wTG3itcP2ZKoLPhNA943SRzmsBPzV+coLsVayquKBexOmxWYFbo/zoC+WbTlQ==
X-Received: by 2002:a5d:574e:: with SMTP id q14mr16512931wrw.200.1549871196107;
        Sun, 10 Feb 2019 23:46:36 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v4sm9013370wme.6.2019.02.10.23.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 23:46:35 -0800 (PST)
Date:   Mon, 11 Feb 2019 08:46:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf, bpf: Retain kernel executable code in memory
 to aid Intel PT tracing
Message-ID: <20190211074633.GB49295@gmail.com>
References: <20190207111901.2399-1-adrian.hunter@intel.com>
 <20190207200211.GG32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207200211.GG32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Feb 07, 2019 at 01:19:01PM +0200, Adrian Hunter wrote:
> > Subject to memory pressure and other limits, retain executable code, such
> > as JIT-compiled bpf, in memory instead of freeing it immediately it is no
> > longer needed for execution.
> > 
> > While perf is primarily aimed at statistical analysis, tools like Intel
> > PT can aim to provide a trace of exactly what happened. As such, corner
> > cases that can be overlooked statistically need to be addressed. For
> > example, there is a gap where JIT-compiled bpf can be freed from memory
> > before a tracer has a chance to read it out through the bpf syscall.
> > While that can be ignored statistically, it contributes to a death by
> > 1000 cuts for tracers attempting to assemble exactly what happened. This is
> > a bit gratuitous given that retaining the executable code is relatively
> > simple, and the amount of memory involved relatively small. The retained
> > executable code is then available in memory images such as /proc/kcore.
> > 
> > This facility could perhaps be extended also to init sections.
> > 
> > Note that this patch is compile tested only and, at present, is missing
> > the ability to retain symbols.
> 
> You don't need the symbols; you already have them through
> PERF_RECORD_KSYMBOL.
> 
> Also; afaict this patch guarantees exactly nothing. It registers a
> shrinker which will (given enough memory pressure) happily free your
> text before we get around to copying it out.
> 
> Did you read this proposal?
> 
>   https://lkml.kernel.org/r/20190109101808.GG1900@hirez.programming.kicks-ass.net
> 
> (also: s/KCORE_QC/KCORE_QS/ for quiescent state)
> 
> That would create an RCU like interface to /proc/kcore and give you the
> guarantees you need, while also allowing the memory to get freed once
> you've obtained a copy.

Yeah, adding a proper change-notification interface to /proc/kcore sounds 
like a superior solution to trying to shoehorn this down perf's throat.

It's not like any of this is useful without having opened /proc/kcore.

Also, /proc/kcore is privileged, so the indefinite resource allocation 
side effect in case user-space doesn't drain the lists is OK.

Thanks,

	Ingo
