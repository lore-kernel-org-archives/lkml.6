Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E3C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F333620842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQsD6Uy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F333620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389209AbeG1Awr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:52:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35935 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbeG1Awr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:52:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so7190097wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zn4AqjEwkg4bjrhmveT0ldpnNUV5AZKc1Y9YHX/BanM=;
        b=mQsD6Uy0BbSjSYRMrgzptYCUxDodVcJmbUpEiZzwsNIcque8IwXIWuqxM7l+8+MAZR
         QYpiQVxttJ/87Mc2o7JePPdAG4SrdVDfqilnsboYJC5rkpdusn2hIOVRPBUHhgYXaaAD
         2VOEE51H98ZzlGMoCk7yDPoQ8R8awC8FDPAH36iofGat/Fu0ibvyph5RIX8rzTrxXLpT
         O+kOTUBGRigtPDjbWNh7m/LUTFwDWoxRb3xNuiFceuL/XU5sezaHxiDf1P3xfAaKhGNh
         8+lXw3gY60Il4RJfsqupgouA14AHjU2f0BLhzBbMcGjGenia4eycgFOLzKqIhD1z6Rhg
         B3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zn4AqjEwkg4bjrhmveT0ldpnNUV5AZKc1Y9YHX/BanM=;
        b=C29CcuBdCbXYrihABNnpvy+RgPFJRMxayM3RdKcj0YJo/ChzM/1hrcyb9MnQ1E5WVV
         9M002jg5TzlyX9E3S7DxxYGyTYrGQ6hdPAqoq2E4pfPjdu5xQmq3j/+cxmqll5OieoaE
         jD6da5VAPWq5SxJn59wzEqncWXA91g6z8gCVWAsJIz2xvPbRPPNGGMp+2M1zddpcO7Yv
         HF5rV3CZ0f8ymmqgz4SEqIH6PDOIBH7v4uRcvxZtLlp/sKWoP7Nfa3Ku3j4h18hiA0ES
         aWT+C6loP7w/2PkzF9hnTbk4nM540bTMpwmWE+yNLTC5kTmUzOrWJrMdaaZqGw23bbHi
         Y26w==
X-Gm-Message-State: AOUpUlFAAzvQGL6dW5TU0n0xFDjN+xhBdZgeyd1Mi3XqHB38/2T8LX06
        cAtbnpYyNAIFonBZ2MiG6zXn3Zv/Lns=
X-Google-Smtp-Source: AAOMgpfXLLnTuKN3c1+re5W9SnSt1wTa+jMC62JrSSxLbhQZD95XuxJvNItPOQLMHkrgKnTdz/lW9Q==
X-Received: by 2002:a1c:864c:: with SMTP id i73-v6mr6249008wmd.40.1532734117856;
        Fri, 27 Jul 2018 16:28:37 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7313217wru.93.2018.07.27.16.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 16:28:37 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/10] staging:rtl8192u: Refactor enum dm_ratr_sta_e usage - Style
Date:   Sat, 28 Jul 2018 00:28:19 +0100
Message-Id: <20180727232826.28014-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727232826.28014-1-johnfwhitmore@gmail.com>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type dm_ratr_sta_e was defined in the file
drivers/staging/rtl8192u/r8192U_dm.h but never actually used in that
file. The only variable which uses this enumerated type is 'ratr_state',
a member variable of the _rate_adaptive structure defined in the file
drivers/staging/rtl8192u/r8192U.h.

To clarify and place the enumerated type close to where it is used the
type was moved to the drivers/staging/rtl8192u/r8192U.h file.

In addition the member variable 'ratr_state' which uses the enumerated
constants was declared as being of type 'u8'. This negates any advantage
of the enumerated type, compiler type-checking, so that member variable's
type has been changed to being of the enumerated type.

Additionally the typedef from the enumerated type has been removed to
clear the checkpatch issue with defining new types.

This is a coding style change and should have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h    | 10 +++++++++-
 drivers/staging/rtl8192u/r8192U_dm.h |  8 --------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index e615d9b3f6b1..b00781e1f5ee 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -662,9 +662,17 @@ typedef enum _RT_RF_TYPE_819xU {
 	RF_PSEUDO_11N = 4,
 } RT_RF_TYPE_819xU, *PRT_RF_TYPE_819xU;
 
+/* 2007/10/08 MH Define RATR state. */
+enum dm_ratr_sta_e {
+	DM_RATR_STA_HIGH = 0,
+	DM_RATR_STA_MIDDLE = 1,
+	DM_RATR_STA_LOW = 2,
+	DM_RATR_STA_MAX
+};
+
 typedef struct _rate_adaptive {
 	u8				rate_adaptive_disabled;
-	u8				ratr_state;
+	enum dm_ratr_sta_e		ratr_state;
 	u16				reserve;
 
 	u32				high_rssi_thresh_for_ra;
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 2444e1c1357b..942e9ba8d3ad 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -105,14 +105,6 @@ struct dig {
 	long		rssi_val;
 };
 
-/* 2007/10/08 MH Define RATR state. */
-typedef enum tag_dynamic_ratr_state_definition {
-	DM_RATR_STA_HIGH = 0,
-	DM_RATR_STA_MIDDLE = 1,
-	DM_RATR_STA_LOW = 2,
-	DM_RATR_STA_MAX
-} dm_ratr_sta_e;
-
 /* 2007/10/11 MH Define DIG operation type. */
 typedef enum tag_dynamic_init_gain_operation_type_definition {
 	DIG_TYPE_THRESH_HIGH	= 0,
-- 
2.18.0

