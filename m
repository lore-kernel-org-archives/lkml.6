Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C1AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDC82172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSR9BtPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDC82172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeHGX32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32825 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbeHGX31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so184702wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oPZPR0w/lqzYzvDPp1G0kdDKhGud4YAPMSGd/hi63bs=;
        b=HSR9BtPR4KYj6eIZjgWlqXkz/RHDz4gFwzPMCxOeRUzyV3LmEQQoejDiti2zcWs33F
         mgkca/vIA1a6uky0cJhHALgGBiOlt366p9u6yQAaT6DzUZHksUgNkwVU2K/QZlaoFiH1
         SjJwYIJ1AzNedRci3l0TjeQmJodsRZ+BUDG0bMJRcQ3KzkvxFdaCwoDcL7GYCBizJ6VJ
         1LECSCZrJL1XQrgoeXM0wBMNRE19siptq5fYy+uDbCbsqdS+9oYTVdkEX+VmJ7RrHgj1
         4stvTY2+8ypf+ihYoKl8pekUoI8/0kXL+N1xmpFFnU5brWHQG/IB3ds8OjCnqE20jdqK
         jLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oPZPR0w/lqzYzvDPp1G0kdDKhGud4YAPMSGd/hi63bs=;
        b=F/GDWR2AukiQS318TH5XJqWZpyW4I9e9XUTdoPM4Y4JjgiFsq/HOxdQDnySXwpSXwE
         ALFopGDCa+YheBwyTPkYx++UW9xxxf2j+sp29vET7RkGyWr8WQ74msIalVsjchFWciF8
         Ac2gkgwTZN2xiWDctatwrHkdB7I8gDYTdIIRCYEd9urfVcoyXj1f0U5dbZ3xuIh56NG9
         kgb0XRc/XFI5OIi75ubplDynxaPh4GMY9auHlN9GTYbewU1wEoFhJzCAAArwjLY/FkEb
         Wx6HIKF5t0KiH5kWqsCDf8iEdaMqfLwSboaJrmiqPNB2P0JWVvtXV+sLzlSOBNkaKPRx
         pY3A==
X-Gm-Message-State: AOUpUlEHasXwdUBelkNxhw5O/ofBeStHoGqq4HKkLqRyX7aNnBcr5+9k
        pfKvpKkD/IgmCOkWdl5i3LiZ3dnc
X-Google-Smtp-Source: AA+uWPwpFSytQ4GNKpwrG//7nlxv+hZjCkv3eAdnanVXeu0CyslbfjpoXgqwup3QF215bWdaryCNSQ==
X-Received: by 2002:a1c:bb86:: with SMTP id l128-v6mr63136wmf.26.1533676389194;
        Tue, 07 Aug 2018 14:13:09 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/17] staging:rtl8192u: Rename macro parameter __pIeeeDev - Style
Date:   Tue,  7 Aug 2018 22:12:44 +0100
Message-Id: <20180807211255.29343-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
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
index a53f6454262a..01adf747f7c8 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -37,17 +37,17 @@ struct rt_dot11d_info {
 	(des)[1] = (src)[1], (des)[2] = (src)[2], \
 	(des)[3] = (src)[3], (des)[4] = (src)[4], \
 	(des)[5] = (src)[5])
-#define GET_DOT11D_INFO(__pIeeeDev) ((struct rt_dot11d_info *)((__pIeeeDev)->pDot11dInfo))
+#define GET_DOT11D_INFO(ieee_dev) ((struct rt_dot11d_info *)((ieee_dev)->pDot11dInfo))
 
-#define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->enabled)
-#define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_len > 0)
+#define IS_DOT11D_ENABLE(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->enabled)
+#define IS_COUNTRY_IE_VALID(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->country_ie_len > 0)
 
-#define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eq_mac_addr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
-#define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cp_mac_addr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
+#define IS_EQUAL_CIE_SRC(ieee_dev, __pTa) eq_mac_addr(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, __pTa)
+#define UPDATE_CIE_SRC(ieee_dev, __pTa) cp_mac_addr(GET_DOT11D_INFO(ieee_dev)->country_ie_src_addr, __pTa)
 
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

