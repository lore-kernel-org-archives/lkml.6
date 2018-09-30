Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D30C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599822075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoEUwqqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599822075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeJAC1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34495 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeJAC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so1607635wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9erDDC+d1SBmE836yJSeJQ/r/XeYWR+gQSl5jqmOmoY=;
        b=QoEUwqqW3yBaDRO6hRphyl56XkUDQabKU38V+dOcKQ9zrwTpk2wokDngGaaHZdMOPY
         qAnst4aiLCgMmhnM+/NvR7ROhM+WxnAGflteR9gXD9fpqgglBFC/NQVgFJ15dayPNlct
         znDjg9ciq7le8r+/EN8HC6ZCIU6lVBSMGCMqV3U0ntYwmcXxJ9CaJgY5QT1ZpBu3pLwP
         DstPsr/jU3pbUT44g1/wtJ5d4P0WB0KLwK3VNYG51fAbCaPqq90HrBNImgwio6cbzuum
         oFl2FEDQsw30SIf9O2L+oxb1mDA/KOtiXQTMvwUozkIlH1UQexeWN1vBVUQDhqDCIKYD
         dXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9erDDC+d1SBmE836yJSeJQ/r/XeYWR+gQSl5jqmOmoY=;
        b=bjTrumL4WK5BlU5oHqnpu6zQcDLNALfJLbiSCf+a5gD6T5/LRx4r5jVZ3zmiiT5AJ9
         4dnghVo7MMXyQClx7/VZJBwv0fAhq98FItOi1F5aum1COns+FxGMVv0V1nXiKvUDm0FD
         3qf7mKBZAmUeTk7f+lWjsqZ0XP/4e2Tg5bHYQ4Ie6+mJyNezE+Vvemkq3fW7u54BJg/q
         eyv6qxKBtePjqXSeDLczhddWiRFVvU1PKq2xP00scnN8MKPoo/I2R16Si5aZtYTv2qNY
         ADM1RNyUafXPJAbacpSEx7SPWUJymtyUXEjna2Kz1wExainlxzQ04/UaK0eDpu65ksX+
         BU5A==
X-Gm-Message-State: ABuFfohw9yFHGlmcNLZS7ePgQ+jY3ObTSmj6Is3w7pdqQyhusfmiPl7p
        WBNLMhPTuBy02rG/fJixOJ8=
X-Google-Smtp-Source: ACcGV62pmJDpEzjDh38qPFJgxqKpgL6s25JJX9AUMD5Wu/ykxH0t6lSTgW8FcVEJXd1ysRSGgAOesg==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr3938274wmd.123.1538337202820;
        Sun, 30 Sep 2018 12:53:22 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:22 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/19] staging: rtl8188eu: rename odm_HWConfig
Date:   Sun, 30 Sep 2018 21:52:53 +0200
Message-Id: <20180930195310.1531-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename source and header file to avoid CamelCase.
odm_HWConfig.c -> odm_hwconfig.c
odm_HWConfig.h -> odm_hwconfig.h

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/Makefile                              | 2 +-
 .../staging/rtl8188eu/hal/{odm_HWConfig.c => odm_hwconfig.c}    | 0
 .../rtl8188eu/include/{odm_HWConfig.h => odm_hwconfig.h}        | 0
 drivers/staging/rtl8188eu/include/odm_precomp.h                 | 2 +-
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/staging/rtl8188eu/hal/{odm_HWConfig.c => odm_hwconfig.c} (100%)
 rename drivers/staging/rtl8188eu/include/{odm_HWConfig.h => odm_hwconfig.h} (100%)

diff --git a/drivers/staging/rtl8188eu/Makefile b/drivers/staging/rtl8188eu/Makefile
index 4e606b03ec03..7da911c2ab89 100644
--- a/drivers/staging/rtl8188eu/Makefile
+++ b/drivers/staging/rtl8188eu/Makefile
@@ -28,7 +28,7 @@ r8188eu-y :=				\
 		hal/hal_intf.o		\
 		hal/hal_com.o		\
 		hal/odm.o		\
-		hal/odm_HWConfig.o	\
+		hal/odm_hwconfig.o	\
 		hal/odm_rtl8188e.o	\
 		hal/rtl8188e_cmd.o	\
 		hal/rtl8188e_dm.o	\
diff --git a/drivers/staging/rtl8188eu/hal/odm_HWConfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
similarity index 100%
rename from drivers/staging/rtl8188eu/hal/odm_HWConfig.c
rename to drivers/staging/rtl8188eu/hal/odm_hwconfig.c
diff --git a/drivers/staging/rtl8188eu/include/odm_HWConfig.h b/drivers/staging/rtl8188eu/include/odm_hwconfig.h
similarity index 100%
rename from drivers/staging/rtl8188eu/include/odm_HWConfig.h
rename to drivers/staging/rtl8188eu/include/odm_hwconfig.h
diff --git a/drivers/staging/rtl8188eu/include/odm_precomp.h b/drivers/staging/rtl8188eu/include/odm_precomp.h
index 0cf7f82b805f..6efddc8f1675 100644
--- a/drivers/staging/rtl8188eu/include/odm_precomp.h
+++ b/drivers/staging/rtl8188eu/include/odm_precomp.h
@@ -22,7 +22,7 @@
 /* 2 OutSrc Header Files */
 
 #include "odm.h"
-#include "odm_HWConfig.h"
+#include "odm_hwconfig.h"
 #include "odm_debug.h"
 #include "../../rtlwifi/phydm/phydm_regdefine11n.h"
 
-- 
2.19.0

