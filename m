Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32725C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB5A20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYMS7xiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB5A20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbeG1Aw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:52:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50178 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbeG1Awz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:52:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so6866896wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zzkFgHU2zoYMH3bOY4DKm8e8p8PC4fieXyW6P81BaOE=;
        b=cYMS7xiP0FdKLRc68WPGB6z0C5KYH0y5FVT4DfX4+lLOkQFTd+A0rvTJhHwI8kuI13
         DF9pcESVwmAB67JiaIIX7IUj2xC8ohh3Rxz0aZ+mB8+KFZU9RAf5mcMRcRMaeTI+uXWO
         f/ixQVCRC1V9FsA1Xtm590zFTIrYG7D1q1ZLtdyfepr9T3yAcqaQFwCGb+zVV/o2b8hJ
         cxnc4h8xc/iZrpeuKyMHIDAUAvUwiHay9UyMgdbNdb2hNXxGkAjtcbzaE4AHJTsKQKzF
         E/cfZrbKF8i9bhO6rMtHBCx0PFwcjpXGmWEvDtZsd6vhmMfPcKw9Yqa/2ZXWbhOl6+8H
         tSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zzkFgHU2zoYMH3bOY4DKm8e8p8PC4fieXyW6P81BaOE=;
        b=khls3vV9sWbkTvQxzxN8v63wc9hQ/S9NdxlAhum67CqangH8vwlxpAIvi2Yt05grcB
         EfF7aetNJsMENqbWoLuMgJFikAqa573xegZEoH3k2Q91gNq0RezSCtzBzTAug6QnmgQL
         sEShxQRmJ4myuE5h+CR947QGgK8ZeVb0COZKENJhDExaPlcRzNh2X2GpXLsIgYLavzce
         kEOzxDjST4m42WTF1gelfSu7BtvUaYoAVU4UE2rS01mSmroD3UsJuDGjIGs1aECoyE2G
         4UbPrIEFfgAOrY2c+iDwwB0dlwRQJ8nW1GB3rqu3RJGE5wn75/aSEqVLhsGsM866MDWQ
         t72g==
X-Gm-Message-State: AOUpUlGWuQe19zaR3EQi32qsUW778wCOaPVaUg+KVUqIIDPHMQd9B/H4
        2LA3LgmNOJ/go0DAvHn9nfhthOPF0U0=
X-Google-Smtp-Source: AAOMgpd3jeESwpoht3CuimVT8rQDdn/yQ4UU3y2RvoIG5+Hv0Wsu6riO93Lp/iZTBm8Ung7p+D267g==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr6249440wmd.77.1532734126210;
        Fri, 27 Jul 2018 16:28:46 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7313217wru.93.2018.07.27.16.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 16:28:45 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/10] staging:rtl8192u: Refactor enum dm_dig_cs_ratio_e - Style
Date:   Sat, 28 Jul 2018 00:28:25 +0100
Message-Id: <20180727232826.28014-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727232826.28014-1-johnfwhitmore@gmail.com>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type dm_dig_cs_ratio_e is never actually used as a type,
but only as a collection of related constants. This is because the
variables, which use the defined constant values, are defined as being
of type u8 rather then enum dm_dig_cs_ratio_e. This omission negates
the possibility of taking advantage of compiler type checking.

To enable the use of compiler type checking of the enumeration the two
variables, (curcs_ratio_state & precs_ratio_state), which use the type's
constants have their types changed from u8 to enum dm_dig_cs_ratio_e.

Additionally the types declaration has been moved above the dig
structure, where the type is used. The 'typedef' keyword has been
removed from the type to clear the checkpatch issue with defining new
types. And the constant DIG_CS_MAX has been removed since this is never
used in the code.

These changes are purely coding style changes and should not impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 41b08211e958..2aef330379cb 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -87,6 +87,11 @@ enum dm_dig_pd_th_e {
 	DIG_PD_AT_HIGH_POWER = 2,
 };
 
+enum dm_dig_cs_ratio_e {
+	DIG_CS_RATIO_LOWER = 0,
+	DIG_CS_RATIO_HIGHER = 1,
+};
+
 /* 2007/10/04 MH Define upper and lower threshold of DIG enable or disable. */
 struct dig {
 	u8		dig_enable_flag;
@@ -107,8 +112,8 @@ struct dig {
 
 	enum dm_dig_pd_th_e		curpd_thstate;
 	enum dm_dig_pd_th_e		prepd_thstate;
-	u8		curcs_ratio_state;
-	u8		precs_ratio_state;
+	enum dm_dig_cs_ratio_e		curcs_ratio_state;
+	enum dm_dig_cs_ratio_e		precs_ratio_state;
 
 	u32		pre_ig_value;
 	u32		cur_ig_value;
@@ -121,11 +126,6 @@ struct dig {
 	long		rssi_val;
 };
 
-typedef enum tag_dig_cck_cs_ratio_state_definition {
-	DIG_CS_RATIO_LOWER = 0,
-	DIG_CS_RATIO_HIGHER = 1,
-	DIG_CS_MAX
-} dm_dig_cs_ratio_e;
 struct dynamic_rx_path_sel {
 	u8		Enable;
 	u8		DbgMode;
-- 
2.18.0

