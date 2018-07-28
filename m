Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED73C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B4620842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DINPAXrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B4620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbeG2AbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:31:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42530 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbeG2AbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:31:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so8693078wrs.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gntd5pvlF7xcaMQM2QoUHVJwEXKCwJCUaf7ecd4NaBU=;
        b=DINPAXrPOMNv/65uPtQKEUx0OvkheGnNItALpV2GbMQ9jeL/yYkmfBuZwJ8MtnN2QC
         1ocQYONFufp6MwgTl4u8H34Uh4XT2RgjiF7Ft++tU5JPumGe3+i5efrb4NfDrGa6zhTA
         yy9apl64KYjBQ28NZhlQ4bUgFnp0UG2he9XxYQkNYH9YnPURrFzEON8qIMZhhPA/QDBv
         8Edacy8/+jN0LVz/VcIQMNOg3dgeT4ERY3CU6ODatiHQY3RXPB4uPNkHImTcWDjCcbVw
         N7CyU1uw9MN2VY1G6dfeU1MGly514v4DfbnbyC/PrUkOShtjicgpcdNrLlgiFd3id/Pz
         F9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gntd5pvlF7xcaMQM2QoUHVJwEXKCwJCUaf7ecd4NaBU=;
        b=kDmcbZb6YzKdjt8rE1cOKtqIwlYL2m3skwpguinrIohFZI08//zQ90JF2cNglBC+j3
         LSMYWc+N0GhuPEoc3DjQvM9gJBSQlEJygwFuuesitI0TRWl90jQjJRoeUST+j1EUc8R+
         Mv3URHa9St7t1JaZix+MBr2x5CvNv0ttA7m52LUCkNjEWQg4RRbt8G4jAFFNz09qtYYY
         Uoj0jN64Im0E2oc76PGzU/Xf5iP7Ws37cW3Dzb/BHlP3MLLG3cTKy+hCZLZIa5UQARcq
         V59AzsAAPysG8+KYcS+te7CdSBb+0EyfDzesv4E36Tr2Omqq4CvcNt21Q+SEsWTYLAoE
         vZPw==
X-Gm-Message-State: AOUpUlG5lO+5rY5ovCq+DGKxZ5m/K9nXznlrfAtkVEsbiSyf8s8S+oBP
        8NJtlswIR+E6GwdSb5GZbB519BZ0
X-Google-Smtp-Source: AAOMgpcVUNW+qPlR2B6hcgmefiMbGAakDjyINaraz68asxypYcvmUWBQZNnh7jS4rJx6J+JNdXs/WA==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr11145191wrq.61.1532818991372;
        Sat, 28 Jul 2018 16:03:11 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m207-v6sm11490569wma.31.2018.07.28.16.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:03:10 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/12] staging:rtl8192u: Remove unused  union AC_PARAM - Style
Date:   Sun, 29 Jul 2018 00:02:56 +0100
Message-Id: <20180728230300.19732-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728230300.19732-1-johnfwhitmore@gmail.com>
References: <20180728230300.19732-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union ACM_PARAM is never actually used in code so removed. This
is a coding style change which should have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 901b85139d3b..43edb830ad5d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -36,21 +36,6 @@ typedef	union _ECW {
 	} f;	// Field
 } ECW, *PECW;
 
-//
-// AC Parameters Record Format.
-// Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
-//
-typedef	union _AC_PARAM {
-	u32	longData;
-	u8	charData[4];
-
-	struct {
-		union aci_aifsn	AciAifsn;
-		ECW		Ecw;
-		u16		TXOPLimit;
-	} f;	// Field
-} AC_PARAM, *PAC_PARAM;
-
 //
 // Direction Field Values.
 // Ref: WMM spec 2.2.11: WME TSPEC Element, p.18.
-- 
2.18.0

