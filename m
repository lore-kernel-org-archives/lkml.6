Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbeCXFFw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 01:05:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeCXFFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 01:05:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 24 Mar 2018 13:05:50 +0800
From: yuankuiz@codeaurora.org
To: cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org, pkondeti@codeaurora.org,
        cgroups-owner@vger.kernel.org
Subject: Re: [PATCH]cgroup: __cpuset_node_allowed return bool
In-Reply-To: <d2f9fe6096235032f445ab88e562560f@codeaurora.org>
References: <d2f9fe6096235032f445ab88e562560f@codeaurora.org>
Message-ID: <0fee75e4a1b12f5fca30e04306a95788@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From 304cec1cc42255fbd9e231a810f4eea20ab74b90 Mon Sep 17 00:00:00 2001
 From: John Zhao <yuankuiz@codeaurora.org>
Date: Sat, 24 Mar 2018 13:01:32 +0800
Subject: [PATCH] cgroup: __cpuset_node_allowed return bool

as a bool, __cpuset_node_allowed(...) return should be bool.

Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
---
  kernel/cgroup/cpuset.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b42037e..42338b7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2552,7 +2552,7 @@ static struct cpuset 
*nearest_hardwall_ancestor(struct cpuset *cs)
  bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
  {
  	struct cpuset *cs;		/* current cpuset ancestors */
-	int allowed;			/* is allocation in zone z allowed? */
+	bool allowed;			/* is allocation in zone z allowed? */
  	unsigned long flags;

  	if (in_interrupt())
-- 
2.7.4
