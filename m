Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01C9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FCC20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbeLQLbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:31:06 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:38390 "EHLO
        webbox4.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeLQLbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:31:06 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2018 06:31:05 EST
Received: from local.marc.ngoe.de (unknown [185.189.112.19])
        by webbox4.loswebos.de (Postfix) with ESMTPSA id 4493D5980FD;
        Mon, 17 Dec 2018 12:25:58 +0100 (CET)
Received: by local.marc.ngoe.de (sSMTP sendmail emulation); Mon, 17 Dec 2018 12:25:58 +0100
From:   Marc Burkhardt <git@marc.ngoe.de>
To:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Marc Burkhardt <git@marc.ngoe.de>
Subject: [PATCH] cgroup: cpuset: remove unused variable
Date:   Mon, 17 Dec 2018 12:25:50 +0100
Message-Id: <20181217112550.5006-1-git@marc.ngoe.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.2 at webbox4.loswebos.de
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 kernel/cgroup/cpuset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 266f10cb7222..784f9480e054 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1498,10 +1498,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
 
 	cgroup_taskset_first(tset, &css);
-	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
 	css_cs(css)->attach_in_progress--;
-- 
2.20.1

