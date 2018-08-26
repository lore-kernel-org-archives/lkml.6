Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC570C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9554D208C1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjKPOrPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9554D208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeH0A6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33417 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeH0A6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id h9-v6so9114837edr.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OVVgJ5SxaXdeE5krpgn00FiXiW3FrW4BQLedmMriOaw=;
        b=gjKPOrPYon9xCcJ5vVGBDw8qCOlo43sXUM/76RyEhF6IUVf/ujFjZwCrSX9Lllxy38
         WXy7nooAZL52U0il4elqipbER9WRF7l0u3fubDyq5V2Q6pwrZRQc4WCEbcjUIcBd1yLY
         KLO3WwObze1FKa2XcIu1uUG+RMLmmJq0N191Zf1R+olRqPJHYiKDbqaW+q4X7ZP8s+NP
         fSQURRqFEEZaa38UaEytCweAe71xZlsIaXWllPEStrXyWkamP+BqGkyarsSTahUfqhi7
         gJKDz0aSdgpy3EdP4KhYd72uy5Gm6hUmSh+3j+W25SxuMxYkoEU+YPuajcM7LJJWbmqM
         C22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OVVgJ5SxaXdeE5krpgn00FiXiW3FrW4BQLedmMriOaw=;
        b=S9Ch5AIZzUVPdReVD1/Uux4jh/aKf7I8HJSg8EzIsy/qiRvlU5FwB+hNndJ5HVfaXI
         6thSY8V6b2+KfEF/I7zXFM+Q4QaAPIRN86h0diVOn0J4CoY+SjJ+/A2BIh0BKqU5tFIx
         0FxyhqHDlpHuCd2JOEhg/9VaQ1TF5yidgYI9voHkYYVEO5OfUig4O3anvPPLyPCA/q2C
         JPBTGb8WyqYyoiAG7GJPMGcAToWSPRF57m9CmZJKP04BpEZwLbxNL51KF798cODmVJ4i
         PjjlR4kjp39nEoJckJBdN/AnhU1VYYYod2qYv7VvB5iolcsUvNPEkAFVeiRsg0n0Qto3
         /GjQ==
X-Gm-Message-State: APzg51DWbzVqoZ0qebDf9L+CgjC0H+O5b/D6o9oO32snx/ySdf0KV5Y8
        fVcnwzv1JniugkpRxTKFpJ+EN4NL
X-Google-Smtp-Source: ANB0Vdbeeu9/Z/UpovuPe02XKHC9exqKV37+ouRdVbfHAcD+FJ4UR8eVxnxU5uFnOlH7znY0gsLQxA==
X-Received: by 2002:a50:86b5:: with SMTP id r50-v6mr13702280eda.201.1535318099446;
        Sun, 26 Aug 2018 14:14:59 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:14:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/21] staging:rtl8192u: Make function rtl8192_phyConfigBB static
Date:   Sun, 26 Aug 2018 22:14:21 +0100
Message-Id: <20180826211439.14326-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtl8192_phyConfigBB is only used in the file in which it
is defined so can be declared static. Additionally the prototype has
been removed from the header file, as it is not used.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 2 +-
 drivers/staging/rtl8192u/r819xU_phy.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 8e6ed20848d8..a6d7ad1f6d79 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -511,7 +511,7 @@ void rtl8192_phy_configmac(struct net_device *dev)
  * notice:    BB parameters may change all the time, so please make
  *            sure it has been synced with the newest.
  *****************************************************************************/
-void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType)
+static void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType)
 {
 	u32 i;
 
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index c7ec3182857f..c938fd8eb51c 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -52,7 +52,6 @@ u32 rtl8192_phy_QueryRFReg(struct net_device *dev,
 			   enum rf90_radio_path_e e_rfpath,
 			   u32 reg_addr, u32 bitmask);
 void rtl8192_phy_configmac(struct net_device *dev);
-void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType);
 u8 rtl8192_phy_checkBBAndRF(struct net_device *dev,
 			    enum hw90_block_e CheckBlock,
 			    enum rf90_radio_path_e e_rfpath);
-- 
2.18.0

