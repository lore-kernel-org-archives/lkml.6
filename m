Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159700-2-7521842026699986473
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159696; b=BSPHB0nkERHhqQzP7nk0MfnKb7zwSfk3SRtoIsViT+gxUcFb3n
    OA505uQhIBr13bJ5jBFG4xO5sxcEh206jGXH79l8/j7ZpfjgG5tAsXgAchz78iVp
    s+ipVOYFqqw8JBQSa3rJz9qHIYOrQmC3VnOMbhObnVYO7MZZ69wA03ep3bHE15hv
    Lam51CYjwz5sLiustoj50zpBI2t30GhJY3AYJVN93yjwQ3cO7vrYv1h18nmKeTYX
    CbX/1ykJiyhRFY4Z/+LjYsf8d4C+FkFBaJ6NWPbf/r6v4rrEfJq8BVS0HW1DuXEs
    R+kx/m1gb5ZZqDehncIPCnIt9TjiMUdVCA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527159696; bh=
    YFWyLpzf3SInDFSXMngOgmfiKPDEPyHcOwne0NSsFn0=; b=Xz/9WhK82WDxKhKz
    8kul3YHDAc4EqeaIDyW2jP4Wg9a9d50irP7MF5R1Aj1Rjw9SrqN8FYrVYuMc6Jy2
    Y56E3vo/AFgFmohqcVDeyme0CCTvwVYra/1EvROBkwwSiDo2Z3YRspjIbxIFcotI
    dU/JFPXOBJNjCfbH8G0zkp5cg6BuTo9IOxUVHNi+tK++KEZSqX5AVy+5o3iHHS2/
    oDqwr32Cv1Hq3BvoAkj46h4cADXbKhds0oXLKgEMoBY7ZpQKPoISqYaaHh1dUdBx
    cFdSe9QFCgG8KB/Jj+LYK3eQ6zzrqwxanmOu8AYWb0bBesws03jU/1ibAolPFcW/
    KqvRpg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAEAIGH+XirHVVmnDdojXm9+Igdh3EnUlhuNap/ZdlUnRXiVsrIcwBqZn2hivQ5ghmIxKiYbnfuuQpb/X41N6wu2qwgBoC4EScHA6qSIR1ljGuEGgb/J
    UsY4OzO/lsw5cCVQ3v0H2QDZYwdvbzKf13LH4vt6y+79BAZhReG9CTjCJaL/yXiv6qcEYUWmW3fgz0uh++f3/NDpRG51J5ma1JAh4SApJMVyfbczo9b3/CNB
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=pEcp_6-7EyntBbE1AEYA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030254AbeEXLA0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:00:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:36134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030227AbeEXLAY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 May 2018 07:00:24 -0400
From: Vlastimil Babka <vbabka@suse.cz>
To: linux-mm@kvack.org
Cc: Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH 5/5] mm, proc: add NR_RECLAIMABLE to /proc/meminfo
Date: Thu, 24 May 2018 13:00:11 +0200
Message-Id: <20180524110011.1940-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524110011.1940-1-vbabka@suse.cz>
References: <20180524110011.1940-1-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The vmstat NR_RECLAIMABLE counter is a superset of NR_SLAB_RECLAIMABLE and
other non-slab allocations that can be reclaimed via shrinker. Make it visible
also in /proc/meminfo and /sys/...node info.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/base/node.c | 2 ++
 fs/proc/meminfo.c   | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index a5e821d09656..b35e3627eab7 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -118,6 +118,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       "Node %d NFS_Unstable:   %8lu kB\n"
 		       "Node %d Bounce:         %8lu kB\n"
 		       "Node %d WritebackTmp:   %8lu kB\n"
+		       "Node %d Reclaimable:    %8lu kB\n"
 		       "Node %d Slab:           %8lu kB\n"
 		       "Node %d SReclaimable:   %8lu kB\n"
 		       "Node %d SUnreclaim:     %8lu kB\n"
@@ -138,6 +139,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(node_page_state(pgdat, NR_UNSTABLE_NFS)),
 		       nid, K(sum_zone_node_page_state(nid, NR_BOUNCE)),
 		       nid, K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
+		       nid, K(node_page_state(pgdat, NR_RECLAIMABLE)),
 		       nid, K(node_page_state(pgdat, NR_SLAB_RECLAIMABLE) +
 			      node_page_state(pgdat, NR_SLAB_UNRECLAIMABLE)),
 		       nid, K(node_page_state(pgdat, NR_SLAB_RECLAIMABLE)),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 2fb04846ed11..6ca0158a9ebd 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -93,10 +93,11 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Mapped:         ",
 		    global_node_page_state(NR_FILE_MAPPED));
 	show_val_kb(m, "Shmem:          ", i.sharedram);
+	show_val_kb(m, "Reclaimable:    ",
+		    global_node_page_state(NR_RECLAIMABLE));
 	show_val_kb(m, "Slab:           ",
 		    global_node_page_state(NR_SLAB_RECLAIMABLE) +
 		    global_node_page_state(NR_SLAB_UNRECLAIMABLE));
-
 	show_val_kb(m, "SReclaimable:   ",
 		    global_node_page_state(NR_SLAB_RECLAIMABLE));
 	show_val_kb(m, "SUnreclaim:     ",
-- 
2.17.0

