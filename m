Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091BDC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CE42083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFUzxfuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CE42083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbeGZUnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41170 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbeGZUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so2243434edr.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WE2pvkLuK4Ccoc5LJM99Bb9ICyh+FrqQdx2lV16votI=;
        b=jFUzxfuTVbQ5TUxzfsrvmWLHf54Em3yrRWVaRKLbbb3rrxO0btsWO07ygdf/UtEaDa
         QhjMdfEO+GMxw6Ae1StNlqG6yi72tXWicyaJVSARpURzhPV8P84impSYvnnRytUmje4x
         4HZAUzyfT9tWglT+URLl9UkWIoXsIY9BJl9RPSBXPDo19TdHZBpMgSjMjcoZGfUQgbDM
         4FZrTT1yf7EOJZTpQ7qvzZ9jpJrAWqBWsiUYTqZZ0oWl5tEp4rptTySI6uM1RCqDSwzy
         7deQmmwOE91fY+AftqFUyPlpem0c0Pd9Qu/fLVPqYx6iZvNkwxEsNt3YJWTHp2+1Bg7e
         +Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WE2pvkLuK4Ccoc5LJM99Bb9ICyh+FrqQdx2lV16votI=;
        b=OlKXoxKNBin1yRJp5jaGDM5/aC5/jvV4/KNVQU7i02GuktMM4mRomJ8da5PbNojDWt
         PAuRI4nmyQwzeLa17uhfZN7Q2XfTbv4MMpheYO74ygEj8gLKNhKdOIRI8sn9K8NUJ1cP
         ZVfsbBmbkk9M1DmMNxzAQNLTxYBzKZyuvqNNRKRsJwawoSxwSxQrDICWvlUn4eODxNQ2
         T8BbdLN6KQ/ZaqkNCoDGRelCdKY6hUCjAWh9H35uUPtUPfwRrJULd4Jx0JG5xTcm5siY
         JdawsRjEBntHG0PurUQGBi9m2LZAbabWKe4lcHdN2rdiGc345TYW7/H5w/SQqq33PPMO
         C22w==
X-Gm-Message-State: AOUpUlEUfURaT9rOfdg2VRwD+3mc6gKzQ/kJmatkRCYjxQ7zHaFSbzsb
        negUoBbQDuOtwinctBdAQeRPyVEa
X-Google-Smtp-Source: AAOMgpcEDG3158AuIZ5hnJZPcHRPn84ZUYiHvQy6cpHF2E7WUvKkw6mzCkZV8vBDBOlu8Q8jN0kF3g==
X-Received: by 2002:a50:c292:: with SMTP id o18-v6mr4235383edf.188.1532633102909;
        Thu, 26 Jul 2018 12:25:02 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:25:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/16] staging:rtl8192u: Remove proxy rtl819XRadioB_Array - Style
Date:   Thu, 26 Jul 2018 20:24:20 +0100
Message-Id: <20180726192426.31913-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726192426.31913-1-johnfwhitmore@gmail.com>
References: <20180726192426.31913-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the array rtl819XRadioB_Array Rtl8192UsbRadioB_Array which acts
as a proxy the actual array Rtl8192UsbRadioB_Array. The only purpose, I
can see for this implementation is to obscure the actual array being
used Rtl8192UsbRadioB_Array.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 7 +++----
 drivers/staging/rtl8192u/r819xU_phy.h | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 775dfa847b93..1cbb48c5c110 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -29,7 +29,6 @@ static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
 };
 
 #define rtl819XMACPHY_Array Rtl8192UsbMACPHY_Array
-#define rtl819XRadioB_Array Rtl8192UsbRadioB_Array
 #define rtl819XRadioC_Array Rtl8192UsbRadioC_Array
 #define rtl819XRadioD_Array Rtl8192UsbRadioD_Array
 
@@ -995,14 +994,14 @@ u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
 	case RF90_PATH_B:
 		for (i = 0; i < RadioB_ArrayLength; i = i+2) {
 
-			if (rtl819XRadioB_Array[i] == 0xfe) {
+			if (Rtl8192UsbRadioB_Array[i] == 0xfe) {
 				mdelay(100);
 				continue;
 			}
 			rtl8192_phy_SetRFReg(dev, eRFPath,
-					     rtl819XRadioB_Array[i],
+					     Rtl8192UsbRadioB_Array[i],
 					     bMask12Bits,
-					     rtl819XRadioB_Array[i+1]);
+					     Rtl8192UsbRadioB_Array[i+1]);
 			mdelay(1);
 
 		}
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 7c4b89a5c592..d708796d7cec 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -25,7 +25,6 @@ struct sw_chnl_cmd {
 	u32		        ms_delay;
 } __packed;
 
-extern u32 rtl819XRadioB_Array[];
 extern u32 rtl819XRadioC_Array[];
 extern u32 rtl819XRadioD_Array[];
 
-- 
2.18.0

