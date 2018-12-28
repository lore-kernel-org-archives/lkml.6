Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844A0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298A1218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545963372;
	bh=K/HifNfTaSpZily3UMxDt2Z+CPgZEEjx1ti8jBO/5+M=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ar/zRq0h97I8VdWTAgYI8uAUiB5g8Jwv2nt9OYecltWwlwOLREiZre0frXzroGv8l
	 WQyVjTeXyemezPbAAnJZaWnVqhDXVXHnuBp6+T7UhPu/44LFcD+2uItA7/8wzwD81E
	 H9UUYxX4q2KCdW8zDkbS/nkoZrEapOUSL+zCsHdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeL1CQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 21:16:11 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34353 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeL1CQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 21:16:11 -0500
Received: by mail-yw1-f66.google.com with SMTP id g75so7937970ywb.1;
        Thu, 27 Dec 2018 18:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jjHgTJ4aRr18V+ui2gibzCqSKjDgcxiZ/58gLInlOzw=;
        b=Lb4dVx8Hwy8+3wyPqhFDXxyrTltxboCN7Hpglv6x5S9Pd/TmGSUiGoegMLLIharsA3
         fUVSh9/0+wRljHCm3ge5fv4eqL4gzSt/YJoX1KJ/f1VCPbtHm1nBUqbifOJ1Reim1ChL
         RvMcO6WioStkzI9JBKQc8H7Y1ZO794zKikc3PgplqBm4phCNASuaMxBaiZAWqYCWgu0p
         enbSNTSqlwwZsXgzkpB3fy8HA2kNFD7sDob+r3dMaESYQqkQEtFnVd8cCVFdKh3X8+hi
         qiZpv7+Wn70CDnL+0qWlQy4M1vWD2iTdej9Ov6BoEAjTxZBudnC7FLeljreqcT9Dvt0T
         UDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=jjHgTJ4aRr18V+ui2gibzCqSKjDgcxiZ/58gLInlOzw=;
        b=kZGzB8PFugG9E8++lM9ExapNCQyewhX5ux7TyO1O0zkVKFq+Uy9mrZI9X84WqytyIm
         kGDWpg65hSiglmVfzFWsCeiCMWzgAuhUjWU/84gJ9WFdSdQj9Z8OmVlaX/JJ1QihcMUq
         mtQ624RZHn+biQ4fXcyaeB3o8gIQIVNFp5400xCuAkn8cqDNgp7jNhMTqbWB9N+1WmIl
         q0QeefDEpCPMcGgSCiL2GLW4NMSiSHomjrdZQixR8zpj4vPdbCtDJnte5mYRCC73L56w
         0DCf6ORS6xmVc1VPxh2qkwlBK2EX18LZqWivrACIkwUGV11YOvz1umwuaaxVi+Npmox0
         nIKA==
X-Gm-Message-State: AA+aEWZUGImSk9IOVLOWWNlo+iU+z1bdKQxPmQKnIngKPFvn3CaDJ3so
        aKXUryLIQ6VF+D9Edt43mTU=
X-Google-Smtp-Source: AFSGD/WH6QRVl8Z7iA/vhZxfzOY2pzjQwrh+mojRqcG2z3kYR9TV8Z4WoiG23gKvsNI9XU2k6uhMOw==
X-Received: by 2002:a81:2b04:: with SMTP id r4mr26538164ywr.511.1545963368474;
        Thu, 27 Dec 2018 18:16:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:7729])
        by smtp.gmail.com with ESMTPSA id d3sm21796471ywc.103.2018.12.27.18.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 18:16:07 -0800 (PST)
Date:   Thu, 27 Dec 2018 18:16:05 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup changes for v4.21-rc1
Message-ID: <20181228021605.GI2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

cgroup changes for v4.21.

* Waiman's cgroup2 cpuset support has been finally merged closing one
  of the last remaining feature gaps.

* cgroup.procs could show non-leader threads when cgroup2 threaded
  mode was used in certain ways.  I forgot to push the fix during the
  last cycle.

Happy new year!

The following changes since commit f2ce1065e767fc7da106a5f5381d1e8f842dc6f4:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-11-19 09:24:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.21

for you to fetch changes up to 4d71c6f8771a6bccb844244f09831fa4624b22c1:

  Merge branch 'for-4.20-fixes' into for-4.21 (2018-12-27 18:05:30 -0800)

----------------------------------------------------------------
Tejun Heo (4):
      cpuset: Minor cgroup2 interface updates
      cgroup: Add .__DEBUG__. prefix to debug file names
      cgroup: fix CSS_TASK_ITER_PROCS
      Merge branch 'for-4.20-fixes' into for-4.21

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

 Documentation/admin-guide/cgroup-v2.rst | 182 +++++-
 include/linux/cgroup-defs.h             |   1 +
 kernel/cgroup/cgroup-internal.h         |   2 +
 kernel/cgroup/cgroup.c                  |  58 +-
 kernel/cgroup/cpuset.c                  | 944 +++++++++++++++++++++++++++++---
 kernel/cgroup/debug.c                   |   4 +-
 6 files changed, 1095 insertions(+), 96 deletions(-)
