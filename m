Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52546C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E5A2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8iXvyZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E5A2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbeKMSBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:01:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44820 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbeKMSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:01:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so5604388plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZxBwqXaiZNsWqLXFmyYSwz6qmfzCZo5KHnYwnsdMXYA=;
        b=h8iXvyZusPAzra+ritGfF4mXx0RNQgwKg/g46J4qLzA6hDTIbismyyr/AQbnHvdb12
         u2aSq+oSX+51y+sc0FYagyoLSr5yNol5n7Jm4cyk1vcq9jC2nYUvMUJ9v4mRg7JMXY2J
         KfwMhJbQCZMRHdipyPVgcxazuJjPJOwhXPfJgGNplzaCK1pnYeCJqh7V2fOL0zRqKm0y
         xvIgdE1QC6js5T5/FGrbwl1Xr3nqxeyNKVsxbSVAKKByhu7d922sPKspurT5XVfQ3BKO
         borG8qlahvV8EV5OppFh0/ko0jLcIDT0dPJpP3UxajJdO6ZxgEe+am0HRspm41CVS9RW
         +q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZxBwqXaiZNsWqLXFmyYSwz6qmfzCZo5KHnYwnsdMXYA=;
        b=cBlF+DkVL2e0X9JFmvT6qrqW/yazXGgUOcg8kp0xwKuV5XTtWChW2Al+YGoCH8tpA9
         FGs7SRg6cPy49O6xaQNDJ4MMC1lNDf1eYA96DlrHvQngc3M+aqjPgTwPxfAFeAoW8WuT
         +IinDy2+rd+vrZIZYXLWLXVurATehDuHSmij5NbUIX7AXBHq2PIr5YyCE2sF4o/1vxzv
         MPoJgU8Bddlh5qoKM2vK6y6EimK3u28OnlTSQRIiYxz2S2PGTW/FDFXwsmTkYricX1vG
         8X0FOE0MifGLU/dHvPQUUPEH50Gf4AOVxpNAg8DoDci6QMKivIXV/1UJyRUBuwsUPIoR
         srZA==
X-Gm-Message-State: AGRZ1gIZ8ZW9+UTovCdHU8SgvggapJDGeHZ1KHluKOSu6xqWA7aHtwQd
        198NnwxHMA/AttPykar5QFM=
X-Google-Smtp-Source: AJdET5cXu3qdnJkORIjfxLSzsZNDubW/Lq5xEtzNlYjml2akDkeUmbSWEHViTuJM2ytVWE7EIVd90g==
X-Received: by 2002:a17:902:223:: with SMTP id 32-v6mr4113792plc.112.1542096291359;
        Tue, 13 Nov 2018 00:04:51 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 7-v6sm16766665pgk.31.2018.11.13.00.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 00:04:50 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2] vmscan: return NODE_RECLAIM_NOSCAN in node_reclaim() when CONFIG_NUMA is n
Date:   Tue, 13 Nov 2018 16:04:36 +0800
Message-Id: <20181113080436.22078-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20181113041750.20784-1-richard.weiyang@gmail.com>
References: <20181113041750.20784-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fa5e084e43eb ("vmscan: do not unconditionally treat zones that
fail zone_reclaim() as full") changed the return value of node_reclaim().
The original return value 0 means NODE_RECLAIM_SOME after this commit.

While the return value of node_reclaim() when CONFIG_NUMA is n is not
changed. This will leads to call zone_watermark_ok() again.

This patch fix the return value by adjusting to NODE_RECLAIM_NOSCAN. Since
node_reclaim() is only called in page_alloc.c, move it to mm/internal.h.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
v2:  move node_reclaim() to mm/internal.h
---
 include/linux/swap.h |  6 ------
 mm/internal.h        | 10 ++++++++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d8a07a4f171d..065988c27373 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -358,14 +358,8 @@ extern unsigned long vm_total_pages;
 extern int node_reclaim_mode;
 extern int sysctl_min_unmapped_ratio;
 extern int sysctl_min_slab_ratio;
-extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
 #else
 #define node_reclaim_mode 0
-static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
-				unsigned int order)
-{
-	return 0;
-}
 #endif
 
 extern int page_evictable(struct page *page);
diff --git a/mm/internal.h b/mm/internal.h
index 291eb2b6d1d8..6a57811ae47d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -444,6 +444,16 @@ static inline void mminit_validate_memmodel_limits(unsigned long *start_pfn,
 #define NODE_RECLAIM_SOME	0
 #define NODE_RECLAIM_SUCCESS	1
 
+#ifdef CONFIG_NUMA
+extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
+#else
+static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
+				unsigned int order)
+{
+	return NODE_RECLAIM_NOSCAN;
+}
+#endif
+
 extern int hwpoison_filter(struct page *p);
 
 extern u32 hwpoison_filter_dev_major;
-- 
2.15.1

