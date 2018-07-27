Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0F6C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA5020842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIYjCult"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA5020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbeG1Awv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:52:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40473 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbeG1Awu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:52:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so6554267wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NtY5vk00ckv5a3sd+u2R01OQofTTtZ+D13J0IDjHn5c=;
        b=iIYjCultQDEg6V6OAUagk5MtM9gIEjY3O/Mszz4KFuOTtIVPbA49mS9GNyT1KM7JfC
         8sisJjsB1p8eja5Btlmh+AzWhxmNrzSNhnfc8rD70QRz5VS3vhFrx+9cnoHC/XQqc/wr
         JP4k43v478btSF0cKfDcU5TIO3d66cTpIsttdS94gnYZuW8S7TYROmK/77jsQreUZ3ZM
         DPkvoeY5sl/MGu51Mp/YN7d7wsQ+MeWqjTo+eQdUtPPbnrqRUFlVIYBtN9zO0ZXvUUzc
         bd10hOYL4kYjziDkL8FsCN9yuq8u3IrBYe7vHFtNFrkUyhgp2q2yz0EstiAtGQEeIH6s
         swCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NtY5vk00ckv5a3sd+u2R01OQofTTtZ+D13J0IDjHn5c=;
        b=OlYvLVB3bTx5etPWjgqTrMrr1Uzm/9Vx3+Ns12b+o9eTAV4BSeZ7yPlZcLzUG1zXZO
         Bq/ja0WuZLsyVAbHRoNU1KsjnpDiwiKDbNvj+ZYLIqQZfqIEBdjVWHwZeRlz2UkT/yTz
         pK4Wb3mrrG+4oyLZfTZ+hbTvO+qiZwNPMx4UIhfuTvj80M3WNjrf9RaoqCb6dW8phTAN
         eo7JJHFs4pEfTqZnj0yYmQaPIu8NO38wwjixTtY/dKmgTXHc3a2GbsZ94qFuer5Pyca1
         RIyl/EY6HYRKaAKdVJq6sI9PFeSlFH6KWWPizkAjbNd7et+iZ7tUWexOCJe2jYorI3Jt
         10gg==
X-Gm-Message-State: AOUpUlE2R527Ul0gNnM7pYpY9UJ1NtDoPPVbe3RYcguQ5MjUmZDBs3dV
        +ka4bpN60Ul8ny0kXohp5yqGEOvX36g=
X-Google-Smtp-Source: AAOMgpeO3nlLzNacmAF2krGganwLrdkLDOCgt+py+GEkIU1fo/j04PEM7YNOnu9e+4W8QFhPclKQTQ==
X-Received: by 2002:adf:a401:: with SMTP id d1-v6mr6579667wra.121.1532734120688;
        Fri, 27 Jul 2018 16:28:40 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7313217wru.93.2018.07.27.16.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 16:28:39 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/10] staging:rtl8192u: Refactor enum dm_dig_alg_e - Style
Date:   Sat, 28 Jul 2018 00:28:21 +0100
Message-Id: <20180727232826.28014-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727232826.28014-1-johnfwhitmore@gmail.com>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type dm_dig_alg_e is only used by one variable in the
code, 'dig_algorithm', a member variable of the structure dig. That
member variable was defined to be of type 'u8' thus negating any
advantage of the use of an enumerated type, (compiler type-checking).

The type of the variable 'dig_algorithm' has been change to reflect
its use of the enumeration and the enumerated type moved in the file
so that it appears before it is used in the file.

Additionally the 'typedef' has been removed to clear the checkpatch
issue with defining new types.

These changes are all coding style in nature and as such should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 7d7eeb1cb9fc..22e25a5cf40a 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -65,6 +65,11 @@
 
 /*------------------------------Define structure----------------------------*/
 
+enum dm_dig_alg_e {
+	DIG_ALGO_BY_FALSE_ALARM = 0,
+	DIG_ALGO_BY_RSSI	= 1,
+};
+
 enum dm_dig_sta_e {
 	DM_STA_DIG_OFF = 0,
 	DM_STA_DIG_ON,
@@ -74,7 +79,7 @@ enum dm_dig_sta_e {
 /* 2007/10/04 MH Define upper and lower threshold of DIG enable or disable. */
 struct dig {
 	u8		dig_enable_flag;
-	u8		dig_algorithm;
+	enum dm_dig_alg_e		dig_algorithm;
 	u8		dbg_mode;
 	u8		dig_algorithm_switch;
 
@@ -105,12 +110,6 @@ struct dig {
 	long		rssi_val;
 };
 
-typedef enum tag_dig_algorithm_definition {
-	DIG_ALGO_BY_FALSE_ALARM = 0,
-	DIG_ALGO_BY_RSSI	= 1,
-	DIG_ALGO_MAX
-} dm_dig_alg_e;
-
 typedef enum tag_dig_dbgmode_definition {
 	DIG_DBG_OFF = 0,
 	DIG_DBG_ON = 1,
-- 
2.18.0

