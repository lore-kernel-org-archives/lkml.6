Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D650C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA3E222DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="A4ujf58V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZBrE7Vyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393279AbfBOWJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:22 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43575 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393247AbfBOWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:20 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id DA113328F;
        Fri, 15 Feb 2019 17:09:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=rMjYn468lmWbJ
        J/Y9UnoFTDhCSw4u+AQXz4D4ksBw0s=; b=A4ujf58V1MFEFOPLdNKwAJHAyesXQ
        SQ34q5PKA3J4Rfuw1dW3pWYteDdWQpzuBYEfB2WGmgiveEW3p4lqNVtmgs3lpeOW
        Ci8Jcp72+T1q/C3kicjr86sJfKICROGfrf0apD97U8oL4oZFwv00Ln3SOdNh+pe/
        r9D18oGy9SvezbjLwItFw05IvtZUm5rokh02KTUv4s7RgYZeX8tEgDzoBx7qYzA0
        zBDHwRlzmNqpp3ZyEGlnP7N/ROp+WMG5I5nVbM3O0pU9FWsHK3KH6WBuVk128JeW
        Kb8HclfadEkbyofFGyq1j7qXN5Fyx4dGJCo2pVRqAVOJbPJd+t44nI9aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=rMjYn468lmWbJJ/Y9UnoFTDhCSw4u+AQXz4D4ksBw0s=; b=ZBrE7Vyw
        38eugooyUyUUG1AKmaXNOP5GWjtIEhS3NB3jWp1ADXoCuy1Q0TFL5ISc7QS4RNaG
        jxGOdKluNN4kFtDYvt6CRg5Pbm6PhRPGq2+6PP4uy0Uc1DqGcuxI0e3OtSSna69K
        OEOYi1czI4SoArwx51Dp+B/JbNRF7o2a5/MwnnAF7QBnR5jU315NYwGEsPViMxVB
        ilI5UfGFIz1mDVzdzE2bk6LrO3aPzShgbIfylrbGLviAI/sFJQVAXKD5NqhlcbML
        QD+DKp15ej7KfEnMbcCzIATWLfPJ9jVfdzIlX58sHegkX2ncao6ZfVKgsGXls7wr
        0HZXDk0SLwJQgQ==
X-ME-Sender: <xms:jjhnXMy4FuyMaJcKEe46UiCuRvL1FgVJBaTTELGrKcoaGKZtTDHyIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpeel
X-ME-Proxy: <xmx:jjhnXDtVpWgZMVc4Lxeulwl1ZlxUyRX9jTcd97wTr5Vdthim9sXCqA>
    <xmx:jjhnXKkoL3NSZLrSJhwSC1Gr48XY7ofmUfQ-zBTbX7XBhCDLtNZkRA>
    <xmx:jjhnXDjVtViafyp8hzIWLw-0oE7rYQzXT4q6d3U-YVMdywz4Dsv55Q>
    <xmx:jjhnXN0L8XQ-OZWS4w97pXFH5Ul6_BkC89bCz8fXpLAC4hTFyVH4ww>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id E7EA2E462B;
        Fri, 15 Feb 2019 17:09:16 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 12/31] mm: stats: Separate PMD THP and PUD THP stats.
Date:   Fri, 15 Feb 2019 14:08:37 -0800
Message-Id: <20190215220856.29749-13-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215220856.29749-1-zi.yan@sent.com>
References: <20190215220856.29749-1-zi.yan@sent.com>
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

PMD THPs and PUD THPs are shown in separate stats.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/base/node.c | 5 +++--
 fs/proc/meminfo.c   | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f21d2235bf97..5d947a17b61b 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -127,6 +127,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       "Node %d SUnreclaim:     %8lu kB\n"
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 		       "Node %d AnonHugePages:  %8lu kB\n"
+		       "Node %d AnonHugePages(1GB):  %8lu kB\n"
 		       "Node %d ShmemHugePages: %8lu kB\n"
 		       "Node %d ShmemPmdMapped: %8lu kB\n"
 #endif
@@ -150,8 +151,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 		       ,
 		       nid, K(node_page_state(pgdat, NR_ANON_THPS) *
-				       HPAGE_PMD_NR) +
-				    K(node_page_state(pgdat, NR_ANON_THPS_PUD) *
+				       HPAGE_PMD_NR),
+			   nid, K(node_page_state(pgdat, NR_ANON_THPS_PUD) *
 				       HPAGE_PUD_NR),
 		       nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
 				       HPAGE_PMD_NR),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 9d127e440e4c..44a4d2dbd1d4 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -131,7 +131,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	show_val_kb(m, "AnonHugePages:  ",
-		    global_node_page_state(NR_ANON_THPS) * HPAGE_PMD_NR +
+		    global_node_page_state(NR_ANON_THPS) * HPAGE_PMD_NR);
+	show_val_kb(m, "AnonHugePages(1GB):  ",
 			global_node_page_state(NR_ANON_THPS_PUD) * HPAGE_PUD_NR);
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
-- 
2.20.1

