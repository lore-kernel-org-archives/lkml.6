Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0134214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="XRVW/VY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeL0CPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:15:32 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:57882 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeL0CPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:15:32 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id A7372BB9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 02:15:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YLHamTgDwpJk for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 20:15:30 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 7E283B45
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 20:15:30 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id g7so21434404itg.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 18:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=X1U5qGJoVBkQ4oS7PPT35S44J3WF8fo8sL5YNAro4GE=;
        b=XRVW/VY0UE9OphL/xbeGLUO/qBCxXXm1b1MAtnmOelrB6rTycvOddlSv7Nw8VUoqlv
         ImfMnDLpoG2A51Y7wob9i3PX3KHAP8vKSL7AV/oCUK/VGynzB/mQpRLje9CaD0UFRPSo
         01MhS2pVbM2VhpBaQBUwhcmA9LAqV9Dqof/d1PGk9/yp4idSi08Hxo5wnUYYzJTRGa6o
         aZkJYGl4WScO+t5cK8rbYITJS9pHf2jOtdGrLHbVx1GNCot55DhTB8evu79ZHxfjTAUO
         q7LKJtu9a1E91XIvPeV9VcXSOtXGQsvRDD23NwHr++eOGREcFxaltLyih5+zp+Y4ysA4
         Foiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X1U5qGJoVBkQ4oS7PPT35S44J3WF8fo8sL5YNAro4GE=;
        b=Y9dYiRRtcnE74rEqFtH6ccJclvtCbcW0UdX04k+qca4NY/iWpLW1eZXlNBTN2/3sG4
         6oCabCWvbW2HDGCwLMlaZAGLKNF1Ep0kRmbJklzZCNwsNJc9Lk+hDLW4vnCvvfRT+g6c
         V6PUPtfOB4yW6V+tIDazFTy0wPHUwTzVwfVPtg9wgWJaUBBb1lSQHy7TT0NXROTHgOTt
         cOTfHKto5G90WpgeYaswijwOwygH72pGsGPF5k8XukYUadQlTks7rk2g1n6eKDt2zsp0
         0ApKGWiXRHB6DtjCFfGGDAgEP/XiuDkWSmm4jtlAIc5G8jLKiJVV0cLsRFqNCPH6WvoO
         O3sw==
X-Gm-Message-State: AA+aEWb0TxOw5v6I1UZYTJONdvCOKR917fnYg7Ao55f9DLvUvbJ6IyXZ
        K5J5P3jF9vg7e0BhIU6iKMit4HwXJw7jbewWqeEuC8qhM3E7hVKTjnHH/85R168Kz8hjQ0yv5wy
        +7gcMs5L3iD9SlILM/irqMSQqsvZe
X-Received: by 2002:a24:9686:: with SMTP id z128mr14050215itd.97.1545876929844;
        Wed, 26 Dec 2018 18:15:29 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VtZCt+FwvpfXyBdyqwfHL1SEAa7Vs0fSem3rVUYSb4W+qbLpIVNPs75X6cbn8Q5UMpUVbENw==
X-Received: by 2002:a24:9686:: with SMTP id z128mr14050210itd.97.1545876929637;
        Wed, 26 Dec 2018 18:15:29 -0800 (PST)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id 196sm14893109itu.37.2018.12.26.18.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 18:15:28 -0800 (PST)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Maurizio Lombardi <mlombard@redhat.com>,
        zhong jiang <zhongjiang@huawei.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] gdrom: fix a memory leak bug
Date:   Wed, 26 Dec 2018 20:15:13 -0600
Message-Id: <1545876914-11283-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In probe_gdrom(), the buffer pointed by 'gd.cd_info' is allocated through
kzalloc() and is used to hold the information of the gdrom device. To
register and unregister the device, the pointer 'gd.cd_info' is passed to
the functions register_cdrom() and unregister_cdrom(), respectively.
However, this buffer is not freed after it is used, which can cause a
memory leak bug.

This patch simply frees the buffer 'gd.cd_info' in exit_gdrom() to fix the
above issue.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/cdrom/gdrom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index a5b8afe..f8b7345 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -873,6 +873,7 @@ static void __exit exit_gdrom(void)
 	platform_device_unregister(pd);
 	platform_driver_unregister(&gdrom_driver);
 	kfree(gd.toc);
+	kfree(gd.cd_info);
 }
 
 module_init(init_gdrom);
-- 
2.7.4

