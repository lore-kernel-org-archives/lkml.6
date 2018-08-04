Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F2EC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C408F217CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2J/Xlvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C408F217CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbeHDLTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:19:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51679 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbeHDLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:19:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so8707323wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zBiYLp2M4NGuObombw7FqzyAFwGufrowZxvmDIvzZ3c=;
        b=e2J/XlvgKX9LwQxfZRVnfmXtmuUrXTIvcrCIZoAQ+eYlU4DM7I886sFh1sDUGvN611
         NK9cMwcg3+MZzJMIFAx/0pD//J2zv8/9ZaKErDvJcuUJl5lF5zzC/ehrB6gkjg3Y847+
         VYvmiDNPe4l9BMacK2aNjH010ykfv7zEypBfhaTY86E80UaERIVTWRSh7GbrCdrXWeNc
         Nhdsk7pYO2B2S37TVUoZS4qQo51Xa6MhShbTdefTIudRpA0zlxhACqIyWbUkv+6nb2vD
         nr1UtRV+j+bVP8rcyLaHSDGm0ZapRwfLLXa+R2AAOwoJXoumwpbYPFZ7jjdJNFG9Mmkz
         V/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zBiYLp2M4NGuObombw7FqzyAFwGufrowZxvmDIvzZ3c=;
        b=Oe3iCnUFOSyedxQgDcI9de55r1DVJcv0DUvgpO3lAMo2bK9ZO6D1ILxoI0CDaaira3
         VMYBO9EdLCOPKAoLjW6+LLCClm5j0JWfBvsYTN3B50adapeLlFXmApSTzWLJ7tRKaaxu
         ZMjWiDJVPuenTwlQF+Wj4GgST1Y6zJGiYWoh+EyaZJ4G43fvqXj94bW3MC0HlhyKq8Jb
         YALjipdyHIhzGpZP8A83oURh5sNUexxtaEJLOhYnTLuzgeX463nznCHblYIES173GdGo
         fd4qlYDj1j6ga30SFMdiySTjbgXpWlWWRayyw34danxvPEJUZdYdGyRyXWl7sS+k87t7
         n9vQ==
X-Gm-Message-State: AOUpUlFN/kXjp4IbjZ7xDNNTpdGq2bUC7EfhkiXo8ul/vkhPDiGPFbMI
        j6bwykdlkzg7WMTw0VC6amqnrS3fXIE=
X-Google-Smtp-Source: AAOMgpf3EiePiDEkAWURSvgYQ++eHhM0Lg/QfGOzb/+OLBHZywlCkBm20PPIzpaVfidg6BARS+pCkg==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr7580803wmh.111.1533374348088;
        Sat, 04 Aug 2018 02:19:08 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id q188-v6sm2710040wmd.36.2018.08.04.02.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 02:19:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 2/7] staging:rtl8192u: Rename types in QOS_TCLAS union - Style
Date:   Sat,  4 Aug 2018 10:18:54 +0100
Message-Id: <20180804091859.6729-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804091859.6729-1-johnfwhitmore@gmail.com>
References: <20180804091859.6729-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst none of the structures inside the qos_tclas union are used, their
names conflict with the coding standard being named in uppercase.
The names of all five have been changed to lowercase.

This is a style change, and since none of the structures are referenced,
these changes should have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 823ba363e0ab..c352ba0bcd8f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -16,22 +16,22 @@ enum tr_select {
 
 union qos_tclas {
 
-	struct _TYPE_GENERAL {
+	struct type_general {
 		u8		Priority;
 		u8		ClassifierType;
 		u8		Mask;
-	} TYPE_GENERAL;
+	} type_general;
 
-	struct _TYPE0_ETH {
+	struct type0_eth {
 		u8		Priority;
 		u8		ClassifierType;
 		u8		Mask;
 		u8		SrcAddr[6];
 		u8		DstAddr[6];
 		u16		Type;
-	} TYPE0_ETH;
+	} type0_eth;
 
-	struct _TYPE1_IPV4 {
+	struct type1_ipv4 {
 		u8		Priority;
 		u8		ClassifierType;
 		u8		Mask;
@@ -43,9 +43,9 @@ union qos_tclas {
 		u8		DSCP;
 		u8		Protocol;
 		u8		Reserved;
-	} TYPE1_IPV4;
+	} type1_ipv4;
 
-	struct _TYPE1_IPV6 {
+	struct type1_ipv6 {
 		u8		Priority;
 		u8		ClassifierType;
 		u8		Mask;
@@ -55,14 +55,14 @@ union qos_tclas {
 		u16		SrcPort;
 		u16		DstPort;
 		u8		FlowLabel[3];
-	} TYPE1_IPV6;
+	} type1_ipv6;
 
-	struct _TYPE2_8021Q {
+	struct type2_8021q {
 		u8		Priority;
 		u8		ClassifierType;
 		u8		Mask;
 		u16		TagType;
-	} TYPE2_8021Q;
+	} type2_8021q;
 };
 
 struct ts_common_info {
-- 
2.18.0

