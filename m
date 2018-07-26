Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0877BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A962088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spxAcnDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A962088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbeGZUnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38809 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbeGZUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id t2-v6so2252910edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JWWquPww3yCSZ62pIjPWrlkmYov8tLxS6XZdkrsrhmg=;
        b=spxAcnDCxEz+A1cFpkViXAq5u7kFx6szJVzVB1EsDvoyWr3WSLwk6n5+PUDmGwSyIL
         mYGkE+5K7TQTGmNsfoB1GQcWDz3wZA9JO3IDwtZJOhUqDmTLnfp9/yphnivnjhWdpo1e
         mEp4xhV25lP26mNYoA523IsM/cNXWNA8K9InuXeLjb7fxf0U822Qc00dxVtGbiD2AP4C
         TF3pH/iWTsZ+xQDo+OTp1IPU7luagndUm50cg28Fes+U9AmcNYX4V9ba/M4pymynRGSG
         fTci41sfcwecSdgyCX6uZ99KWZCxVxYCmCKstwtSeSgH7DP729giGs5/uZgsJTfTDsjY
         tqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JWWquPww3yCSZ62pIjPWrlkmYov8tLxS6XZdkrsrhmg=;
        b=Ldcs4Fdk3E3NuLjVs0bg1fCy0w5tmKhc8WqQixmO5EGiOjAKpj6gVUUE6+CaSpzElH
         qLAys/Sf+WJuFFuF/Kjg6p90+du2t2ONrwtGQw0f37I9CbMq1ADM05RLqitli301igBK
         zmpOvKE92C7BlXMUpRBVjs346emkjGayw72c3U+UiBF/9GpHb9yH5zTxG2CYZA+qxaNg
         ef2LaCfWjliX1/dFKpQEmGND7BfFzqQgnJ0z5a+kGJqTD0TY5fvHEbJWziTc6QWow3FO
         OESRvsCKMNHeIT4V9ZvGAVfcwXi0iJYxpG7rsfOpLftCu51DZQmP6RBFNlg6X0KSen6+
         OKHw==
X-Gm-Message-State: AOUpUlEB5xFr3MZfeDpPtksJutcHqn2SLESxts5k489Nnkb7h1qr9xwd
        B17nOAhTjDqFwbFIdJIRmGPmB0Y3
X-Google-Smtp-Source: AAOMgpd5iSeYDWs6wAorrTuUTy+mdMSumLY9kwVfnRwoGbRM4H8alnH5m/MmeRbwWXrOETnIRUMJIg==
X-Received: by 2002:a50:d7cb:: with SMTP id m11-v6mr4040116edj.19.1532633097502;
        Thu, 26 Jul 2018 12:24:57 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:24:56 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/16] staging:rtl8192u: Remove proxy struct rtl819XMACPHY_Array_PG - Style
Date:   Thu, 26 Jul 2018 20:24:16 +0100
Message-Id: <20180726192426.31913-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the struct rtl819XMACPHY_Array_PG which is simply a proxy for
the struct Rtl8192UsbMACPHY_Array_PG. There appears to be no purpose
served by this implementation, other then to obscure the
Rtl8192UsbMACPHY_Array_PG structure.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 3 +--
 drivers/staging/rtl8192u/r819xU_phy.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 496f42b8f425..cc35ca7b9140 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -30,7 +30,6 @@ static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
 
 
 #define rtl819XPHY_REG_1T2RArray Rtl8192UsbPHY_REG_1T2RArray
-#define rtl819XMACPHY_Array_PG Rtl8192UsbMACPHY_Array_PG
 #define rtl819XMACPHY_Array Rtl8192UsbMACPHY_Array
 #define rtl819XRadioA_Array  Rtl8192UsbRadioA_Array
 #define rtl819XRadioB_Array Rtl8192UsbRadioB_Array
@@ -491,7 +490,7 @@ void rtl8192_phy_configmac(struct net_device *dev)
 	if (priv->btxpowerdata_readfromEEPORM) {
 		RT_TRACE(COMP_PHY, "Rtl819XMACPHY_Array_PG\n");
 		dwArrayLen = MACPHY_Array_PGLength;
-		pdwArray = rtl819XMACPHY_Array_PG;
+		pdwArray = Rtl8192UsbMACPHY_Array_PG;
 
 	} else {
 		RT_TRACE(COMP_PHY, "Rtl819XMACPHY_Array\n");
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index d783e9c0dfd1..3c069b89bcdb 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -25,7 +25,6 @@ struct sw_chnl_cmd {
 	u32		        ms_delay;
 } __packed;
 
-extern u32 rtl819XMACPHY_Array_PG[];
 extern u32 rtl819XPHY_REG_1T2RArray[];
 extern u32 rtl819XAGCTAB_Array[];
 extern u32 rtl819XRadioA_Array[];
-- 
2.18.0

