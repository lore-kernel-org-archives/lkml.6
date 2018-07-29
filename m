Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA76C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7193F20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlnfCVDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7193F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeG2U0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:26:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41130 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeG2U0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:26:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so10380115wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZFqdCCH6ZI+d3LDahQQiW60xLeAP0rUK1K+K0VA9YqU=;
        b=VlnfCVDTtjaOoBpPu7xY7dceQGEl7sJytwBiwdUMSj9Jl10ebKJQjKhZ/1EynbZ1up
         hlI670lj7NT5RgbAeI4sYSb0blvpF04oZ5sbGUegxeAEEOjy0OYauBERPH6VQ7aztLQX
         3HfPbZ5IxtwAs26PMBS2mgxumSIlaO2T0twmMDBwF0AAwX7dodHgi8yB5zFnhOUT/3sr
         PQPuFoDzjENRgXdGyWNScH5/LAmb+DSqsyIwTVz6oFLElAAFA4ouRnqVapFUaiR6jHjN
         PKXN4MPZoaNXoo4lcdNKj9JF7RqJlbHbeT/ue/YcE3C/Qt6vvM8zJbrzBo0siI8YgrYE
         TG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZFqdCCH6ZI+d3LDahQQiW60xLeAP0rUK1K+K0VA9YqU=;
        b=F5gNnA4MH4r14v9JxdujKGW+LlA3Kt0+UtxVVl7r0vItCwTjsnCarCd73UKnPM32WZ
         NzPgE9JH76kPnBA88LERVjDt0HwYsmXWNBOQb6J+hoNif9mEpgT2b4REBVrRdTOd/voj
         EDOiRKD59HhhOV8u6i8QNl78+8xOf/RbzIfvf+lPlQ5TIZnxLR+MUeq1eEiGYw4TfIFS
         +KKABC5nlxqtvLekhSgztTJ7kTVacZV9/BFy1LPcKY9uwlq2nc3QHFTSa4mriECTzCRI
         R4d7evjw8SjWpk8rkMaAWVykPksgU3GqsQPQN/+QuZia2K/TK3e42MTSeJiIxjqI0L4e
         uT8g==
X-Gm-Message-State: AOUpUlF9VvPXgrG4UJ6rAv9pR74l8GGCaHEYkC9Lu1VESUe8tynPckSb
        xGljBW9XHoDfU87DuQ0BUqs=
X-Google-Smtp-Source: AAOMgpdHZ3fS8lSwNoep5nyBTOF5fYvJy3WnEjJEQEb9seKZ/44VpSkDCfn+SwcjjnxYjdiw4ZgHXw==
X-Received: by 2002:adf:f210:: with SMTP id p16-v6mr14604953wro.184.1532890505651;
        Sun, 29 Jul 2018 11:55:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id g125-v6sm8674247wmf.16.2018.07.29.11.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:55:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/7] staging: rtl8188eu: remove unused should_forbid_n_rate()
Date:   Sun, 29 Jul 2018 20:54:42 +0200
Message-Id: <20180729185447.19903-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729185447.19903-1-straube.linux@gmail.com>
References: <20180729185447.19903-1-straube.linux@gmail.com>
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

