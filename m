Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8702AECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE77214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="iHW4Xuaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE77214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJJCGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:06:41 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33580 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJJCGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:06:40 -0400
Received: by mail-yw1-f68.google.com with SMTP id m127-v6so1111663ywb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KEsEdGBvrMUNWtGyEIiTPpN958jHDkc6gRi8ilCin8=;
        b=iHW4XuazhRFqlrZRq9IUKEVo7Apl+liUkomlKYHmxGSxyFc2pckXE8G6NTzXQ5su7/
         okopKOrLP5N1PXqh8N8RYwtSnbtaSlmxmce+2IQchMunbthj/9WDU89QVNbdwqc0/kX8
         fxvzAZ3mhC1Q2vL895UEFZY6BDqyNjZ0D9m98T8Lg5KGnpYzoo9BFONj02tvdJM2e+jg
         ljsIwB7FxTAVrnnLRXuoZT08vIztvbrB19hE0Gcmei1orsZIunZ7qsGA2F4dhN9jpaRh
         eI7yUuXCKEhL4VwqEszgnTOYaVxXbQLTsfQ/NwOSYTWkzpZTmpm+LF4U7D8oNofLm8gu
         oyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KEsEdGBvrMUNWtGyEIiTPpN958jHDkc6gRi8ilCin8=;
        b=QRoZXnu3A24HY+CgtXhhmJ8GdFj+mrgjvIpay3WMPjNagTCoHp1dKA8cGkU8nVim93
         huhdBP13kioRxWRWiNGpN2/T/VgjY4yR8TScJ4uN06MlkJ0u4rVA8Qfuf1oYLBwkSMiV
         Bxb0jVDMPjBcdDVwXkCi+qO8fix5WP+/ETBSeijmjrtTJ55kuqAdNjXvrzNnlTod7yZF
         hQdDTti8Pvrzp/SiLVu8p5YmjACp7A8R/25yxgfZHr21jx6HWrCEFSsjDst5PS/aYlOg
         vmb9y9G/yMfYfSWEPtKYXKUC0PRooMCBBabbaR2CAChBOEcnQtw3F+xKpObutXYtZW5R
         LMTQ==
X-Gm-Message-State: ABuFfoiXPSTSnv5bUWmsbDTJWduzKc1zBJWuSsesnmec1okPA30p1aX6
        mRb2tZOX6sTWN8y3Hwd1qdBuJ4f2QAc=
X-Google-Smtp-Source: ACcGV63u3zwG+OP0mGmwt3IuEh4X6VI2/AtHABSD8/EI77QXHbis0ICPaJuSb4LP/KYxxnZ84Yp3ug==
X-Received: by 2002:a81:2609:: with SMTP id m9-v6mr16924353ywm.67.1539110899119;
        Tue, 09 Oct 2018 11:48:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:14c5])
        by smtp.gmail.com with ESMTPSA id o202-v6sm35068808ywo.38.2018.10.09.11.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 11:48:18 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/4] mm: workingset: add vmstat counter for shadow nodes
Date:   Tue,  9 Oct 2018 14:47:32 -0400
Message-Id: <20181009184732.762-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009184732.762-1-hannes@cmpxchg.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it easier to catch bugs in the shadow node shrinker by adding a
counter for the shadow nodes in circulation.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h |  1 +
 mm/vmstat.c            |  1 +
 mm/workingset.c        | 12 ++++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4179e67add3d..d82e80d82aa6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -161,6 +161,7 @@ enum node_stat_item {
 	NR_SLAB_UNRECLAIMABLE,
 	NR_ISOLATED_ANON,	/* Temporary isolated pages from anon lru */
 	NR_ISOLATED_FILE,	/* Temporary isolated pages from file lru */
+	WORKINGSET_NODES,
 	WORKINGSET_REFAULT,
 	WORKINGSET_ACTIVATE,
 	WORKINGSET_RESTORE,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d08ed044759d..6038ce593ce3 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1143,6 +1143,7 @@ const char * const vmstat_text[] = {
 	"nr_slab_unreclaimable",
 	"nr_isolated_anon",
 	"nr_isolated_file",
+	"workingset_nodes",
 	"workingset_refault",
 	"workingset_activate",
 	"workingset_restore",
diff --git a/mm/workingset.c b/mm/workingset.c
index f564aaa6b71d..cfdf6adf7e7c 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -378,11 +378,17 @@ void workingset_update_node(struct xa_node *node)
 	 * as node->private_list is protected by the i_pages lock.
 	 */
 	if (node->count && node->count == node->nr_values) {
-		if (list_empty(&node->private_list))
+		if (list_empty(&node->private_list)) {
 			list_lru_add(&shadow_nodes, &node->private_list);
+			__inc_lruvec_page_state(virt_to_page(node),
+						WORKINGSET_NODES);
+		}
 	} else {
-		if (!list_empty(&node->private_list))
+		if (!list_empty(&node->private_list)) {
 			list_lru_del(&shadow_nodes, &node->private_list);
+			__dec_lruvec_page_state(virt_to_page(node),
+						WORKINGSET_NODES);
+		}
 	}
 }
 
@@ -472,6 +478,8 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	}
 
 	list_lru_isolate(lru, item);
+	__dec_lruvec_page_state(virt_to_page(node), WORKINGSET_NODES);
+
 	spin_unlock(lru_lock);
 
 	/*
-- 
2.19.0

