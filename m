Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AEBC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1893C20862
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQMh/y3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1893C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932833AbeGGO4d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:56:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41667 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753977AbeGGOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so198744wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qYnd26S5+ltBNLdfgUTTRKjpFzwKg0cdnvqwOi4lhEc=;
        b=PQMh/y3vV8fH6jGtuxYr1F0IPT0K7Fc1cS290wbE7huKUghW8f9UroYtm8phWau+cQ
         74KMnLfeGfmc34BnkLlis2ivhEJyYF4xZyoWBw9nixCeFh6MmU1C+D+MTcPhzQCxH4er
         9RN+nzOp2R5Gn2g6ZDqbJd8eOcPhSMSH9+OjL5UiqiJO3vfsBwuqVPmhnw6tZRVAW2Mf
         FNPXZn4a0LlFjcgCVtVoTqqLt87rZJ8gzhBwfWeEqEucrtSNUljwavCQNNgiuo+0x6oo
         yTbcOT3YTrUIa6DmFtULsEfLtYooW2QESAOC3MecZMmyPmLrv3JHBBxuT92S2D+pOKLc
         2BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qYnd26S5+ltBNLdfgUTTRKjpFzwKg0cdnvqwOi4lhEc=;
        b=ik8kg4w9XbV20kzSXfKuORc1rBiSxWXzh5M5nPP8RmBgnbF5IAhG0U624Fn984nfuQ
         HlQzLAZHJO5z6mr2ixhMV8M7/F9yf1hwSEUDpmCJGoCDYq3LFQG8Kh46xrKv/M/6xk0u
         BSwgRAkj2+e37IkygdVv3WZfIgMrWD0YZvsXEh5ym8YOcK8tmfLRFaaUILf7liwkgqQS
         bam+B/Z97Mz67fEPLe4FGhJ2f5/lZ8PI7R9TfXQZVfOORJfhxVefi+hjFDFzbPhdY6rS
         gjNdaQQzaiYjWl0vIplaedU3eFPugRXJByuEHBKgIIlFWSpdfEloTaKkNN3tjY5zQZAj
         MzOQ==
X-Gm-Message-State: APt69E1ZsoohJ6lgZ05HYfmh1pRa+GS/OYsHoz426OI+IYgu+pT8U0ZQ
        Pn49VVNI+EVAXvLqQTMS0DKobQ==
X-Google-Smtp-Source: AAOMgpd9QGxJ7L9h/bJ5aBZjUJ2LG3ai7laW6ST/QdG83vZUsxy2kKFpODfzEM8MrgmgGScqtUzeOA==
X-Received: by 2002:adf:f210:: with SMTP id p16-v6mr10657152wro.184.1530975342451;
        Sat, 07 Jul 2018 07:55:42 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:41 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/12] staging:rtl8192u: Remove unnecessary parentheses - Coding Style
Date:   Sat,  7 Jul 2018 15:55:11 +0100
Message-Id: <20180707145513.15325-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl flags unnecessary parentheses so removed from code.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 7bc2e94792ca..fd2cf8d8d593 100644
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

