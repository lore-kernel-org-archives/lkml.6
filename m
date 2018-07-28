Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7CCC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F1F208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDVaa6LF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F1F208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbeG2AnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:43:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40208 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbeG2AnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:43:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so8711875wrs.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wjqr9oW2v98Sh4Pkw8ZVY9CuXao3Z4EK2O6ZSMuHy6I=;
        b=EDVaa6LFloRBNSe/19E//k5WiowHuHOVHO1juklmpzgzYTmOqZVj2i8RyUFsVCWZt0
         fMRbZMXK5n/L7hbWKRPGcgIvHMcLTiXc/U55n2IZfUrvPprz8g+SrxAGaH6krd/igzdA
         D4umavXKpSxTXB0iRFfElVTGZ8NYgYb/uXYklHka7DR6qGE79Ddwu2nxcukIasG0kgSd
         KW8BjaegCYTA0xP131pNqZaGbs/jKsMa5W0eWJmqTzXGNh1BwXsBB+Qgro4ODf7mw6vq
         Tr2sKxq+B4zXtSVp/8lctE3u3CmhoPLRsKQJ+lEuIg2xvl3U2g4Hc4ICHxC0iYqz1Hr0
         5g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wjqr9oW2v98Sh4Pkw8ZVY9CuXao3Z4EK2O6ZSMuHy6I=;
        b=lQEmY3Clsthq8FZFlNz9SH9TFaYaP8XrpQ3Vr6wTwTK0X6JERJqgC3STE/uxUd/XC0
         MLV9y0y0/MbhmLWE1YDAQz/X20A2cXWaFljUcQudkIk4mMldR0/ae0icQkyEm+Sk7Yxq
         a8EtqUBAKKBa/7DOf/l3raAcEu9T11VaDJSoAT6O7NRzVdR2qehT9t8X4fdNgo9fefvI
         z3h4maS1r2JitQoJe7yO6bOLTPfB7S8NwMEQIVOGl+JzfA57p8AfOtf55EpBVjHLLmAB
         Pxyb6AK1riHeC3jWqGbIqEcQNueGKLRGGpe7qhZb7rw8Qu4Ry+jEi/XGWHUJV/fGHvY+
         NLyA==
X-Gm-Message-State: AOUpUlHKpTfGw27hF/Yi3euco8l8w6XbSzPQY1WWqSwUYb0CRAHWBfeN
        cGSpnOg6SvQgUE7C+9lF0BXEs0wZ
X-Google-Smtp-Source: AAOMgpe1KRMaSxQ9Z2m2dr7I+ochWJZthenQW7MymphXwN5wBxwslxfYbaOy/VpjdLxcaDB6ZXjOKg==
X-Received: by 2002:adf:fdcd:: with SMTP id i13-v6mr10606090wrs.276.1532819708999;
        Sat, 28 Jul 2018 16:15:08 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id j131-v6sm8909745wmb.25.2018.07.28.16.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:15:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 07/08] staging:rtl8192u: Rename union QOS_TSINFO - Style
Date:   Sun, 29 Jul 2018 00:14:51 +0100
Message-Id: <20180728231452.20107-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728231452.20107-1-johnfwhitmore@gmail.com>
References: <20180728231452.20107-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union QOS_TSINFO, as a type, should have a lowercase name. The
union has therefore been renamed to qos_tsinfo. Additionally the
'typedef' directive has been removed to clear the checkpatch issue
with defining new types.

These are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h    | 6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 428a8c4cebf1..17b676b0ed8b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -42,7 +42,7 @@ enum direction_value {
 //	1. WMM spec 2.2.11: WME TSPEC Element, p.18.
 //	2. 8185 QoS code: QOS_TSINFO [def. in QoS_mp.h]
 //
-typedef union _QOS_TSINFO {
+union qos_tsinfo {
 	u8		charData[3];
 	struct {
 		u8		ucTrafficType:1;			//WMM is reserved
@@ -56,7 +56,7 @@ typedef union _QOS_TSINFO {
 		u8		ucSchedule:1;			//WMM is reserved
 		u8		ucReserved:7;
 	} field;
-} QOS_TSINFO, *PQOS_TSINFO;
+};
 
 //
 // WMM TSPEC Body.
@@ -66,7 +66,7 @@ typedef union _TSPEC_BODY {
 	u8		charData[55];
 
 	struct {
-		QOS_TSINFO	TSInfo;	//u8	TSInfo[3];
+		union qos_tsinfo	TSInfo;	//u8	TSInfo[3];
 		u16	NominalMSDUsize;
 		u16	MaxMSDUsize;
 		u32	MinServiceItv;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 79c96da41d8b..4d92b97a1521 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -355,7 +355,7 @@ bool GetTs(
 			// For HCCA or WMMSA, TS cannot be addmit without negotiation.
 			//
 			TSPEC_BODY	TSpec;
-			PQOS_TSINFO		pTSInfo = &TSpec.f.TSInfo;
+			union qos_tsinfo	*pTSInfo = &TSpec.f.TSInfo;
 			struct list_head	*pUnusedList =
 								(TxRxSelect == TX_DIR)?
 								(&ieee->Tx_TS_Unused_List):
-- 
2.18.0

