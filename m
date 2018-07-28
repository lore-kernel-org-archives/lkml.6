Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B225C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B109620878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnATyPTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B109620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeG2AnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:43:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40196 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731528AbeG2AnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:43:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so8711674wrs.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wlXd15PhfUS8yG4U5TS9F83C/I+YrgCvbVzrdjilPeY=;
        b=XnATyPTRavsEW3L4ThBVCxq3B+bERRViYMOkgM2VpGqQgAGYzZ+JYzVdBX24xGlmeQ
         6Q+Mt+xTdyZmRsacpMuqUns5pbV45Di+5FNm4hxa6Ef3BlTGC55GqT8inVISYJxG0i/+
         0lAXzptCC8+K6CDFpaGy8hIaos87/GeHvK98OX/Zhaop3aqIhefikZXSL2lvgKjH0qUR
         7KHEhUJ2ZkqxNSOLTy6KNKrrxismWDdCPWdC3ZDu3UJ5Jr9PCFP9bGMa/UnTR53gQhAN
         KYYnvRsNaSxuHpmb4PZWxoqfuJV9bTCqjfRlUOc6OotSC+2+KDFuc96u2PFJH3SqThBI
         uZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wlXd15PhfUS8yG4U5TS9F83C/I+YrgCvbVzrdjilPeY=;
        b=C8Lfo040ep9DKbAqcD/JlRYoZmpi/U0miYvRRRTxE8UacIv9UbDupeunf9jOwlaQk0
         gWh407gQNpmFYcd7taZNjKZoMRvfMvWoyp4if/pL49nkIWrajdhBrkV15SAG6qxkN7Up
         emGOGALvr/aGKBgVaMWUr8klIQNX2QNu7dQuiOwaVReGKi0ubBB7V6ZDQAXL8x1yb9wM
         iTgvXvIS+3Zh/t9E68bfEXaVQt33Jm6PsvLF8oNDp5/TrRsT39tLTN0inJH9xcrI0Iv7
         1lVLDOYwto5Cr5aVlGzYQR8SURDPuCr5CKc5CWPNTTvhUf3wkiSeCkKJQ7m1BJEaltgc
         QY+Q==
X-Gm-Message-State: AOUpUlGJgZ/4x8FyNL2WIHKikL8ZVylBDGtIv0/dfXrnjtKC2ElbGVH6
        2sDzCjTFQ2ea1dJFHwUGnGinM58X
X-Google-Smtp-Source: AAOMgpexzgP3YG4GyCyqm8n9ShbsOAV6f8POfRayo7QIOZcuDsLV0SFWyNUw5L0pSkOy8dyMRAO0cw==
X-Received: by 2002:adf:be0f:: with SMTP id n15-v6mr11331799wrh.267.1532819700701;
        Sat, 28 Jul 2018 16:15:00 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id j131-v6sm8909745wmb.25.2018.07.28.16.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:14:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 01/08] staging:rtl8192u: Add spaces around operators - Style
Date:   Sun, 29 Jul 2018 00:14:45 +0100
Message-Id: <20180728231452.20107-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728231452.20107-1-johnfwhitmore@gmail.com>
References: <20180728231452.20107-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required spaces around '+' and '*' operators. This is a
coding style change to clear the checkpatch issue. There should be
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 8ee9370520f3..92afa9dc9663 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -7,7 +7,7 @@
 #define AC_PARAM_SIZE	4
 #define WMM_PARAM_ELE_BODY_LEN	18
 
-#define WMM_PARAM_ELEMENT_SIZE	(8+(4*AC_PARAM_SIZE))
+#define WMM_PARAM_ELEMENT_SIZE	(8 + (4 * AC_PARAM_SIZE))
 
 //
 // ACI/AIFSN Field.
-- 
2.18.0

