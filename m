Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-158926-1521910335-3-3295577391794853059
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521910334; b=QG6lsUyGePl7myqK+4bKFmZDd2AMnzgUps3oeyDOySFAbDx
    qXG+xtWIJMxPU0oK1aqG4bRvIuLC1n2JbTIwSXgO1fzsTht4U8ToI9uBCtKhOmzS
    WPeX4pznSA3L1kDdUmIfwxPTCUYNWWfH/SNRfQX7Ys02HXt+1cYx5/GnihD8xcMY
    q297euzH8tJHij5QPZJ5lJTHWBI7Erd37uQ6Mn35vDpsV+wnh5nD/RJa4GSElVY3
    fZaxAuIxChVvxFAWlMMo/WgU/4hmk7TyJDvarx4Lf6Iw2AJ4/nEuaV9r3jDQYRD0
    y4iXT73saiRJNG3pE71tKYNVc+0p4xsxBNHTVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521910334;
    bh=F2dszFmORTEWNhhPQ9tFklvEM4H+/rrWKxYCx32wkn0=; b=aut3j98+zAOS
    Bdk+E6sOBPcQM7E2VNfIDy2DaBkpGp0eyr3ejOWcAzeU+cHg9ti7peDCXCqiXFLw
    9XdLl3FAswRXOn7ar0mCoFghV0QEAKcg5zQuoZUabvUe9b2KIILi692Z4tXUIvW+
    IC6nhwLmHtkJ1VWhaTZH04uaZSGeJ92G2h+NKuo43tL2bAyodihoCDCYrvPRSiJ8
    M6oItymBphvq84jcTut7XVP5rMZGh4ehV8vZzpn3EKSoaKF90XwIpdVlhQG8M8MX
    uSNLv84QGUyY96ghESmjrCsMUOcTBXUZ4Wz5k4oF+x77ZTe9WSSsMAZ6lt1lX1iA
    RX9k6lYyLA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r2QsDjcm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aqbZ2I8/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r2QsDjcm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aqbZ2I8/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeCXQwA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 12:52:00 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36492 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbeCXQvq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 24 Mar 2018 12:51:46 -0400
X-Google-Smtp-Source: AIpwx4+TtC4mrWSjwEocvBDicoEonLnOikZy7a+40PlZ4wsPHBO7MjDNNXiL1WSgebPFAhraWo7k+Q==
From: Tejun Heo <tj@kernel.org>
To: hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Cc: guro@fb.com, riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Tejun Heo <tj@kernel.org>, linux-api@vger.kernel.org
Subject: [PATCH 2/2] mm, memcontrol: Implement memory.swap.events
Date: Sat, 24 Mar 2018 09:51:27 -0700
Message-Id: <20180324165127.701194-3-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180324165127.701194-1-tj@kernel.org>
References: <20180324165127.701194-1-tj@kernel.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add swap max and fail events so that userland can monitor and respond
to running out of swap.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-api@vger.kernel.org
---
 Documentation/cgroup-v2.txt | 16 ++++++++++++++++
 include/linux/memcontrol.h  |  5 +++++
 mm/memcontrol.c             | 24 +++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
index 74cdeae..b0dda10 100644
--- a/Documentation/cgroup-v2.txt
+++ b/Documentation/cgroup-v2.txt
@@ -1199,6 +1199,22 @@ PAGE_SIZE multiple when read back.
 	Swap usage hard limit.  If a cgroup's swap usage reaches this
 	limit, anonymous memory of the cgroup will not be swapped out.
 
+  memory.swap.events
+	A read-only flat-keyed file which exists on non-root cgroups.
+	The following entries are defined.  Unless specified
+	otherwise, a value change in this file generates a file
+	modified event.
+
+	  max
+		The number of times the cgroup's swap usage was about
+		to go over the max boundary and swap allocation
+		failed.
+
+	  fail
+		The number of times swap allocation failed either
+		because of running out of swap system-wide or max
+		limit.
+
 
 Usage Guidelines
 ~~~~~~~~~~~~~~~~
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 85a8f00..f198339 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -54,6 +54,8 @@ enum memcg_event_item {
 	MEMCG_HIGH,
 	MEMCG_MAX,
 	MEMCG_OOM,
+	MEMCG_SWAP_MAX,
+	MEMCG_SWAP_FAIL,
 	MEMCG_NR_EVENTS,
 };
 
@@ -202,6 +204,9 @@ struct mem_cgroup {
 	/* handle for "memory.events" */
 	struct cgroup_file events_file;
 
+	/* handle for "memory.swap.events" */
+	struct cgroup_file swap_events_file;
+
 	/* protect arrays of thresholds */
 	struct mutex thresholds_lock;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9f9c8a7..1a14d4a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5987,13 +5987,17 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	if (!memcg)
 		return 0;
 
-	if (!entry.val)
+	if (!entry.val) {
+		mem_cgroup_event(memcg, MEMCG_SWAP_FAIL);
 		return 0;
+	}
 
 	memcg = mem_cgroup_id_get_online(memcg);
 
 	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
+		mem_cgroup_event(memcg, MEMCG_SWAP_MAX);
+		mem_cgroup_event(memcg, MEMCG_SWAP_FAIL);
 		mem_cgroup_id_put(memcg);
 		return -ENOMEM;
 	}
@@ -6131,6 +6135,18 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int swap_events_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
+
+	memcg_stat_flush(memcg);
+
+	seq_printf(m, "max %llu\n", memcg->events[MEMCG_SWAP_MAX]);
+	seq_printf(m, "fail %llu\n", memcg->events[MEMCG_SWAP_FAIL]);
+
+	return 0;
+}
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -6143,6 +6159,12 @@ static struct cftype swap_files[] = {
 		.seq_show = swap_max_show,
 		.write = swap_max_write,
 	},
+	{
+		.name = "swap.events",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
+		.seq_show = swap_events_show,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.9.5

