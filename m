Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DE4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0D820857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPjNTbvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0D820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbeGaWmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43001 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732472AbeGaWmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so5853600edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bDlImQf/upvPckdyLVfdcp9H9e3C2zXLEiPZlPdQUsg=;
        b=jPjNTbvml2lVR9pUYVSINLVB6MRyNVB62ufe+jhhlc674dCt8FquhU/NiJWTj3+071
         PLViyZq2VHsIUyDYzor35NTiEV6g+S43eo56A2tbSvUn3++9bav3DAf7wAWqOK4DSBoN
         FoRzijXy5nSUeUpbHpVovuV8g5JUENwFGcGsLqnN5llWWVJWs7xPKkQ9vO7ZcfyrHECp
         VIe1FneBhwdOmwdOhVQ5BVSTP/A+BfUwC4d+zmcEnddglmJZe6WOGlEJHb20UUatNK+G
         eCckEf1rZEsPgIoI15lUgLCk0XQJKfIfB7qeN02YSnjbOcOxJEiBCsbFguoyxOUrqjoA
         NLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bDlImQf/upvPckdyLVfdcp9H9e3C2zXLEiPZlPdQUsg=;
        b=J7v5+6Shu4tr/HLBdosXaMOBlIHwR8jihDZcG95bU3uR94n8FVdQOUQDvcCtvJtnXq
         KfFldjXxTC40qYaglTai2nQGoBX3o+1y1L4o09e7PvbUi8VHP+EHJAJh3K2GSqIGCa+i
         F3YGwck6qNQTqLcJ414p3IByJ6hshEwJgrqSjcJLYKNBYxVxyS/db3srMTLaG+mJ1R2v
         iUh3Qd2+qg2yec4o+pLvunHw+LKpROU7wt3jsHwRWnSIBUc6YCbJK6tNzNy8hh6dMnDm
         6ygpQbGxD+QI0R1PIZ5mELHLCs0EEMsOZoRe3eb5rg4lnQbeupW0/avCRbPuLCg7RQT/
         c3vg==
X-Gm-Message-State: AOUpUlGi+5Wqbvr7WJ5mI0arv0hAHPBlH8tzb6ABHMekhoLdIek2MlyJ
        K2G8alBw3V+pZMXYaQlnmjNazRbi
X-Google-Smtp-Source: AAOMgpe8lGcb+oO7AbP7pHNMigRqCqkX9hFJPN72b7SUMIHHhziZVlljOkMxIMq7Ibmv75h+XNekBg==
X-Received: by 2002:a50:9b5d:: with SMTP id a29-v6mr1068959edj.167.1533070842070;
        Tue, 31 Jul 2018 14:00:42 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:41 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/14] staging:rtl8192u: Move QOS_TCLAS to rtl819x_TS.h - Style
Date:   Tue, 31 Jul 2018 22:00:00 +0100
Message-Id: <20180731210005.17452-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the union QOS_TCLAS from the header file rtl819x_Qos.h to header
file rtl819x_TS.h, where the structure is actually used, as the member
of another structure.

This is a coding style change, which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 51 -------------------
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index a4b8b577cf79..fb055a848d59 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -69,57 +69,6 @@ struct tspec_body {
 	u16	medium_time;
 };
 
-typedef union _QOS_TCLAS {
-
-	struct _TYPE_GENERAL {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-	} TYPE_GENERAL;
-
-	struct _TYPE0_ETH {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u8		SrcAddr[6];
-		u8		DstAddr[6];
-		u16		Type;
-	} TYPE0_ETH;
-
-	struct _TYPE1_IPV4 {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u8		Version;
-		u8		SrcIP[4];
-		u8		DstIP[4];
-		u16		SrcPort;
-		u16		DstPort;
-		u8		DSCP;
-		u8		Protocol;
-		u8		Reserved;
-	} TYPE1_IPV4;
-
-	struct _TYPE1_IPV6 {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u8		Version;
-		u8		SrcIP[16];
-		u8		DstIP[16];
-		u16		SrcPort;
-		u16		DstPort;
-		u8		FlowLabel[3];
-	} TYPE1_IPV6;
-
-	struct _TYPE2_8021Q {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u16		TagType;
-	} TYPE2_8021Q;
-} QOS_TCLAS, *PQOS_TCLAS;
-
 //----------------------------------------------------------------------------
 //      802.11 Management frame Status Code field
 //----------------------------------------------------------------------------
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index a9f865f810ce..5cf00a2e08ae 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -14,6 +14,57 @@ enum tr_select {
 	RX_DIR = 1,
 };
 
+typedef union _QOS_TCLAS {
+
+	struct _TYPE_GENERAL {
+		u8		Priority;
+		u8		ClassifierType;
+		u8		Mask;
+	} TYPE_GENERAL;
+
+	struct _TYPE0_ETH {
+		u8		Priority;
+		u8		ClassifierType;
+		u8		Mask;
+		u8		SrcAddr[6];
+		u8		DstAddr[6];
+		u16		Type;
+	} TYPE0_ETH;
+
+	struct _TYPE1_IPV4 {
+		u8		Priority;
+		u8		ClassifierType;
+		u8		Mask;
+		u8		Version;
+		u8		SrcIP[4];
+		u8		DstIP[4];
+		u16		SrcPort;
+		u16		DstPort;
+		u8		DSCP;
+		u8		Protocol;
+		u8		Reserved;
+	} TYPE1_IPV4;
+
+	struct _TYPE1_IPV6 {
+		u8		Priority;
+		u8		ClassifierType;
+		u8		Mask;
+		u8		Version;
+		u8		SrcIP[16];
+		u8		DstIP[16];
+		u16		SrcPort;
+		u16		DstPort;
+		u8		FlowLabel[3];
+	} TYPE1_IPV6;
+
+	struct _TYPE2_8021Q {
+		u8		Priority;
+		u8		ClassifierType;
+		u8		Mask;
+		u16		TagType;
+	} TYPE2_8021Q;
+} QOS_TCLAS, *PQOS_TCLAS;
+
 struct ts_common_info {
 	struct list_head		list;
 	struct timer_list		setup_timer;
-- 
2.18.0

