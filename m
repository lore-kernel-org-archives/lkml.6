Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6706BC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148F2206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx4p44DH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148F2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbeG0EAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:00:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46211 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeG0EAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:00:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so1207253pfn.13;
        Thu, 26 Jul 2018 19:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lhLdPSEjtof4PARL+jbQIELKrc8oApgcCwcTjMgi6lY=;
        b=Gx4p44DHIITEfz0JssWbN9Ri2R4PqAW4PQPfpRs9qLzFwmCVsJ2mrRxk3ei7aYJJuS
         /PHmnBiuqywk5SRxSNsnz7CC7VWW1atACA6bC8nspjwC/Z8xJ1Eyb60bNy8IPx7gjli3
         K3Vvnle7tNt+fZhnfHWagFr+HmDzeOI4BtS5fZ/JE7pXtTIZ6mYVNjNvzGFb3s5kB9is
         eGwIxFiSb3Ce7SU8dj4In9c7qiJDKX0YRJQUJ87Lwr5fsYU0wzWGMFdNKoc3DkpIWmcu
         zJPttklfSCE8RcuUVwL9s+QBhxgukS86vsIOoj5cA56UkqksPs3ddr+/tsfrO92dzQvX
         tDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lhLdPSEjtof4PARL+jbQIELKrc8oApgcCwcTjMgi6lY=;
        b=o06lP1jv3vqa7wdsI9AtTTDsLeLxpm/Ei+XWdCuSXUjWAkINiticP1hcK4myaCTWvY
         O2l+BCyiCrbAkC9iWw6FkSvL5riKlc5xWe9a9p221GFQ38fnFj+DzRtV9acy2o28kQwm
         W8q/gUvFT83YnL9SuzMfdJKmqIYn5j2Ph98c9wiL2z01DwwAR2JD8tZBIKsvqNdBOZfw
         lxF8W/DNhfOsXeGopQz63yEWyMfLGc63lKf3T+wqzQrStz3hT/qSayLqBBt7aCgNcHCL
         TxXjmz+7tlLgAbS2TK5Qv0TM7HkMqHw4vuYjaN2huZefFnFiZITEvMhnHkxtrbpGXtGx
         6Lcw==
X-Gm-Message-State: AOUpUlFPl07+K/q8DawUvPsTBbwHrP9RBbRlow0kPKpXdYu63q3YgzV0
        GffWz4N7dc5unfbwyTbvi3Yn2YrB
X-Google-Smtp-Source: AAOMgpe/WYr5W2ukDvh70MikeNOYSKto94ZgAWUoLfIlULEjdMw2Jo3qiCXVnJgFXTes1XIxcqhInw==
X-Received: by 2002:a62:4695:: with SMTP id o21-v6mr4655827pfi.176.1532659277361;
        Thu, 26 Jul 2018 19:41:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id c88-v6sm4257552pfe.132.2018.07.26.19.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:41:16 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     isdn@linux-pingi.de, keescook@chromium.org, jeyu@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] isdn: mISDN: netjet: Replace GFP_ATOMIC with GFP_KERNEL in nj_probe()
Date:   Fri, 27 Jul 2018 10:41:09 +0800
Message-Id: <20180727024109.1702-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nj_probe() is never called in atomic context.
It calls kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/hardware/mISDN/netjet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/mISDN/netjet.c b/drivers/isdn/hardware/mISDN/netjet.c
index 89d9ba8ed535..2b317cb63d06 100644
--- a/drivers/isdn/hardware/mISDN/netjet.c
+++ b/drivers/isdn/hardware/mISDN/netjet.c
@@ -1084,7 +1084,7 @@ nj_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENODEV;
 	}
 
-	card = kzalloc(sizeof(struct tiger_hw), GFP_ATOMIC);
+	card = kzalloc(sizeof(struct tiger_hw), GFP_KERNEL);
 	if (!card) {
 		pr_info("No kmem for Netjet\n");
 		return err;
-- 
2.17.0

