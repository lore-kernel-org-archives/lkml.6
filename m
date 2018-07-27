Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39B8C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC2720842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRGFRobO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC2720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389435AbeG1AxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:53:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42663 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389283AbeG1Aww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:52:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so6550041wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nBr7oY0lQ9PsfuT36swr5W00CVnDq6glvIIF5Hs+1oU=;
        b=eRGFRobOAFbp3WjU6wK7R45zW640azBQ/taqOOpXePmVbvbxLJQIifysq0xas1IVsV
         Q7rgLoyuDlJH/KpuQ30k5ON9AwFTfUEpWCJxrgNj6y5q7q2EGs2cipLc8ziDNCMmCdVI
         z+/lj8AocSKj+kcIiij6zyW1nQIb2qN4crG5PYwWC/AHCIQhR70WKM/C4PXMot4qL9yV
         DidwO1fay0CdQ+XIe+6LBhaiLRXP+ahPTBWOIH/YaCm3bxARiM79qQHBJHRpMSB5kxuu
         PWRv1onbvSOd9k7Nxsrezyu4EUJdusQaajfZPl+F9tFo87R2KDFCZAFE8jm9WkAEKQQR
         nG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nBr7oY0lQ9PsfuT36swr5W00CVnDq6glvIIF5Hs+1oU=;
        b=J13R/NO1ezDGEiowCEr6SYPeAvdzCJvnqIh1GmYRtVGmkUB47h+SNXxxkQkKCQo7U6
         u9Ml66m/Nmiwj4RGtZXOjbh59QYTvheW3OHZgwuVPHUNTvDNPPqJsvcmGmn1g6DjTaLG
         XqVUpOnR7mbWycGgHWPvL3A+udLxO1Mw/j5WsnT7g3tMXOMPiek2IH9WnEGbiuhgMTas
         MlHEqlaKDehjeotF9Fd7foKprRqVy/n0bJa7VUSWVpBkvSAgaxynV+ftKJGGO4OK3wID
         uf2bjGecymWexG+LjH0HWKTbQqSnd9bQ5zQfYjhHIar7EDWCocj2hFLH/o8sWv8eXSbz
         1XNA==
X-Gm-Message-State: AOUpUlF3tlmOQyEsP93vMNrCQHr1CI2wxkt7+cYPjbqVRCc2NFXS5eXZ
        O2IoVP3yeBEmfKdyuLIULCOTT4L9ml4=
X-Google-Smtp-Source: AAOMgpcZVRBFhhZ6B+6r/TrQgkXyvCbgt/KfQ3HBXZg4atUqSnkpUu3JCbGD0k1ReMHNcspa0rYhNA==
X-Received: by 2002:adf:a211:: with SMTP id p17-v6mr6830768wra.196.1532734123390;
        Fri, 27 Jul 2018 16:28:43 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7313217wru.93.2018.07.27.16.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 16:28:42 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/10] staging:rtl8192u: Refactor dm_dig_connect_e - Style
Date:   Sat, 28 Jul 2018 00:28:23 +0100
Message-Id: <20180727232826.28014-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727232826.28014-1-johnfwhitmore@gmail.com>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type dm_dig_connect_e is only used to group constant
values, as the actual type is never used as the type for the variables
which use the defined constants (cur_connect_state and pre_connect_state).

These two member variables have had there defined types changed to
properly reflect there usage and to permit compiler type checks to be
performed.

In addition the definition of the enumerated type has been moved above
the structure which uses the type. The typedef of the enumerated type
has been removed to clear the checkpatch issue with defining new types
and the enumerated value DIG_CONNECT_MAX has been removed since it is
never used in code.

The resulting changes are all coding style in nature and should not
impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 450bcbe3095e..825df06e17a8 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -76,6 +76,11 @@ enum dm_dig_sta_e {
 	DM_STA_DIG_MAX
 };
 
+enum dm_dig_connect_e {
+	DIG_DISCONNECT = 0,
+	DIG_CONNECT = 1,
+};
+
 /* 2007/10/04 MH Define upper and lower threshold of DIG enable or disable. */
 struct dig {
 	u8		dig_enable_flag;
@@ -91,8 +96,8 @@ struct dig {
 
 	enum dm_dig_sta_e		dig_state;
 	enum dm_dig_sta_e		dig_highpwr_state;
-	u8		cur_connect_state;
-	u8		pre_connect_state;
+	enum dm_dig_connect_e		cur_connect_state;
+	enum dm_dig_connect_e		pre_connect_state;
 
 	u8		curpd_thstate;
 	u8		prepd_thstate;
@@ -110,12 +115,6 @@ struct dig {
 	long		rssi_val;
 };
 
-typedef enum tag_dig_connect_definition {
-	DIG_DISCONNECT = 0,
-	DIG_CONNECT = 1,
-	DIG_CONNECT_MAX
-} dm_dig_connect_e;
-
 typedef enum tag_dig_packetdetection_threshold_definition {
 	DIG_PD_AT_LOW_POWER = 0,
 	DIG_PD_AT_NORMAL_POWER = 1,
-- 
2.18.0

