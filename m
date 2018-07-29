Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C8BC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEDE20892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFr7fcio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEDE20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeG2SkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:40:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43423 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeG2SkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:40:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so10189182wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZFqdCCH6ZI+d3LDahQQiW60xLeAP0rUK1K+K0VA9YqU=;
        b=OFr7fcioQVNKFlcpfPvv39VDKJwmrTfF3zMVS2lcXqubvDzMsB8Z+Vo9y/ErrM9iuW
         E7hgwQQMp6nOqeQo2EshkDJKGgAn+4dndVDOZIoYLVPAVQLHzgTotCxtYoD0TTsHcEuW
         jASB88ba22FuAqIUjxexqSdwpNyXv/D5iQrNTjItKcws++/UMLhtk/9F2+p9bmU/ZKi2
         2MprwLBD322MdmKmUGE7/cX+6Di86i7iXcStcEvJoBrccSW0nXoUC2m+bMqHlfboNXY9
         oWvTo7UqwBG5mmXxSVf/s4hEqrCsHMPvNmhjNQ+YcAWYMj95qqdLjjJ4Ws/O6qWzxQzm
         r/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZFqdCCH6ZI+d3LDahQQiW60xLeAP0rUK1K+K0VA9YqU=;
        b=tbaUrJcYSYCMWxMfuQHPMZIDwxx2ZoR/rDjz6vaoUD0cy/7pUZEIwxn9vrLo5OAhm7
         WkSUJh90ythhx5r1s35jLOQHaw+7fpPPUwi+pVyIvw9DwecSGN5o1u2kb2YDHWro93ss
         WpJ/vmZxBtv6nip8u8RB/ce8PqDzMrHZxvdK3n8OndQ75IAbVReFJkIGc7xbta+ysv6i
         bwZjG5uErp2WfXfiVVFMgHASaeiPo06+Y4iEXjyWY8W8yz556SnBKckLN16XmAztDGTB
         2+rUlD48XYtzn9UXrVhlAqw9XkCDesHqlMcvkUfJ1/PNzbQHWvp1sGcrTU8OTcEhOa/Y
         nJJA==
X-Gm-Message-State: AOUpUlEPYq7Pk3HPU8RwkIvyrl2IMOf7PDjlBzY2wjmXHcnBOk2eYkZL
        rJZFLf2Ho1Cq7E7OxphYhQIEmmGN
X-Google-Smtp-Source: AAOMgpdQM47RD3506i4lwpIRIqNzXSzn4bicoB0tZadNQXy07oDFxaG2zOnNtb+fnhY2OFjJWhkHIw==
X-Received: by 2002:adf:ff11:: with SMTP id k17-v6mr13924505wrr.255.1532884156891;
        Sun, 29 Jul 2018 10:09:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v1-v6sm19916360wrs.34.2018.07.29.10.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 10:09:16 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: rtl8188eu: remove unused should_forbid_n_rate()
Date:   Sun, 29 Jul 2018 19:08:45 +0200
Message-Id: <20180729170851.2581-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729170851.2581-1-straube.linux@gmail.com>
References: <20180729170851.2581-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function should_forbid_n_rate() is never used, so remove it.
Discovered by cppcheck.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 35 -------------------
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |  1 -
 2 files changed, 36 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 0fe35e141926..b9406583e501 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -1094,41 +1094,6 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 	}
 }
 
-unsigned int should_forbid_n_rate(struct adapter *padapter)
-{
-	u32 i;
-	struct ndis_802_11_var_ie *pIE;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct wlan_bssid_ex  *cur_network = &pmlmepriv->cur_network.network;
-
-	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
-		for (i = sizeof(struct ndis_802_11_fixed_ie); i < cur_network->ie_length;) {
-			pIE = (struct ndis_802_11_var_ie *)(cur_network->ies + i);
-
-			switch (pIE->ElementID) {
-			case _VENDOR_SPECIFIC_IE_:
-				if (!memcmp(pIE->data, RTW_WPA_OUI, 4) &&
-				    ((!memcmp((pIE->data + 12), WPA_CIPHER_SUITE_CCMP, 4)) ||
-				    (!memcmp((pIE->data + 16), WPA_CIPHER_SUITE_CCMP, 4))))
-					return false;
-				break;
-			case _RSN_IE_2_:
-				if  ((!memcmp((pIE->data + 8), RSN_CIPHER_SUITE_CCMP, 4))  ||
-				       (!memcmp((pIE->data + 12), RSN_CIPHER_SUITE_CCMP, 4)))
-					return false;
-			default:
-				break;
-			}
-
-			i += (pIE->Length + 2);
-		}
-
-		return true;
-	} else {
-		return false;
-	}
-}
-
 unsigned int is_ap_in_wep(struct adapter *padapter)
 {
 	u32 i;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index c072e1e25d61..ade68af15e04 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -534,7 +534,6 @@ unsigned char get_highest_rate_idx(u32 mask);
 int support_short_GI(struct adapter *padapter, struct ieee80211_ht_cap *caps);
 unsigned int is_ap_in_tkip(struct adapter *padapter);
 unsigned int is_ap_in_wep(struct adapter *padapter);
-unsigned int should_forbid_n_rate(struct adapter *padapter);
 
 void report_join_res(struct adapter *padapter, int res);
 void report_survey_event(struct adapter *padapter,
-- 
2.18.0

