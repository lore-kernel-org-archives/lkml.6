Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F9CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684EB2177A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/PTOFAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684EB2177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHUUgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:36:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56101 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbeHUUgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so3652767wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M9bY589X3JqdY//Yiwi8SyouDqydWJxY9KrskDcXJOk=;
        b=u/PTOFAndwRhRMdxy7KIhWZcAQhyW5xRStwgItIrZe8WCweIKbWsKsekdl8GthzbpN
         Ee9b7et8rqKuFdKnWVRcyWaDn/kTPc3uvkR37iqtaFff18elRaUOfBdZ22MlOv8W1xRX
         fOZmegH5onO2mv0jXcbRQE7i4yKvZbSkZmuFT1VLn35ZH6/5WU8YVSWCczD0BVP0j0vu
         EtHlXPMzRgpWnh2L5T75wjycEkU6QAs5HiEYfqQw8jlz3CtG5GJd/7hRmFwNtaVyGRhK
         M5zzh4srLAEhqW4bU4aPrpKHhjH+FhOsOTmlLOZOoipPbHI2DK11ZHMzFD5bdftmFPHx
         hRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M9bY589X3JqdY//Yiwi8SyouDqydWJxY9KrskDcXJOk=;
        b=HeQcr8D7NgT7inNmXcwKzYDvdeW2kD7Dpy9lqWY2JA866yB8RLvKL9WReoxcNbkwpQ
         CvYctUzRMFKVT7NP38dzlV4Zz6flOGKjWC4kAcfO969matPvQuExyPcu61vX8xwniy3o
         WKAo6VQl01uS5M1rTbleYCX982L030xj1UEBqUCD09cf4+ynV258ZZIGtOteA4Ex5+Br
         EqnK0ZOmzoqROQcRUm/KUN9qVmNeOgVp2RMeB7sHxB6H5bEfsqeF8Lc3LvF2BAkhUAKv
         imdG3kcnKFZQvaTW/Nhk2wAQ+f3RF6cZspsIhQ04g2awbS5ztotzrmbWs6ytIkSQNJVV
         xpJQ==
X-Gm-Message-State: APzg51C30u+v3fh58oxuEngSz4xj3c0PuLj5w51ro+mzGcHuVjQAm9/n
        khU73xX5BHAO6Z1b5IEefFdfK2newsk=
X-Google-Smtp-Source: ANB0VdYuS2iv5McwTn4XJpA0A4xzSs4clIcQSWzaQ9ooCK5RMTxQ0jxwLf2p2VMklBGJ2FyI/UD0RA==
X-Received: by 2002:a1c:ea53:: with SMTP id i80-v6mr168555wmh.113.1534871740905;
        Tue, 21 Aug 2018 10:15:40 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:40 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/17] staging:rtl8192u: Remove unused defines - Style
Date:   Tue, 21 Aug 2018 18:15:21 +0100
Message-Id: <20180821171537.9330-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a number of unused constant definitions.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index b6a76aae4832..8a74faedf6d6 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -2,11 +2,7 @@
 #ifndef _BATYPE_H_
 #define _BATYPE_H_
 
-#define		TOTAL_TXBA_NUM	16
-#define	TOTAL_RXBA_NUM	16
-
 #define	BA_SETUP_TIMEOUT	200
-#define	BA_INACT_TIMEOUT	60000
 
 #define	BA_POLICY_DELAYED		0
 #define	BA_POLICY_IMMEDIATE	1
@@ -15,7 +11,6 @@
 #define	ADDBA_STATUS_REFUSED		37
 #define	ADDBA_STATUS_INVALID_PARAM	38
 
-#define	DELBA_REASON_QSTA_LEAVING	36
 #define	DELBA_REASON_END_BA			37
 #define	DELBA_REASON_UNKNOWN_BA	38
 #define	DELBA_REASON_TIMEOUT			39
-- 
2.18.0

