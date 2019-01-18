Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F58C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F5E20657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFYdWvnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfAROtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:49:41 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45019 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfAROtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:49:41 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so11280717edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBmBImbtK42ECkTxRscQDa1tYpAATAfmBz75TzZh5j8=;
        b=sFYdWvnz4P7D/hK8BXg0k0/z1OfterKWevGlmYWRQOlQFRDSgvNFvU5LpmJBRi99wY
         V1U6tZ1mwoVL614iLEi6KsMznK9SMkDN0unAzRY40twoCosfE/EPQRqLWQYFz42RhTIN
         /dokD9Xv74ge4aao5+Jd67pEXHonFsMFR8wSe9kRjlUKtST+0jXcww9Zx5+uCg2yFccw
         gDCTf6mOdtGxNz5l1za+R4lwFwdOxf35KJ6Ub8zJ8ZbwdRBy4T5l2/aJmR9Z8GL1yeAd
         YIzWILId/FHJrFT9rIQDPQ0xV3gQl+6spEySZU6VMX7Zo2CXVxn6cKPJSeS7dZ8Ugyva
         eaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBmBImbtK42ECkTxRscQDa1tYpAATAfmBz75TzZh5j8=;
        b=nWJvZyvtAGVHWbaY9UVYpgu1Lq8uegW2+KGll0prNka2yzsTqMFpTuVy3tq00dFmdT
         eOKmrjnZEkBKQ1o5UKqAtg5A4/DSjxclblIpRJMIIv+clFCF8aLKttCjON34ByNB+lAQ
         3WSm5GlNGUPpOicMeeQcarZuMRX0smPbyR1itXMJoqAyYx+65vxZFvAuIcZwqBlSHIQG
         IJkjypuolMSJwVYNwuW/Gzwa9KDS6uUw2nkXLeVPFfPo4LbIGwbvmhCwk4s4O40fOYgP
         amx5ios/eQIdwKOOHlJyXfTpga76GGB7aVMPhRKexKeMyVs+zj3SxF9HNUGvd85k1WQ1
         MsKw==
X-Gm-Message-State: AJcUukc5VZGRhWmyYxxxOwWM//4TqjC79qh8DDSzSa4Cfq+fCPExAU/M
        MdBe+Cz/EJz4rGiQFZEUncNX/bgS
X-Google-Smtp-Source: ALg8bN4axILXOa0aY7FX/n34uIrCqrd/M8pUA6kSFtYfMox1p1fyAx81DuV5kvfZH8b6vqmzlX16LQ==
X-Received: by 2002:a50:a517:: with SMTP id y23mr16397441edb.219.1547822979538;
        Fri, 18 Jan 2019 06:49:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40fa:9f00:74c6:12d0:25bf:3ed0])
        by smtp.gmail.com with ESMTPSA id d27-v6sm3885543eja.20.2019.01.18.06.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:49:39 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] sched/topology: fix percpu in struct sd_data & struct s_data
Date:   Fri, 18 Jan 2019 15:49:36 +0100
Message-Id: <20190118144936.79158-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu members of these structure are declared as:
	struct ... ** __percpu member;
So their type is:
	__percpu pointer to pointer to struct ...

But looking at how they're used, their type should be:
	pointer to __percpu pointer to struct ...
and they should thus be declared as:
	struct ... * __percpu *member;

So fix the placement of '__percpu' in the definition of these
structures.

This silents a bunch of Sparse's warnings like:
	warning: incorrect type in initializer (different address spaces)
	  expected void const [noderef] <asn:3> *__vpp_verify
	  got struct sched_domain **

CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/sched/topology.h | 8 ++++----
 kernel/sched/topology.c        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c31d3a47a..57c7ed3fe 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -176,10 +176,10 @@ typedef int (*sched_domain_flags_f)(void);
 #define SDTL_OVERLAP	0x01
 
 struct sd_data {
-	struct sched_domain **__percpu sd;
-	struct sched_domain_shared **__percpu sds;
-	struct sched_group **__percpu sg;
-	struct sched_group_capacity **__percpu sgc;
+	struct sched_domain *__percpu *sd;
+	struct sched_domain_shared *__percpu *sds;
+	struct sched_group *__percpu *sg;
+	struct sched_group_capacity *__percpu *sgc;
 };
 
 struct sched_domain_topology_level {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3f35ba1d8..efca2489d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -676,7 +676,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 }
 
 struct s_data {
-	struct sched_domain ** __percpu sd;
+	struct sched_domain * __percpu *sd;
 	struct root_domain	*rd;
 };
 
-- 
2.20.0

