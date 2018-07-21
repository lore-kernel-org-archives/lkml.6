Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901DEECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497F120856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGo9aGtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497F120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbeGUNvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:51:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37454 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbeGUNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so229216pfo.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ubexO41eU5i6ImnFrQXEb0OCgTpDP6HhIWS2okH8gp4=;
        b=dGo9aGtj5rIoh60WJ1qGmbuU4LHN/DtPMR+t5vtp4F1ZWh8VRSe7pRfBaMQLxEwC1o
         efdzP0H9N32oV0F3TvXC1np5jsEttBPTuRBaQUe9g/7ttGvJXaSYMKU01RoaSAR68P32
         A9vJfrODqW+gFh3zAiiZpwdPhndQqcDX+EqVlr91ybmACSye7Qp04nz86Rmw00H0LI1i
         ajVbIgefxcH4BEcgUOUHvMsH4S+sjPPnIJESLzNIk3RMhet19wfi7QyJUAHAJfq9QK3o
         mJDbUrJAe4wHkN+/Yy1l1nMaJYfu+0kIOqPWG0I+NVIyEAoW5mrsAVuaUY6Hef6Jl0br
         BgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ubexO41eU5i6ImnFrQXEb0OCgTpDP6HhIWS2okH8gp4=;
        b=lmJx7+86NCB19V9o1G7sHACKCcIdWtprkYeW6rwgVFpewjm6OECzJKiGJbnvAbErlm
         lEX3ZSmRbEYmQiXhXpqXyx3inN7NRhfFAYW5iGRtucuWr/1F27uGvmat97hNhTwhDfmf
         Fl+RFkDDXIRt+766CdjIPIXYa01cdK4DqqangHawPk+wt2Qi6SbaJ8Kw2QSlwH5wZoT9
         UC6Ij6hvX1BfbcRvAszDUUPwf6xVtJDE446/6C6P9l3KY8w4FTb1VW+mUq2WHtVXItrI
         SDFA0zQ2pOGJVQQMmE1nYaq0d2Mnqh22vrNDCzPxJpXQowQbiSdo8i9T56tS7aXvENTn
         TL4A==
X-Gm-Message-State: AOUpUlE0QwecbSai7HEbZi3iYT9D6ketUaeccVyAWU2Wq0OSHWxhgzVR
        t054iyOWsENkaespTeH7FUc=
X-Google-Smtp-Source: AAOMgpd0Gck4w/iPfwFkPEoZ0plRZdiJuGuu2nS+XtadzrVbXDxhiuBmnc2C1Hy0x+WL2GPtkSiI4g==
X-Received: by 2002:a65:5a01:: with SMTP id y1-v6mr5532597pgs.125.1532177874351;
        Sat, 21 Jul 2018 05:57:54 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:53 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 12/14] staging: gasket: page table: convert various logs to debug level
Date:   Sat, 21 Jul 2018 05:57:02 -0700
Message-Id: <20180721125713.88501-24-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Debugging information is improperly logged at non-debug log level in a
number of places, and some logs regarding error conditions may be
generated too frequently, such that these could cause performance
problems and/or obscure other logs.  Convert these to debug log level.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 9f8116112e0ac..f0c4884cb4bc6 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -306,7 +306,7 @@ int gasket_page_table_init(
 	 * hardware register that contains the page table size.
 	 */
 	if (total_entries == ULONG_MAX) {
-		gasket_nodev_error(
+		gasket_nodev_debug(
 			"Error reading page table size. "
 			"Initializing page table with size 0.");
 		total_entries = 0;
@@ -323,7 +323,7 @@ int gasket_page_table_init(
 
 	*ppg_tbl = kzalloc(sizeof(**ppg_tbl), GFP_KERNEL);
 	if (!*ppg_tbl) {
-		gasket_nodev_error("No memory for page table.");
+		gasket_nodev_debug("No memory for page table.");
 		return -ENOMEM;
 	}
 
@@ -332,7 +332,7 @@ int gasket_page_table_init(
 	if (bytes != 0) {
 		pg_tbl->entries = vmalloc(bytes);
 		if (!pg_tbl->entries) {
-			gasket_nodev_error(
+			gasket_nodev_debug(
 				"No memory for address translation metadata.");
 			kfree(pg_tbl);
 			*ppg_tbl = NULL;
@@ -658,7 +658,7 @@ int gasket_page_table_system_status(struct gasket_page_table *page_table)
 	}
 
 	if (gasket_page_table_num_entries(page_table) == 0) {
-		gasket_nodev_error("Page table size is 0.");
+		gasket_nodev_debug("Page table size is 0.");
 		return GASKET_STATUS_LAMED;
 	}
 
@@ -903,7 +903,7 @@ static int gasket_perform_mapping(
 				(unsigned long long)ptes[i].dma_addr);
 
 			if (ptes[i].dma_addr == -1) {
-				gasket_nodev_error(
+				gasket_nodev_debug(
 					"%s i %d"
 					" -> fail to map page %llx "
 					"[pfn %p ohys %p]\n",
@@ -1612,7 +1612,7 @@ int gasket_set_user_virt(
 	 */
 	pg_tbl = gasket_dev->page_table[0];
 	if (!pg_tbl) {
-		gasket_nodev_error(
+		gasket_nodev_debug(
 			"%s: invalid page table index", __func__);
 		return 0;
 	}
-- 
2.18.0.233.g985f88cf7e-goog

