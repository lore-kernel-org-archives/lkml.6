Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9E7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B9F2172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVRdc/zF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B9F2172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeHGX3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33243 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeHGX3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so92379wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KG0iO52wV23ZkurK9M6iTcKO3QZpryLy38619kBa5Ks=;
        b=XVRdc/zFaTMx4WLCp99550tTrP+Eoh6EcJkmmyCCJ/E8wO4ta6EzPRFpj/FowRS0ME
         /44+wU4X3Xf00nZ7V60cYE53J4w6Q9JT+R14TCvDpqZiMYZdN8nACXvAR4JjPWj59Js9
         y2RE5t1yFfxn5hkB6rMsuniF3zZLJ5CEQgWdyk27HbEGazHKE+IXu/NOUKFsQZeCyQC4
         3PjmWaVPy0D55BYnZeqFfaCopkPxQBXuH262TkD7w/k3DWGmHIQohHsyNmSqYozupQUo
         NkFeKCeyaLNpi+41I1RrofznnSnSLKeehqW17ZOS6TSMHKtT2MpI6wuZpE/gNrmNFCZI
         Dv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KG0iO52wV23ZkurK9M6iTcKO3QZpryLy38619kBa5Ks=;
        b=lo3a2vGJvDdlViO4qm9J9hoRzjPo2RVYCs6ulyB2REMJyXr4+tBjh/Ejcoj9VBq6VC
         uVXQpEWgVeRJ713pBv58lzwdhPUuXAfpbjOSKt0Sckv0uFew2LiKZSISXf2YUTqHVznO
         hYRjilb9eWD+e6DNkcgaOGakHtCy1VJ/oE2bxwtl9RgU/9gs+wCq3EpHD/M2fN2ONGfv
         gx2ddJVz8RrZsIgo8ZarAmDgFUwZgW5sYGtokmIj86ceZP7FH/cn3pCYEjecyRRVKSP7
         m8k1hCVa0FLontkYS52aDe9YqgxE+Ahh37k1xvRzpjVZC1/JfIf5DBkI9GgxC7Rt75Lr
         nQ1g==
X-Gm-Message-State: AOUpUlEX5JNOcjWpl8toQR1dXzbp8kCNHb5RGIhgk6Bdp3SWcO5s/c6g
        InbIhjKrV42mn4qVluV/iyH/7eTh
X-Google-Smtp-Source: AA+uWPz2uIO9W6fx3BnUjYHejowM9sg7WmPvOeMFWNXbabycS+DVOfbsS4BY1nNNYeqLbu3KrgV5qA==
X-Received: by 2002:a5d:4985:: with SMTP id r5-v6mr61648wrq.116.1533676384646;
        Tue, 07 Aug 2018 14:13:04 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/17] staging:rtl8192u: Remove unused macro definitions - Style
Date:   Tue,  7 Aug 2018 22:12:41 +0100
Message-Id: <20180807211255.29343-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unused macro definitions as they add nothing to the code.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 8d4d5e582782..363a6bed18dd 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -45,18 +45,10 @@ struct rt_dot11d_info {
 #define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eqMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
 #define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cpMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
 
-#define IS_COUNTRY_IE_CHANGED(__pIeeeDev, __Ie) \
-	(((__Ie).Length == 0 || (__Ie).Length != GET_DOT11D_INFO(__pIeeeDev)->country_ie_len) ? \
-	FALSE : \
-	(!memcmp(GET_DOT11D_INFO(__pIeeeDev)->country_ie_buf, (__Ie).Octet, (__Ie).Length)))
-
-#define CIE_WATCHDOG_TH 1
 #define GET_CIE_WATCHDOG(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_watchdog)
 #define RESET_CIE_WATCHDOG(__pIeeeDev) (GET_CIE_WATCHDOG(__pIeeeDev) = 0)
 #define UPDATE_CIE_WATCHDOG(__pIeeeDev) (++GET_CIE_WATCHDOG(__pIeeeDev))
 
-#define IS_DOT11D_STATE_DONE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->State == DOT11D_STATE_DONE)
-
 void
 Dot11d_Init(
 	struct ieee80211_device *dev
-- 
2.18.0

