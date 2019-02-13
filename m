Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60698C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359F0222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="THQG++2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391251AbfBMRrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:47:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404533AbfBMRqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EqKUxXuSonkTTvkNlEundh14K2DWfFZ464FMZZAxl7E=; b=THQG++2+MpmCSvwZtsq9Qoqqqf
        4pcV87lepVdvEDJawizc06v8uTJiifCdLqFWYhdT2wo4PD9BaqH6zGTNiEp4I1icDbm/v2UL84LFW
        I5UqL2g2H2Pl6/sv5Tsvv6pO0pe4rvW135XYLfzY8clFVkZW9YzvAZnUJvCdvHkBAOQYCJfg4ttSc
        0U8FgGhAo9WR3OToYDnniks3nmuixZ9J1jvkgv2/DupTXIq1+zsvahcU2fDanry73ZPvYVSbxdwfK
        MO5KmpsBmOx19exAMgTEt9dwA302YaEAsaG8HnynUyR4xy7Q7WTpW5V4DB6ufo//uv7BsJw1a5yoY
        MWRZjbPQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyc3-0006YY-Vg; Wed, 13 Feb 2019 17:46:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] mm: unexport free_reserved_area
Date:   Wed, 13 Feb 2019 18:46:14 +0100
Message-Id: <20190213174621.29297-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is only used by built-in code, which makes perfect
sense given the purpose of it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 35fdde041f5c..45f12a42709d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7255,7 +7255,6 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 
 	return pages;
 }
-EXPORT_SYMBOL(free_reserved_area);
 
 #ifdef	CONFIG_HIGHMEM
 void free_highmem_page(struct page *page)
-- 
2.20.1

