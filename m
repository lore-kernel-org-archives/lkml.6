Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF238C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77794251AF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHs3Om/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77794251AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754840AbeFXQED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:04:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46181 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755913AbeFXPlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:41:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id l14-v6so6064402wrq.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MT2uFqBXz6lD5/6nAK7r+pYbCGG3WuvJ0V3hIZDp6iI=;
        b=uHs3Om/LbXiBWLOEbYHMpTADOWvElfhhaTF/zaYbTeCaMhGj3xDOo5XZ+YpIT7Tt8K
         IxM3OMf2oIq8I1iN0eBHGdbSbbR2l1PR4RZacByY6mIZ/SX8kspsqLp2VbA/5wPw1am6
         FWQZUPxdYGZsNoC4wr0usLsjkaPVFrB0xl9eWLVsoYBDFbcJRrhePGlP1bjGUhZgsF9A
         LrSNO1iLswxto4s5dC1w9UeZJknmSm4ZTMLZMVZzQqN5nFXc2E/wJc4LoIdxinqUOKVA
         tFmBVHu1SvAJA54zpLeXvbzzd2cNfNocc5/hvr7AF+eSMt/CKN9m4VtAG+XQs8AdlqKT
         iuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MT2uFqBXz6lD5/6nAK7r+pYbCGG3WuvJ0V3hIZDp6iI=;
        b=PIhdf/YUa/QocfduY9HCbKaLuR+Rzz4hv5/TBxck8Qgr/wp6H8g4owrNziPMQYgh3/
         +JfoQ+MhyvzdTCBHy6rH1ZtANVfBRnPTggiTSpct5hqQvRr/WoS5Xu+DAb7EbwKe1FpD
         ajyAaFC1L796g1/z89KY9EpY3mOdtwVvTrsbqMIf8MvhTu1XRYsdcokGLK9/N6FuwrAr
         dFU9dU9oP4WplOdarg+shCe5gWMepvCWW6uSDegI8M8tUzZKLutCfiBAwaaBQseRvGce
         c/YuhJlUDgFet0vZbIZTT7f10yyrvslCQUSdIygds4lSfrhXMMlN0nxpYjssyUey1ol8
         syIg==
X-Gm-Message-State: APt69E2tlgdv84Co+PDj8HSBdyKpd8AgMGYpRgxfSDidDLicRxLaYRLy
        bD+rlXrgXTy8YfaYsUKbokJ3RD7H
X-Google-Smtp-Source: AAOMgpcChmIN9tV5Mcim7nJuYmGNvcMeasvzuhxEqtGhNmatq9dFw8kfAPxsx+NIt50zdKy7MwOahg==
X-Received: by 2002:a5d:4843:: with SMTP id n3-v6mr7223484wrs.24.1529854864510;
        Sun, 24 Jun 2018 08:41:04 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2782920wrp.69.2018.06.24.08.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:41:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 8/8] staging: rtl8192u: Correction of spelling mistake in  comment.
Date:   Sun, 24 Jun 2018 16:40:27 +0100
Message-Id: <20180624154027.27654-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624154027.27654-1-johnfwhitmore@gmail.com>
References: <20180624154027.27654-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple spelling correction.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 07259f108ee5..a54688b3d674 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -866,7 +866,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	/*
 	 * TODO: fill suggested rate adaptive rate index and give firmware info
 	 * using Tx command packet we also shall suggested the first start rate
-	 * set according to our singal strength
+	 * set according to our signal strength
 	 */
 	HT_PickMCSRate(ieee, pOperateMCS);
 
-- 
2.17.1

