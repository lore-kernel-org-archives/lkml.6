Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ECFC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396AA20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIeSv/e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396AA20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389390AbeG1Aw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:52:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47038 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389317AbeG1Awy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:52:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so6553867wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iFZbODAXmIOMf+KTSzdHOMhDJ6FWaRDKAVnuHltjmDM=;
        b=iIeSv/e16Ax9rQAP9ebslOxOczFQvb6CLU1naWZPeJGhKtNWOTCmnAr77t9YeYWe25
         Io3e8yMaTWwp7LpjalF5q7y7YWXaVTmScvnd4UFT7Wxs4LqEMlWNsFLeSULHWJYpv31i
         HGcgY5RHQrWk5s0zDW85tp+FBTNMHe/vrGT1pEd1W+8vOHvyB9KZxKhyqNpk66oew2u0
         OkIUruh+FKxLDR/E9dMYkffR3oslc6dFmQFuvwQ5ItGNKVbtvu+TxIQhFJDOeM1m/iUq
         iDKJ7B9NZmCvDIpEomgiEQdIrdlQjouA64eKDI3G8Ion/37mpOFvQ6m7cve8WrSKCy6B
         yb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iFZbODAXmIOMf+KTSzdHOMhDJ6FWaRDKAVnuHltjmDM=;
        b=PjbOWyKSOiXozPpQtEJOdgHM0mqFy5b3DBQtgDdYs7ydc0OxExBKvPO2x3yZ5zfjwp
         2TcN4fS++xGZMynJknVpL8PLT5jn7PMgZ0NrD4V/M7YE0tvn21qwvpnwnmcgYhvYB8td
         vWOf0Fkpe/j2S/ynu2H+3SyDwaKLcK+s8WFfeYfaKlCt6uyu1wDIuZE/884jyMEjR7Tc
         AGithfGL3cgp8p96Zq4xEpW2E2LVfdIO90/egprlL7G2h3TMjTm/gCfBFum8+WZFppnr
         foW142LD41Smzwkuu/REWJDGm4pKL5rpu2lltv++LFZZjZsWtuHnZs2yg6XHf/YhdHID
         Cn0w==
X-Gm-Message-State: AOUpUlHx/9ZsxYA00fsWLacqP+d6nNmkAaeYmDh3ii5vDstQQly+g+VA
        kZq+k4pPH86LrZm5Qzoc3yYoxEPuCh0=
X-Google-Smtp-Source: AAOMgpfhTfycgi0umRt6D7Ni869MEOIhpz6OCAeU7E/L1yJBMPyTkJCwDRq+BiDWJh45SEF6T4bkWg==
X-Received: by 2002:adf:97d5:: with SMTP id t21-v6mr7060208wrb.28.1532734124810;
        Fri, 27 Jul 2018 16:28:44 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7313217wru.93.2018.07.27.16.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 16:28:44 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/10] staging:rtl8192u: Refactor enum dm_dig_pd_th_e - Style
Date:   Sat, 28 Jul 2018 00:28:24 +0100
Message-Id: <20180727232826.28014-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727232826.28014-1-johnfwhitmore@gmail.com>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type dm_dig_pd_th_e is never actually used as
the type for the two variables which use the constants, which the
enumeration defines. This omission removes the possibility of taking
advantage of compiler type checking.

To correct this the two member variables, (curpd_thstate & prepd_thstate)
have been changed to use the type enum dm_dig_pd_th_e rather then u8.

Additionally the enum's declaration has been moved above the dig
structure, where the type is used, the 'typedef' has been removed to
clear the checkpatch issue with defining new types, and the value
'DIG_PD_MAX' has been removed from the enumeration, since it is never
used in code.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 825df06e17a8..41b08211e958 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -81,6 +81,12 @@ enum dm_dig_connect_e {
 	DIG_CONNECT = 1,
 };
 
+enum dm_dig_pd_th_e {
+	DIG_PD_AT_LOW_POWER = 0,
+	DIG_PD_AT_NORMAL_POWER = 1,
+	DIG_PD_AT_HIGH_POWER = 2,
+};
+
 /* 2007/10/04 MH Define upper and lower threshold of DIG enable or disable. */
 struct dig {
 	u8		dig_enable_flag;
@@ -99,8 +105,8 @@ struct dig {
 	enum dm_dig_connect_e		cur_connect_state;
 	enum dm_dig_connect_e		pre_connect_state;
 
-	u8		curpd_thstate;
-	u8		prepd_thstate;
+	enum dm_dig_pd_th_e		curpd_thstate;
+	enum dm_dig_pd_th_e		prepd_thstate;
 	u8		curcs_ratio_state;
 	u8		precs_ratio_state;
 
@@ -115,13 +121,6 @@ struct dig {
 	long		rssi_val;
 };
 
-typedef enum tag_dig_packetdetection_threshold_definition {
-	DIG_PD_AT_LOW_POWER = 0,
-	DIG_PD_AT_NORMAL_POWER = 1,
-	DIG_PD_AT_HIGH_POWER = 2,
-	DIG_PD_MAX
-} dm_dig_pd_th_e;
-
 typedef enum tag_dig_cck_cs_ratio_state_definition {
 	DIG_CS_RATIO_LOWER = 0,
 	DIG_CS_RATIO_HIGHER = 1,
-- 
2.18.0

