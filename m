Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67CFC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E26217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCEYY3jJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E26217CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbeHDLTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:19:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53878 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbeHDLTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:19:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so8702634wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+3YhrMrUeGWoJrZ2wy/EbrmmWhd1NpGwLMUeVXxdlY0=;
        b=kCEYY3jJaGPog7qzqQgjYwlE7hQsHaqVLn+yBAHvb2MmQUuhkYZJbnmEKhWWKarl/2
         BvDI2TC6F3Um1R6mRIl7AdAmDQ4bSMol781Ax+zO+KsH2NqiqZZUfffphR5motgs1wRA
         N4KYth3lEJrMy78GXCmrCBDyCfv1E/47UMl/wlfbhz6ibq/rNiW2fjcgeVrnJRv5LBFF
         KgGIfU5pu2a2OUtUiYc2zWQ1pVU0rOL0W+84yW/gIhKSz0sb9LzbSqWpX14Nos3T9tHZ
         ooRLsRY2e6JKRxq/0McuLTqpPSAmsM5l/gYC/o0dFSimX/k1fU3RChv1Wt2dXDvTXBEs
         NIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+3YhrMrUeGWoJrZ2wy/EbrmmWhd1NpGwLMUeVXxdlY0=;
        b=YloEk3x9WU6kGdqy3L7GheimymFHI5jXDlM96S4vaUyFE+yKBxbYuptiynQUn7yZab
         5+XwKoS3fdDDHjthJ5TVZPAbjnKz15H4mBLrgBRonrzIenrDql2TKaeBjwV8k2J2Sl4P
         iRidcGrn/nhJXfy235IfN+tFoRCgddyCLbKL8ng5wmK8RwUIjKJgYuaEtGt8SqL1mG1M
         HHnLcAITVfxqGzs5ADMDEKoaI3wzDmXB/HujXJpx6oQ68sgtBlvt95BSlSR2E3Fo0Mux
         2gDTETBstTpAnBgik0SEj+3ncgOd7hVc6j+zYitbeYFN0rjWB/sP/MrtQiAoozM5vwcn
         6vdw==
X-Gm-Message-State: AOUpUlFNfRnC1M4Bshb0IomMLShN01vYQHj9UBJcs8NX/xZEAd0Nzq80
        4lWgCKelaWFSVDKBKq3bCLNlQPgLiJ8=
X-Google-Smtp-Source: AAOMgpchNWTPcTtFhQsM8b+sKY29XvmzEjIoNNhtj1A6fQ/b+fsFHW0TeOqPZr87PYsVuvBTDQJNpQ==
X-Received: by 2002:a1c:9847:: with SMTP id a68-v6mr5442873wme.99.1533374352155;
        Sat, 04 Aug 2018 02:19:12 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id q188-v6sm2710040wmd.36.2018.08.04.02.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 02:19:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 5/7] staging:rtl8192u: Remove comments - Style
Date:   Sat,  4 Aug 2018 10:18:57 +0100
Message-Id: <20180804091859.6729-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804091859.6729-1-johnfwhitmore@gmail.com>
References: <20180804091859.6729-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removal of three comments. The comments in question do not add anything
to the understanding of the code, and if they are necessary it would
imply that the structure and its member variables are badly named.

This is a simple style change and should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 93984e8e87c3..924d4b373099 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -78,8 +78,8 @@ struct ts_common_info {
 struct tx_ts_record {
 	struct ts_common_info		ts_common_info;
 	u16				tx_cur_seq;
-	BA_RECORD			tx_pending_ba_record;	/*  For BA Originator */
-	BA_RECORD			tx_admitted_ba_record;	/*  For BA Originator */
+	BA_RECORD			tx_pending_ba_record;
+	BA_RECORD			tx_admitted_ba_record;
 	u8				add_ba_req_in_progress;
 	u8				add_ba_req_delayed;
 	u8				using_ba;
@@ -93,7 +93,7 @@ struct rx_ts_record {
 	u16				rx_timeout_indicate_seq;
 	struct list_head		rx_pending_pkt_list;
 	struct timer_list		rx_pkt_pending_timer;
-	BA_RECORD			rx_admitted_ba_record;	 /*  For BA Recipient */
+	BA_RECORD			rx_admitted_ba_record;
 	u16				rx_last_seq_num;
 	u8				rx_last_frag_num;
 	u8				num;
-- 
2.18.0

