Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C1DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4C92192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550257541;
	bh=LqlPcCo9lG1dpPq1I4m4LJFkkEIIEFdDUAqzCdnMRcE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0hRl1tDo5wLI9DxtYtAWGtMyRxMF3q8djdlh24eXE8Y1yOnivw4LmDS2ulL7XhE61
	 4eF5A4TIwDv5sSFYBYFg5B4aQ4Xdu40gu4+kHcllfBevYVdqRNssLtsjM9S9zsx+dA
	 LPrfFGUnPuC3i2v4iJ9OPFxqOwPCP0NvV4fS9/6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfBOTFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:05:39 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34233 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBOTFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:05:39 -0500
Received: by mail-yb1-f194.google.com with SMTP id j62so4213620ybb.1;
        Fri, 15 Feb 2019 11:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=542kMV/M+F4ke2Nez4pG0EO/cK2G2uhP23eV8bg4uGc=;
        b=fqohBaoCh6j07OJSvNB8YJkGy7d7sCxJdAaXOMg30nSbXziT7y+/S7HPkzBp6tv5w+
         4jtBehbmIspbhohxS9FyV/e2dwR2scC7ZpC3s2Bl6Ybj4qu8PEFgAspIEyvzVIjcOfaP
         +vOGLsHhI0UIvoH3WvYEXBJ5q2LAY5AloHoXnKtT0ao/23j1Y2Z6CgwyyHQqahMRP5R1
         LoaaDrFQvxX3f3xGdS7bw4CIJj25lYnf+HUBqesdGzEYESkRDd86qs2zqwJOJ/p2pguE
         pAp0v9FP7bVkWKMFGa9uHOJiTXm1sFOStnuow7/yDaN3Q97YYAPA4VudCAXI2ldAK0Op
         ur0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=542kMV/M+F4ke2Nez4pG0EO/cK2G2uhP23eV8bg4uGc=;
        b=G+wCPaYy471p8fq30IXNa0TK/Dtpz+dkt3NTG6vjRavL0zAY45PJyolC3jYUCB1M3R
         5FQfN5zVc+z/dDrunQrNT3kovBaM7r/HEStCBHPbMtEIzGLeIPeFlELxB5ATFEqm2fTi
         EsS5MjFqy3Vq/c+rmFXvVdtMufzeJCa2nnoka+KuYLp/u3xuzPUWLu5RFEI8iHsEk7Fy
         snC8vUBcv9gAN+xEI2rn4p1fRdujnf9r0KOHr7wBfCqUdyyNLcWRckWM+Df8PkTdbK68
         EXZAyIMrCinrtP/GbLe5Ye0JfVhFOhCe4elFh8Gv6D62yleuLJZk8QloeyKOCCqAg2oZ
         kP+w==
X-Gm-Message-State: AHQUAub8FtbfW6/j5F1tC/6Kv9ugkkju+DJjZSn4QoU0B8bUqe/7F/WN
        hN4tyh7OZ8kTznGKvPG9Gq8=
X-Google-Smtp-Source: AHgI3IYMUC0OK4+5xnNXmafOJaja9su2sx87jrRy4aXEYhHQXbaJItVJw97xK6I6rZquAR6NtFVo0g==
X-Received: by 2002:a25:208a:: with SMTP id g132mr9268729ybg.470.1550257538285;
        Fri, 15 Feb 2019 11:05:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:2c70])
        by smtp.gmail.com with ESMTPSA id l73sm2626457ywl.72.2019.02.15.11.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 11:05:37 -0800 (PST)
Date:   Fri, 15 Feb 2019 11:05:35 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH cgroup/for-5.0] cgroup, rstat: Don't flush subtree root
 unless necessary
Message-ID: <20190215190535.GR50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From b4ff1b44bcd384d22fcbac6ebaf9cc0d33debe50 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 15 Feb 2019 11:01:31 -0800

cgroup_rstat_cpu_pop_updated() is used to traverse the updated cgroups
on flush.  While it was only visiting updated ones in the subtree, it
was visiting @root unconditionally.  We can easily check whether @root
is updated or not by looking at its ->updated_next just as with the
cgroups in the subtree.

* Remove the unnecessary cgroup_parent() test.  The system root cgroup
  is never updated and thus its ->updated_next is always NULL.  No
  need to test whether cgroup_parent() exists in addition to
  ->updated_next.

* Terminate traverse if ->updated_next is NULL.  This can only happen
  for subtree @root and there's no reason to visit it if it's not
  marked updated.

This reduces cpu consumption when reading a lot of rstat backed files.
In a micro benchmark reading stat from ~1600 cgroups, the sys time was
lowered by >40%.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

I'm applying this on for-5.0.  It's a fairly straight forward
optimization.

Thanks.

 kernel/cgroup/rstat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d503d1a9007c..bb95a35e8c2d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -87,7 +87,6 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 						   struct cgroup *root, int cpu)
 {
 	struct cgroup_rstat_cpu *rstatc;
-	struct cgroup *parent;
 
 	if (pos == root)
 		return NULL;
@@ -115,8 +114,8 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	 * However, due to the way we traverse, @pos will be the first
 	 * child in most cases. The only exception is @root.
 	 */
-	parent = cgroup_parent(pos);
-	if (parent && rstatc->updated_next) {
+	if (rstatc->updated_next) {
+		struct cgroup *parent = cgroup_parent(pos);
 		struct cgroup_rstat_cpu *prstatc = cgroup_rstat_cpu(parent, cpu);
 		struct cgroup_rstat_cpu *nrstatc;
 		struct cgroup **nextp;
@@ -140,9 +139,12 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 		 * updated stat.
 		 */
 		smp_mb();
+
+		return pos;
 	}
 
-	return pos;
+	/* only happens for @root */
+	return NULL;
 }
 
 /* see cgroup_rstat_flush() */
-- 
2.17.1

