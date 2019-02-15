Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09EBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8628A222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="GAhYBfQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hJ8TkaDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393033AbfBOWJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:11 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38519 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730633AbfBOWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:08 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4460031E4;
        Fri, 15 Feb 2019 17:09:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=0R137jNOULA0X
        2GJv6mEJu5LnxgF5CPDaCLQF5uXUrw=; b=GAhYBfQMmMRzrEHYF5T9M2KOo4dry
        SLuvQ9eILeoNUaXhEQY7COUT/A3kkS2ktOFJU94tA9dmQ7FYOC+QE47OpMSvVVoV
        FPIKfIBrMFRkN0aI8Vt29uXi9f4EsBptLlzhcvDiy/9sTHFTeNpyjVy0JF2oVa9Y
        qvcXUDDU1aCMPdMVhTpsTgtsB3KNIot7yoHXl7GRjQCbJSmttB3C74c45K7ju+qo
        dj2OtrJuDC5KZy9igtlw36VqsDRcUZ9tFc/8tYhOBJ8EsRckG7sN5Tc8vtn4lP2j
        k/k24X5OlVW6DMf2JIVDUL0DOPk5ebHDSrifOCiQnwUdijrCEaZpnAsWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=0R137jNOULA0X2GJv6mEJu5LnxgF5CPDaCLQF5uXUrw=; b=hJ8TkaDB
        yewsnxFqRp9q1orVZP7Tviy/yYFVMXM54lVvD8Mw1fVOJhRdGY+F41C0udeuWqOT
        E1ZOFzs/5e9CwB+Y8IfshApHXlnOWSJI71Usb5zjVRwI5EbZ+FcSe2Y5txfPjEFW
        e0JLu+Y1dTVLgSwR7jU2KtjOcX3i3XtZJSss2ni+Ai3M2IpquYPKUtdXung5LpqD
        zHA/Xz4MTHHXW/etVqaqYBqN4IxODCrIthiEPgM7p2eLYwO7wdmm0uofxB/n0uD9
        YiVf5ysutMlbtxgR+xtBEscxqFb/m93V05mwMUizfp16iIxo9qMBQNGTV4pIReM+
        f882ZfB1ihjnJw==
X-ME-Sender: <xms:gThnXBN_qmSXEE4j_wEV6G-M7LHvM_8HCc4CM0NQ5_HDVfypitNsrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedu
X-ME-Proxy: <xmx:gThnXEXhVXTgW8hjrbeETRoKJEXwVEsForw_HemEcFEd61K1_DdaEA>
    <xmx:gThnXBb2SrFexQLReoIQbIlxVPDooV8f7EONQH650YJbWpCs8oqgrA>
    <xmx:gThnXJs8HGQYvHPRFBcOSmk_hRIiGc2Qh7e4Aaa-eAi-P46Kde41OQ>
    <xmx:gThnXL4to-yXfkDIAYljYJIC_I1jLQco36wk88r0tLxHVtoQ6BI31w>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4187CE46AB;
        Fri, 15 Feb 2019 17:09:04 -0500 (EST)
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
Subject: [RFC PATCH 03/31] mm: migrate: Add tmpfs exchange support.
Date:   Fri, 15 Feb 2019 14:08:28 -0800
Message-Id: <20190215220856.29749-4-zi.yan@sent.com>
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

tmpfs uses the same migrate routine as anonymous pages, enabling
exchange pages for it is easy.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/exchange.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/exchange.c b/mm/exchange.c
index 8cf286fc0f10..851f1a99b48b 100644
--- a/mm/exchange.c
+++ b/mm/exchange.c
@@ -466,7 +466,10 @@ static int exchange_from_to_pages(struct page *to_page, struct page *from_page,
 		rc = exchange_page_move_mapping(to_page_mapping, from_page_mapping,
 					to_page, from_page, NULL, NULL, mode, 0, 0);
 	} else {
-		if (to_page_mapping->a_ops->migratepage == buffer_migrate_page) {
+		/* shmem */
+		if (to_page_mapping->a_ops->migratepage == migrate_page)
+			goto exchange_mappings;
+		else if (to_page_mapping->a_ops->migratepage == buffer_migrate_page) {
 
 			if (!page_has_buffers(to_page))
 				goto exchange_mappings;
-- 
2.20.1

