Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D846DC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9306F20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyAU9rrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9306F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeG2Wka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37981 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbeG2Wk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so11405672wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jUKSEExy78DYrfT6hXQo422B6f3+/v8b2xmUwQ1K7iA=;
        b=kyAU9rrVhhLOcHSThIUEZHR7B9qVbJSKk+65zltVQcvasZUFwA5DmA7w0nOPvFtcRE
         MpJNZnfqj3PUE+CccVB/PA2Tbz3geMfGlJ+rDfx0DOYt6+32m3cAOQtToXJV5WT+UMvW
         RfwGGdDLjESCv9DHuyOaF37kQIfZwvu+gQLtIiG8DO4w3+zkVLErar5hnowpQlXjsxBi
         z6o69tdduW7w/Zjo2txi4/D3t5D9aTU/82uWN3H6o/P/KHx2Py71BDo5rNub6AID7xSQ
         8pemjLr5Fp/F9W96JZAIisIgrcyHpiLClYeEwhawiN/H214XgTmLXqRbXnW3jDdu2+sC
         3AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jUKSEExy78DYrfT6hXQo422B6f3+/v8b2xmUwQ1K7iA=;
        b=JmTNeOeSy87JVIcKs9Z5yRoxw21LH4HBp84upJF7Blmp49AbzcWB+02GAFEPPUIPcR
         7ExXhQ6Mz/AAutCWnniLdYAs70K+Io3jn1saKwVwLNt9cZ4/p7Ahc91g66WNnrjdTrQh
         fYT4jJpB1NoizQ9Y+lsL5qQ/h6hc5txiQwWSUqlAxAQURy8x7hfLc4OVGu5gt9e9zAnO
         RbP/DkjHcT0xmDoM/OR8XQsN/Eoz4t3CQ+icguP4Fb8qU/tXEZUaCetsTjJ1KqIzqm7Y
         lwngNWyqr8mN4gi6RnSrRdi4zGGYXvymqqTPe2skrkBOhI+s4hCWKNXAPzb/DWB1eFPK
         6YcQ==
X-Gm-Message-State: AOUpUlE3yepWBZDUQKndlTI1yyRlLPNSJ5weJ3FGWtstDbAAQ8g5+78o
        kDNJNW+GU4Tkzy/3A7NbawD6MNhOesc=
X-Google-Smtp-Source: AAOMgpfbLojj2X0TgQW9fYGKhmE4xLVjpr4exyV5NUJ9RNiiOeCoSKwg/slzwAsV+mTTrtZpDUzmpg==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr13422372wmf.114.1532898517191;
        Sun, 29 Jul 2018 14:08:37 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:36 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 11/15] staging:rtl8192u: Remove unused enum dm_dig_dbg_e - Style
Date:   Sun, 29 Jul 2018 22:07:43 +0100
Message-Id: <20180729210747.10803-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type dm_dig_dbg_e is never used in code so has simply
been removed from the source code.

this is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 9cea9b818843..c15faa428b1d 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -110,12 +110,6 @@ struct dig {
 	long		rssi_val;
 };
 
-typedef enum tag_dig_dbgmode_definition {
-	DIG_DBG_OFF = 0,
-	DIG_DBG_ON = 1,
-	DIG_DBG_MAX
-} dm_dig_dbg_e;
-
 typedef enum tag_dig_connect_definition {
 	DIG_DISCONNECT = 0,
 	DIG_CONNECT = 1,
-- 
2.18.0

