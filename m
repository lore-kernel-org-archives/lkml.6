Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B26EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396C2208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udqkSccT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396C2208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934161AbeGJPGH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:06:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42552 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeGJPGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:06:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id g12-v6so16816082edi.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3dVfhoHIt+BbjDfJRojhSjqWipwUqcVVwHBMiDQtAik=;
        b=udqkSccTO8XiklCnw6Q98mZLX+QCvm+eHlJwNHN4Eyiz1/MJVCtTcI0l8LnHw/75CH
         per9jYZUofoWTuAiWzCbqOtW3BK/yUya1y817QBcEgbnlKoQubxz30+iaCTCViEvczil
         SPhMRQ5be0AwiFSiKLS+C2e62HoV7AHo2i357GkSlbk4Gg6QDakXcPl5sijTX5Eoo1SY
         ludFsnKxsfYkxrjMPIWn6zeH5Dm7X5bD+vqzNTYFC+UIwu/TW4vuKAMwYZcQt2Uhd30Q
         YKB4OwbnKrSdnpxjSmfjT4DU5DbxLy9Cbt6dU21ITx0iaIlVR4gWkzW3UOPUVFdaoMw5
         nY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3dVfhoHIt+BbjDfJRojhSjqWipwUqcVVwHBMiDQtAik=;
        b=j2xtXHR2elqiLQffYd/r5z/+dOLVwErdF9oK3j12p8+WbW5a3M0xqceEgSSHOuVTE7
         Aujb+Y0qMVkpSWmun2G/1WYV8ZGjkzP9BazDs+lgoelup62K0W/9X4KXfoomoG1qW/k7
         wZ8IRksnwW4DthAbtPE4+1I3NHU6Apy0ralhAofHc0a4SgAnJZgN2abh/+fBNwPMgvth
         I5MpRqHlMDFClq+MN4ZGaYJ0N9W9PFAavbt0KxJKN82Ehm2Gq5mbe1OMsesuw/FqY0a9
         TYdifYwN64KT91NDQroi5hpS+mCgBE5dArRBCI73+gK8xodTjee0MyyaXhgn0pvs8ojd
         6swg==
X-Gm-Message-State: APt69E24hLnguAHGJvWHgcPWKZfHJJGXhVWu8/YE9WnvIWVUyowXr/4Z
        +pjHDZi1DrMVCSHdfQ1lBqbH80dL
X-Google-Smtp-Source: AAOMgpfgJDW8b/kC+6ABw/YhxjlGZCO2aXfQM7SoFHeM8KW+lNkMcuV3HZEzRN1rhklodKz1AGH54A==
X-Received: by 2002:a50:b376:: with SMTP id r51-v6mr5539936edd.145.1531235160352;
        Tue, 10 Jul 2018 08:06:00 -0700 (PDT)
Received: from localhost.localdomain ([109.76.156.5])
        by smtp.gmail.com with ESMTPSA id s19-v6sm1895389edd.53.2018.07.10.08.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:05:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 6/8] staging:rtl8192u: Remove unnecessary parentheses - Coding Style
Date:   Tue, 10 Jul 2018 16:05:21 +0100
Message-Id: <20180710150523.17384-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710150523.17384-1-johnfwhitmore@gmail.com>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl flags unnecessary parentheses, so removed from code.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index d916cc5b97db..023f23d2eb67 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -699,9 +699,9 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
 		((0 == strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
 	/* HT ralated element */
-	tmp_ht_cap_buf = (u8 *)&(ieee->pHTInfo->SelfHTCap);
+	tmp_ht_cap_buf = (u8 *)&ieee->pHTInfo->SelfHTCap;
 	tmp_ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
-	tmp_ht_info_buf = (u8 *)&(ieee->pHTInfo->SelfHTInfo);
+	tmp_ht_info_buf = (u8 *)&ieee->pHTInfo->SelfHTInfo;
 	tmp_ht_info_len = sizeof(ieee->pHTInfo->SelfHTInfo);
 	HTConstructCapabilityElement(ieee, tmp_ht_cap_buf, &tmp_ht_cap_len, encrypt);
 	HTConstructInfoElement(ieee, tmp_ht_info_buf, &tmp_ht_info_len, encrypt);
@@ -973,7 +973,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 
 	/* Include High Throuput capability && Realtek proprietary */
 	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
-		ht_cap_buf = (u8 *)&(ieee->pHTInfo->SelfHTCap);
+		ht_cap_buf = (u8 *)&ieee->pHTInfo->SelfHTCap;
 		ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
 		HTConstructCapabilityElement(ieee, ht_cap_buf, &ht_cap_len, encrypt);
 		if (ieee->pHTInfo->bCurrentRT2RTAggregation) {
@@ -1413,7 +1413,7 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 					    ieee->current_network.bssht.bdSupportHT) {
 /*WB, 2008.09.09:bCurrentHTSupport and bEnableHT two flags are going to put together to check whether we are in HT now, so needn't to check bEnableHT flags here. That's is to say we will set to HT support whenever joined AP has the ability to support HT. And whether we are in HT or not, please check bCurrentHTSupport&&bEnableHT now please.*/
 					//	ieee->pHTInfo->bCurrentHTSupport = true;
-						HTResetSelfAndSavePeerSetting(ieee, &(ieee->current_network));
+						HTResetSelfAndSavePeerSetting(ieee, &ieee->current_network);
 					} else {
 						ieee->pHTInfo->bCurrentHTSupport = false;
 					}
-- 
2.18.0

