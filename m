Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC19C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CEF2172A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcdqi+IO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CEF2172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeH0C34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:29:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35223 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0C34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:29:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so2513643edq.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vC0Nr0VRgE7y9lO944pfWpYNY3TDqT2hWIjmjmT2Gj0=;
        b=Hcdqi+IO8HGup17uFr5oDirP4VE33ipNbOpqjP4MUgpCUKuEWcJEIWS1MYlo9nIW/l
         E8M0anlktfXTM3xXjRu5E6+ROwPCd1jaojA9Jtyr33SxUj1ea4L+iaGoq/tah7E+Quyg
         b7xJrHk9edhL5O3gWvMeO/DCBJtvOK7zfYsNG27Ciaf8N2XgEd/x4VwsBzO4dcvLQv0P
         xBGm7COhtAqUKRq+dgxrZGN12K0pnP1lRR9YDijrvlnE3bC7tEeWy2u0TREkcyYcAEGD
         yF79G6KibbCenXRAb5QVgMZDehGmCH4yl2nBPYQuSJLb/+thyRF6ZjVafsUKbdcd8fYf
         On9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vC0Nr0VRgE7y9lO944pfWpYNY3TDqT2hWIjmjmT2Gj0=;
        b=a/g9Mgyz16TEwJlBzkubIPdEK5r01Ahx1Xq31zQOyiJg5pDfjF8+4WM3DTxo2aLYVm
         dhZlCoqOkEnAgMkM/H4+PP0GWGLbR39mNc11hP8BcHznTCgNvXMfgNSW6z/SfnRzkwbk
         kkWNOjgQG7U53N2pRrtABvq8dsQvYvjGxG3l8X4wdgFtPd77dIJqHBBUxVMqeCoK762H
         BqitT7MkAk4wbDRRLKanCIePigO8tyFqu9t2P6TYOrKWUGIE6H7u5UhAmlotH1b5L30o
         m5oP8Zq8M7ZXk75BBV20JmolB/CEnX1IpyDbyhfiqM/YnuVysNS4bR7zpgn/Jy4ImlGJ
         BBXA==
X-Gm-Message-State: APzg51CyaBupJA9BJGl1gi1fXry/p5pt/f2ED3O04Jcbe+rIk/Pjs8m0
        O2SkHR5jUSqBYkrBhz4Q8Q3gIj5f
X-Google-Smtp-Source: ANB0VdZNyZWc+l3Y0DoLBgfDbERHdKeZaNGFvEaqIfkeiQZJLFlfFPA1W4jXytD/9BSkik8QvLhJUg==
X-Received: by 2002:a50:cb8c:: with SMTP id k12-v6mr13897360edi.171.1535323556640;
        Sun, 26 Aug 2018 15:45:56 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id a33-v6sm5519165eda.2.2018.08.26.15.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 15:45:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 1/6] staging:rtl8192u: Rename PHY_SetRF8256Bandwidth() - Style
Date:   Sun, 26 Aug 2018 23:45:28 +0100
Message-Id: <20180826224533.16020-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826224533.16020-1-johnfwhitmore@gmail.com>
References: <20180826224533.16020-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function PHY_SetRF8256Bandwidth() to
phy_set_rf8256_bandwidth(). This change clears the checkpatch issue
with CamelCase naming.

The parameter Bandwidth has been renamed to bandwidth, for the
same reason.

Additionally a new line has been added to the parameter list of the
function declaration in r8190_rtl8256.h to truncate the line length
to the checkpatch limit.

These changes are simple coding style changes which should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.c | 8 ++++----
 drivers/staging/rtl8192u/r8190_rtl8256.h | 3 ++-
 drivers/staging/rtl8192u/r819xU_phy.c    | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index 9b7f822e9762..8916a1069b38 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -23,7 +23,7 @@
  * Note:	8226 support both 20M  and 40 MHz
  *--------------------------------------------------------------------------
  */
-void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwidth)
+void phy_set_rf8256_bandwidth(struct net_device *dev, enum ht_channel_width Bandwidth)
 {
 	u8	eRFPath;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -53,7 +53,7 @@ void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwi
 						(enum rf90_radio_path_e)eRFPath,
 						0x14, bMask12Bits, 0x5ab);
 				} else {
-					RT_TRACE(COMP_ERR, "PHY_SetRF8256Bandwidth(): unknown hardware version\n");
+					RT_TRACE(COMP_ERR, "phy_set_rf8256_bandwidth(): unknown hardware version\n");
 					}
 				break;
 		case HT_CHANNEL_WIDTH_20_40:
@@ -68,11 +68,11 @@ void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwi
 					else
 						rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e)eRFPath, 0x14, bMask12Bits, 0x5ab);
 				} else {
-					RT_TRACE(COMP_ERR, "PHY_SetRF8256Bandwidth(): unknown hardware version\n");
+					RT_TRACE(COMP_ERR, "phy_set_rf8256_bandwidth(): unknown hardware version\n");
 					}
 				break;
 		default:
-				RT_TRACE(COMP_ERR, "PHY_SetRF8256Bandwidth(): unknown Bandwidth: %#X\n", Bandwidth);
+				RT_TRACE(COMP_ERR, "phy_set_rf8256_bandwidth(): unknown Bandwidth: %#X\n", Bandwidth);
 				break;
 
 		}
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.h b/drivers/staging/rtl8192u/r8190_rtl8256.h
index 29b926cad14b..25f5c8b72e92 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.h
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.h
@@ -14,7 +14,8 @@
 #define RTL8225H
 
 #define RTL819X_TOTAL_RF_PATH 2 /* for 8192U */
-void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwidth);
+void phy_set_rf8256_bandwidth(struct net_device *dev,
+			      enum ht_channel_width bandwidth);
 void PHY_RF8256_Config(struct net_device *dev);
 void phy_RF8256_Config_ParaFile(struct net_device *dev);
 void PHY_SetRF8256CCKTxPower(struct net_device *dev, u8	powerlevel);
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 7ee10d49894b..77ded1efc3a3 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1633,7 +1633,7 @@ void rtl8192_SetBWModeWorkItem(struct net_device *dev)
 		break;
 
 	case RF_8256:
-		PHY_SetRF8256Bandwidth(dev, priv->CurrentChannelBW);
+		phy_set_rf8256_bandwidth(dev, priv->CurrentChannelBW);
 		break;
 
 	case RF_8258:
-- 
2.18.0

