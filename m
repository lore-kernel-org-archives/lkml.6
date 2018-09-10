Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA56C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9B8204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcF3fZ1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeIJNfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:35:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39903 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeIJNfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:35:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so20528261wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uwmPfUUeuaJXElutvLLPRRn4POqiBCgn/iDJbE0P1v8=;
        b=XcF3fZ1tUI0WPbxHuRWaw2bBBwD3e9dCTDg7joDsIfhWeS8VlMOgYu+QmtwjN3ikQN
         Ol2hX6rOURboknAWg6d4hG4/kzWtw2i4YvSYe9a+47XaJJXgbfAa6wOSLtSa9Y7YM7tC
         DQRdLx3hCJ69kL3LgxAhO1HekXuQpiSwmtGwvz38LwrGwrpwzW4gL2dvZ5Ms6Hx8AbbB
         G/YuIjlbHoGHRmb1gBCok5nVM42XN+wzFM1GjHn/TCHgzVWYEzuNz1eBnfMP//W19vNr
         0GvUtyRjYR/Faax7GoocefGyy0rsaISVBxbnRnIFpr+MhY67NqC/3+SqtaQOcu50Fhnx
         paUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uwmPfUUeuaJXElutvLLPRRn4POqiBCgn/iDJbE0P1v8=;
        b=Kua1m0e6FTNDDDiMOw14gXHgG8h4F9V+V/eddubIbdHioLikeRd9q79kwIkierIsDz
         LprefYY4vKt5Uqk3KIPZlivJCYFjZupVjzIJRxi3m/bE/bb3GJaCT3+arVeEX0dmBLyW
         vuVkiqLZJDSN32HmaDS/jEEv5xvsSYZMQ+9AZFZWL/mMCYTKhxo7oRuGlEeATeOGptW5
         DD2+6oClVNGEhp6IV952WVHCpl2pEdS7bCWQJxTRgg4c+s7fNRCEqbokDH2cC2nJBO5M
         bhRDBZShUm62VLQdEKzHO7HP6EY5mg79hf/tYM1rslJA1/F684QUw6bn6LiWbSyT3hk4
         vQYw==
X-Gm-Message-State: APzg51Bxx1B2Emt9nTlXQuByvFQDhxQwBLsEjPssYbdwwc7/qmS1Glsz
        GTJ8aHR5pbvAC8gwqhUX1sA=
X-Google-Smtp-Source: ANB0Vda9Ep7iRKl7Cg2YDivwcJtTiPYkL4RHfAjDVSfuUBCWo6h+HxOhxfiCVmhcMdtMmJ1PQ4xyJA==
X-Received: by 2002:a1c:dcf:: with SMTP id 198-v6mr12424697wmn.131.1536568960157;
        Mon, 10 Sep 2018 01:42:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s131-v6sm17473328wmf.2.2018.09.10.01.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 01:42:39 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:42:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/6] sched/numa: Stop multiple tasks from moving to the
 cpu at the same time
Message-ID: <20180910084237.GC48257@gmail.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533276841-16341-2-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533276841-16341-2-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> Task migration under numa balancing can happen in parallel. More than
> one task might choose to migrate to the same cpu at the same time. This
> can result in
> - During task swap, choosing a task that was not part of the evaluation.
> - During task swap, task which just got moved into its preferred node,
>   moving to a completely different node.
> - During task swap, task failing to move to the preferred node, will have
>   to wait an extra interval for the next migrate opportunity.
> - During task movement, multiple task movements can cause load imbalance.

Please capitalize both 'CPU' and 'NUMA' in changelogs and code comments.

> This problem is more likely if there are more cores per node or more
> nodes in the system.
> 
> Use a per run-queue variable to check if numa-balance is active on the
> run-queue.
> 
> specjbb2005 / bops/JVM / higher bops are better
> on 2 Socket/2 Node Intel
> JVMS  Prev    Current  %Change
> 4     199709  206350   3.32534
> 1     330830  319963   -3.28477
> 
> 
> on 2 Socket/4 Node Power8 (PowerNV)
> JVMS  Prev     Current  %Change
> 8     89011.9  89627.8  0.69193
> 1     218946   211338   -3.47483
> 
> 
> on 2 Socket/2 Node Power9 (PowerNV)
> JVMS  Prev    Current  %Change
> 4     180473  186539   3.36117
> 1     212805  220344   3.54268
> 
> 
> on 4 Socket/4 Node Power7
> JVMS  Prev     Current  %Change
> 8     56941.8  56836    -0.185804
> 1     111686   112970   1.14965
> 
> 
> dbench / transactions / higher numbers are better
> on 2 Socket/2 Node Intel
> count  Min      Max      Avg      Variance  %Change
> 5      12029.8  12124.6  12060.9  34.0076
> 5      13136.1  13170.2  13150.2  14.7482   9.03166
> 
> 
> on 2 Socket/4 Node Power8 (PowerNV)
> count  Min      Max      Avg      Variance  %Change
> 5      4968.51  5006.62  4981.31  13.4151
> 5      4319.79  4998.19  4836.53  261.109   -2.90646
> 
> 
> on 2 Socket/2 Node Power9 (PowerNV)
> count  Min      Max      Avg      Variance  %Change
> 5      9342.92  9381.44  9363.92  12.8587
> 5      9325.56  9402.7   9362.49  25.9638   -0.0152714
> 
> 
> on 4 Socket/4 Node Power7
> count  Min      Max      Avg      Variance  %Change
> 5      143.4    188.892  170.225  16.9929
> 5      132.581  191.072  170.554  21.6444   0.193274

I have applied this patch, but the zero comments benchmark dump is annoying, as the numbers do 
not show unconditional advantages - there's some increases in performance and some regressions. 

In particular this:

> dbench / transactions / higher numbers are better
> on 2 Socket/4 Node Power8 (PowerNV)
> count  Min      Max      Avg      Variance  %Change
> 5      4968.51  5006.62  4981.31  13.4151
> 5      4319.79  4998.19  4836.53  261.109   -2.90646

is concerning: not only did we lose some performance, variance went up by a *lot*. Is this just 
a measurement fluke? We cannot know and you didn't comment.

Thanks,

	Ingo
