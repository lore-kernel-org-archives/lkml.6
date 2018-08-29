Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F6DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED558205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/fRqIvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED558205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbeH3Aep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40891 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3Aep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so6758070wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ByJyiwGVa7cSxprkpaN4ePRZrzG8NLf8VIF8XluxnRQ=;
        b=p/fRqIvh+a0/37qGWIFTE1o4qbV5YRLHSH/dz+eGKEr6WHhHL3dGxg5rNcCuZMdU1L
         67vXdCKd2zTv7W7op+JSdVMCweLRmseNXYEjYY6D+oIJVLuDSfIbJUjtkP7Y0fT4a7gS
         xIVCz/0hdAFVFVFP97FEzYCHg6hyNqf92W7M+t2NzstuFzGRILy6xVXKR+U1Csc2+nvC
         W0mUhR5F8seBdWQfpkCqrdZVxkx8MSs0einzK7+L5ebU/hDiyoaswBPldr3cOB0oK7K6
         wLiD9cM+n3N6mX0n8RLG7cfhSjjJydeB1p0dlHr3+KKq79OXRiWiIkxokjRMG3gHD14Z
         egWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ByJyiwGVa7cSxprkpaN4ePRZrzG8NLf8VIF8XluxnRQ=;
        b=jiUaXfEuLmuDCmXnfsEBH7bLvd4FM4aTwPfxHruaIKbxWEZ6JOYlv18c9HSozDju+o
         pAXGaiJQe4V2K1ebtawkW6DEhofurL87YTXznYkYDOvhVXfdUFqpYmkhdVTDWjz5n6ny
         IKWXCfqwewSuQQtJkixdwwElwSSwJBVJdLHRTUAyZ+fTrR+sWJ/UDscCCjQqECMPQpzU
         D1mI/nSGw+P5n/H2qLi+Nw4mb6dZKL11CNnT+Z+5rmPBjAokDx/6dM1/B1ucoBmT0rSg
         qJF7yL9kAwItOxDLHQXVUIY7gkq8jmWbhI5869gB5TxbW5lNLovzkXG2Cti/Qxpo5hy9
         sgoQ==
X-Gm-Message-State: APzg51CkI1oMD5mB765FNQn8z28+mxaXyBNs8bgRLzlEqbKdrAwyQ8vH
        gcG8BE56nvWg7QvfU5cTzHPGA5+vQjs=
X-Google-Smtp-Source: ANB0VdZInss1pMP0o8BC/AIxdBmCQt2FH5Hw+GczbXt0tpKbwoZqnJtOVTtir80cuqQXZl2quFNEag==
X-Received: by 2002:a1c:2787:: with SMTP id n129-v6mr5139225wmn.101.1535574969774;
        Wed, 29 Aug 2018 13:36:09 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/21] staging:rtl8192u: Rename RxSTBC - Style
Date:   Wed, 29 Aug 2018 21:35:34 +0100
Message-Id: <20180829203547.15650-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member RxSTBC, since its use of CamelCase naming
causes a checkpatch issue. Because the member is not actually used
in code the variable has been renamed to 'not_used_rx_stbc'. The
single line of code which initialised the member has been removed.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index ab61c9e81c2c..994ff0f30a07 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -46,7 +46,7 @@ struct ht_capability_ele {
 	u8	short_gi20_mhz:1;
 	u8	short_gi40_mhz:1;
 	u8	not_used_tx_stbc:1;
-	u8	RxSTBC:2;
+	u8	not_used_rx_stbc:2;
 	u8	DelayBA:1;
 	u8	MaxAMSDUSize:1;
 	u8	DssCCk:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 65c377094278..c0789ddfd024 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -560,7 +560,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->short_gi40_mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
 	//pCapELE->chl_width, pCapELE->short_gi20_mhz, pCapELE->short_gi40_mhz);
-	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
 	pCapELE->MaxAMSDUSize	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	pCapELE->DssCCk			= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
-- 
2.18.0

