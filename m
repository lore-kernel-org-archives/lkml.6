Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F31222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="BQ6h4EMP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3v/Qhodh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393246AbfBOWJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:19 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54111 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393199AbfBOWJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:18 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4C83B31E4;
        Fri, 15 Feb 2019 17:09:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=jPUMl05hp4GyY
        NPKyUU/j1/LhtwQWzBCTR2KiGtIjhE=; b=BQ6h4EMPTg4jJ0R72Qup5JbWpeCpy
        dzOaqn8Ww8vNnPWA3Gsra+/513+QVm3TnPdfFClO5KVwub/InOwz/Mnx+T3N6UKN
        /zRSRUSUzkx8O9RHe9QTJM4nfusej/0Ti0wJrf5Sl6JgqKJ+B54Xy3qM0E3BqAX8
        rmKpUXAZCFfpVvSoATLHZdgBtA6r1XW823RVM9iqQ+4PZfU4RF5yNVGIzGo++IJz
        HMLLR4odcMaEAp126CPnk0kJXug+Apz9T1VpbD/iYyYitRDC+NoJgXgeJMTT+6OW
        47thcQNkT0SIPHA4jQAeZSBheymoaWDiQ1y8jJb3iA1HRWuqR0RfYdkXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=jPUMl05hp4GyYNPKyUU/j1/LhtwQWzBCTR2KiGtIjhE=; b=3v/Qhodh
        InEnJMOf3bLckfH9lSJhVQmHnWX/0B2Q4Y2ByWqwrlIcXJI1yMDZA4FMUEpAz6Kx
        sfD4ukW/MRGzTnI79jbXaeyWKo2EQZGiANrOZuQYzvQD6rYitA4xMo6t5vS6ahzJ
        3I9793OkBllaXj2mne6aJa3FsPJOcenUyqAnotNAri7k6anYgC4rvS/19Pj/XCA1
        aVNGKgwn/IzSH5TefCaI3OM0otU2R8Y7nSWLtwDINEAvFntb5FWDjla1Jgy4A2IZ
        JkxolW+rRHnJxQMfM4ms+Avce8xytqW+AcfcBqskAyhcUP9ue4lvzQRCp2zTONBk
        AP4rId/C4vq3rA==
X-ME-Sender: <xms:izhnXI2VS_dBz3PTw5P-TXklNjLd6zOWXhdreeZRjPzC1vLC1OQrTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpeel
X-ME-Proxy: <xmx:izhnXOmkVow0n8y0cz-_ZyaQGo2NgB2uPKL0XTzY0LqmvA0n64DazA>
    <xmx:izhnXH7Qrf3gF0SLW019gYpvTUzhv4lfKKKE8aHfhkFNuNfBFtb03w>
    <xmx:izhnXKz_Tx3reWpKobQgpVDDOwIVxBdhjb2hSgR7ly3WfRRYDmd2sA>
    <xmx:izhnXG99W0ghHBSXKoI7-i4_UBblNpSFENIUXYo-iou4aRgks6ne9g>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id E04D5E4680;
        Fri, 15 Feb 2019 17:09:13 -0500 (EST)
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
Subject: [RFC PATCH 10/31] mm: proc: add 1GB THP kpageflag.
Date:   Fri, 15 Feb 2019 14:08:35 -0800
Message-Id: <20190215220856.29749-11-zi.yan@sent.com>
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

Bit 27 is used to identify 1GB THP.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/page.c                         | 2 ++
 include/uapi/linux/kernel-page-flags.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 40b05e0d4274..5d1471a6082a 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -138,6 +138,8 @@ u64 stable_page_flags(struct page *page)
 			u |= 1 << KPF_ZERO_PAGE;
 			u |= 1 << KPF_THP;
 		}
+		if (compound_order(head) == HPAGE_PUD_ORDER)
+			u |= 1 << KPF_PUD_THP;
 	} else if (is_zero_pfn(page_to_pfn(page)))
 		u |= 1 << KPF_ZERO_PAGE;
 
diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
index 21b9113c69da..743bd730917d 100644
--- a/include/uapi/linux/kernel-page-flags.h
+++ b/include/uapi/linux/kernel-page-flags.h
@@ -36,5 +36,7 @@
 #define KPF_ZERO_PAGE		24
 #define KPF_IDLE		25
 #define KPF_PGTABLE		26
+#define KPF_PUD_THP		27
+
 
 #endif /* _UAPILINUX_KERNEL_PAGE_FLAGS_H */
-- 
2.20.1

