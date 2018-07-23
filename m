Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2F7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779E020875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLKMqQb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779E020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbeGWVxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:53:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54636 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388161AbeGWVxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so413196wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Av0CJmxQz3UTLL1rs3jzjBY1wWc1pDHVb6ZSaIA95I0=;
        b=LLKMqQb19TrMFy62KFsQYkmLE/RjrJeGoeCUHggtxN+/50sZ+iEwRez5KEr6eCE/CJ
         a3ZHGErDO7jlsgfHhHbeBj7snARuG5UCXdwiNtWDNmOP1V2gZtXKikRd3wysVkbUCs8t
         P8m4nVvumCFBzXZI/Ofpe09Y1vBQQlaPc3PhcjNUnWcglAFa8v1ScsG+a9GilO3jHtlt
         TH3Y/KUL/vKsB8+QBfVwxkPKY5aZ7297vcqEJeKtFyZvB4mI1fjcDF45tC9Nvyxn7c39
         LMixRiGwxWlcmzzNbaqDuD+cIw5Z8OrnrU7Ud+iXJCetV7uKM6TzhbgcOD4m7/6vGaw7
         4+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Av0CJmxQz3UTLL1rs3jzjBY1wWc1pDHVb6ZSaIA95I0=;
        b=N39hdjv3hNeIAl7oebYyiTFOhkrI9Fm0cH7hDx9yeHfF+PffS4BjpnMqBuI+iYrtY/
         TH9vlcPAu/f5FOMUUCnjNgZU0JfYCFhZx51yI4xgLjV+Da1O1IurMpKmNOLxAuMUlpeB
         Z2vndndYmBvXhGvg1+b54FZNrmrc19LFPZmpQ/LiMDCH8FHHprJ7GHnDHDQVzmIda0M+
         4floRa0auTqVPqesgQpFyma0FY7qGLIMCmsSkVlVPOEkehQk+Qcg/3p/yy2m+IhlGzuj
         vOnWSZtaYJAfjLvHrQsyPNRe7eyWX29YLMlqXCDXHCznxLDy6hE1mZh1DB5AN/lbayLn
         3JLQ==
X-Gm-Message-State: AOUpUlF5sZt23R3kX+xq5CVUPQ3pHSrWO8Go5FCR24CQf2201WQ8cS7A
        3qj0EXbEzzVewjNifC/QteFkToM+
X-Google-Smtp-Source: AAOMgpdROLVv/wFjUJHJpIfOONf/nxh10Tjuvg7U9IjAEWYXLAyDyCgjP9v2pXYPnJUrwkZOaaprFQ==
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr273693wmd.144.1532379054654;
        Mon, 23 Jul 2018 13:50:54 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:53 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/15] staging:rtl8192u: Remove unused union QOS_INFO_FIELD - Style
Date:   Mon, 23 Jul 2018 21:50:23 +0100
Message-Id: <20180723205031.19816-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union QOS_INFO_FIELD is unused in code so has been removed from source.
This change is a coding style change so should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 86 -------------------
 1 file changed, 86 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 90f5939c9ecc..e0c51c5c6816 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -9,92 +9,6 @@
 
 #define WMM_PARAM_ELEMENT_SIZE	(8+(4*AC_PARAM_SIZE))
 
-//
-// QoS Info Field
-// Ref:
-//	1. WMM spec 2.2.1: WME Information Element, p.11.
-//	2. 8185 QoS code: QOS_INFO [def. in QoS_mp.h]
-//
-typedef	union _QOS_INFO_FIELD {
-	u8	charData;
-
-	struct {
-		u8		ucParameterSetCount:4;
-		u8		ucReserved:4;
-	} WMM;
-
-	struct {
-		//Ref WMM_Specification_1-1.pdf, 2006-06-13 Isaiah
-		u8		ucAC_VO_UAPSD:1;
-		u8		ucAC_VI_UAPSD:1;
-		u8		ucAC_BE_UAPSD:1;
-		u8		ucAC_BK_UAPSD:1;
-		u8		ucReserved1:1;
-		u8		ucMaxSPLen:2;
-		u8		ucReserved2:1;
-
-	} ByWmmPsSta;
-
-	struct {
-		//Ref WMM_Specification_1-1.pdf, 2006-06-13 Isaiah
-		u8		ucParameterSetCount:4;
-		u8		ucReserved:3;
-		u8		ucApUapsd:1;
-	} ByWmmPsAp;
-
-	struct {
-		u8		ucAC3_UAPSD:1;
-		u8		ucAC2_UAPSD:1;
-		u8		ucAC1_UAPSD:1;
-		u8		ucAC0_UAPSD:1;
-		u8		ucQAck:1;
-		u8		ucMaxSPLen:2;
-		u8		ucMoreDataAck:1;
-	} By11eSta;
-
-	struct {
-		u8		ucParameterSetCount:4;
-		u8		ucQAck:1;
-		u8		ucQueueReq:1;
-		u8		ucTXOPReq:1;
-		u8		ucReserved:1;
-	} By11eAp;
-
-	struct {
-		u8		ucReserved1:4;
-		u8		ucQAck:1;
-		u8		ucReserved2:2;
-		u8		ucMoreDataAck:1;
-	} ByWmmsaSta;
-
-	struct {
-		u8		ucReserved1:4;
-		u8		ucQAck:1;
-		u8		ucQueueReq:1;
-		u8		ucTXOPReq:1;
-		u8		ucReserved2:1;
-	} ByWmmsaAp;
-
-	struct {
-		u8		ucAC3_UAPSD:1;
-		u8		ucAC2_UAPSD:1;
-		u8		ucAC1_UAPSD:1;
-		u8		ucAC0_UAPSD:1;
-		u8		ucQAck:1;
-		u8		ucMaxSPLen:2;
-		u8		ucMoreDataAck:1;
-	} ByAllSta;
-
-	struct {
-		u8		ucParameterSetCount:4;
-		u8		ucQAck:1;
-		u8		ucQueueReq:1;
-		u8		ucTXOPReq:1;
-		u8		ucApUapsd:1;
-	} ByAllAp;
-
-} QOS_INFO_FIELD, *PQOS_INFO_FIELD;
-
 //
 // ACI to AC coding.
 // Ref: WMM spec 2.2.2: WME Parameter Element, p.13.
-- 
2.18.0

