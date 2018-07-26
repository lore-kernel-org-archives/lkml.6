Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08918C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36CE20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB+NRu83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36CE20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeGZUoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:44:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41167 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbeGZUnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so2243272edr.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8StP2SYzZJP38uHqwuLrYpciAm5fdBAi6wn/6UoBD4o=;
        b=IB+NRu83jBjwIA5wBSDnLjtCk1AANMHEDOawtJ1ersPQxEDF11WIo/kHVwwkYJqIbW
         unLQy2J6/CLu69pqq3pu8WTF+Z/lpUBYvpHzZg89xQUhiUfH6IGbcMnI7+BnPg5bXg0t
         m6r43Mi3zhEde/+jrJvimkNkMUFqVMLa9OUF7yY2pM3YGjGgL7PWhSiZVUfe2TET++hc
         0YcnK2aW5heMLvIL5MAxRyPSBkIK352jlp2lvsnGaaeeHc66oP9O4Vg4kNpKyK9GAF2r
         kTaz+pREmk1+Plcd1nN8sFR4MteV4L3FfwweHbdjJ/tXmqzv8lQPpm51PNuwdYHOC9Bp
         +YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8StP2SYzZJP38uHqwuLrYpciAm5fdBAi6wn/6UoBD4o=;
        b=Anl3fF0Ez13LIYYIvffVLcg20NZ/QrVSXpUxPv25Hu8p7TJwNCIWAhQAyVjlqUebnt
         juGb4iI8J5XtaJgguhUoRR9OANVEicqBSVGr79FyCuFzF10x1SOeHd8ykZ7Peh+j734+
         U6KsvgCxIUMMeWYJr9L3pfYwojp0yr6izKpxlJB6L/6QMFW64GMtHdK+wXyBkMhDoD57
         XGjIX1ffOLwu43sf72xve4MiYyza0fRPvF9PZseLu62dCC43S3gY7eQjmA/HFgbzJ+4Q
         CkJF9vPxJc8zmRLTmQbqaftN6GCIgg4hTjX4qufJOb7Jaz5kuiOiHyhY/0h2QvOF2e1d
         EUug==
X-Gm-Message-State: AOUpUlFtTNTjrzSQAKZLb3XgdyQ++XucJ8KWRldQqBjDLS0Dt2uam8b6
        sdifwDy9Dz6NZ0i8+NxSMFSpGDvS
X-Google-Smtp-Source: AAOMgpfCPswwgGK68QGrZoN9/Z3/gX8Rs2Ks2HmjwljWZZpxCMiAL9RKj86P+he9hs9uwK9K0x2ZUw==
X-Received: by 2002:a50:af45:: with SMTP id g63-v6mr4201002edd.30.1532633098873;
        Thu, 26 Jul 2018 12:24:58 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:24:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/16] staging:rtl8192u: Remove proxy struct rtl819XPHY_REG_1T2RArray - Style
Date:   Thu, 26 Jul 2018 20:24:17 +0100
Message-Id: <20180726192426.31913-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the struct rtl819XPHY_REG_1T2RArray which is simply a proxy for
the struct Rtl8192UsbPHY_REG_1T2RArray. There appears to be no purpose
served by this implementation, other then to obscure the
Rtl8192UsbPHY_REG_1T2RArray structure.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 10 ++++------
 drivers/staging/rtl8192u/r819xU_phy.h |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index cc35ca7b9140..8d44bbe90221 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -28,8 +28,6 @@ static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
 	0x0f72, /* 2484    */
 };
 
-
-#define rtl819XPHY_REG_1T2RArray Rtl8192UsbPHY_REG_1T2RArray
 #define rtl819XMACPHY_Array Rtl8192UsbMACPHY_Array
 #define rtl819XRadioA_Array  Rtl8192UsbRadioA_Array
 #define rtl819XRadioB_Array Rtl8192UsbRadioB_Array
@@ -534,13 +532,13 @@ void rtl8192_phyConfigBB(struct net_device *dev, u8 ConfigType)
 #endif
 	if (ConfigType == BaseBand_Config_PHY_REG) {
 		for (i = 0; i < PHY_REG_1T2RArrayLength; i += 2) {
-			rtl8192_setBBreg(dev, rtl819XPHY_REG_1T2RArray[i],
+			rtl8192_setBBreg(dev, Rtl8192UsbPHY_REG_1T2RArray[i],
 					 bMaskDWord,
-					 rtl819XPHY_REG_1T2RArray[i+1]);
+					 Rtl8192UsbPHY_REG_1T2RArray[i+1]);
 			RT_TRACE(COMP_DBG,
 				 "i: %x, Rtl819xUsbPHY_REGArray[0]=%x Rtl819xUsbPHY_REGArray[1]=%x\n",
-				 i, rtl819XPHY_REG_1T2RArray[i],
-				 rtl819XPHY_REG_1T2RArray[i+1]);
+				 i, Rtl8192UsbPHY_REG_1T2RArray[i],
+				 Rtl8192UsbPHY_REG_1T2RArray[i+1]);
 		}
 	} else if (ConfigType == BaseBand_Config_AGC_TAB) {
 		for (i = 0; i < AGCTAB_ArrayLength; i += 2) {
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 3c069b89bcdb..842837bd6631 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -25,7 +25,6 @@ struct sw_chnl_cmd {
 	u32		        ms_delay;
 } __packed;
 
-extern u32 rtl819XPHY_REG_1T2RArray[];
 extern u32 rtl819XAGCTAB_Array[];
 extern u32 rtl819XRadioA_Array[];
 extern u32 rtl819XRadioB_Array[];
-- 
2.18.0

