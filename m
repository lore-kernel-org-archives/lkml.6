Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8010C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEE72086A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rb08LBeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEE72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeH0A6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46577 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeH0A6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so2739144edr.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fCiit2dLWMqwo45oRB9f2AEIpuW+LaA7uD3M9XjCFWw=;
        b=rb08LBeUXwxsTY97HwMqjocALRJ76NmiUQjdiew+aTnFSDZrLsRt8T5gJJbMc2HALo
         s6S3ouxgEjmCPsRnZam346AYpAYetI2FnA2jYejE1/vKK/l2FdXCndNP9Aqv5jDIvNl0
         cD5t/dAKnJso4gOuadDD//WVCfM8TpofNFN2/oqFxrHQITX3nvlm/HQk5UPPjwd2v3hi
         0P82LiBtc1pw3M9YQlyzHTY5aSLfYp/nEOSgZCSqNrsFFIm4w0u4k1XRBYRrkRIiXWka
         dNYMV+qNfJjcSu4oE8OUE7ZIR0XL1KsbC+VJtmK+rwx+T54s5ccSt5OhFSzg8vq0qC+a
         3efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fCiit2dLWMqwo45oRB9f2AEIpuW+LaA7uD3M9XjCFWw=;
        b=rZz3GvMyMQL+xquJwFqF+gnNE+045NNExfC9wKr1hYv2VJ2HAhJMHuht4bez5BjGcB
         i+LcZE3+gIjT65j77tar9Zh8nHSCwHAnA9i8v/lP4Rh0+0kaQ84X+yg86AhYe8LoAXc6
         JoBcMpTvju+cn/Ft21VJE0gmaopD8GBmQKaic6324pIIBJ8f4phP/YfEJJG9okAyxGHE
         0BntWb48Ys12QDhY9m9jFy/k+bHPYsqZMeg7u3V0O5HULDWPRR6IaKaLmbEO64zu3wpI
         3751IhTBxzWwxaz9u0f3Z6iwDk0qVwFJGlYIZXPBeo/JUKYnC2Z/rEsjg/wUKZFogVQq
         HjQg==
X-Gm-Message-State: APzg51Bd6K9YmJEL3FdJa1I3pyXwixUgEAjVS8nPqxoyz4+dzJsu4rPi
        rYosgwJsR+93SBbr7t5jlZqHimZb
X-Google-Smtp-Source: ANB0VdbB0IIXtrczOMXHH+5UMbNgh3mOlFDhp0GNMXWUk/E8go3ycaF6f2RSFafL9pJXF8iGijhHXQ==
X-Received: by 2002:a50:e249:: with SMTP id o9-v6mr13871929edl.253.1535318098113;
        Sun, 26 Aug 2018 14:14:58 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:14:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/21] staging:rtl8192u: Refactor RT_RF_TYPE_DEF - Style
Date:   Sun, 26 Aug 2018 22:14:20 +0100
Message-Id: <20180826211439.14326-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the enumerated type RT_RF_TYPE_DEF to rt_rf_type to comply
with the coding standard, lower case type names. Removed the 'def'
postscript which provides no additional information.

The 'typedef' directive has been removed to clear the checkpatch issue
with defining new types.

The type has been moved to the file r8192U.h, where it is
actually used by the member variable 'rf_type'. Previously the member
variable used a 'u8' type so no compiler type checking is being
performed. The type has been changed to the correct type.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h    | 8 +++++++-
 drivers/staging/rtl8192u/r8192U_hw.h | 9 ---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index ce287e2f79e1..1b51601df1ee 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -804,6 +804,12 @@ enum version_819xu {
 	VERSION_819XU_C,// C-cut
 };
 
+//added for different RF type
+enum rt_rf_type {
+	RF_1T2R = 0,
+	RF_2T4R,
+};
+
 typedef struct r8192_priv {
 	struct usb_device *udev;
 	/* For maintain info from eeprom */
@@ -844,7 +850,7 @@ typedef struct r8192_priv {
 
 	struct mutex wx_mutex;
 
-	u8 rf_type;			/* 0: 1T2R, 1: 2T4R */
+	enum rt_rf_type   rf_type;	    /* 0: 1T2R, 1: 2T4R */
 	RT_RF_TYPE_819xU rf_chip;
 
 	short (*rf_set_sens)(struct net_device *dev, short sens);
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index 15e56003d97c..f91dd20fa568 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -20,15 +20,6 @@
 #ifndef R8192_HW
 #define R8192_HW
 
-//added for different RF type
-typedef enum _RT_RF_TYPE_DEF {
-	RF_1T2R = 0,
-	RF_2T4R,
-
-	RF_819X_MAX_TYPE
-} RT_RF_TYPE_DEF;
-
-
 typedef enum _BaseBand_Config_Type {
 	BaseBand_Config_PHY_REG = 0,			//Radio Path A
 	BaseBand_Config_AGC_TAB = 1,			//Radio Path B
-- 
2.18.0

