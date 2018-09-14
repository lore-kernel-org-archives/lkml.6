Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F3BFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAE220882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTxdPcWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAE220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeINR10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:27:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53522 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeINR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:27:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so1718279wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PilsJ2yt8Dc/NO7/jP/6FxhAqs4vfIXRQyPe0pg/H+4=;
        b=VTxdPcWpkJsDcyYYzddtsccrSpEvclILesA/VQ+D4aKkSOcXWSDqFFPrS6ZaVfVQhO
         deCvY0H3mANoi2pnkGs6SRQ7ixfb3NcjMoZWaPbvXxc1g5lNc1yZ/xKiA9MCQsYGPR1r
         uhdP13OpcvtFWeKNA35K9/vAE+uLL4WxB8TaWrU5/HrkehkpWRnfX0CRlUfx2lvOVEKR
         ylJ0RjBeOqmTlKTFNpwM3W5OMtewKPUNYm1edi6RBiFZMk9AIo8NYI/Wc1LZSf0oYYEF
         xM4FAucfwNSLgjVao6aaTjh9JbyaDWwvZ9OT+81wLNftCnyTQilJn5gmo7tm4Q0cLBtr
         J/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PilsJ2yt8Dc/NO7/jP/6FxhAqs4vfIXRQyPe0pg/H+4=;
        b=jfCm3YbeddmkiqDSRCBsYC5rsb2iKQAlEWYavqkuqr5uKqrqEMLSfS1ia+sabV29e3
         dDjyyocLjCqG3Cum/AzjI0QLnjxkWP0RTjTpGtBDYEZNnZzJhVKPQLcAYeGlVYdz6QuH
         teSN9+ekz28rmZrUUJRRrwKSFg7dR/T6xlJmrflRYGIGnCSHAcSWmNlf35R82NDURMtK
         GXDIJitJfWkurxSnLOzzO7niMAJwNsssDRGf+HWSYJrgBzPMiiI6s99JQtlPvzU8xOly
         XWkPXFwwsWH4KhWMA5Cr5ht9sBUbjrP99x4KVAWFLKEmsaEBKQoQEQKZN0JVKOyAb80k
         J3qw==
X-Gm-Message-State: APzg51BgwvP+qBYwrssPGn0VG2bp1rLLNzqbVLShusNiwZwwq9mSfWcM
        m5hgdq5uFXfZ1Y+QeA5lP6E=
X-Google-Smtp-Source: ANB0VdaJeME89oZmNOo1AAvmCzxGvciDJEfA1NNndrb9ZxIXAkDgFCJqxcFiNGi3U+UpUjzf3zPFdg==
X-Received: by 2002:a1c:1d87:: with SMTP id d129-v6mr2046233wmd.34.1536927190588;
        Fri, 14 Sep 2018 05:13:10 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 204-v6sm3040991wmh.25.2018.09.14.05.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 05:13:09 -0700 (PDT)
Date:   Fri, 14 Sep 2018 14:13:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>, kernel-team@lge.com
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914121307.GA98534@gmail.com>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914022910.GA15146@sejong>
 <20180914082307.GF24224@krava>
 <20180914094022.GB96351@gmail.com>
 <20180914111528.GH24124@hirez.programming.kicks-ass.net>
 <20180914114725.GB17042@krava>
 <20180914120129.GJ24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914120129.GJ24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Sep 14, 2018 at 01:47:25PM +0200, Jiri Olsa wrote:
> > On Fri, Sep 14, 2018 at 01:15:28PM +0200, Peter Zijlstra wrote:
> > > On Fri, Sep 14, 2018 at 11:40:22AM +0200, Ingo Molnar wrote:
> > > > In fact keeping the files separate has scalability advantages for 'perf report' and similar 
> > > > parsing tools: they could read all the streams in a per-CPU fashion already, from the very 
> > > > beginning.
> > > 
> > > Also writing to different files from different CPUs is good for record,
> > > less contention on the inode state (which include pagecache).
> > 
> > maybe I should explain a little bit more on this
> > 
> > we write to different (per-cpu) files during the record,
> > and at the end of the session, we take them and store
> > them inside perf.data
> 
> How long does it take to combine that? If we generated a lot of data,
> that could take a fair amount of time, no?
> 
> I feel that record should not mysteriously 'hang' when it is done. It
> used to do that at some point because of that stupid .debug crap, but
> acme fixed that I think.

Agreed - plus at the report stage it would be advantageous to be able to *read* per-cpu files 
as well.

If we do things smartly them report will create similar NUMA affinity as the record session 
used.

Thanks,

	Ingo
