Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeCXE4v (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 00:56:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeCXE4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 00:56:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 24 Mar 2018 12:56:48 +0800
From: yuankuiz@codeaurora.org
To: cgroups@vger.kernel.org, tj@kernel.or, lizefan@huawei.com,
        hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org, pkondeti@codeaurora.org
Subject: [PATCH]cgroup: __cpuset_node_allowed return bool
Message-ID: <d2f9fe6096235032f445ab88e562560f@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as a bool, __cpuset_node_allowed(...) return should be bool.

Signed-off-by: John Zhao <yuankuiz@codeaurora.org>

--- kernel/cgroup/cpuset.c.orig	2018-03-24 12:39:27.854178608 +0800
+++ kernel/cgroup/cpuset.c	2018-03-24 12:40:51.020708670 +0800
@@ -2552,7 +2552,7 @@ static struct cpuset *nearest_hardwall_a
  bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
  {
  	struct cpuset *cs;		/* current cpuset ancestors */
-	int allowed;			/* is allocation in zone z allowed? */
+	bool allowed;			/* is allocation in zone z allowed? */
  	unsigned long flags;

  	if (in_interrupt())
