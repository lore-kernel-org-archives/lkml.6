Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2165C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4212064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goRBR8My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4212064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeI0BcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:32:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39990 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeI0BcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:32:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so2883989edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HeEP8lTVz0835vo+4PoDakHzCbXDT7ugsWYPaX1mdBQ=;
        b=goRBR8Myx4Vu6NXNCJeolihuD7sli7Z27FFaRDZDtZNE7HLgHhVn06sMvV1U5v/Ijp
         J5lbwSCR02OZLKb+zpI2PRD/OQrV4QZEbpG7ac36hgMUc7K7D4QXaJj3RLePF04KcgTz
         WbUuhdHqXW/aAodDH1H8sd4j0TLaer69NOXuuUNkSPinaSDUs1qWOPaBeBOZ0d6MlPzM
         Rg+XPASEV+mEfDN94cgvqlWcWXRl5V/ID/J+J2nfvnBly5AEavsv9G28c8MsQ+yxrxlz
         8rDKHjRF4XlOgL3l7kla/XDyqXi6IlRkEMRSfDqmVN+czRBM3jv8D39V//g6GU+FmNzB
         tTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HeEP8lTVz0835vo+4PoDakHzCbXDT7ugsWYPaX1mdBQ=;
        b=loT766o3+e4yFKioPuma6GHNKL+ExBZvmmFf24ux+taIJUzaeqFxY5OO+FJuFg5eEY
         3ljAAK3xKvIaEI/LaozvWk2Zqy+HZ87OwysZObmAxTy2cOe2gAWPMEOpe3K6BpJliOt8
         1p3TYHgt1eej3Q0B3so/Q39PJeLx19LSHxkSYjsHudcIh5FNKz7gjJfwz+2l4YpdMK6x
         3inhe05z49Kv36lL8XWK5oXn7BL1zx+aTji9C8RGwSKUVkciWwE+wvhCnPT4hcQ9KEqJ
         n+UXLcT89TGqvrDMz9Vzguqo+oCr+5KVFLlIRWYbbrvRmdSLpnoUZj/sC+L37WuNAkJt
         6LQg==
X-Gm-Message-State: ABuFfoj6i7nZyL/+SXTvePboeyvS8maXwQNlJDCMzH5AFEvlTbrT5h7d
        9t2ZwrwIiTa5D/Q2UzfoIhUMiXKr
X-Google-Smtp-Source: ACcGV63TA5bS9W5NA5YxOfDHE4CTgcKqvhiIjSRgbGFNYRkKQrKw60qowTumt76N48p9MCCNXmF+dA==
X-Received: by 2002:a50:8f66:: with SMTP id 93-v6mr12191554edy.248.1537989458071;
        Wed, 26 Sep 2018 12:17:38 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:37 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/13] staging:rtl8192u: Remove TxBFCap - Style
Date:   Wed, 26 Sep 2018 20:17:02 +0100
Message-Id: <20180926191704.16322-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member variable TxBFCap is not used in code so has simply been
removed from the code.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 3 ---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index f36fbf56c585..204e4a5495a1 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -54,9 +54,6 @@ struct ht_capability_ele {
 	//Supported MCS set
 	u8	MCS[16];
 
-	//TXBF Capabilities
-	u8	TxBFCap[4];
-
 	//Antenna Selection Capabilities
 	u8	ASCap;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index e20488ecbd96..9188bd925262 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -542,9 +542,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 			pCapELE->MCS[i] = 0;
 	}
 
-	//TXBF Capabilities
-	memset(pCapELE->TxBFCap, 0, 4);
-
 	//Antenna Selection Capabilities
 	pCapELE->ASCap = 0;
 //add 2 to give space for element ID and len when construct frames
-- 
2.18.0

