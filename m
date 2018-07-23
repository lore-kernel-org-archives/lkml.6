Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF34DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571B020685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRxecaJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571B020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbeGWWZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:25:13 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43449 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388119AbeGWWZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:25:13 -0400
Received: by mail-vk0-f65.google.com with SMTP id s17-v6so1038487vke.10;
        Mon, 23 Jul 2018 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWwxIEnBoVISPE9+JYRAjl8u3ujEBTaXxzWNyTN3g6Y=;
        b=vRxecaJ10da3n7xAZYgprobXGgLBXQprbzt0kLF0Vtundt1t3iXqmkeuOTV8n7TKrP
         XjD7oiC3ocTsqTvEX+IOziMXW6d5H6UDciHo/Myt02cUychJFBTmKrNNuOo8au3dkT/V
         kVFd58NHXUFfGNXQHMy7wp6c6+t6U14lU+pVY2gCzwumbcmBrcg25GNj7oUZiCR6H3dO
         sQWpF2ZxkVPBkh6ZvRPvX2dUx+nRIeYUvxNfaZjbWTGcsJ7eagCjwCjWeEynOkrrV451
         RBcas2nfnTcTGA05HTW62PzQ68yg3WX8wo0EiMTLWKSvE2DIzKvQhBqa9a+vBFZHz+HK
         baXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWwxIEnBoVISPE9+JYRAjl8u3ujEBTaXxzWNyTN3g6Y=;
        b=uLjFPEZFy29GzsijBhDxrhF1neHc+MGzLcrlDlwVpRE3i58pJYswhQho1VkLWPfDo3
         60hDM4f3KDRnE2Y50uIlURtmXid2STxXUjA8XmOQrU5jq7T2YdoTAXCR1GSaMDsXIsFu
         tjqOOmq62gKpcGYmGX4fSCtJXmom3x0POcSWq3/K0swyviniuDukbducAYnyIN+CaNm2
         z0BSIyM9UNuAWX64jvuVJc1pZn1AkRQgx5F2kqu1BEtHPxLlF83hyGgjxbJCPDCau2Je
         hKxTghkCd8ea+T05Hn05rAngUlHtx8/N6HC7ReF6AS6rtPw6Z1M85vjMB0ZXWqZIYneD
         8+jg==
X-Gm-Message-State: AOUpUlEXxCO0aGMvqJCcEyN0i6m/+PtlcjpEx0Aa9LvDcuqUUQDa61kl
        liGENOCtbdE6yrSkGdTjyoJtL03uSIkbehgJxqs=
X-Google-Smtp-Source: AAOMgpeb0ob8M97nnBNqxBTd+9U3ZU+oreBBBm3njaczc/N5iFA5zqUud8GdjEjWeM7QnjigddSJV1YI3WTP3l1U1VM=
X-Received: by 2002:a1f:d744:: with SMTP id o65-v6mr8546715vkg.101.1532380453746;
 Mon, 23 Jul 2018 14:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180712172942.10094-1-hannes@cmpxchg.org>
In-Reply-To: <20180712172942.10094-1-hannes@cmpxchg.org>
From:   Balbir Singh <bsingharora@gmail.com>
Date:   Tue, 24 Jul 2018 07:14:02 +1000
Message-ID: <CAKTCnzmt_CnfZMMdK9_-rBrL4kUmoE70nVbnE58CJp++FP0CCQ@mail.gmail.com>
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory, and
 IO v2
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, surenb@google.com,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christoph Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        linux-mm <linux-mm@kvack.org>, cgroups@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 3:27 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> PSI aggregates and reports the overall wallclock time in which the
> tasks in a system (or cgroup) wait for contended hardware resources.
>
> This helps users understand the resource pressure their workloads are
> under, which allows them to rootcause and fix throughput and latency
> problems caused by overcommitting, underprovisioning, suboptimal job
> placement in a grid, as well as anticipate major disruptions like OOM.
>
> This version 2 of the series incorporates a ton of feedback from
> PeterZ and SurenB; more details at the end of this email.
>
>                 Real-world applications
>
> We're using the data collected by psi (and its previous incarnation,
> memdelay) quite extensively at Facebook, with several success stories.
>
> One usecase is avoiding OOM hangs/livelocks. The reason these happen
> is because the OOM killer is triggered by reclaim not being able to
> free pages, but with fast flash devices there is *always* some clean
> and uptodate cache to reclaim; the OOM killer never kicks in, even as
> tasks spend 90% of the time thrashing the cache pages of their own
> executables. There is no situation where this ever makes sense in
> practice. We wrote a <100 line POC python script to monitor memory
> pressure and kill stuff way before such pathological thrashing leads
> to full system losses that require forcible hard resets.
>
> We've since extended and deployed this code into other places to
> guarantee latency and throughput SLAs, since they're usually violated
> way before the kernel OOM killer would ever kick in.
>
> The idea is to eventually incorporate this back into the kernel, so
> that Linux can avoid OOM livelocks (which TECHNICALLY aren't memory
> deadlocks, but for the user indistinguishable) out of the box.
>
> We also use psi memory pressure for loadshedding. Our batch job
> infrastructure used to use heuristics based on various VM stats to
> anticipate OOM situations, with lackluster success. We switched it to
> psi and managed to anticipate and avoid OOM kills and hangs fairly
> reliably. The reduction of OOM outages in the worker pool raised the
> pool's aggregate productivity, and we were able to switch that service
> to smaller machines.
>
> Lastly, we use cgroups to isolate a machine's main workload from
> maintenance crap like package upgrades, logging, configuration, as
> well as to prevent multiple workloads on a machine from stepping on
> each others' toes. We were not able to configure this properly without
> the pressure metrics; we would see latency or bandwidth drops, but it
> would often be hard to impossible to rootcause it post-mortem.
>
> We now log and graph pressure for the containers in our fleet and can
> trivially link latency spikes and throughput drops to shortages of
> specific resources after the fact, and fix the job config/scheduling.
>
> I've also recieved feedback and feature requests from Android for the
> purpose of low-latency OOM killing. The on-demand stats aggregation in
> the last patch of this series is for this purpose, to allow Android to
> react to pressure before the system starts visibly hanging.
>
>                 How do you use this feature?
>
> A kernel with CONFIG_PSI=y will create a /proc/pressure directory with
> 3 files: cpu, memory, and io. If using cgroup2, cgroups will also have
> cpu.pressure, memory.pressure and io.pressure files, which simply
> aggregate task stalls at the cgroup level instead of system-wide.
>
> The cpu file contains one line:
>
>         some avg10=2.04 avg60=0.75 avg300=0.40 total=157656722
>
> The averages give the percentage of walltime in which one or more
> tasks are delayed on the runqueue while another task has the
> CPU. They're recent averages over 10s, 1m, 5m windows, so you can tell
> short term trends from long term ones, similarly to the load average.
>

Does the mechanism scale? I am a little concerned about how frequently
this infrastructure is monitored/read/acted upon. Why aren't existing
mechanisms sufficient -- why is the avg delay calculation in the
kernel?

> The total= value gives the absolute stall time in microseconds. This
> allows detecting latency spikes that might be too short to sway the
> running averages. It also allows custom time averaging in case the
> 10s/1m/5m windows aren't adequate for the usecase (or are too coarse
> with future hardware).
>
> What to make of this "some" metric? If CPU utilization is at 100% and
> CPU pressure is 0, it means the system is perfectly utilized, with one
> runnable thread per CPU and nobody waiting. At two or more runnable
> tasks per CPU, the system is 100% overcommitted and the pressure
> average will indicate as much. From a utilization perspective this is
> a great state of course: no CPU cycles are being wasted, even when 50%
> of the threads were to go idle (as most workloads do vary). From the
> perspective of the individual job it's not great, however, and they
> would do better with more resources. Depending on what your priority
> and options are, raised "some" numbers may or may not require action.
>
> The memory file contains two lines:
>
> some avg10=70.24 avg60=68.52 avg300=69.91 total=3559632828
> full avg10=57.59 avg60=58.06 avg300=60.38 total=3300487258
>
> The some line is the same as for cpu, the time in which at least one
> task is stalled on the resource. In the case of memory, this includes
> waiting on swap-in, page cache refaults and page reclaim.
>
> The full line, however, indicates time in which *nobody* is using the
> CPU productively due to pressure: all non-idle tasks are waiting for
> memory in one form or another. Significant time spent in there is a
> good trigger for killing things, moving jobs to other machines, or
> dropping incoming requests, since neither the jobs nor the machine
> overall are making too much headway.
>
> The io file is similar to memory. Because the block layer doesn't have
> a concept of hardware contention right now (how much longer is my IO
> request taking due to other tasks?), it reports CPU potential lost on
> all IO delays, not just the potential lost due to competition.
>

There is no talk about the overhead this introduces in general, may be
the details are in the patches. I'll read through them

Balbir Singh.
