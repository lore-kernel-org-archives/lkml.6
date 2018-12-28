Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B43C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D271C2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="iqmqnztT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbeL1ULt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 15:11:49 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:39366 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbeL1ULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 15:11:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 227CBD12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 20:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DpUZ17KoTouh for <linux-kernel@vger.kernel.org>;
        Fri, 28 Dec 2018 14:11:47 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id DE511D1C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 14:11:46 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id d63so26172841iog.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 12:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0HvSt97ykFbzJ0i95x3si2xjQYna4NpLDsUQ/E+zItI=;
        b=iqmqnztTf3g4S59H+jFzyAhookaX/BUcP8xblR0LEzo6d+Kigk5c9oM191wsq8rupo
         Ylfw6d692WmD6SCXmqZcic1vq+AcgK+6GF0W0bJ9l7kJee2BJU9Kyz5RM3m0pcmDYZLO
         nVtbZHo9rqBPB9QNBTQxzvC7xE/tgNQJNjpz5+h8BI32+w1pDkrOkbEszWDmus6mU92f
         bXYOIBH5LIVAwZpTWhThEpuTd1o9mobxfwDLwhhjdM/MipuROlOy7F0yLfcydqhKRNks
         ETDZ3XQ5CLJSz/ijoPLSNzzvl/LvBIGOpHQSqTuexZT0Z4YcHF9m4ozjb7odjZd03gEj
         U9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0HvSt97ykFbzJ0i95x3si2xjQYna4NpLDsUQ/E+zItI=;
        b=fRytGBOQCN2BA5s9uSc+H/wTneIqxuym93elEzvHzifadS8oqpeM8DjW6fnXAWjwFK
         K2UlKmzvyJRYcK9H5NCVTdFOpXsFcN2UdY/d3f3ntfKEq2wa2p/1Nd3fV1evNndldYCz
         tC+5EJ/1CWyxeg+rER1b9ZLm4NlpxtFLWQyiKBvg7jelGd6d5r42IPac/y500KpiTFGE
         gVBC2vwkSdfsURvxZuN6PBbFMTDqCJKDMVabn8elhIiuWtvEcn8M2qNOnt8ZM2rOjXCD
         E7BNeUvrRbiM5yEuVK9lOvszvUjkQDCNQRo48/p8qwWjbThJe6EpnkkKd+L8w6YI6RJF
         F9YA==
X-Gm-Message-State: AA+aEWZR4fGe6z9rFtOYXMrhmcl2NkeHZeC+jXDdM/QgyLLaEC4fgmvP
        7jBVfPARlK7sL86URRyZVal/NF70lkGHFrXQdKxc7e0Ud2m2Ed4C6hI37bi6uroaqoH9C++0aaY
        nHpjVX3K3rlNdGRivQ5e7HIcAE7iA
X-Received: by 2002:a02:5f49:: with SMTP id r70mr19011008jab.128.1546027906413;
        Fri, 28 Dec 2018 12:11:46 -0800 (PST)
X-Google-Smtp-Source: AFSGD/Vn/7aJ/pf1MpYrMM3KbH2UMHwByETt89ky+gFhjfvXoNCXDGesy/q1qKNvt5QIr9LAnCDt/Q==
X-Received: by 2002:a02:5f49:: with SMTP id r70mr19010994jab.128.1546027906160;
        Fri, 28 Dec 2018 12:11:46 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id q14sm14904982itb.36.2018.12.28.12.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 12:11:45 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: qcom_hidma: Check for driver register failure
Date:   Fri, 28 Dec 2018 14:11:19 -0600
Message-Id: <20181228201119.11920-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While initializing the driver, the function platform_driver_register can
fail and return an error. Consistent with other invocations, this patch
returns the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/dma/qcom/hidma_mgmt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index d64edeb6771a..681de12f4c67 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -423,9 +423,8 @@ static int __init hidma_mgmt_init(void)
 		hidma_mgmt_of_populate_channels(child);
 	}
 #endif
-	platform_driver_register(&hidma_mgmt_driver);
+	return platform_driver_register(&hidma_mgmt_driver);
 
-	return 0;
 }
 module_init(hidma_mgmt_init);
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

