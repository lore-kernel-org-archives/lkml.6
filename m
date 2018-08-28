Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2AFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19512087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="btS19MrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19512087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeH2At5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:49:57 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36508 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeH2At5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:49:57 -0400
Received: by mail-yb0-f196.google.com with SMTP id d34-v6so1166654yba.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qe4URwpF2ELDwboL1mzyrFlyVo74zo76mUZy91AnNQM=;
        b=btS19MrMqzoJxXouoy8fD9Wo2MIC15tki4oHYx1m/8Xw4qsaLPGu5ry8MdYgmtz4pd
         dgR5x46uYjmE7yg2ATQqtuH4JNS+bT42xw4sGAY3sFjqMMjt1MsXEOrSjXf317B4ZwUl
         feTH8WAR7vduDXJ3dUopA1QDPlOX6byxtgFV1tHScuJFsN33d3PHuDtxjVvC044H61L6
         k+8FXx4zw+MmpIXCoxzqhTcZasHwqzxqQ63SyOrb0FONuvbhgJSsbq/Luz5x65Iz+AAp
         erRChajIfrdz12xAXRVrAAUKpMB4tKmZ1veH3X4Lz85Jnocik5ctlu3hXEzH7gucwUHC
         KqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qe4URwpF2ELDwboL1mzyrFlyVo74zo76mUZy91AnNQM=;
        b=A2/I7tZQNqI3ABrsunYnS/xgMnduD/nnvs/ergRA4Nx9jS6YW9iq9JzK0RIVKg1enF
         FMngGUI7SW5Ccyz0p4FnKit+Rjwcypy4950K/bURtAGnMhiYilpHFgW0iA7e+OqsDEFd
         FJaEDWGz02+/BlAHwADZNhW+vwrkIuRW+EfBv1DDkSdVdHnfNjO7ZmeuOoFpGWOUXkwX
         yQbEA8GMzqeBRNjMwPOwMHcva76b+tHMnCKaMsYrI99W5/qvD5AKunm6N/cB/n4GY18B
         FpiC09RlJiAAhODzGeEuZBuKnirV19SjZUea0NW4Aa6FR0Z48hoY4Vu3TPix8MWgbQgE
         E6gQ==
X-Gm-Message-State: APzg51C3KnqdppSnhBvAczTdrAre1DLEs4t/5gjymqodRZ30F6a2gNOX
        Z+skdlQsHZYedpHagE+6MgzHJw==
X-Google-Smtp-Source: ANB0Vdazei+G8XffOuwfwnSFcEoFiAtOu/Xcwe3jwX6guBk6HJ2EFLm6/bVMwTU0cJn90UZImvzI4A==
X-Received: by 2002:a25:6756:: with SMTP id b83-v6mr1834357ybc.413.1535489788075;
        Tue, 28 Aug 2018 13:56:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:de86])
        by smtp.gmail.com with ESMTPSA id y188-v6sm758373ywe.2.2018.08.28.13.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 13:56:26 -0700 (PDT)
Date:   Tue, 28 Aug 2018 16:56:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180828205625.GA14030@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180828172258.3185-9-hannes@cmpxchg.org>
 <6ff71c29-3b6a-4849-6f2a-3d829bbd43e2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff71c29-3b6a-4849-6f2a-3d829bbd43e2@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:11:11PM -0700, Randy Dunlap wrote:
> On 08/28/2018 10:22 AM, Johannes Weiner wrote:
> > diff --git a/Documentation/accounting/psi.txt b/Documentation/accounting/psi.txt
> > new file mode 100644
> > index 000000000000..51e7ef14142e
> > --- /dev/null
> > +++ b/Documentation/accounting/psi.txt
> > @@ -0,0 +1,64 @@
> > +================================
> > +PSI - Pressure Stall Information
> > +================================
> > +
> > +:Date: April, 2018
> > +:Author: Johannes Weiner <hannes@cmpxchg.org>
> > +
> > +When CPU, memory or IO devices are contended, workloads experience
> > +latency spikes, throughput losses, and run the risk of OOM kills.
> > +
> > +Without an accurate measure of such contention, users are forced to
> > +either play it safe and under-utilize their hardware resources, or
> > +roll the dice and frequently suffer the disruptions resulting from
> > +excessive overcommit.
> > +
> > +The psi feature identifies and quantifies the disruptions caused by
> > +such resource crunches and the time impact it has on complex workloads
> > +or even entire systems.
> > +
> > +Having an accurate measure of productivity losses caused by resource
> > +scarcity aids users in sizing workloads to hardware--or provisioning
> > +hardware according to workload demand.
> > +
> > +As psi aggregates this information in realtime, systems can be managed
> > +dynamically using techniques such as load shedding, migrating jobs to
> > +other systems or data centers, or strategically pausing or killing low
> > +priority or restartable batch jobs.
> > +
> > +This allows maximizing hardware utilization without sacrificing
> > +workload health or risking major disruptions such as OOM kills.
> > +
> > +Pressure interface
> > +==================
> > +
> > +Pressure information for each resource is exported through the
> > +respective file in /proc/pressure/ -- cpu, memory, and io.
> > +
> 
> Hi,
> 
> > +In both cases, the format for CPU is as such:
> 
> I don't see what "In both cases" refers to here.  It seems that you could
> just remove it.

You're right, that must be a left-over from when I described CPU
separately; "both cases" referred to memory and IO which have
identical formats. It needs to be removed:

diff --git a/Documentation/accounting/psi.txt b/Documentation/accounting/psi.txt
index e051810d5127..b8ca28b60215 100644
--- a/Documentation/accounting/psi.txt
+++ b/Documentation/accounting/psi.txt
@@ -35,7 +35,7 @@ Pressure interface
 Pressure information for each resource is exported through the
 respective file in /proc/pressure/ -- cpu, memory, and io.
 
-In both cases, the format for CPU is as such:
+The format for CPU is as such:
 
 some avg10=0.00 avg60=0.00 avg300=0.00 total=0
 
