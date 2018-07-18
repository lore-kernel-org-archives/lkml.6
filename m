Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB2B2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="cOQbwKhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB2B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeGRWdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:33:52 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37717 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbeGRWdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:33:52 -0400
Received: by mail-yb0-f195.google.com with SMTP id r3-v6so2468265ybo.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=97AZiZvtK6lsL3fru/ZpGGEtAAQ5rvikpgO5M2WEQLY=;
        b=cOQbwKhNq/HEGZyKB8wNjyAhCcmvzk5lptyZTs2+HOjnhPunJDnykUjHRybl84kZJf
         FiNt+HZo8pLQp+T2T/LGoQkZ94ro5XbE5k3XUKok3W15mYDDI/JCmtM9c1Czav/GdMy9
         +3lEI2n5ywsU6ItSZLybGe9aEylVoyBRy1hMIKaYvvGDHiCCI/i5gCEU4Aawzbv3S9K0
         mWGpJplcJGmix3S+7FC8lrBcNZsL2Uo3gJtDW7Gf+adIGwFb+R2K6zgZWAcL13SnvhQT
         bxgaJsaoMnRUOUXV1kb5/Qe7aMrVbVMXwIpV+hZ5NnAEoGulNidM++07Mm5UPXgsv1Fx
         a+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=97AZiZvtK6lsL3fru/ZpGGEtAAQ5rvikpgO5M2WEQLY=;
        b=KUXU43lDcyiyYXUOMTPp/lBlqlvljULcP/2576MTTwcPh/smmaR4USx7Yy8Ca9uoaW
         CgnqIAbQWNMFvXvnt+aHlFXiOF2rqSsJPjEtVsJkgq+jyYdl0r4MaLFEzMvYU5MyT3lr
         6Bkl2zsJcaYxDt1Ok0xg2c3RUS0T2X/+M50fWDqmLK1tIF4C2iLkXVrcNNN3XKHh2wYb
         mv9rLhXQa+dn4oZnPW4dtAZVYWvbyEgQXEgLYCO7Us1YeK/ykcaoUpwta9awdGsRnUTU
         scF9Hf4BA3ujL22wA0pS8VyKf8u39Na7rAOkfsULkC4mXy39VW3cC1obpuLi8ZlbNdG4
         BTIQ==
X-Gm-Message-State: AOUpUlHEOB1QqD4hXuHTdkY+Ph5MsKoFtYa+TBdqCiW3FvFK0zpukNrm
        X3Ha3R2VpqiP7VzHR/w0KpTEqQ==
X-Google-Smtp-Source: AAOMgpezJ5hbGUWw7qhCYA2Zi93f2PHds9hd0pSBS+C+ffVTLdT5lse9W4lVp01+26kHM6+Cfnx5YA==
X-Received: by 2002:a25:5a03:: with SMTP id o3-v6mr2862468ybb.196.1531950839166;
        Wed, 18 Jul 2018 14:53:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:7eca])
        by smtp.gmail.com with ESMTPSA id 198-v6sm3474501ywh.59.2018.07.18.14.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 14:53:58 -0700 (PDT)
Date:   Wed, 18 Jul 2018 17:56:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180718215644.GB2838@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180717100347.GD2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717100347.GD2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:03:47PM +0200, Peter Zijlstra wrote:
> This is still a scary amount of accounting; not to mention you'll be
> adding O(cgroup-depth) to this in a later patch.
> 
> Where are the performance numbers for all this?

I benchmarked it using our two most scheduling sensitive workloads:
memcache and webserver. They handle a ton of small requests - lots of
wakeups and sleeps with little actual work in between - so they tend
to be canaries for scheduler regressions.

In the tests, the boxes were handling live traffic over the course of
several hours. Half the machines, the control, ran with CONFIG_PSI=n.

For memcache I used eight machines total. They're 2-socket, 14 core,
56 thread boxes. The test runs for half the test period, flips the
test and control kernels on the hardware to rule out HW factors, DC
location etc., then runs the other half of the test.

For the webservers, I used 32 machines total. They're single socket,
16 core, 32 thread machines.

During the memcache test, CPU load was nopsi=78.05% psi=78.98% in the
first half and nopsi=77.52% psi=78.25%, so psi added between 0.7 and
0.9 percentage points to the CPU load, a difference of about 1%.

As far as end-to-end request latency from the client perspective goes,
we don't sample those finely enough to capture the requests going to
those particular machines during the test, but we know the p50
turnaround time in this workload is 54us, and perf bench sched pipe on
those machines show nopsi=5.232666 us/op and psi=5.587347 us/op, so
this doesn't add much here either.

The profile for the pipe benchmark shows:

     0.87%  sched-pipe  [kernel.vmlinux]    [k] psi_group_change
     0.83%  perf.real   [kernel.vmlinux]    [k] psi_group_change
     0.82%  perf.real   [kernel.vmlinux]    [k] psi_task_change
     0.58%  sched-pipe  [kernel.vmlinux]    [k] psi_task_change


The webserver load is running inside 4 nested cgroup levels. The CPU
load with both nopsi and psi kernels was indistinguishable at 81%.

For comparison, we had to disable the cgroup cpu controller on the
webservers because it added 4 percentage points to the CPU% during
this same exact test.

Versions of this accounting code now run on 80% of our fleet. None of
our workloads have reported regressions during the rollout.

[ Also note that the webservers that tested the nopsi kernel were
  during that time susceptible to swap storms, memory livelocks, and
  eventual hardresets because without psi they couldn't run our full
  resource isolation stack that would prevent that ;) ]

Let me know if there are other tests I could run.
