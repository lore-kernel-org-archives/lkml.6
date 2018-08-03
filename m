Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D1DC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7BF21709
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTd/pGTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7BF21709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbeHCB4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44998 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHCB4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id f23-v6so1550676edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z+BNxof3xd4YoA/WeiLqW3WbqSrgq1Pg2n9oK/KV4/Y=;
        b=vTd/pGTSn6Dz+5S1hw5GnqgleXdRntKIeg4UzcIPIPbLw0Ob0EsMJf6TXLeLeC3szs
         NPihuiDW55puCXx5l5hOUS4GvQuZ6oU+VNxLogpSgqfiCEr3fy6sePRfBeB1i5Vls/gr
         sCFtTsck4Hf+fZ3FOavUiIUW/044vrdEsBLZVq4GAyDLgNnq6PuMjhMz7+gpvdXHPzcx
         hzf4SFsP9fqaLbZFuWq8ahCIM+TBBXbYeX6SXvD7rMhXwyo9/zHjVO2bN1Z9s/JxqDF7
         K+LecdLgVhAYI5Q1SfMxccK8kqQX2UGqeWBahB2XhL6QpeRDiY+LZUd9AF9APabI77u0
         cHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z+BNxof3xd4YoA/WeiLqW3WbqSrgq1Pg2n9oK/KV4/Y=;
        b=IM5MzDgxZpo7yXdryz+KziW+0uvHrdMA63ea3BtvzZlQj5OQtwnUA/Xt5XCWcK2ev9
         3+7HsdLk82qmg2x7rXBxjTpaTG4t4C9bl+aC59WGeuZdgj0rZYEi43YdQiEtLda+SIr4
         weBH3NDXYT8I/zNcY85VvVM6eiQotQTm9T1SbrTRyu8W9Ki5LQODFvTf3LkihpTq6F6l
         Ky4WgHZ8OnPeXPOU00+xWtwcKqZ8azEB9nY3I5KZYZMxaEfD/qZPo9xPGwBQSMee+SLd
         Sr/c2L0htUCghEe8pp0YACa8wB4unWFPL6vzhSQR0GTsXYKrZfrZWPWDkc8k08s78CIk
         lclA==
X-Gm-Message-State: AOUpUlGCQug8gi5bn2mPYOoUa76z6A8gJ6JRasx1MMWWhBtGy2uLHzCD
        /r9qs3+qJo0E6xqhm8DOZefXAGEk
X-Google-Smtp-Source: AAOMgpc+obM2B2CGjLwWJ6/M0BrQVViwQ0NeUrzsnqLTC3iQg+fhNIX55gjIR4A20y9D7Scz4qVbrg==
X-Received: by 2002:a50:9e2f:: with SMTP id z44-v6mr5121827ede.303.1533254571412;
        Thu, 02 Aug 2018 17:02:51 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:50 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/18] staging:rtl8192u: Rename cck_Rx_path - Style
Date:   Fri,  3 Aug 2018 01:02:00 +0100
Message-Id: <20180803000211.10589-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable cck_Rx_path to cck_rx_path. This clears
the checkpatch issue with CamelCase naming.

This is a coding style change which should have no impact one runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 8 ++++----
 drivers/staging/rtl8192u/r8192U_dm.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 611bf3e34bf3..495f563879c8 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2417,8 +2417,8 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 		return;
 
 	if (!cck_Rx_Path_initialized) {
-		read_nic_byte(dev, 0xa07, &DM_RxPathSelTable.cck_Rx_path);
-		DM_RxPathSelTable.cck_Rx_path &= 0xf;
+		read_nic_byte(dev, 0xa07, &DM_RxPathSelTable.cck_rx_path);
+		DM_RxPathSelTable.cck_rx_path &= 0xf;
 		cck_Rx_Path_initialized = 1;
 	}
 
@@ -2573,8 +2573,8 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 	}
 
 	if (update_cck_rx_path) {
-		DM_RxPathSelTable.cck_Rx_path = (cck_default_Rx<<2)|(cck_optional_Rx);
-		rtl8192_setBBreg(dev, rCCK0_AFESetting, 0x0f000000, DM_RxPathSelTable.cck_Rx_path);
+		DM_RxPathSelTable.cck_rx_path = (cck_default_Rx<<2)|(cck_optional_Rx);
+		rtl8192_setBBreg(dev, rCCK0_AFESetting, 0x0f000000, DM_RxPathSelTable.cck_rx_path);
 	}
 
 	if (DM_RxPathSelTable.disabledRF) {
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 53daec820ca7..b1f19bad2c30 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -130,7 +130,7 @@ enum cck_rx_path_method {
 
 struct dynamic_rx_path_sel {
 	enum cck_rx_path_method		cck_method;
-	u8		cck_Rx_path;
+	u8		cck_rx_path;
 
 	u8		SS_TH_low;
 	u8		diff_TH;
-- 
2.18.0

