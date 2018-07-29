Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAD8C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFE220892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzW6NFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFE220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbeG2Wkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35732 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbeG2Wka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so10594682wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XMVFQ/95txj0VwHpHzShqMwIG89klA6UdYbGRjJ6PT4=;
        b=NkzW6NFZHRqVD37RkhjXBBucOfHf/XpFJ1jflOe7NZbm+Dtf1szr6ozGl6lDipHtrN
         YxaAYxJPmRp7Rf9PKx1P2LDPdsK6+/zLgbBdY+J8cdO8TZhtt/s05CKLA4WbKUOnVC3j
         KcmR5KVG39nBORQX8qUCORJBFX+P9ogNVDlp77TEZqQDEW4heC6rRYSqlPdjLpNrz2Wz
         znA2ugRtyojcBmvsb2KRNZDYkblkRxrklNZeIQumW7J70MjJAmW9uP6OKldUFF8w5rnh
         HxD3qHilz+/fSkXidMpW20PP4/LjA/R1+PMV/WewxzUPf9pml86N87MBW8Q0N9zhMusQ
         N8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XMVFQ/95txj0VwHpHzShqMwIG89klA6UdYbGRjJ6PT4=;
        b=OzK2pHN2nGEf69ZHlhj+1x94ZkNCIUNTnwG8OL1wKtRFhi9GGXWdUhnKF8knUBI0e4
         YM2K6rcFBuPlAVD9yIBckl4u06xPm7zu+6xT3uktVUWUMMLmWHOEh94Aq0hG07FumF+y
         FbSmLIwXixFyADk4s2KF4eSl7RlcZ+zCJHW/61tX31H/3u+54U319T7gVPf+5KEdApA0
         1rkcRh3rraCaeB9ZvqXAJrkoM3HgvzmX+g00NVliWV9GGiNtlgeh/cxNs/LRuL7IthNx
         A5KSbrw3O3v+B59sjC7lfkkEliA078VMV6bmMvV2kNnlyC6/BOAtPcchLCWz9rtOdDZm
         0dVw==
X-Gm-Message-State: AOUpUlEtO87hM8+r178U4Phmgbxk7V+0M7Xr/WNTt8NSCvKsDLrS00oR
        voKw6ZEPOzb9+6XhcacqsV3XVjb8uVY=
X-Google-Smtp-Source: AAOMgpfIMkdP4E4KUCXFyAhh5l7q8I9qC3u9nySxI75uaVvaCMAyd4Z4Xj4qK1DQJC6wtMCmg+eZyQ==
X-Received: by 2002:adf:eac8:: with SMTP id o8-v6mr14001476wrn.150.1532898518581;
        Sun, 29 Jul 2018 14:08:38 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:37 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 12/15] staging:rtl8192u: Refactor dm_dig_connect_e - Style
Date:   Sun, 29 Jul 2018 22:07:44 +0100
Message-Id: <20180729210747.10803-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
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
index c15faa428b1d..8de6d15fb659 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -76,6 +76,11 @@ enum dynamic_init_gain_state {
 	DM_STA_DIG_MAX
 };
 
+enum dig_connect {
+	DIG_DISCONNECT = 0,
+	DIG_CONNECT = 1,
+};
+
 /* 2007/10/04 MH Define upper and lower threshold of DIG enable or disable. */
 struct dig {
 	u8		dig_enable_flag;
@@ -91,8 +96,8 @@ struct dig {
 
 	enum dynamic_init_gain_state		dig_state;
 	enum dynamic_init_gain_state		dig_highpwr_state;
-	u8		cur_connect_state;
-	u8		pre_connect_state;
+	enum dig_connect		cur_connect_state;
+	enum dig_connect		pre_connect_state;
 
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

