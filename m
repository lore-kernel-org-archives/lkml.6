Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10953C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F032146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546022483;
	bh=DBG15kp9u6HRKe4vKc2Brxh0gNMsnUycPV3RSBjC70s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ia9PqtU8DlryEeAb6s0N12sGeC3v/+qpjKF0Voc0XjpUDW3Mux6uiusdKMk109izR
	 925w2o/T5DMEUnOC/ufHB6oiJUUQNS7CSdyS7LRbt0BwFYVra5jSaMsTPfWDbf17q5
	 XpKidDHztqRfqrC4aeyGf1+3/IRM7vuDsggjiD0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbeL1SlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:41:22 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40165 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeL1SlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:41:22 -0500
Received: by mail-yb1-f193.google.com with SMTP id x201so4835102ybg.7;
        Fri, 28 Dec 2018 10:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sBbL421+bYwi0jfrEuusHOcZ6XbW1Wn1tPoDDCiEq9Q=;
        b=YTevJs64nf8i+6b4/NpUDS5FnWgMpJ2fGRIZ8evVuVsIMQs+N35qXrctyvWKo782OO
         uMM5zYz0Ssdt7GzUke8fN6attT8DOFo+71CLw0J/2VeD0BEpsqXJ1uYRr7OOIAMI4obM
         gVy6wuX4tWrXblpLa+r1OZvV6tX05S/YGFODZqIHIokeTmm/Wr4FpjkUikUsh+g4VXA6
         ri5fwHrvH2W3DTL62JLg4wg2uSNwiuzTijduPH90bnq+juenyqc0pdd0DdCVIgRTZXbp
         RmbprbCU7FhZk7rdNdVrxhvr9AR083bdwBnfhr9TuGzhNRPYdt3NUw97S9LmmAq44msW
         4stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sBbL421+bYwi0jfrEuusHOcZ6XbW1Wn1tPoDDCiEq9Q=;
        b=l0f0APivK1hWW37KVFewJCtbn9aG4kI4drvfsvVTvVtdU/xPwsey73D0fSSlz6445Y
         ReHUJPm7p0Q0A0HJuxwR9RaHRyIprXiIJZ99nwwP2lzYvWeV97qPXrCfkgZA7UYnkceL
         vty5VetSAzxRh+x8fl8jx9jEygKctVpssgqYSGHgp7ps01/iDb00LJAJcUspQ1Cv8Wv8
         SLaUCIvA51OgmFXZdyrLT8F9XeAzjbY903q0k6Q+ETnoFi2yhRDWLU9CaKzutcQYNoeO
         WRPjQr20MUaLwgerrTu5aP9UNPamHzJHJ85CXdYhPBE3P6sq30+JSS7TFmnTzg+ZyD2J
         1ztQ==
X-Gm-Message-State: AJcUuke8RLjWwWWcN4gZozs3OnVLHI+ofiYhepgt0TAc82VyqTwLPUWi
        gIpWM7Hw8GrSq9bSR22UQMM=
X-Google-Smtp-Source: ALg8bN6p972AuOUbara10KqK0pXUt6NRLLkN0EaGg/6jbpi5WZsrwTlLxsNrd3YfbMQ5MD9AIPPEog==
X-Received: by 2002:a25:7797:: with SMTP id s145mr25590221ybc.477.1546022480895;
        Fri, 28 Dec 2018 10:41:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4800])
        by smtp.gmail.com with ESMTPSA id l83sm15669921ywb.23.2018.12.28.10.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 10:41:20 -0800 (PST)
Date:   Fri, 28 Dec 2018 10:41:17 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [GIT UPDATED PULL] cgroup changes for v4.21-rc1
Message-ID: <20181228184117.GN2509588@devbig004.ftw2.facebook.com>
References: <20181228021605.GI2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228021605.GI2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Updated cgroup pull request for v4.21.  The last two bullets are the
additions.

* Waiman's cgroup2 cpuset support has been finally merged closing one
  of the last remaining feature gaps.

* cgroup.procs could show non-leader threads when cgroup2 threaded
  mode was used in certain ways.  I forgot to push the fix during the
  last cycle.

* A patch to fix mount option parsing when all mount options have been
  consumed by someone else (LSM).

* cgroup_no_v1 boot param can now block named cgroup1 hierarchies too.

Thanks.

The following changes since commit f2ce1065e767fc7da106a5f5381d1e8f842dc6f4:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-11-19 09:24:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.21

for you to fetch changes up to 3fc9c12d27b4ded4f1f761a800558dab2e6bbac5:

  cgroup: Add named hierarchy disabling to cgroup_no_v1 boot param (2018-12-28 10:34:12 -0800)

----------------------------------------------------------------
Ondrej Mosnacek (1):
      cgroup: fix parsing empty mount option string

Tejun Heo (5):
      cpuset: Minor cgroup2 interface updates
      cgroup: Add .__DEBUG__. prefix to debug file names
      cgroup: fix CSS_TASK_ITER_PROCS
      Merge branch 'for-4.20-fixes' into for-4.21
      cgroup: Add named hierarchy disabling to cgroup_no_v1 boot param

Waiman Long (12):
      cpuset: Enable cpuset controller in default hierarchy
      cpuset: Define data structures to support scheduling partition
      cpuset: Simply allocation and freeing of cpumasks
      cpuset: Add new v2 cpuset.sched.partition flag
      cpuset: Add an error state to cpuset.sched.partition
      cpuset: Track cpusets that use parent's effective_cpus
      cpuset: Make CPU hotplug work with partition
      cpuset: Make generate_sched_domains() work with partition
      cpuset: Expose cpus.effective and mems.effective on cgroup v2 root
      cpuset: Use descriptive text when reading/writing cpuset.sched.partition
      cpuset: Add documentation about the new "cpuset.sched.partition" flag
      cpuset: Expose cpuset.cpus.subpartitions with cgroup_debug

Yangtao Li (1):
      cgroup: remove unnecessary unlikely()

YueHaibing (1):
      cpuset: Remove set but not used variable 'cs'

 Documentation/admin-guide/cgroup-v2.rst         | 182 ++++-
 Documentation/admin-guide/kernel-parameters.txt |   8 +-
 include/linux/cgroup-defs.h                     |   1 +
 kernel/cgroup/cgroup-internal.h                 |   2 +
 kernel/cgroup/cgroup-v1.c                       |  14 +-
 kernel/cgroup/cgroup.c                          |  60 +-
 kernel/cgroup/cpuset.c                          | 944 ++++++++++++++++++++++--
 kernel/cgroup/debug.c                           |   4 +-
 8 files changed, 1115 insertions(+), 100 deletions(-)

-- 
tejun
