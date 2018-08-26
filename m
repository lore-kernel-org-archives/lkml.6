Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1229BC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB68E2173D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZa0QMbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB68E2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeH0CaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:30:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41527 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeH0C37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:29:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so9169552edd.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DBghDmebKbbhMmBnqhml+KVW21VMQpXYRsyHGk1kL2E=;
        b=OZa0QMbx1c/X/i0fXn5oZyUw29OeY2ftg5vjDf3wm61AggkKnNQ7hXzDL2I9Rfg2BF
         r4cdnPY4ZiakgcCcihjldHuXON0FYuJCVqfm2jfV/+uawfbW4ciQf8dCwf/UJADTSg2/
         38Zs7+fj1P/Qw48JUkrY3r919kLP9I3qaGR7e0PU02PUNvS8rUNIw/EuGX28d4+MRzKh
         paqXpwyk2ZBTlUca27OXISP708EVhEZbsz6vmepQvn4toFvRTwx31eALy0Lpt8+O1/y8
         vGz7mSD2+TbmTsoJVg0sNKwo9IPm3zZhm2B7EM46lGsaZyJorZyGnGmfprbK35JZKuni
         pSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DBghDmebKbbhMmBnqhml+KVW21VMQpXYRsyHGk1kL2E=;
        b=T9HPplIx7DuIw5L4Rww/yYTDwXOHdb1DzVFbCnpbVTKIgYZ9B5Z8RyvAM39VaEGGz8
         BlTWSzHuh0w+qHAU7Ce9tfWlSh2AI9EdqJOY6OPUrvtth4zVjqQLEFz7hS8yfS/Y8GfY
         f09K7/m0PKA/Cj9KQxcqmNDf1tAicnUnv2XdnsoeRuMmJiPZHLnk8cnaA1tgp1+LIF1i
         vFRFSepHRcinShSW5LC1MHHQToH+GVFTTv/eJIPRNzo5qFisCZn/0gH7MY77Lhd0pSoK
         v5Z3dSV5QIp197r6CUvrF8CG1c9MNpU0jGIKkbqzqhnE1UG1D7SwBb/r4HHJbrTd0/CR
         P/0Q==
X-Gm-Message-State: APzg51DQ8quJH22pkaJwI9J+pmcqQxiBbqTIWlbjYT54+LgKB5kpS9c5
        wDC9+FprPgl2KQiiLZT/q756XWFV
X-Google-Smtp-Source: ANB0VdbVPK+iB4oOiUaVGKkeBg44Q1uquYweqpKxyr5o5xNewb18DgoVnC3ocddJj5A58PvmW5xazw==
X-Received: by 2002:a50:96c4:: with SMTP id z4-v6mr14169457eda.14.1535323560509;
        Sun, 26 Aug 2018 15:46:00 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id a33-v6sm5519165eda.2.2018.08.26.15.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 15:45:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 4/6] staging:rtl8192u: Rename PHY_SetRF8256CCKTxPower() - Style
Date:   Sun, 26 Aug 2018 23:45:31 +0100
Message-Id: <20180826224533.16020-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826224533.16020-1-johnfwhitmore@gmail.com>
References: <20180826224533.16020-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function PHY_SetRF8256CCKTxPower() to
phy_set_rf8256_cck_tx_power(), to clear the checkpatch issue with
CamelCase naming.

This is a purely coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.c | 2 +-
 drivers/staging/rtl8192u/r8190_rtl8256.h | 2 +-
 drivers/staging/rtl8192u/r819xU_phy.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index 7dbed5e4ea8b..e4abb15d2067 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -226,7 +226,7 @@ static void phy_rf8256_config_para_file(struct net_device *dev)
 }
 
 
-void PHY_SetRF8256CCKTxPower(struct net_device *dev, u8 powerlevel)
+void phy_set_rf8256_cck_tx_power(struct net_device *dev, u8 powerlevel)
 {
 	u32	TxAGC = 0;
 	struct r8192_priv *priv = ieee80211_priv(dev);
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.h b/drivers/staging/rtl8192u/r8190_rtl8256.h
index 891d7510cea1..c291f699eaf7 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.h
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.h
@@ -17,7 +17,7 @@
 void phy_set_rf8256_bandwidth(struct net_device *dev,
 			      enum ht_channel_width bandwidth);
 void phy_rf8256_config(struct net_device *dev);
-void PHY_SetRF8256CCKTxPower(struct net_device *dev, u8	powerlevel);
+void phy_set_rf8256_cck_tx_power(struct net_device *dev, u8 powerlevel);
 void PHY_SetRF8256OFDMTxPower(struct net_device *dev, u8 powerlevel);
 
 #endif
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 4ecd12923b93..69bc0afd4e5c 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -917,7 +917,7 @@ void rtl8192_phy_setTxPower(struct net_device *dev, u8 channel)
 	switch (priv->rf_chip) {
 	case RF_8256:
 		/* need further implement */
-		PHY_SetRF8256CCKTxPower(dev, powerlevel);
+		phy_set_rf8256_cck_tx_power(dev, powerlevel);
 		PHY_SetRF8256OFDMTxPower(dev, powerlevelOFDM24G);
 		break;
 	default:
@@ -1065,7 +1065,7 @@ static void rtl8192_SetTxPowerLevel(struct net_device *dev, u8 channel)
 		break;
 
 	case RF_8256:
-		PHY_SetRF8256CCKTxPower(dev, powerlevel);
+		phy_set_rf8256_cck_tx_power(dev, powerlevel);
 		PHY_SetRF8256OFDMTxPower(dev, powerlevelOFDM24G);
 		break;
 
-- 
2.18.0

