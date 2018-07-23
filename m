Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D91ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0220C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYyjXB85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0220C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388284AbeGWVxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:53:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50458 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388255AbeGWVxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so430725wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TIeAJXrmBk9qqEbDR/pAlv1fWkyHLYg1VP5Otql7Kf8=;
        b=tYyjXB85xulxQMREzLa5SScBAP1g2CNf4dvsKIwJkNOjVrqO4kTdSfAEu4pyh2Iefb
         0CuB1erx/1JFisUKTeyvMli7eGPJE3yX+rsUHLRzCF8kWgQLkOZOF32T2iXyDaPD1V8L
         w071xHHHK5dTe5UFtLYHEhbdr5E2QngDTbVLhgp2L/WHQJMyNam8IpopPcCIcAgFKq//
         ovn/3oa9w9XTAqwLFs26WXjh/xPqDmtWoW1Amgu8g+249LHZnSilNxGIdm6PPAA+0TQ0
         hQX8Q/jgwdm1ehqEk+zc6rm7TuugXAVvprCmT7ED2HzIGv06tX/cEB/dWlVMvSLnRHPE
         zbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TIeAJXrmBk9qqEbDR/pAlv1fWkyHLYg1VP5Otql7Kf8=;
        b=BHiQ3tRWxqYew1JSadVPm8G7uPAQqfFj7MI8C8eNkKys49L96Yn/8w17KXce4AXqtI
         +lZTYwM5twlY9Q4GKk1umaYJoqaSQ5F5ijnlEUvdB1pZeskOA3bf00SZlwnpKSVj7+9e
         H3nXJqQdNdUW8OOapTiS7+rLGCtLV1zD/aI9hNxIpdDjJ1gDpCMqBDz12/M6ERbszg5z
         tSY2jXFYUE2xr8+oogLeZoOa3UcADymGzu824PQXmyeQsr6vCGE7V6CjHB1fKAVJouzF
         aJ12+68D/JAGcV2o/IvzYL8sm20On+vygnYUH5jTQRFFzodi2L7DU6lgwPXbLZSlXmDq
         3JyQ==
X-Gm-Message-State: AOUpUlHP4XldPUkkGW7o8koV7hvscStjaF7PdN1B1KQNqbBAyCAGKRqJ
        NDrdjWkYV1zNOT93MenqmjUp+wpx
X-Google-Smtp-Source: AAOMgpfzG23jGQrJy5Igsag1WwmBMrrl0bSXrEyT1xF3TS7O0OhTKGcwsNgT4+/fW87wDGSoKcKCdg==
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr273011wmf.1.1532379053099;
        Mon, 23 Jul 2018 13:50:53 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:52 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/15] staging:rtl8192u: Remove unused structure QOS_CTRL_FIELD - Style
Date:   Mon, 23 Jul 2018 21:50:22 +0100
Message-Id: <20180723205031.19816-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure QOS_CTRL_FIELD is unused in code so has simply been removed
from source. This is a coding style change and should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 50 -------------------
 1 file changed, 50 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index da74d4a29ed2..90f5939c9ecc 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -9,56 +9,6 @@
 
 #define WMM_PARAM_ELEMENT_SIZE	(8+(4*AC_PARAM_SIZE))
 
-//
-// QoS Control Field
-// Ref:
-//	1. WMM spec 2.1.6: QoS Control Field, p.9.
-//	2. 802.11e/D13.0 7.1.3.5, p.26.
-//
-typedef	union _QOS_CTRL_FIELD {
-	u8	charData[2];
-	u16	shortData;
-
-	// WMM spec
-	struct {
-		u8		UP:3;
-		u8		usRsvd1:1;
-		u8		EOSP:1;
-		u8		AckPolicy:2;
-		u8		usRsvd2:1;
-		u8		ucRsvdByte;
-	} WMM;
-
-	// 802.11e: QoS data type frame sent by non-AP QSTAs.
-	struct {
-		u8		TID:4;
-		u8		bIsQsize:1;// 0: BIT[8:15] is TXOP Duration Requested, 1: BIT[8:15] is Queue Size.
-		u8		AckPolicy:2;
-		u8		usRsvd:1;
-		u8		TxopOrQsize;	// (BIT4=0)TXOP Duration Requested or (BIT4=1)Queue Size.
-	} BySta;
-
-	// 802.11e: QoS data, QoS Null, and QoS Data+CF-Ack frames sent by HC.
-	struct {
-		u8		TID:4;
-		u8		EOSP:1;
-		u8		AckPolicy:2;
-		u8		usRsvd:1;
-		u8		PSBufState;		// QAP PS Buffer State.
-	} ByHc_Data;
-
-	// 802.11e: QoS (+) CF-Poll frames sent by HC.
-	struct {
-		u8		TID:4;
-		u8		EOSP:1;
-		u8		AckPolicy:2;
-		u8		usRsvd:1;
-		u8		TxopLimit;		// TXOP Limit.
-	} ByHc_CFP;
-
-} QOS_CTRL_FIELD, *PQOS_CTRL_FIELD;
-
-
 //
 // QoS Info Field
 // Ref:
-- 
2.18.0

