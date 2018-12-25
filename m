Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4976EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EBD2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lJhmDPPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbeLYIQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 03:16:35 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:36298 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeLYIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 03:16:35 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 6BB4FBDE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 08:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eE-QBYkj2JxU for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 02:16:33 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 376A2B35
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 02:16:33 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id 135so16347653itk.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 00:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WbmFsVQO4DoN05WcRqHohE7yWiCWGo6Qyy+3eJ7IH5o=;
        b=lJhmDPPRK7HaiDr26Oex0/Hi73eRQTSO2kl2mroCLsG3uBo4Wi2506wtlqlASOFH0T
         rSjnq5TxWh3InkYv89JIiORid0Xx1Co5cielYt7dcN9yATrWi4PIjCS7xgnZNG9zyNlr
         aJZ1VbZGUi3hv5xNSNDLzII7+YFUp3wyDvyJdRkg/h1/IMnztiXLqOIjyp3vx30wob3c
         Su9vXs/xmpc6Kdkc3Mk5MlfxIKmlyq4dzlVTu3eMBh9PJ/RlXrvj6CrZ3a6dmNwf9qoC
         5Zeu2cBcuAahJN2gpTmh8m6ZLVRtx3U6aqfP3+0r8LneyTnIcUt5gPty/XKFvl95X61B
         8ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WbmFsVQO4DoN05WcRqHohE7yWiCWGo6Qyy+3eJ7IH5o=;
        b=ifw98k5fAYi2MccalKMMJVCzM+wX1TtBvIrNaIc+3PTH3o6YsU2Qkr6E+mp7h/no8Y
         3kMxMLMxt9u7+Acu3rAvphaiEg/dfdYLMZE1XjM8MWV3wlv58fcHd2Bhme2w36azeAZB
         L14VL/oV07A7S9UXqe65z+e44k84bdMUtAIrdxdzxiKqV4rVWzzb4haCAqqBwyWn8pf+
         YetJqXft7tDpXeIQ9DEJGAXd0fCuodphvcPcxWVwYMNbs2t/FbqqRe83mHKmG7t/vE2m
         6NypfcRvl0PHBPMfg5Z5Q4p438UaQwBrb5sh7Ny43hRXRDh7GJZC66Cm/UKGNzFPXJ5j
         AxKQ==
X-Gm-Message-State: AA+aEWaGRPfe43NhzOSr3U8SA+vebjcOkM77fkec60bCHbSseczZygdR
        Im6bfkbM8BzfTnlhq3PuAjoSJQuW19Cta0khm3gPCZLedUL8mORXf6KMY4SVzA3EABdEyC16eTw
        9ITPSkOTrNJ6UBM3aU+CchBHdScIs
X-Received: by 2002:a24:1c04:: with SMTP id c4mr10615656itc.79.1545725792454;
        Tue, 25 Dec 2018 00:16:32 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6op6aiO+vymqXsAafLobAcMYCSvzbZtbDgMPTV0tf0jBNbXW2OHcMokIKWZJEMV/r2mxjGFA==
X-Received: by 2002:a24:1c04:: with SMTP id c4mr10615651itc.79.1545725792233;
        Tue, 25 Dec 2018 00:16:32 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id 14sm10542699itm.3.2018.12.25.00.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 00:16:31 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: add a check for the status of mc13xxx_reg_read
Date:   Tue, 25 Dec 2018 02:16:05 -0600
Message-Id: <20181225081606.68273-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mc13xxx_reg_read() fails, old_adc0 could be a random value and
should not be used. The fix checks the status of mc13xxx_reg_read(): if
it fails, returns with its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/mfd/mc13xxx-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index f475e848252f..d0bf50e3568d 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -274,7 +274,9 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 
 	mc13xxx->adcflags |= MC13XXX_ADC_WORKING;
 
-	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
+	ret = mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
+	if (ret)
+		goto out;
 
 	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2 |
 	       MC13XXX_ADC0_CHRGRAWDIV;
-- 
2.17.2 (Apple Git-113)

