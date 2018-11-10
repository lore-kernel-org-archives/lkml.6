Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2759C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911CE22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRVtqkKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911CE22504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbeKMGGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:06:07 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42000 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeKMGGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:06:07 -0500
Received: by mail-io1-f68.google.com with SMTP id h19-v6so7128148iog.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 12:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=G4cJi4rjeVqw5//2Rb5uT8ty823OadA78ByrL+zVCq4=;
        b=BRVtqkKtVUhUJtS3ny6fqbVF7eANd2Sv9248fhNoHUvyRsOSPzEzI8jBbWYZChjJBA
         w9aAPpYyIuy+N37SZhaAId1ke0ArICaPnHjVE8EkZO9BkFnyJuRxXysASJuK/Pq6kZOC
         WxGW3fA8ucV586MtpiPQimsTsAyIdY7poFn8Csfsm7M6g1ZZHqW2KY+qpQOfX7cyBBkl
         lPWOSE8mJw279+a1qW1m+my3FpnE0f+h9hteQK4feSAl24uKYqIWv9ixrVfdERg/WGqr
         5QWOy0PhmHEE8jPBrrmOG0WlMUJfkGuC7J0pbu2B9mJNUXXq+V30SGy+g67DHIPqIIj6
         XcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=G4cJi4rjeVqw5//2Rb5uT8ty823OadA78ByrL+zVCq4=;
        b=hleoUAHu0Vb3t9SS2MOFImzIPg4/ex8TM8ZlV4SIGJKSrHnaNKUfdSK4vZFGuXPv9U
         qb9jvYHkVEDZ1WNNNO+tA6v6qrslScc0H1geD/Q8OfxMi4jXuyl3iiOFXYLf+bRRcF1q
         RgghGWlR5OOUwZ4Ydm09+URVQT9LyV5n8i809QkaNCZI6Vtv37TgnDzWT3obT74ch4R5
         T807QLCYjvZDK+gpioCsBRKS6n5zC6F38zYO68g36A8hBF6Ii3qi8fI31e31lDC8wars
         kWgJb7LkR9TvxIf+/7peEydGR+cdujWhL4jryLqnF5NGGaB9jmwKGjPAMNqlMGco2Vjb
         zGPg==
X-Gm-Message-State: AGRZ1gIlaMDqZ3DZG+HhGNzoymNGZH95OkcAqRFcCXOsHP6/dJWJ2Z5n
        bQ2UpND6t58TIncQSbJ7QRn7oXYn
X-Google-Smtp-Source: AJdET5ftTkgofk9MYsw+ngKOJkHQpBaIkB88cA6EZRl+qgYLxIVWRAYIpnpS0zFtX4lnFgCOiQP31w==
X-Received: by 2002:a6b:3fc5:: with SMTP id m188-v6mr1938951ioa.188.1542053479466;
        Mon, 12 Nov 2018 12:11:19 -0800 (PST)
Received: from rdeal-VirtualBox (cpe-174-98-59-17.cinci.res.rr.com. [174.98.59.17])
        by smtp.gmail.com with ESMTPSA id a185-v6sm4994857itc.14.2018.11.12.12.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 12:11:18 -0800 (PST)
Date:   Fri, 9 Nov 2018 22:48:49 -0500
From:   Robert Deal <robert.edward.deal@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] help conform gasket page table to style
Message-ID: <20181110034849.GA18111@rdeal-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formating arguments in gasket_page_table.c functions to conform to
the kernel style.

This is my first patch and I apologise in advance if this email and or patch
is not correct, or if i sent it to the wrong maintainers.

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

