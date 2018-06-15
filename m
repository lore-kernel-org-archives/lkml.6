Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 78718C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284FF208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dX/5FjoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284FF208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936243AbeFOJ7s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:59:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37234 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936207AbeFOJ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:59:45 -0400
Received: by mail-wr0-f195.google.com with SMTP id d8-v6so9337394wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=u9uuGzmf4enrIny/JvPD087s+CCtQ/fCgWXfahiRIa4=;
        b=dX/5FjoEXsJtbIDxwy4OI5yHoJmNSg2JPyuU3kOvx3LdrqFSSZB3mUhhWWGM7JG8FD
         9KZ06YL3nKTvvVd8A6NfqOl1DnkbhNkUtThNGBii3wTIx1i8BPdEbng5x6w3avDFzeyl
         5qtVigcWmWe+tqfFsaPpY+rKg9zlip141vMRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u9uuGzmf4enrIny/JvPD087s+CCtQ/fCgWXfahiRIa4=;
        b=qZzuHzrgOL/gxbD2Uqo8xu6YISGCJCsfGYNtGCRS/RV1rX8KTiDiXvSeanyJ2F7II3
         c+HeSsFbUS9SuX4M9gNx/wM3Qwn9dTEIkLlGRZeN3pPOC9LI6mWPaaPNr+LfQfb3znLw
         bNoXGMGKlg3/gta7MW6F6MUhfwhM3LMSdBzuY/igchMV1OMC+Mn8e1kt/EghQanit0Ma
         IB8umo+gTT4OYwY67aRLzyylfzlOerPh0p6EE0GPbP7EkQ94Balg7raHeP1A3ZRlhVGW
         +PmOSwbqYV9Zoujxcs98e5Nh901xr4liHme+u4XhcxyCtrW0wA2wwpKNmlsxUgP1RON1
         4BOg==
X-Gm-Message-State: APt69E0TwwNXENBL1Pa2emIeqH4BdvwEVNRPlamD1FxdX2mLs7/Pb8Of
        Q0kGCJeY1R6vtEFW/5pWv1vHQA==
X-Google-Smtp-Source: ADUXVKILCJh9n4VR1JljnHmyobvTCLOOFSEPl97A4ET+wKEcabN8YTzW9mNZ1ZxxD3EFDGEQf4inBA==
X-Received: by 2002:adf:fd88:: with SMTP id d8-v6mr981113wrr.276.1529056784183;
        Fri, 15 Jun 2018 02:59:44 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id p3-v6sm7502812wrn.31.2018.06.15.02.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 02:59:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] rpmsg: core: add support to power domains for devices
Date:   Fri, 15 Jun 2018 10:59:39 +0100
Message-Id: <20180615095939.1331-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the rpmsg devices need to switch on power domains to communicate
with remote processor. For example on Qualcomm DB820c platform LPASS
power domain needs to switched on for any kind of audio services.
This patch adds the missing power domain support in rpmsg core.

Without this patch attempting to play audio via QDSP on DB820c would
reboot the system.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index b714a543a91d..8122807db380 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/rpmsg.h>
 #include <linux/of_device.h>
+#include <linux/pm_domain.h>
 #include <linux/slab.h>
 
 #include "rpmsg_internal.h"
@@ -449,6 +450,10 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
+	err = dev_pm_domain_attach(dev, true);
+	if (err)
+		goto out;
+
 	if (rpdrv->callback) {
 		strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
 		chinfo.src = rpdev->src;
@@ -490,6 +495,8 @@ static int rpmsg_dev_remove(struct device *dev)
 
 	rpdrv->remove(rpdev);
 
+	dev_pm_domain_detach(dev, true);
+
 	if (rpdev->ept)
 		rpmsg_destroy_ept(rpdev->ept);
 
-- 
2.16.2

