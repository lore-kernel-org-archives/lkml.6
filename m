Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00523C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E51320645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8Ir3cio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E51320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeIKLdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:33:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43973 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeIKLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:33:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so24304188wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 23:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s4n91sRXbu+9tfXiStf63pSCNYHPIctDfUjc0aY4PpI=;
        b=s8Ir3cioLmgW6yiEk+Ir3OWFyyI3juwPWcSgfzxoOKsV2Tvk2LqNsDqlf5tQx2L6g2
         OnxAZDjcPv7PvWHapWBlTjSm3pNYXok8Efmjbzo8hOG+I+diBSYfbseNE1w2Nf3YTZ9W
         bEhFHsJjIVnb7mOMimlb1K0W2Wdt60ume0LoTCD3zxeQnWf/xKpvFHcRCPoXcUMsMS2l
         tnmDKf/0YfYByZ89CNDm+a66r9aiHZVc5c4WokevJIqyDZ6/+ImhBL480nw/eVSPs7S9
         dnsX++ZVmVJ8LoGixRrAZ/t8xBhB62qJLo/gmzzqgaIeG6gj7S/QHh8DY0b7LKENNvCV
         gGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s4n91sRXbu+9tfXiStf63pSCNYHPIctDfUjc0aY4PpI=;
        b=cr2jqW981UFau63SdbON8FIc5EboY2qY9iHRoHMU/WO6QNfNOc/ZPNQV67X9iHeFRw
         Q3crraMVBFxbBJNhrnzHtzNTxHLYdJaGJ/Rc3cy0OUmDxRynxyqzLIENo3YWk5ttyWoe
         hzD6UuoIfawvZeK1YY+DIyufH1V02lUAnpl5SxFpq991BI+zmGFx0fTrlESlX84g0qaK
         65ye5fdd5tqWQdtOOLX3ngy/k1KtHNGoJZN61FZOB1XpT1uG+mKNK7Zs3TZ2PBlaO9WZ
         HTINf1PWWbr+b9W4ymV1YA8vG99Cp1Y/2cZByeP1S6gHmv9BJrZA9z2GfgLynnA2nz2G
         gA+A==
X-Gm-Message-State: APzg51CU5XhZKVbWWFVn+CgArw3XpVk4pK2mEej4VmSs9R5oTgju5uM9
        7nWTp6G59Bx8mU5iOpeA8O4=
X-Google-Smtp-Source: ANB0VdY8eRWxVLRtc95C7xCONtZQVEfx40KMr9khjiGrI6CqzvdIGg3lxW+Eo/q0zMDBNldIbDMnTw==
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr17241409wrg.249.1536647715101;
        Mon, 10 Sep 2018 23:35:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y184-v6sm101921wmg.17.2018.09.10.23.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 23:35:14 -0700 (PDT)
Date:   Tue, 11 Sep 2018 08:35:12 +0200
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
Message-ID: <20180911063512.GA130116@gmail.com>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
 <2c5d4b01-0eb8-f97e-6a70-44be7961d7f8@linux.intel.com>
 <20180910120643.GA4217@gmail.com>
 <1ad36918-ddd0-aa3c-c52e-e4e419409dd4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad36918-ddd0-aa3c-c52e-e4e419409dd4@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Budankov <alexey.budankov@linux.intel.com> wrote:

> It may sound too optimistic but glibc API is expected to be backward compatible 
> and for POSIX AIO API part too. Internal implementation also tends to evolve to 
> better option overtime, more probably basing on modern kernel capabilities 
> mentioned here: http://man7.org/linux/man-pages/man2/io_submit.2.html

I'm not talking about compatibility, and I'm not just talking about glibc, perf works under 
other libcs as well - and let me phrase it in another way: basic event handling, threading, 
scheduling internals should be a *core competency* of a tracing/profiling tool.

I.e. we might end up using the exact same per event fd thread pool design that glibc uses 
currently. Or not. Having that internal and open coded to perf, like Jiri has started 
implementing it, allows people to experiment with it.

This isn't some GUI toolkit, this is at the essence of perf, and we are not very good on large 
systems right now, and I think the design should be open-coded threading, not relying on an 
(perf-)external AIO library to get it right.

The glibc thread pool implementation of POSIX AIO is basically a fall-back 
implementation, for the case where there's no native KAIO interface to rely on.

> Well, explicit threading in the tool for AIO, in the simplest case, means 
> incorporating some POSIX API implementation into the tool, avoiding 
> code reuse in the first place. That tends to be error prone and costly.

It's a core competency, we better do it right and not outsource it.

Please take a look at Jiri's patches (once he re-posts them), I think it's a very good 
starting point.

Thanks,

	Ingo
