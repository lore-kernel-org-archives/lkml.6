Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126C7C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EB725811
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgU+8xM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EB725811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755624AbeF3Lg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 07:36:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36606 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936427AbeF3Lgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 07:36:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id u18-v6so4424877wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=avxRk7VC/JqDf6hUBqvHF9SquRaLSUvzKVwQUVSomDY=;
        b=RgU+8xM5JvKXg/MTY+VEr9K1W3ypJWMktZ4NYizVlSZPlJnuKgnUElJgCgJ3Ckaxln
         jEu+w74dRSG8v7RPYKr0yDGP+cl7gWB1aCZcwTcrUYJWNeTu+SdOlKNo0EfjLl0FqTJg
         8pHnaV4kuE63Mxk3r7BElZJd08vlTsOZNyFwTYJMCQv0tLSN3lHJXkJC0VcV2HMf3B9Y
         ZxWsTYCE/k58kNKkj/78ymy1cB6nWqUuJjmKIMh4l+mCFwX4VBXwGLuk+rfy1lxU1uMH
         PY52hCG17uWxW1PAt5VDvdZqDxA8SpMnjEX17PVgjoVg2rRqRt/iOdPk7CXsUvTZr7hm
         y3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=avxRk7VC/JqDf6hUBqvHF9SquRaLSUvzKVwQUVSomDY=;
        b=lRGSVWOF5v0izGsaMFPi8zmnW42lLBhlSItD96DAOZ9eEOfd9hVRxqrB1/VUrzw7fh
         n+0i6fryg7k8wu3+GlX0cVlxASv//EqZtH6IK6Y7c+I907FhhiGmbSzqsa5mY7I2rBa/
         8Q3r+fUunde06BkAaVP92EQ+62d5RNPA1nrYJuXPzH/SmEnbJeqGM1f9CJKLAMABB6yw
         6uvuySa6CrXOqrak16tDeDYQYA7JURDeiMV3HrSnxgMep1Q+NPogII+adNsxRBGOcKrU
         r7FvPteqdZ8HgrbDe2QVdM1mbUYxg5nu93tRssJoVePXuvCK2KnBs7g3BATIs08Sd6Jx
         ReqQ==
X-Gm-Message-State: APt69E2+zl5xO9CWZevj78ooZEuEWkKoeLPbCd8DgtydcxWhzQ2S9u55
        0F5Dt/+/yIDhFAJxgBl0ZT0=
X-Google-Smtp-Source: AAOMgpdnGUwCWNfctxXRuze5fsQmSgQBQA0PKBIU1cD4XqCqlkOIO26G2+wCnEHA8awoZm67Z1O+WA==
X-Received: by 2002:a1c:e3d5:: with SMTP id a204-v6mr3990704wmh.20.1530358607469;
        Sat, 30 Jun 2018 04:36:47 -0700 (PDT)
Received: from arch.localdomain (x4db215a8.dyn.telefonica.de. [77.178.21.168])
        by smtp.gmail.com with ESMTPSA id s184-v6sm3733848wmf.5.2018.06.30.04.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 04:36:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        schwab@linux-m68k.org, Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/2] staging: rtl8723bs: simplify if else statement
Date:   Sat, 30 Jun 2018 13:36:28 +0200
Message-Id: <20180630113628.18231-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180630113628.18231-1-straube.linux@gmail.com>
References: <20180630113628.18231-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify if else statement to a single function call
by passing the variable.

Suggested-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_btcoex.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
index e56502e301ec..35310e8e0806 100644
--- a/drivers/staging/rtl8723bs/core/rtw_btcoex.c
+++ b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
@@ -115,11 +115,7 @@ s32 rtw_btcoex_IsBTCoexCtrlAMPDUSize(struct adapter *padapter)
 
 void rtw_btcoex_SetManualControl(struct adapter *padapter, u8 manual)
 {
-	if (true == manual) {
-		hal_btcoex_SetManualControl(padapter, true);
-	} else{
-		hal_btcoex_SetManualControl(padapter, false);
-	}
+	hal_btcoex_SetManualControl(padapter, manual);
 }
 
 u8 rtw_btcoex_IsBtControlLps(struct adapter *padapter)
-- 
2.18.0

