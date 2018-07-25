Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF847C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7729620844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmLhCcAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7729620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeGYUN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:13:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50523 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeGYUN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:13:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so3788899wmc.0;
        Wed, 25 Jul 2018 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O5IhaNKKHCy5sgqF9CPRQ7cLxpnYhl/t9aW/DjTeM6E=;
        b=gmLhCcAQK7LeuBHW+TxgBg2jCjeFEJeh6W2Uydk/urqyZN1NtJ96rAPADvLpoMNNnP
         q68Q8i9CzUQ1F3Rz2qMBsQ2UJ558yOaTMeQfZggW+Np5gNBAanKNjxhY79m8y2bLItPW
         xQ+lxcFER1NuilSs2peOgbJ2liOM9jI7BnWQ10j4a+8E1zoGMK3Zi+dfqiLipq/OFKaI
         Cfo3R+S11jBHjeow6hjtP5mkZbdXD2Uh2OjWGDH3FBEuiN/oUiKD+LO8wHvUrbbLUy3c
         fnGGLQH4vqdoHqQJm7TG25SaU7RV2I9bxl90v/kpEM92xLe2UmPrXd06K/NtMKiPWmen
         abfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O5IhaNKKHCy5sgqF9CPRQ7cLxpnYhl/t9aW/DjTeM6E=;
        b=i6kKLNMhou0Pevr7fMygx+WQ0zx2odyfPUTSl5WhkCgqPiMLS5zU3CSeoh/fXZGIRa
         CRz8gD4Yw6mTTFG27eMkyzT/1fgTqZvqXeUFeiEBp79sSCwZEtRe7lAFfzYIauqeJlqD
         I8UM7FQ177MELdMUzp9PXPUYyudWsp5rLhYPTz09vJgiY8YrestH3R2SjbzueckC8QMU
         3OqMTIebo5QLa9jEOeiaETgNMy6Oa2B4x76nnb9GMUQicu5qVXQ19tDUVjJIAoZKzLpe
         tcUw1DZ3hsOGYohnSu0LrnenZ4YoGfSRdc9v0B7Jv+OaK4AnxfiHrXP0OTZjDvda3Aj1
         bu6A==
X-Gm-Message-State: AOUpUlE9xlcWUeNNDBLBJg4aNsAIVfTdl6AYj+74G7ZdGD718gE9OA6r
        J+FHAo1dij4Cp2up+VxAeOA=
X-Google-Smtp-Source: AAOMgperQOfAe25E4oPOgmRukgIxJIdFK1+1ddhtqk6YR/S8Om0NmgDPbfUZGhswZX//eGDkok497w==
X-Received: by 2002:a1c:1c52:: with SMTP id c79-v6mr5168575wmc.147.1532545228117;
        Wed, 25 Jul 2018 12:00:28 -0700 (PDT)
Received: from euri.wifirst.net (eth-west-pareq2-46-193-2-21.wb.wifirst.net. [46.193.2.21])
        by smtp.googlemail.com with ESMTPSA id j131-v6sm6841597wmb.25.2018.07.25.12.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 12:00:27 -0700 (PDT)
From:   Varsha Rao <rvarsha016@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Solomon Peachy <pizza@shaftnet.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH] net: wireless: cw1200: Remove extra parentheses
Date:   Wed, 25 Jul 2018 21:00:07 +0200
Message-Id: <20180725190011.4317-1-rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses to fix the extraneous parentheses clang
warning.

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/net/wireless/st/cw1200/txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index f7b1b0062db3..8c800ef23159 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -624,9 +624,9 @@ cw1200_tx_h_bt(struct cw1200_common *priv,
 			priority = WSM_EPTA_PRIORITY_ACTION;
 		else if (ieee80211_is_mgmt(t->hdr->frame_control))
 			priority = WSM_EPTA_PRIORITY_MGT;
-		else if ((wsm->queue_id == WSM_QUEUE_VOICE))
+		else if (wsm->queue_id == WSM_QUEUE_VOICE)
 			priority = WSM_EPTA_PRIORITY_VOICE;
-		else if ((wsm->queue_id == WSM_QUEUE_VIDEO))
+		else if (wsm->queue_id == WSM_QUEUE_VIDEO)
 			priority = WSM_EPTA_PRIORITY_VIDEO;
 		else
 			priority = WSM_EPTA_PRIORITY_DATA;
-- 
2.17.0

