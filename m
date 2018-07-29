Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D223EC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A0E20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSIaXSmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A0E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeG2Wka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34158 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbeG2Wk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so6720119wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BubcNjpqWKuMfV1P7oOfXs3QEXtDon6DFrRAz69gErw=;
        b=BSIaXSmW3MYJOSJhkvqkotXs/yFB/m5CLPtwOZeGXKgaVTljyeQOERuRUf/ONZHK02
         qTAh2GD3CM4Fk/PqAymCSTsoXyTn2UVn9UbW8xKH1qVb+UqqXARa5ggu9dH5kSrhXKCS
         Q+lgNG2fqyFDnTp7fyW7okMM6FWaxtw+yJYxmQIUgqElzn1zCiUbVi+Jh2+KHqwhHBqI
         qUhiXVbdNiyCep7vAu18896b1Y15sfiFn+fSzHySCkziXsCGPjgRD8BZL//93Uy8SNj9
         +s5JZ7fpcQ/k3JOZQCAg7HZKSzoTWkg2D2LcS18Re1ciorMQq7D3Oh7ZNh62aOkh56Wl
         q6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BubcNjpqWKuMfV1P7oOfXs3QEXtDon6DFrRAz69gErw=;
        b=tnq8Z3/SB+QMGpj4tvDkgIX3poni4RK/lwh4M7fpZ8AnTJ9do11npfXvR6syaB+pqL
         ncVa6s5ZuLoUrB7KnRk1fEhIPSIvXNhM8IkPhyA4EtoQIzkgzqBO9wXERH1eBK8qerv2
         YrY0UaKgsIdA+snS9rpZgR5jl+2LxpRbbu5Zt8R4WWt96+Zh7TtFDrVxvQvTVzsyCHHt
         YfFrwuvT5Jvx9veLx6RevYHjt3hScrj7lxC8UKSAFUIcAllku6DUQiswOE14lEbADoQN
         gJ+hUPQWSPylJ1nhAb1NsfjbjE5d89NqfzniVkSH9EzonV6D0eDaSb1BCPV3REuBGWpk
         lNZw==
X-Gm-Message-State: AOUpUlE3wbFeaFsIBvYvKu+fdQQuajgG3C2y2Vzz7kJpJzaWnwYV/VTK
        G2eki7wG4QC7GQ5H9EdskB1Bw/LrU4M=
X-Google-Smtp-Source: AAOMgpdfJjpfnBTCVCaajbVd9f7rTvjchMtIkig2uRXk1A0O0fka/skLosv288amGr7UMRkPbfe1AA==
X-Received: by 2002:a1c:93d2:: with SMTP id v201-v6mr12528543wmd.77.1532898515856;
        Sun, 29 Jul 2018 14:08:35 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:35 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 10/15] staging:rtl8192u: Refactor enum dm_dig_alg_e - Style
Date:   Sun, 29 Jul 2018 22:07:42 +0100
Message-Id: <20180729210747.10803-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
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
issue with defining new types, and the type renamed to
enum dig_algorithm.

The enumerated constant DIG_ALGO_MAX has been removed from the type
since it is never used in the code.

These changes are all coding style in nature and as such should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 471609819e08..9cea9b818843 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -65,6 +65,11 @@
 
 /*------------------------------Define structure----------------------------*/
 
+enum dig_algorithm {
+	DIG_ALGO_BY_FALSE_ALARM = 0,
+	DIG_ALGO_BY_RSSI	= 1,
+};
+
 enum dynamic_init_gain_state {
 	DM_STA_DIG_OFF = 0,
 	DM_STA_DIG_ON,
@@ -74,7 +79,7 @@ enum dynamic_init_gain_state {
 /* 2007/10/04 MH Define upper and lower threshold of DIG enable or disable. */
 struct dig {
 	u8		dig_enable_flag;
-	u8		dig_algorithm;
+	enum dig_algorithm		dig_algorithm;
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

