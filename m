Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEE8C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9639520652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7Pwox7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9639520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeJOMoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:44:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34605 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeJOMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id f18-v6so8675531plr.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REvWl6h7uqkQ0ooxW+I4lyjuNlyvPQXk6NQbJVOXu1U=;
        b=R7Pwox7mCT/77xh4Fj8Z6iY8gHHfXCXtSYzoqOIeUOqhhzFpVV+jjM8GJN4WRh2Vap
         /whQeqvDi/wMUGulse5FRrgQHOWfZegzxyKIfT00cs2kzlUw7CpharHiwG56iaU9Qx9I
         XYdLSZCjQoSa5ZZFnQ5qANxhBt5fivM630pd5bILx2z1ylOB4YO8kIdVWPN1Pdzq6CTh
         pPthSeTEs19t9epaoWgtCB73i4SOWdGgmE434JiGqM4BaECkVPmICkE83WkrdQRk6NtY
         Amgflq/9uNxio6PhUqi9N+GxfdxL3/Y3Yc1nwu7LDJ+gb8ZtEsXmrtcAg23OhKF114Gl
         zzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REvWl6h7uqkQ0ooxW+I4lyjuNlyvPQXk6NQbJVOXu1U=;
        b=SWsmmY+AjTmqHWaDuAErv3x5UnCG1QW7KDoEhFiJ/e/sbhyK5xwLpF0S0r5wjPCia2
         qv2QxNG5fGQ2VfL+IssAufOKK8+kwRMIiJaMgYjH7tq5HQgmc6NFZADW7AEEDH8CO93O
         h1eXSWKeha1Ll6oSv7IGSQAuaD5U4Sae9rZY/9yvK3iv8Qs9IJB/vWmT7kxN/AVqh8sl
         DNMGCq9m5XMw6//F63nN0gg2FTf+bC5m2uiZO4oZMz2sAzWtdF+GMks+oL/G7TR0fGOs
         cIGEdrPXz6KAwPqigNlwXDU9MWRDgg8KIiGP4EFkX2uMr/H2p8TiZvq5YzjKiGd45KWP
         WfIw==
X-Gm-Message-State: ABuFfoilSx7bkG9D99W4MuPPhiDYpkybhc9Xz6FJsF4Zpg4u4v9QCAFt
        5EMTVBbE3ZWFIO1ZmltwRcI=
X-Google-Smtp-Source: ACcGV61reGdOmw0SI7WVG1kc095DF2g8NBVbI9HhtHVBBx/2Zln9li4/mtg70kg0d9nEern5fZcieg==
X-Received: by 2002:a17:902:e201:: with SMTP id ce1-v6mr15177123plb.47.1539579599902;
        Sun, 14 Oct 2018 21:59:59 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.21.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 21:59:59 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 05/11] staging: gasket: page_table: rearrange gasket_page_table_entry
Date:   Sun, 14 Oct 2018 21:59:21 -0700
Message-Id: <20181015045927.156790-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Rearrange gasket_page_table entry to reduce padding slop.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index d2e115d2dba30..9c2f8671216b5 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -103,12 +103,6 @@ struct gasket_page_table_entry {
 	/* The status of this entry/slot: free or in use. */
 	enum pte_status status;
 
-	/* Address of the page in DMA space. */
-	dma_addr_t dma_addr;
-
-	/* Linux page descriptor for the page described by this structure. */
-	struct page *page;
-
 	/*
 	 * Index for alignment into host vaddrs.
 	 * When a user specifies a host address for a mapping, that address may
@@ -119,6 +113,12 @@ struct gasket_page_table_entry {
 	 */
 	int offset;
 
+	/* Address of the page in DMA space. */
+	dma_addr_t dma_addr;
+
+	/* Linux page descriptor for the page described by this structure. */
+	struct page *page;
+
 	/*
 	 * If this is an extended and first-level entry, sublevel points
 	 * to the second-level entries underneath this entry.
-- 
2.19.0.605.g01d371f741-goog

