Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755737AbeC0QpN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:45:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755722AbeC0QpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:45:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Mar 2018 00:45:08 +0800
From: yuankuiz@codeaurora.org
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, pkondeti@codeaurora.org,
        cgroups-owner@vger.kernel.org
Subject: Re: [PATCH]cgroup: __cpuset_node_allowed return bool
In-Reply-To: <20180326141212.GI2149215@devbig577.frc2.facebook.com>
References: <d2f9fe6096235032f445ab88e562560f@codeaurora.org>
 <0fee75e4a1b12f5fca30e04306a95788@codeaurora.org>
 <20180326141212.GI2149215@devbig577.frc2.facebook.com>
Message-ID: <ac790397826d5ec30102e0b3f1233c65@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-26 10:12 PM, Tejun Heo wrote:
> Hello, John.
> 
> On Sat, Mar 24, 2018 at 01:05:50PM +0800, yuankuiz@codeaurora.org 
> wrote:
>> as a bool, __cpuset_node_allowed(...) return should be bool.
> 
> So, as a minor cleanup patch, this is fine but can you please soften
> the commit title / description a bit?  It doesn't have to be bool.
> int is fine.  bool may be marginally more readable but that's about
> it, so let's please make the commit match that.
> 
[ZJ] On summary, update it as below:

 From 6fd65547d4c704d86fd98cac1d9b8c74c8bee879 Mon Sep 17 00:00:00 2001
 From: John Zhao <yuankuiz@codeaurora.org>
Date: Sat, 24 Mar 2018 13:01:32 +0800
Subject: [PATCH] cgroup: allowed of __cpuset_node_allowed to be bool

makes variable allowed returned by the __cpuset_node_allowed(...)
to be bool as it is assigned by the test_bits which always
return 0 or 1. In addition, it could save the size from
typical 4 bytes to 1 byte only. In another side, it could
save the potiential unnecessary instructionis during type conversion.

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
