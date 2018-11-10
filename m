Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA36C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D93A22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/TrHFGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D93A22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeKMHWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:22:05 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53462 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMHWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:22:05 -0500
Received: by mail-it1-f193.google.com with SMTP id r12-v6so14874625ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 13:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2YigA4xI0vqIvXIqwK5mp19gQJMv6bYkGSyKwrGBXoM=;
        b=k/TrHFGe0/BvxrdT6/73hseFsxAoVZjDzAQ/pH+YMlTitxUZFjXVlvJKEDGWdN5CHt
         RkuyV2BbVfw25Pon2WDIeVNFiyZixgDmGICTd6DFuyOU9R6L6gsbUuP7CY6ePpBPDp9G
         RcU6+BX8V1/p+Qg3PFj2Sl05aGgl4YoQghrC6mNMyeMJUeaBehGAhqgOk/NCovbUGFse
         y7NfwHFkM8cHBJWfJPmrutzSsDYhPScGkMIUkkFXmtEl+2sAUdaSWoCYhgdOERBLJHOs
         ePXp7nhrQqld4rkBLNwipX+zWEiSn2hGpdr0fdv5RXY0eUQzeQhqf55d9DHWKv8BAVG6
         Wk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2YigA4xI0vqIvXIqwK5mp19gQJMv6bYkGSyKwrGBXoM=;
        b=gYQCU30kPZhMgjw58VdO9+h+m1KswZVZx1i8sJKkqM51IbcZ9pHZOAb7+fWF6/LrDL
         pjqVcVbcahYJNRi26aSwxA6KtoEzM8DT3c9nFi6EC2IWNleE2eEpl1FmN9KYnTHWWPg3
         wBDY1u2pRJjdKLe5EY5Ut1emPBWH58gJmgT3WDcHixPMFy3xYBQcxnEUMAky30kegxz1
         apCySGxFnJvZDVA4ds5ROl9qjGg6MMHeF2DDH3yqzisk5TR1Fb0Zj2/mNeWgKpEVpZ4U
         ZPexezxrUcieUoPjzOTPhoKvZLycj7RrMSz/OPGvTUafB0obE19b9mi8oaMlOOXxUOmb
         fXmw==
X-Gm-Message-State: AGRZ1gJ6l1tZs+vX+dd8FesVpov09Qfjc4Q5ZcYCNLF1ykNJcJjNak71
        LJUzSKBJXFe4jCrBWqF9mpR/aMwp
X-Google-Smtp-Source: AJdET5dDPlNsEtip5jYsIcM9U4BxdIVso3PhwdONUyPp+8QHghSsatAqe1Bla2j21DXIG0Q5v18BCQ==
X-Received: by 2002:a02:7113:: with SMTP id n19-v6mr2381958jac.91.1542058024058;
        Mon, 12 Nov 2018 13:27:04 -0800 (PST)
Received: from rdeal-VirtualBox (cpe-174-98-59-17.cinci.res.rr.com. [174.98.59.17])
        by smtp.gmail.com with ESMTPSA id g18-v6sm5167290itg.7.2018.11.12.13.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 13:27:03 -0800 (PST)
Date:   Sat, 10 Nov 2018 00:04:34 -0500
From:   Robert Deal <robert.edward.deal@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gasket: formatting fixes
Message-ID: <20181110050434.GA18281@rdeal-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat arguments in a few functions in gasket_page_table.c to better
follow linux kernel formatting standards.

Signed-off-by: Robert Deal <robert.edward.deal@gmail.com>
---
 drivers/staging/gasket/gasket_page_table.c | 24 ++++++++++------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index f5253ba9a430..26755d9ca41d 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1088,9 +1088,9 @@ void gasket_page_table_reset(struct gasket_page_table *pg_tbl)
 }
 
 /* See gasket_page_table.h for description. */
-int gasket_page_table_lookup_page(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, struct page **ppage,
-	ulong *poffset)
+int gasket_page_table_lookup_page(struct gasket_page_table *pg_tbl,
+				  ulong dev_addr, struct page **ppage,
+				  ulong *poffset)
 {
 	uint page_num;
 	struct gasket_page_table_entry *pte;
@@ -1134,9 +1134,9 @@ int gasket_page_table_lookup_page(
 }
 
 /* See gasket_page_table.h for description. */
-bool gasket_page_table_are_addrs_bad(
-	struct gasket_page_table *pg_tbl, ulong host_addr, ulong dev_addr,
-	ulong bytes)
+bool gasket_page_table_are_addrs_bad(struct gasket_page_table *pg_tbl,
+				     ulong host_addr, ulong dev_addr,
+				     ulong bytes)
 {
 	if (host_addr & (PAGE_SIZE - 1)) {
 		dev_err(pg_tbl->device,
@@ -1150,8 +1150,8 @@ bool gasket_page_table_are_addrs_bad(
 EXPORT_SYMBOL(gasket_page_table_are_addrs_bad);
 
 /* See gasket_page_table.h for description. */
-bool gasket_page_table_is_dev_addr_bad(
-	struct gasket_page_table *pg_tbl, ulong dev_addr, ulong bytes)
+bool gasket_page_table_is_dev_addr_bad(struct gasket_page_table *pg_tbl,
+				       ulong dev_addr, ulong bytes)
 {
 	uint num_pages = bytes / PAGE_SIZE;
 
@@ -1226,9 +1226,8 @@ int gasket_page_table_system_status(struct gasket_page_table *page_table)
 }
 
 /* Record the host_addr to coherent dma memory mapping. */
-int gasket_set_user_virt(
-	struct gasket_dev *gasket_dev, u64 size, dma_addr_t dma_address,
-	ulong vma)
+int gasket_set_user_virt(struct gasket_dev *gasket_dev, u64 size,
+			 dma_addr_t dma_address, ulong vma)
 {
 	int j;
 	struct gasket_page_table *pg_tbl;
@@ -1346,8 +1345,7 @@ int gasket_free_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 }
 
 /* Release all coherent memory. */
-void gasket_free_coherent_memory_all(
-	struct gasket_dev *gasket_dev, u64 index)
+void gasket_free_coherent_memory_all(struct gasket_dev *gasket_dev, u64 index)
 {
 	if (!gasket_dev->page_table[index])
 		return;
-- 
2.17.1

