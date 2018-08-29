Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E960FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9960D20666
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxHKjLS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9960D20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeH3AfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:35:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54830 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbeH3AfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:35:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so6537888wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KZJby10M2M7A5jH603hbjvq6RMU0NqzaE5Kkteb7usE=;
        b=gxHKjLS8iSxWhcLx+y147MmuV8boO+IGEjwu+2P+x63+M8+MHEKxbwvA+vlWFwiYsC
         3alM6s40BRNALRdSUNakrOU33lXxEVRbEF03GL/QavQu4CjTRgLPxrOGCjcKeRxo9HKu
         BAdE9VvjPCVa8ezhbIOnaya+msXGqthmwi2Ex5BXtX0G+BR7aaMAvTfUhxFQsSA//K0u
         VTSPNoVEPT2EqSH6ZSLNNFdAjxTtChKQDEborNyz2qxwHuuLJLvyYNJO1nsklQCru+cW
         yzm8jxS7K+B5uwrLCr2iUM0P/B8Z/1QlnEhNld29yJ77HvxC/HttZEcsAtyr1m9Ld05v
         W6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KZJby10M2M7A5jH603hbjvq6RMU0NqzaE5Kkteb7usE=;
        b=hWbHJVgJbaA+JQQ32EKbSd6s5aQs1kxofR8AetVFS3+xjxaLz/Jd2XXIuYW09dAGoC
         7Bh7UPSemjnDtxPXsF4UicOVmp2wV3TLQkBBaeb+cQCYDxQ63FjUpt16izG0MZ2MgptR
         lwSgsAJvManc0buQwVIo9aFUBvIJoohuzAKmCEfsILRjzQoaKsLwbQsZ5Du7FORMgr0f
         tkU1qcPvjywQ0XA7+RVTSq2qPznKPSQD/yp7RUDDnVEka9Jxl4FPqd10BvPVQtXNSqM1
         +EkmC4yEOk+MmjiOFcNOpGTw+i/Ln+2vw/hRzZbpzzA3LZsW6DiBZ7CDRlvnBqnCEDL4
         H48g==
X-Gm-Message-State: APzg51CFM64RZIGDNckUAwmaKHuz2ZhwCSrl5Y+uhFnxwJtxoAI5L3O/
        FgQIhNcqjVYMdr+Y+cir5UxJ2NB4Vmk=
X-Google-Smtp-Source: ANB0VdZKoy/PUFgPmglTyO1yM4ro3/N1tSlXYomEvFHngW/7FtGSo0Pa+0+6SneuHc/QeQESrv0G+w==
X-Received: by 2002:a1c:2283:: with SMTP id i125-v6mr5380894wmi.28.1535574991540;
        Wed, 29 Aug 2018 13:36:31 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:30 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 20/21] staging:rtl8192u: Rename TxBFCap - Style
Date:   Wed, 29 Aug 2018 21:35:46 +0100
Message-Id: <20180829203547.15650-21-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable 'TxBFCap', since it causes a checkpatch
issue with CamelCase naming. The variable has been renamed to
'not_used_tx_bf_cap', since the member is not actually used, apart
from initialisation, which has been removed.

This is a coding style change which should not have an impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index b4a412d8f61c..fa4c0ab43703 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -66,7 +66,7 @@ struct ht_capability_ele {
 	u16	not_used_ext_ht_cap_info;
 
 	//TXBF Capabilities
-	u8	TxBFCap[4];
+	u8	not_used_tx_bf_cap[4];
 
 	//Antenna Selection Capabilities
 	u8	ASCap;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index fe7682d8e258..3e2172b6008b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -599,9 +599,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 			pCapELE->cap_mcs[i] = 0;
 	}
 
-	//TXBF Capabilities
-	memset(pCapELE->TxBFCap, 0, 4);
-
 	//Antenna Selection Capabilities
 	pCapELE->ASCap = 0;
 //add 2 to give space for element ID and len when construct frames
-- 
2.18.0

