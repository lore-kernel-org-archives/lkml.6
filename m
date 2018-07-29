Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ED3C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EDC20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8Gy04vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EDC20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbeG2WkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43885 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbeG2WkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so10589760wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5vsa0KOCGtXDPKts07R2gp/2/VrWVSLUkcW4Vvzm35g=;
        b=G8Gy04vwXWpCr3e/VKuh+mNSLn45i7n2CuLiKfkEe9c7ay36hl2vodn5371uQqFZzq
         oq+nnlumfkW797hetcr+KxqMNZeBFJYDRdJ/OKN6o/VtRpJhTHw6GEGPaaRJbOas7fZ4
         JprFx3H3VNOGwTN9kzuiIrZXYnhO3o2AMZIalj/jejeJD4G8eHp4+S12NhNhNuXr5KfJ
         3DPA1oPnIGG6pi7pnEK2gkO6ILThgvfpSFra64M45CmcRE1i4a7iJOwveF5BXSCg4adc
         94FYkLH5O7UlvnpsZruPXQmy13vFVkEZpl8ATT62gy8GuHvW22vNYSH0u4eIjzLvGPzP
         7aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5vsa0KOCGtXDPKts07R2gp/2/VrWVSLUkcW4Vvzm35g=;
        b=NQBaDW/QkGVZ3Xy6GsbaQ0jUTcrhbXQj3oJ0VYqL9f8r+oZCCnhP0holhukqaEzdZK
         mKzl63/Ows0qQl04Hq+nNObS5LT0xtHru9xLiLMPL+1OMiRL3ip40uKRaDfuFdD7qPsE
         RM6UqhDlRvYS2xYENpKGZEBlLl6T053hwBTS51h7OVsopCvNcE71W+LKDD/X94oLSrzt
         2t+tl5P1QOZFwBCWsSufmXmoM6xMAv9+Yocw9UQMbUXlQkWB1Rj9T513FekzVAdnNHdm
         ybk2oJ5raILA9i8K3GBYFou5ijSCfVVbIZCsK9CPD6b1F2W1N5hltbf0R4R6Z97x+eBl
         RV9Q==
X-Gm-Message-State: AOUpUlGm37iymXPhLmL42Qfvtb21l9rq7YsJccjje9hbdSPuD20BuIT0
        DkMzP2954/gysn2cxl+bHrzDvIXXsmk=
X-Google-Smtp-Source: AAOMgpdDCvCNuLqkY7KgG6XCFnu8xqdogYNMFmGHzwaWB7u7xZ5dTEtgYOqVTOBt9RfIWCcc33uD7g==
X-Received: by 2002:adf:b1d2:: with SMTP id r18-v6mr15060341wra.79.1532898511460;
        Sun, 29 Jul 2018 14:08:31 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:30 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 07/15] staging:rtl8192u: Refactor use of enum dm_dig_sta_e - Style
Date:   Sun, 29 Jul 2018 22:07:39 +0100
Message-Id: <20180729210747.10803-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the use of the enumerated type dm_dig_sta_e, which is not
actually used for type checking by the compiler.

The typedef of dm_dig_sta_e is removed to clear the checkpatch issue
with defining new types, and the enumerated type is left with the name
enum dynamic_init_gain_state

The enumerated type defines values for the enumeration, which are used
by both dig_state and dig_highpwr_state, (members of the struct dig).
Both of those variables were defined as being of type u8. This negates
any usefulness of the use of the enumeration, (compiler type checking).

To make use of the compiler's type-checking the two member variables,
dig_state and dig_highpwr_state have been changed to being of type
enum dynamic_init_gain_state. The enumerated type has been moved above
the struct dig definition so that the enumeration is already defined
when the compiler reaches the two types using the enumerated type.

These changes, whilst convoluted, are purely coding style in nature and
should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index e86dda99c223..078770a8c7bf 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -64,6 +64,13 @@
 
 
 /*------------------------------Define structure----------------------------*/
+
+enum dynamic_init_gain_state {
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
+	enum dynamic_init_gain_state		dig_state;
+	enum dynamic_init_gain_state		dig_highpwr_state;
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

