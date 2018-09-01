Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5817C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C7F2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZoiVLnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C7F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeIAQMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:12:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46330 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeIAQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:12:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so6674936pfn.13;
        Sat, 01 Sep 2018 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sM3w2bjmYgJst2AECfsghRunGLy7wuu0ZvSPdnjwU6I=;
        b=kZoiVLnw/kPaPmx8lPouqVpRGQO2UfI68e1EX1d3nCFgpV8mFLkTbVCuhUA8OMLR8w
         EtEVjM+57CEg1QgnDpCr+z54JLHLRFW2TVT+IbZYFRqS1eHryz405uuWWavojhYzz22h
         IsPUkpaWKoSKIIKBtsOjSv0O/CgmSYycAeK+gIAbAF2j4Z4aNprnGPI1SIJjlKHgThWw
         nHbjOsMFXy/L/o6G/Q6uDSjBZyzGqpWOVVrCRalatyIpYig1Pf0aDb3nADz9rf22LYb5
         fSk/eQtyrGYhFTKdxvSi2alAFnChAWp6QYOUJiozkElx3JHnKSitITrg/upNKFBoP1iD
         RtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sM3w2bjmYgJst2AECfsghRunGLy7wuu0ZvSPdnjwU6I=;
        b=AFZsTYk3z8BvYAVv2o7inC42fIXhUeGiq+4oQxANiackG5QsVaOTKNmYG5+W6edzWQ
         +KNualtXVyfCxY8BArtX087teJkVnn/F5xaJD7izXTTGKQDmCig+s/O8jwUCi/n/zC/j
         Ap+TCdjJsWoRGKOjkXc2i4ftKcT4GaLJ6MY3AvrRszY74XGgEIN4MnVUasIs0NfD1/XQ
         Qd6qrl2SI/Q75havf4XZ0M4wsxN8f7dZPtnRfM58hAF14rojzBrEdVzMGwGlDV6p0sBs
         x1zL00u0Hsnv7uPLP3OowjseI1pL3/60maHcQkQsa/FnIVziAWON7Ed4F6H6mPhvomRV
         8w0g==
X-Gm-Message-State: APzg51BIfMPm2TTkRF4CzPECHI/WhM9uy5+lGAUId0e0qXahNkA1OBdK
        b7hkEACeHEFPNM1v1/pAat6U7pWG
X-Google-Smtp-Source: ANB0VdYW4Pchq8gNXRzDcYjufjRk702ScEdjtfqhjBBq4976ireAIi0bk4R7SNXaD2IjOTtdrhoMbg==
X-Received: by 2002:a63:3e8b:: with SMTP id l133-v6mr18015733pga.355.1535803226124;
        Sat, 01 Sep 2018 05:00:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id r81-v6sm18359748pfa.18.2018.09.01.05.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 05:00:25 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     isdn@linux-pingi.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] isdn: mISDN: tei: Fix a sleep-in-atomic-context bug in create_teimgr()
Date:   Sat,  1 Sep 2018 20:00:19 +0800
Message-Id: <20180901120019.31664-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] kzalloc(GFP_KERNEL)
drivers/isdn/mISDN/tei.c, 1058: kzalloc in create_teimgr
drivers/isdn/mISDN/tei.c, 1278: create_teimgr in mgr_ctrl
drivers/isdn/mISDN/tei.c, 1048: [FUNC_PTR]mgr_ctrl in create_teimgr
drivers/isdn/mISDN/tei.c, 1045: _raw_read_lock_irqsave in create_teimgr

Note that [FUNC_PTR] means a function pointer call is used.

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/mISDN/tei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/mISDN/tei.c b/drivers/isdn/mISDN/tei.c
index 12d9e5f4beb1..6d95ee639fdb 100644
--- a/drivers/isdn/mISDN/tei.c
+++ b/drivers/isdn/mISDN/tei.c
@@ -1055,7 +1055,7 @@ create_teimgr(struct manager *mgr, struct channel_req *crq)
 		       crq->adr.tei, crq->adr.sapi);
 	if (!l2)
 		return -ENOMEM;
-	l2->tm = kzalloc(sizeof(struct teimgr), GFP_KERNEL);
+	l2->tm = kzalloc(sizeof(struct teimgr), GFP_ATOMIC);
 	if (!l2->tm) {
 		kfree(l2);
 		printk(KERN_ERR "kmalloc teimgr failed\n");
-- 
2.17.0

