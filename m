Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6199C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F87720833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5BZDx/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F87720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbeGYUDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:03:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35829 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeGYUDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:03:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so8357337wrt.2;
        Wed, 25 Jul 2018 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IR4dRtFeBOzwrZBIMPRfMg7fGDrniXCfHPGE7xwhZ80=;
        b=X5BZDx/9nN80jkIYlLTx4b5qwJECbhx+xRXapJ1WunX9Tbx819I2KZ8QkjaVchFPoK
         usNVOnSsSxpD5jWAHDGLHujw6iCNE66R+OUAUDlrXFA4ae6JLjYnDE5tDifUoeqmPU7U
         XIs/Qj+Ot0EwZ6GmJmXQkHlW5UpFkJbPxrSh7NofdnA8MR9Rw5HFVj5730eD6lzBZNTS
         NYQxuYz5h1GNMargjgAun+Stb9XMX5KwXSQgE0PAPSCdKlb/7Jp1j8oUcgl2VwiX5euR
         8GphjYz3Ls96heu94fu44epllksLCosG0TMUg4AUWHCsmgSCNPKQG4YWP7JbmVvDRq19
         1ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IR4dRtFeBOzwrZBIMPRfMg7fGDrniXCfHPGE7xwhZ80=;
        b=jewy7UdidVib3arBtrNiCol9yIFU1tgsqJPE0RKPg48kqhJ5XyG1lwMhRhfwF++dCQ
         8erjbrE3kfeXqRMuryf+7G7uw3HF0e7UR4DBsmd913EHHAl9LtuYQgv2/fDPfGbAInpZ
         Q5hleWuT7GvdZY2tQ7FAr7veDRSQjyGFeeju3/SAUxXZhvW57ETfnwNlvBXjtMZV7+16
         /5peugInnc0sWC2BAkaYkQs3gIpVmEFuvwf5it2R/pikz2JFE7xWdwrYvoKc3Rj3B3uv
         RkoZwm9C6Jqqt34DEHYXNiT9KjerVO2v4Td4kFoN2k4Ys0vyw9heGroEBUAEHEdpLDXG
         FA7g==
X-Gm-Message-State: AOUpUlH86cdkzUgqvAdGkvvz7FaNIVsRP+BslB9sIqM1c6yMTLD05exy
        3/ZxcbvRJ+egWkH0OnaTUTP6KZC0gCI=
X-Google-Smtp-Source: AAOMgpeVU/tnZgJLmCE0OWIiLOWNj3vRHuu+WAWWZuMi5gCK9Yef/7lk8Q+g9QjbDKHtfFuqUp55hw==
X-Received: by 2002:adf:ac2d:: with SMTP id v42-v6mr15553811wrc.142.1532544604548;
        Wed, 25 Jul 2018 11:50:04 -0700 (PDT)
Received: from euri.wifirst.net (eth-west-pareq2-46-193-2-21.wb.wifirst.net. [46.193.2.21])
        by smtp.googlemail.com with ESMTPSA id q140-v6sm8895066wmb.35.2018.07.25.11.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 11:50:03 -0700 (PDT)
From:   Varsha Rao <rvarsha016@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH] net: wireless: ath6kl: Remove unnecessary parentheses
Date:   Wed, 25 Jul 2018 20:49:48 +0200
Message-Id: <20180725184949.4032-1-rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra parentheses to fix the clang warning of extraneous
parentheses.

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/net/wireless/ath/ath6kl/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/main.c b/drivers/net/wireless/ath/ath6kl/main.c
index 808fb30be9ad..451297441532 100644
--- a/drivers/net/wireless/ath/ath6kl/main.c
+++ b/drivers/net/wireless/ath/ath6kl/main.c
@@ -639,7 +639,7 @@ void ath6kl_connect_event(struct ath6kl_vif *vif, u16 channel, u8 *bssid,
 	memcpy(vif->bssid, bssid, sizeof(vif->bssid));
 	vif->bss_ch = channel;
 
-	if ((vif->nw_type == INFRA_NETWORK)) {
+	if (vif->nw_type == INFRA_NETWORK) {
 		ath6kl_wmi_listeninterval_cmd(ar->wmi, vif->fw_vif_idx,
 					      vif->listen_intvl_t, 0);
 		ath6kl_check_ch_switch(ar, channel);
-- 
2.17.0

