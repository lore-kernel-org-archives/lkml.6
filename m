Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83182C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3131B21A84
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDNT227h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3131B21A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbeHHXW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32779 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731552AbeHHXWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so1915567edr.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3PEyKL8B6Hvn3zHu7vwm/12Oz9nWvHp/J7PmrBF9RjI=;
        b=vDNT227hW8g2y2RQ5p1xopnSMJlLf0NPzkpLjaH6mujw5XhNMcIAR5AkyPBCzn/APb
         8NiONFbzSkG/9mixbYT+7fJEQsMcbp4k3z9oRYuoskRmtiB77F6ezxoz6oN3uc2m+FNQ
         CWJqZAUvP0YeHysnawxMCpC2rV7SDAPPaU48Yw2biDDUNBRNggkFxVroPf0JDz5vjgFy
         5nJNtaFAigPkHpWRbZK/IiVwtl6+cDDk4ARe1Zjkjq2krSRVZzbtjFXHbuHgUYyY+dV4
         ZIEhJ6CLDlg+iRJdwUhW6/4p3+RwMOovEqeV7380UdbdlLqo2GvzDIBeAIE+iPrxSrCR
         3gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3PEyKL8B6Hvn3zHu7vwm/12Oz9nWvHp/J7PmrBF9RjI=;
        b=PJJixXWIKnVay8SvWCjZ5laZzr64+Y4mXydG9jwiTry4HZ9uJ6fAbVAoa40cvYRYrs
         0ZL9mlB++cpUNZlL79JIkhAmYdUE2mdb2z21PSK8R2vkqmfwPzvFrWoqpLEWz7QRpI7Z
         DNAbZeMzqPqPRJG1PLKhymBW26GwmlRa9LKudaLi5Qwizg1FCt1kXeHELNRnxSD5oH6n
         Ce5q92vOTJRSchNl2v8GZI1EI7B4JhVtPodXI1MuFxa1gtw8n/vzQj6FDq9iVv5QbFR4
         pWzm5cQL0DnWZur5oLn76ZHGwsl87uroeRhN5palDJXbcNEmPawTgNRQcS5LdvitleJk
         BrQQ==
X-Gm-Message-State: AOUpUlFhq2V7CDrSea1YG0X7TsIaK7cnagVL8xlczHKAT2OXczKGRsUg
        5+evyd5RGbXqC25asvYrMWMFVF3y8eQ=
X-Google-Smtp-Source: AA+uWPzKNTIWNmvEkwAhM42P+QHTymZcDlXClXrQ1vRAO2RmJm07UMvd2vqgDzeq6HmCi1c8fxUYrQ==
X-Received: by 2002:a50:ace2:: with SMTP id x89-v6mr5111546edc.152.1533762058801;
        Wed, 08 Aug 2018 14:00:58 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:00:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 02/15] staging:rtl8192u: Remove macro cpMacAddr - Style
Date:   Wed,  8 Aug 2018 22:00:23 +0100
Message-Id: <20180808210036.22580-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro cpMacAddr implements the same functionality as the
ether_addr_copy function defined in etherdevice.h, as a result the
macro has been removed from the code, and its use replaced with the
function call.

Note that the header comment of the function ether_addr_copy states
that the two byte arrays passed as parameters to the function must
be u16 aligned. Because of this the structure ieee80211_network has
had its member variables re-ordered so that the members bssid and
MBssid are aligned to a u16 boundary.

This is a coding style change which should have no impact on runtime
code execution.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h       |  6 +-----
 drivers/staging/rtl8192u/ieee80211/ieee80211.h    | 11 ++++++-----
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c |  2 +-
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 3bfd7efe05a0..14879bc0fe6b 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -31,17 +31,13 @@ struct rt_dot11d_info {
 	bool enabled; /* dot11MultiDomainCapabilityEnabled */
 };
 
-#define cpMacAddr(des, src)	      ((des)[0] = (src)[0], \
-	(des)[1] = (src)[1], (des)[2] = (src)[2], \
-	(des)[3] = (src)[3], (des)[4] = (src)[4], \
-	(des)[5] = (src)[5])
 #define GET_DOT11D_INFO(__pIeeeDev) ((struct rt_dot11d_info *)((__pIeeeDev)->pDot11dInfo))
 
 #define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->enabled)
 #define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_len > 0)
 
 #define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) ether_addr_equal(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
-#define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cpMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
+#define UPDATE_CIE_SRC(__pIeeeDev, __pTa) ether_addr_copy(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
 
 #define GET_CIE_WATCHDOG(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_watchdog)
 #define RESET_CIE_WATCHDOG(__pIeeeDev) (GET_CIE_WATCHDOG(__pIeeeDev) = 0)
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 3cfeac0d7214..62df6f229989 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -1329,8 +1329,13 @@ typedef enum _erp_t {
 
 struct ieee80211_network {
 	/* These entries are used to identify a unique network */
-	u8 bssid[ETH_ALEN];
+	u8 bssid[ETH_ALEN];   /* u16 aligned! */
 	u8 channel;
+
+	// CCXv4 S59, MBSSID.
+	bool	bMBssidValid;
+	u8	MBssid[ETH_ALEN];    /* u16 aligned! */
+	u8	MBssidMask;
 	/* Ensure null-terminated for any debug msgs */
 	u8 ssid[IW_ESSID_MAX_SIZE + 1];
 	u8 ssid_len;
@@ -1341,10 +1346,6 @@ struct ieee80211_network {
 	bool	bCkipSupported;
 	bool	bCcxRmEnable;
 	u16	CcxRmState[2];
-	// CCXv4 S59, MBSSID.
-	bool	bMBssidValid;
-	u8	MBssidMask;
-	u8	MBssid[6];
 	// CCX 2 S38, WLAN Device Version Number element. Annie, 2006-08-20.
 	bool	bWithCcxVerNum;
 	u8	BssCcxVerNumber;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 28cae82d795c..2c11d3ef63d7 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1944,7 +1944,7 @@ int ieee80211_parse_info_param(struct ieee80211_device *ieee,
 					{
 						network->bMBssidValid = true;
 						network->MBssidMask = 0xff << (network->MBssidMask);
-						cpMacAddr(network->MBssid, network->bssid);
+						ether_addr_copy(network->MBssid, network->bssid);
 						network->MBssid[5] &= network->MBssidMask;
 					}
 					else
-- 
2.18.0

