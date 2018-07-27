Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D00C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8EB20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1ipDPOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8EB20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbeG1Awq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:52:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35205 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbeG1Awp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:52:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so7196267wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OAf+f0cW5l8x3pPCzW6+D6k28z7op01JkjFTz+E9iYQ=;
        b=m1ipDPOkGVK3gNaZzt4g0ndxIdTvq/HTmi5GvmL30E/ta9dEnHpKQrw9P/PjojsuUm
         fU/JvTyfD51jTbsM8aeysOZfRxRhq2tGoGhLyVp2CGSsoz6/Xt1eEfUuhsh4d7MDZTWz
         Y7itgCa3T5gznntx+P9xoMfd3xOAp/EzFG2lpL2CcTzDiIlt+Yg78UGeOfc7wdOswI8H
         NzmHdmity3ilUQi83zniOGJActgTksdTDK8L4yZrLrao+S0Y0qYQnI+LM+JnxAj+oMut
         SgUzuJrG067QsrXLDA85lrMfNLMiUYMZk655aEkYs6S7kAdIQLQGrYmigDtCMuU0Zh8f
         EZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OAf+f0cW5l8x3pPCzW6+D6k28z7op01JkjFTz+E9iYQ=;
        b=Pqn8+7CSE/wAGY78pybjLn+jgrQeypb9R0864jb4KbWTT0LnB8XIlWpsQuUhF1THOl
         A/X75UqPTyojDVwOFzl3jq+dnApKFNpVRMpwbKS3IUxoeARjenCpmY+6uXaUh5/kfdCT
         4vsaaPYQ6gLgWo9eTghPX2weY2IlDxObw2+yK/YesGEICn6aKFJGeSL/67BIQZoo07hy
         9HjsP6cGChgpjBi3Rci5XKSrGS/IszhnFQEfZMf8m0bTcj/wFjVqcMMxBUlPzZspaz3P
         Hke/8IOU/hpc5YuJ07zEZm+6SYlhVXPeCIe5hoPAByeBTLZLDIrpLQffL6Gva0XTkMRg
         6LEQ==
X-Gm-Message-State: AOUpUlGl4zsajAf1l/4twSB3CfillHKotXAZ5JBpfBtZ508IQFUZrAWV
        wURo/GNzmw8gurJEj5ztgSJN11KCsK4=
X-Google-Smtp-Source: AAOMgpdL2izKvgeu2nujwou8go38unEWcMl/prIT4BI5B1ba60JHCn9br/r0RQkKWCl78Yd88MW6Lg==
X-Received: by 2002:a1c:f611:: with SMTP id w17-v6mr5712325wmc.143.1532734116467;
        Fri, 27 Jul 2018 16:28:36 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7313217wru.93.2018.07.27.16.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 16:28:35 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/10] staging:rtl8192u: Refactor use of enum dm_dig_sta_e - Style
Date:   Sat, 28 Jul 2018 00:28:18 +0100
Message-Id: <20180727232826.28014-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727232826.28014-1-johnfwhitmore@gmail.com>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the use of the enumerated type dm_dig_sta_e, which is not
actually used for type checking by the compiler.

The enumerated type defines values for the enumeration, which are used
by both dig_state and dig_highpwr_state, (members of the struct dig).
Both of those variables were defined as being of type u8. This negates
any usefulness of the use of the enumeration, (compiler type checking).

To make use of the compiler's type-checking the two member variables,
dig_state and dig_highpwr_state have been changed to being of type
enum dm_dig_sta_e. The enumerated type has been moved above the
struct dig definition so that the enumeration is already defined when
compiler reaches the two types using the enumerated type.

In addition the 'typedef' of the enumerated type has been removed to
clear the checkpatch issue with declaring new types.

These changes, whilst convoluted, are purely coding style in nature and
should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index e86dda99c223..2444e1c1357b 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -64,6 +64,13 @@
 
 
 /*------------------------------Define structure----------------------------*/
+
+enum dm_dig_sta_e {
+	DM_STA_DIG_OFF = 0,
+	DM_STA_DIG_ON,
+	DM_STA_DIG_MAX
+};
+
 /* 2007/10/04 MH Define upper and lower threshold of DIG enable or disable. */
 struct dig {
 	u8		dig_enable_flag;
@@ -77,8 +84,8 @@ struct dig {
 	long		rssi_high_power_lowthresh;
 	long		rssi_high_power_highthresh;
 
-	u8		dig_state;
-	u8		dig_highpwr_state;
+	enum dm_dig_sta_e		dig_state;
+	enum dm_dig_sta_e		dig_highpwr_state;
 	u8		cur_connect_state;
 	u8		pre_connect_state;
 
@@ -98,13 +105,6 @@ struct dig {
 	long		rssi_val;
 };
 
-typedef enum tag_dynamic_init_gain_state_definition {
-	DM_STA_DIG_OFF = 0,
-	DM_STA_DIG_ON,
-	DM_STA_DIG_MAX
-} dm_dig_sta_e;
-
-
 /* 2007/10/08 MH Define RATR state. */
 typedef enum tag_dynamic_ratr_state_definition {
 	DM_RATR_STA_HIGH = 0,
-- 
2.18.0

