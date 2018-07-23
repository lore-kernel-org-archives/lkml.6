Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1C720880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+g2kFWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1C720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbeGWVyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:54:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35356 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeGWVyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:54:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id a3-v6so2003241wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g4UclxoNJ8SP0vbsz6ltnCsITebOd2Gap9UhyxnCDZM=;
        b=j+g2kFWg/KAvyC51u0RJoB2f6NdVfTDhjK5Y5EgFff/71p928rQQ8fBsP5A3UirPqv
         t6Q6c4IxL+B2ESWC8XUZmMkTlXWCS4V6Yr89aPMz+d/KRw9IfnR9qv1fk5n7RyzSQqqv
         5sMvmSCmLTPFPEsJG7/6hJR1z+IF5oAcYNbdxfh0ms9/NRAGh9km9yrCRm6qjfXlN1qK
         r08UXz9rm1OaoGslbx4vx79k0UOp+1If/qk/v+lcwwPqheB7yhN/YxqQ+wx5rXaaOmhr
         ZXDJq1w+A99HVIwH60nbz1SXnSpk+9299h9/L4G6PUTBdnG3fA35RDUrPTwtvXR1s/DA
         smyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g4UclxoNJ8SP0vbsz6ltnCsITebOd2Gap9UhyxnCDZM=;
        b=shKJHBfeKu9Kw7kcAGcxTSGYv5IPXCGLayt+Dc3HDo2l9jvhxki3ahvXa+1NWd9WDA
         esOUqird/DiYbOQyez5jElzv/eC1dsV9Wvp5oiuVJIvPLR+rAxQc7ZjnrAWwbJO6/y4e
         i8eAqj5nsj4g5s7d2HhQu6P6fl4D3Ya9l4tct0oMcRj9pyLhhfyUAEHwWQuY75h/kklM
         lvhD9oP377+DK3OVRQ4YcZuKulI2Oaxdp8cD5xEjuIjkzzlP9pegURPOq7PiaVWT7kkM
         +lgsudF83cDBVia884joiiFipE9341OsCU4RSvTojLE0iPZwpP07DB3sF9aDI7hKKWW4
         9x6Q==
X-Gm-Message-State: AOUpUlGH5AalqKRCQZtWj7PRzl7xIYI1gdqs0Q1XcfIXR0il9f5o/cqy
        DcXEzrJvcaMVgzOGbcN+1E7CB60N
X-Google-Smtp-Source: AAOMgpdOI0SkrssFolLwT4myknvCIHwXhBw6ojPrUWFoguy16XQ11oVS7Rf7vzyZNg8xV3mDojyKag==
X-Received: by 2002:adf:ef03:: with SMTP id e3-v6mr8958512wro.182.1532379062474;
        Mon, 23 Jul 2018 13:51:02 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:51:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/15] staging:rtl8192u: Remove unused enumerated type ACM_METHOD - Style
Date:   Mon, 23 Jul 2018 21:50:28 +0100
Message-Id: <20180723205031.19816-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the enumerated type ACM_METHOD as it is unused in code. This is
a coding style change and should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 58101d1ff2b8..49d9184f22ec 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -112,17 +112,6 @@ typedef union _TSPEC_BODY {
 	} f;	// Field
 } TSPEC_BODY, *PTSPEC_BODY;
 
-//
-// ACM implementation method.
-// Annie, 2005-12-13.
-//
-typedef	enum _ACM_METHOD {
-	eAcmWay0_SwAndHw		= 0,		// By SW and HW.
-	eAcmWay1_HW			= 1,		// By HW.
-	eAcmWay2_SW			= 2,		// By SW.
-} ACM_METHOD, *PACM_METHOD;
-
-
 typedef struct _ACM {
 //	u8		RegEnableACM;
 	u64		UsedTime;
-- 
2.18.0

