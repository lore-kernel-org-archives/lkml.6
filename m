Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB66C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3A121A5D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvVuMCmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3A121A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbeHHXW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33887 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731552AbeHHXW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id h1-v6so1901881eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q1EkejcigdsLrY0TPVf3ZGhwDU42h9wR7TjDz9vDn0M=;
        b=YvVuMCmmSLrUnTqCgB6a+Dr99Pt271H000AfAd5TgSUCu/zFOZFguIlJbRQXSKZjJy
         QJtDPGJ8EBF4bRkzVyIvYg3MfpZ0vL1B0f2woks9B/oL3LGzAxOm6SCM7vkIrRL2YzSc
         KDZlTYejpo/d61njR+XA9iKGOGwtAiVopI60Yd1m1hA+w2ovUfvYPvuXrPkqromVZUoa
         jDa1ikGBH9wL2tocrQPCkH2K+7nkgYa6FmqhA2dVtwJyv3DvEQuQUUByZh/IyJVT2lyj
         M+Vb+Zh/JQHO5L9KGQM2g6ELpg2lPDNgziiCQrar2PnnSXEzjkKOVEV+1dZxXsPB1oNF
         qymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q1EkejcigdsLrY0TPVf3ZGhwDU42h9wR7TjDz9vDn0M=;
        b=AWQ0wdLRCE0gSPLkc6R7I/sXei6YezJ4mgMk4iGaqtjHjleToZBbKMKPcx8Ua7TmNU
         Pbe+TGdjIC+TyzWC6bDJN2PJFWy40fiWq0aq9TIZQmLwOb9W7TrW1veNrSTf6EQ0hzq8
         OqoR0xhxjyp6wgYv/2QQkQK5hL2rQRhzaG2Ig0Syaqy9guiamFmmmKt6RTND+fyss/Ph
         iyqozJC8H7SsmBySLfnk0yHoC8xa1wBYJrBVVaDoJkbPMYgc9FA3pocEjw6KJ5S61qT4
         OAkfwrPU1K9juVMUE9zUHaclunXwcbZCHkSiVZXk4ulb4yocrOrHQe4zwUeplt9Y0Oku
         RZrg==
X-Gm-Message-State: AOUpUlHUg/pPMbiD0pdAQHBiEH/lrGr4OWYs2C+QUtr+y7kVqOwg/jz1
        JSf2cPFbXMca+Nl0R0fpaBTwWYjUibo=
X-Google-Smtp-Source: AA+uWPyeXgH6tbPJXJ6AIRU+jUIkudT1cCXpR5hUYtd6blhHecev/mKv3MPZnhBl8hKetM3BCURNag==
X-Received: by 2002:a50:ec0b:: with SMTP id g11-v6mr5039241edr.38.1533762061489;
        Wed, 08 Aug 2018 14:01:01 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 04/15] staging:rtl8192u: Rename macro parameter __pIeeeDev - Style
Date:   Wed,  8 Aug 2018 22:00:25 +0100
Message-Id: <20180808210036.22580-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple macros, defined in dot11d.h, use the variable __pIeeeDev as a
parameter. This name causes a checkpatch issue due to its use of
CamelCase naming. The parameter name has been changed to ieee_dev to
clear this issue.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 4ef609abc68b..0f0e10fa645d 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -31,17 +31,17 @@ struct rt_dot11d_info {
 	bool enabled; /* dot11MultiDomainCapabilityEnabled */
 };
 
-#define GET_DOT11D_INFO(__pIeeeDev) ((struct rt_dot11d_info *)((__pIeeeDev)->pDot11dInfo))
+#define GET_DOT11D_INFO(ieee_dev) ((struct rt_dot11d_info *)((ieee_dev)->pDot11dInfo))
 
-#define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->enabled)
-#define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_len > 0)
+#define IS_DOT11D_ENABLE(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->enabled)
+#define IS_COUNTRY_IE_VALID(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->country_ie_len > 0)
 
-#define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) ether_addr_equal(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
-#define UPDATE_CIE_SRC(__pIeeeDev, __pTa) ether_addr_copy(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
+#define IS_EQUAL_CIE_SRC(ieee_dev, __pTa) ether_addr_equal(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, __pTa)
+#define UPDATE_CIE_SRC(ieee_dev, __pTa) ether_addr_copy(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, __pTa)
 
-#define GET_CIE_WATCHDOG(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_watchdog)
-#define RESET_CIE_WATCHDOG(__pIeeeDev) (GET_CIE_WATCHDOG(__pIeeeDev) = 0)
-#define UPDATE_CIE_WATCHDOG(__pIeeeDev) (++GET_CIE_WATCHDOG(__pIeeeDev))
+#define GET_CIE_WATCHDOG(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->country_ie_watchdog)
+#define RESET_CIE_WATCHDOG(ieee_dev) (GET_CIE_WATCHDOG(ieee_dev) = 0)
+#define UPDATE_CIE_WATCHDOG(ieee_dev) (++GET_CIE_WATCHDOG(ieee_dev))
 
 void
 Dot11d_Init(
-- 
2.18.0

