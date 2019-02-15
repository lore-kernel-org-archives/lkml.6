Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29E5222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="ZAWqHFVS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7EJVwMDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404415AbfBOWL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:11:29 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56763 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393025AbfBOWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4F0A6310A;
        Fri, 15 Feb 2019 17:09:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=6ymhdlS0PDEIx
        uW6nq05LKSmTCjvZyCs+nOTiikq+3M=; b=ZAWqHFVSjc7AMUIPUmVIUa6hcCX+X
        Ob2ZssfT10pMRBWr/zR+1ObMQyajh8+qwCJbD8rMpMudIV3IqGfK1Cg/nQdlV9X5
        uIRNDPywDowLQM82w8SRqIl+V+nmHXLqfcR87ullpaMMqpgUKbPupsPfr3yKWANX
        U1F6UJs2FYVBVyQMkgdkzL0Z/qxfXQfdGhNjDwt+TLajRm4T9kjYLu+Sjrn8wbox
        3LvgzM8ysGXv0Ufm+CQQhR02liZ0JCrEeY9o02prDi5UZEGRt405Oi3sDRTBYs5+
        JSaOM8nzV8Ue+yR+bytxuZMoOAhV9NBeut//pOp162k9zHp7GcjH/jzeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=6ymhdlS0PDEIxuW6nq05LKSmTCjvZyCs+nOTiikq+3M=; b=7EJVwMDl
        uKYJsQjnqcYbihQy6KGbt8K216aqhCQYZkKwRZFkYKgtNqSWaQ/SZyJPShOxPff/
        0Mbqh/2JNwJsciSqnw3c0E5taomwFv97PvP3Pc+XYX63SLve1Idd9/knB8gMB94n
        l4/kD/8BhizsJ+QhLLQWAwxgSKpyINs+cmJieie+HgbhmcwuZCBF+k5eIJ1NBgSb
        ZYco42z77qgkk9zZhhW2N6wbWUWI6eFZbE+BCqxgaugva08jcfbaBK6ZZuq0LAF8
        t4WaMzFjcGweQcEd7ZWu9XdsVbk/62OQWwabrrwS5sZ3ct8x27RO56pqMD4lv3U1
        W9ZbmDFDgBpTkQ==
X-ME-Sender: <xms:hThnXG13NdlOX8pIQ4M4JG8GPIJueRDkHhG7UVYxopadmLmH9ZLbGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpeeh
X-ME-Proxy: <xmx:hThnXMF4wrKi-0nHAgs2eH7A3T_KZc0aRKwRXSKSxjhu2ynHw187Fw>
    <xmx:hThnXIysuxWrmZ54OK41Ntcev2gp7ZLE9bXoKoTYJ7TdJpJybDWIjw>
    <xmx:hThnXC5ZmaKeBJn1ndDN6EynJS-LBjIInWVhMW-gw1tE5TLY5AX3-Q>
    <xmx:hThnXNeYwAluH7YpHJQIwfc8LhWr8F433CzqI_QEsUP6nW9QGochXw>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7598FE4599;
        Fri, 15 Feb 2019 17:09:08 -0500 (EST)
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
Subject: [RFC PATCH 06/31] mm: Make MAX_ORDER configurable in Kconfig for buddy allocator.
Date:   Fri, 15 Feb 2019 14:08:31 -0800
Message-Id: <20190215220856.29749-7-zi.yan@sent.com>
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

To test 1GB THP implemented in the following patches, this patch enables
changing MAX_ORDER of the buddy allocator.

It should be dropped later when we solely rely on mem_defrag to generate
1GB THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/Kconfig                 | 15 +++++++++++++++
 arch/x86/include/asm/sparsemem.h |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..f766ff5651d5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1665,6 +1665,21 @@ config X86_PMEM_LEGACY
 
 	  Say Y if unsure.
 
+config FORCE_MAX_ZONEORDER
+	int "Maximum zone order"
+	range 11 20
+	default "11"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
 config HIGHPTE
 	bool "Allocate 3rd-level pagetables from highmem"
 	depends on HIGHMEM
diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 199218719a86..2df61d5ccc2d 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -21,12 +21,12 @@
 #  define MAX_PHYSADDR_BITS	36
 #  define MAX_PHYSMEM_BITS	36
 # else
-#  define SECTION_SIZE_BITS	26
+#  define SECTION_SIZE_BITS	31
 #  define MAX_PHYSADDR_BITS	32
 #  define MAX_PHYSMEM_BITS	32
 # endif
 #else /* CONFIG_X86_32 */
-# define SECTION_SIZE_BITS	27 /* matt - 128 is convenient right now */
+# define SECTION_SIZE_BITS	31 /* matt - 128 is convenient right now */
 # define MAX_PHYSADDR_BITS	(pgtable_l5_enabled() ? 52 : 44)
 # define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)
 #endif
-- 
2.20.1

