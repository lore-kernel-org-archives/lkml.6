Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CFC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129C4208A1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scqw6Jiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129C4208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbeG2Wkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52151 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbeG2Wkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:33 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so10954141wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d+/Nr+HczgTe9aJw50VdbujcfkdYPhHGBlYLzqkfvUc=;
        b=scqw6Jiw3oo1L6cb51OKhGYOlHvnKe4ylKq0D8/7tCCILmZDMwMtgF2qZ5CXAk6gn1
         0UsgY9JOBYEtJ8FMHxnn72/MC6IAJlFa753YtOcWSOTakO+KiGjvgif7NfkeWRFtIsAI
         /U64KULBCYIj4eff2igIXt0zGZ7E8LViRe3gzBk43G7pF/R/kuaXuKOItGynsH32E4WO
         jl3isx6Ewk1I4g5VD66Z7UJ+QAfItX3XAf7VD7hxHGlI/+L3iFgzkmJll5EckAKcUgkh
         sNDS7xKJCJqahcBB51ksJZHpf2bkAMg6R78V95tSEEr1zsfmqxtDQ8oG/56EL4cNZVAH
         jELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d+/Nr+HczgTe9aJw50VdbujcfkdYPhHGBlYLzqkfvUc=;
        b=Q7VY4DB3r55CLIRFDSOOVx3v0ulqbJCZnvH/WHRT0q0zLXVEbvVnrQPUqRQGYJOhG+
         JYTytzGKe/zPCqAFBD7bXuy7pyiegKrE5s26REhGXQH5eInzgU8mpswttMK2H20/NvSI
         zfQJ0zfhBGlBoBoNLqYh1aglWLC2AmbxJKtavboz3M4ZBmEmLjaZbWj6DYLDryuScR2C
         t32ce6gCL4kTBQpe8/tuqQcuf27J4eCq9cPOG6uPWBPidmsd4dFR117ky79jygfKHPBR
         TXKAWJfMNK7FkjjGb5aaxTVjGJdr6E/NOvDl1oePTdQf1rK6e7LGCsSeL7d8HtM3CeLh
         npBA==
X-Gm-Message-State: AOUpUlEeYDP0PSkm+muORqVe+iWfFQOj792pvJ/ZfKTefBfWXPZp7sd0
        CBpR6AkfmC2q8AcUT6y6DFkL0aKaUy0=
X-Google-Smtp-Source: AAOMgpd0JXSp81GCyPpfOUPrA0u7qTx8YGRgOrKKpbvVJw3qCR336pyL/9tK2mPNORcmitjqkJVb8g==
X-Received: by 2002:a1c:790b:: with SMTP id l11-v6mr12359570wme.66.1532898521579;
        Sun, 29 Jul 2018 14:08:41 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:40 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 14/15] staging:rtl8192u: Refactor enum dm_dig_cs_ratio_e - Style
Date:   Sun, 29 Jul 2018 22:07:46 +0100
Message-Id: <20180729210747.10803-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type dm_dig_cs_ratio_e is never actually used as a type,
but only as a collection of related constants. This is because the
variables, which use the defined constant values, are defined as being
of type u8 rather then tne enumerated type. This omission negates the
possibility of taking advantage of compiler type checking.

To enable the use of compiler type checking of the enumeration the two
variables, (curcs_ratio_state & precs_ratio_state), which use the type's
constants have their types changed from u8 to enum dig_cck_cs_ratio_state.

Additionally the types declaration has been moved above the dig
structure, where the type is used. The 'typedef' keyword has been
removed from the type to clear the checkpatch issue with defining new
types. And the constant DIG_CS_MAX has been removed since this is never
used in the code.

These changes are purely coding style changes and should not impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index f9d75ad9eaee..f0e259ddea5d 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -87,6 +87,11 @@ enum dig_pkt_detection_threshold {
 	DIG_PD_AT_HIGH_POWER = 2,
 };
 
+enum dig_cck_cs_ratio_state {
+	DIG_CS_RATIO_LOWER = 0,
+	DIG_CS_RATIO_HIGHER = 1,
+};
+
 /* 2007/10/04 MH Define upper and lower threshold of DIG enable or disable. */
 struct dig {
 	u8		dig_enable_flag;
@@ -107,8 +112,8 @@ struct dig {
 
 	enum dig_pkt_detection_threshold		curpd_thstate;
 	enum dig_pkt_detection_threshold		prepd_thstate;
-	u8		curcs_ratio_state;
-	u8		precs_ratio_state;
+	enum dig_cck_cs_ratio_state		curcs_ratio_state;
+	enum dig_cck_cs_ratio_state		precs_ratio_state;
 
 	u32		pre_ig_value;
 	u32		cur_ig_value;
@@ -121,11 +126,6 @@ struct dig {
 	long		rssi_val;
 };
 
-typedef enum tag_dig_cck_cs_ratio_state_definition {
-	DIG_CS_RATIO_LOWER = 0,
-	DIG_CS_RATIO_HIGHER = 1,
-	DIG_CS_MAX
-} dm_dig_cs_ratio_e;
 struct dynamic_rx_path_sel {
 	u8		Enable;
 	u8		DbgMode;
-- 
2.18.0

