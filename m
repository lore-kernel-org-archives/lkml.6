Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB7DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0697320661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsgDW/2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0697320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbeGTVL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:11:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40095 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731190AbeGTVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:11:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so10923650wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F0MSt35te4iw57C1Mkp9Mxiic8Muxvjt3zkiuyNnfjs=;
        b=NsgDW/2LSAXeIzKJbezaXXB+zMo1GKonuwgipHrE0RXFFFogq96/vSsj7GMbMP2SmD
         eNaJ9xyf28x703zSpuWA0FfCpHUXgFo+RZ9LKnBfxcf8CzGoquyixK5yFKvsvfUzv5FT
         yDQFPKuB7esljTBXpWHF0qbLtqg6FGCoJrNSlIu199cvC2ZI8BsRpQMDfehCx+7P+vGz
         BUktLIU0EDZZznLieuUC62vtCRc37LgZ4flvDTzOTBYzvkAA+Log4UdKF1WZETpoqdgt
         xfE5xxkKxof8/dJN+Td/Yu93Lsk2KPD8/XSedJhm49WH7/Q0DrDvUrLbrQHy8tXOB1t9
         t0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F0MSt35te4iw57C1Mkp9Mxiic8Muxvjt3zkiuyNnfjs=;
        b=p0T54GbCRCgWuwyWuob27MRAU/Z93q1zu6drKIL5x81E/Za0L5PBSsy1oGU+vTF9sW
         vFOWQEU5lmM0wCA2irj4vmZPVMHa/1l4mXvV8Lk9atgiyKDRAhD82UJ/SJM92vC6jigg
         Y7qUgwPqKf2In5QvH17iXHtVQ5am6HdEqQm6uQK23QV0Tf9ancKeOMfahKHR03DOCuXt
         sZbG4heD9sdlUsKL0Js9mm+BOUG/2yUHKNHhWZ/PzBkDOVo7xPfvhLnG1r5CBL+Cfrxl
         2jcaf+0C3L6Sg0gqO3/OR2rEy5hjcWBftLQncVyqWXpAprSSpsFhu1OC72c4HAYsBG+7
         f5xg==
X-Gm-Message-State: AOUpUlHtdCx68ovKE9fvTnT10tG/D4U6CfFxu7sPRHZILys1xUShnR4g
        30BI3r64I28KwB+ioEu+eoa2K6h/+bU=
X-Google-Smtp-Source: AAOMgpcNqD/n1x550U7j0+rdxOM5pYGJO4R8fqQ4ALRjiAKOE0eol23QJQFwlFkfmBo67J6AfdP9lA==
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr2310797wmi.16.1532118124534;
        Fri, 20 Jul 2018 13:22:04 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/14] staging:rtl8192u: Rename variable MaxTxPowerInDbm - Style
Date:   Fri, 20 Jul 2018 21:21:33 +0100
Message-Id: <20180720202142.26312-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable MaxTxPowerInDbm to max_tx_pwr_dbm. This change clears a
checkpatch issue with CamelCase naming. This coding style change should not
impact runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 17bccb7bf594..44b5e506b140 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -79,7 +79,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 
 		for (j = 0; j < pTriple->num_channels; j++) {
 			pDot11dInfo->channel_map[pTriple->first_channel + j] = 1;
-			pDot11dInfo->MaxTxPwrDbmList[pTriple->first_channel + j] = pTriple->MaxTxPowerInDbm;
+			pDot11dInfo->MaxTxPwrDbmList[pTriple->first_channel + j] = pTriple->max_tx_pwr_dbm;
 			MaxChnlNum = pTriple->first_channel + j;
 		}
 
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 8c2b11d12185..1b377faa53e0 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -7,7 +7,7 @@
 struct chnl_txpower_triple {
 	u8  first_channel;
 	u8  num_channels;
-	u8  MaxTxPowerInDbm;
+	u8  max_tx_pwr_dbm;
 };
 
 typedef enum _DOT11D_STATE {
-- 
2.18.0

