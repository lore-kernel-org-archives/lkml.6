Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48876C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E9F2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+XNJtgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E9F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeIJNcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:32:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40320 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbeIJNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:32:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so20364900wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+wshDsuPePzrXYx1p9iQwM/p219pjz8+Y8yZkLdsBD4=;
        b=l+XNJtgZxjjaQa43w/Bw7axnc4boKlF3n0JgMzsI1uhH8nNPIoiYqdaXL/HvyTr3t1
         qkaHOEGcY+maQ1ZpWsgBvbiOK2x8ExHUT5sHX0GCu58IaTrYnGphJ1WQD92ZOYOQEtag
         dwzMvTuMU8giMRBZfKY/4sSZQMmsY2W35gzIcjmqseJfCtW4KZD58gXf8YfCwRf23A3U
         j7GIgVqbKv4UwNxo6bwFQCSoMqQnMXz7J/dkLHMlsqlYW2L6gfXNWG4Awo3s3ihHfaND
         gKkkUN8tlk7AYwwQQUa4GXp7MYSjp9PS8EEbsyY3r9sU5bOBt7xLQ2QrVleVe7PRw9X4
         XL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+wshDsuPePzrXYx1p9iQwM/p219pjz8+Y8yZkLdsBD4=;
        b=d8RNOGO8BNws9gZcq8urFx1NC5wiv7Xj+8oBJkygQiBmURlVafhT9fG3BGFzqM/eqT
         WXBs0mvWoLBeryzhKq6/uYRPTahhxuiXIM/Vw2S2opHCKddT2UYHLJtnK1mYkK5SBhkI
         Sorfj95s/1d2+bJ7i8fYEFvvCn1i5vPV5OTa3uls7zCqGPEDZt1m7ZJu/FUB7oMksNWS
         +n0+42AKCG9e9+03FELN7G6K2jNThFKEpQKxIPtkXgPkR+mE21YgfXqGU8bLUANNQbF7
         lMhAH4efi+Pwk6xVsXKLRkTuFvnfgy2ExiF3/j7AMbHO4AhHQo4FI4Jl39v/J2Eaew2q
         SaBg==
X-Gm-Message-State: APzg51BEz14YFj4lNcZDoukwbkDbFIr+jP71wcXeBeXyH6HWnz9Qawkz
        /6/SyftRis106ve1zPkHoeU=
X-Google-Smtp-Source: ANB0VdYB8bP8Pzk/sDSciG1geq/F/dpn8MTI5iISmRKJUjG8npnXDcNGAjWs3AXO+2HDerUVvZllbw==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr11549451wmd.18.1536568767754;
        Mon, 10 Sep 2018 01:39:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x65-v6sm17020833wmg.39.2018.09.10.01.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 01:39:27 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:39:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/6] mm/migrate: Use trylock while resetting rate limit
Message-ID: <20180910083925.GB48257@gmail.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533276841-16341-3-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533276841-16341-3-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> Since this spinlock will only serialize migrate rate limiting,
> convert the spinlock to a trylock. If another task races ahead of this task
> then this task can simply move on.
> 
> While here, add correct two abnormalities.
> - Avoid time being stretched for every interval.
> - Use READ/WRITE_ONCE with next window.
> 
> specjbb2005 / bops/JVM / higher bops are better
> on 2 Socket/2 Node Intel
> JVMS  Prev    Current  %Change
> 4     206350  200892   -2.64502
> 1     319963  325766   1.81365
> 
> 
> on 2 Socket/2 Node Power9 (PowerNV)
> JVMS  Prev    Current  %Change
> 4     186539  190261   1.99529
> 1     220344  195305   -11.3636
> 
> 
> on 4 Socket/4 Node Power7
> JVMS  Prev    Current  %Change
> 8     56836   57651.1  1.43413
> 1     112970  111351   -1.43312
> 
> 
> dbench / transactions / higher numbers are better
> on 2 Socket/2 Node Intel
> count  Min      Max      Avg      Variance  %Change
> 5      13136.1  13170.2  13150.2  14.7482
> 5      12254.7  12331.9  12297.8  28.1846   -6.48203
> 
> 
> on 2 Socket/4 Node Power8 (PowerNV)
> count  Min      Max      Avg      Variance  %Change
> 5      4319.79  4998.19  4836.53  261.109
> 5      4997.83  5030.14  5015.54  12.947    3.70121
> 
> 
> on 2 Socket/2 Node Power9 (PowerNV)
> count  Min      Max      Avg      Variance  %Change
> 5      9325.56  9402.7   9362.49  25.9638
> 5      9331.84  9375.11  9352.04  16.0703   -0.111616
> 
> 
> on 4 Socket/4 Node Power7
> count  Min      Max      Avg      Variance  %Change
> 5      132.581  191.072  170.554  21.6444
> 5      147.55   181.605  168.963  11.3513   -0.932842

Firstly, *please* always characterize benchmark runs. What did you find? How should we 
interpret the result? Are there any tradeoffs?

*Don't* just dump them on us.

Because in this particular case the results are not obvious, at all:

> specjbb2005 / bops/JVM / higher bops are better
> on 2 Socket/2 Node Intel
> JVMS  Prev    Current  %Change
> 4     206350  200892   -2.64502
> 1     319963  325766   1.81365
> 
> 
> on 2 Socket/2 Node Power9 (PowerNV)
> JVMS  Prev    Current  %Change
> 4     186539  190261   1.99529
> 1     220344  195305   -11.3636
> 
> 
> on 4 Socket/4 Node Power7
> JVMS  Prev    Current  %Change
> 8     56836   57651.1  1.43413
> 1     112970  111351   -1.43312

Why is this better? The largest drop is 11% which seems significant.

Thanks,

	Ingo
