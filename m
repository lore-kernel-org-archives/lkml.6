Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70299C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC3F208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8LaIZvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC3F208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389265AbeG0Syu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51877 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388886AbeG0Syt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so6049312wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=npAefTkhd79j7IQDevEAHM8ezvNcbSttP0k8RL6iTe4=;
        b=C8LaIZvtZOrRuttJWLQK1zjC+2OrLdBKbuujxflXWOoBSRt7Y15jr7wLzVss05yjMi
         9oD6Lbi6bhcNap+R8kbZ7blfU38g/HYSMEvWakGeu6ayBgvN5MeqSu5J4hq/NoAM4gMP
         0lPXWRk2Esavoj22T4HEEN88IPisAEVCwk4maP7SVJh7/XLgb/WfjgnjgN7ieG6liZIn
         j+TQ6ns+bpcpqhxVW1BsBEEw8aiQvvyOBVBKs1ilIBiy2XiMbkPSEt/baSFyixXBCoXi
         eEr2Xjn3VqYoZkJndqGwfYnUOd7AJFS0jyvGURsSGg6C3FjB8XGu3Tb7b5OHTpOg4oJj
         ab3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=npAefTkhd79j7IQDevEAHM8ezvNcbSttP0k8RL6iTe4=;
        b=KonU2EHObaEC9iit4iv2avEuPj1GRvdS2rP8hXP5xyN14hzLRAcr8fsTXJnRK3uxim
         uExrjOmAwvuO2ZdOWmh23pyr/uFGU5sJSzmhLx9J1c3A4T6rK5Lh1iqW9I5cEKY4IH1f
         DUU50RIOAw3LFYFXtY7GwtLz39z+bGiQvfeirV5tDNqC3P3K6PPwq9YQVwZaLdAvLDMq
         G9My9VZ+VBJHym77ALgdsEVU6c8EqWeJP7ZZn0I3Ufv5CnjdF8YCSzMy/KdhR+6GphLJ
         3UVEw5pPL9MhiMRhuuj6KrcaTLHNEbgmoCK/im9JvkTTT49+6WNAYH7NYE/yzS3Jhvpv
         7Rpg==
X-Gm-Message-State: AOUpUlH58iFv+m4MdoiMIneL2m5ooMfeSkCD9BwK9qb9NtP+KwLjO59S
        pYO/6bHUECXvpMUwSYe2XiGx/kKNyik=
X-Google-Smtp-Source: AAOMgpe829zAc8pntDP2nTGO/eJrD3P/LOybYJVTRYLdRsqVsFva0rQS3JXiESEks0P9S1tWJ8k1pQ==
X-Received: by 2002:a1c:af0c:: with SMTP id y12-v6mr4853334wme.87.1532712715434;
        Fri, 27 Jul 2018 10:31:55 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:54 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/20] staging:rtl8192u: Remove commented out code - Style
Date:   Fri, 27 Jul 2018 18:31:14 +0100
Message-Id: <20180727173123.27391-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove commented out sections of code, specifically for a structure,
QOS_DL_RECORD, which no longer exists in the module.

This change is a coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 53203e633c0b..2840d6e8dfda 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -31,7 +31,6 @@ struct tx_ts_record {
 	u16				tx_cur_seq;
 	BA_RECORD			tx_pending_ba_record;	/*  For BA Originator */
 	BA_RECORD			tx_admitted_ba_record;	/*  For BA Originator */
-/* 	QOS_DL_RECORD		DLRecord; */
 	u8				add_ba_req_in_progress;
 	u8				add_ba_req_delayed;
 	u8				using_ba;
@@ -49,7 +48,6 @@ struct rx_ts_record {
 	u16				RxLastSeqNum;
 	u8				RxLastFragNum;
 	u8				num;
-/* 	QOS_DL_RECORD		DLRecord; */
 };
 
 
-- 
2.18.0

