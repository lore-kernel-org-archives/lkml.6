Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DF5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC20206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJINNjOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC20206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeLDWhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:37:25 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54738 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDWhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:37:25 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so18203811ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOi69ish+ghyK7JjoNTHw9jzIHwlPxmIFC4vT6nlZOI=;
        b=iJINNjOIX1s8KNzdHLIVkiN76uW+ahJqUFXWW6Kmw3waPJgCcn2e0xE0BLqQ1/2KTT
         Ekd52GFW1GcdhkiJlb0OvOV7kKOgmKLMZFMCfiiQPiqSHYOZdNxBh6j0xecK3Uvznz+1
         b0LWlyNx0Fl3ySmR/EjnGNEHiCil55zMRm1+OL1qfoqO0JAMgUm5Y8C8rrOQDaaqEDSn
         chPN2eBnfhMRSJ9LJSBGldTzB8K2mw9+5FYuVuqlBscr4KFOJkT7sU8xmuPc8VswxmoB
         8fdl9YQUvq3RLBtbLe+kOE/zAlRYqElMIexzq2a6dusEsw1m+Now7BxdrYaJY0PDzBqI
         DcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOi69ish+ghyK7JjoNTHw9jzIHwlPxmIFC4vT6nlZOI=;
        b=h+F5M8Mo1eUq+35MGfwDkxDU2lCgLs7EjA+xfJbuVwmstVhs6Mqrjq0rtBg935wTU2
         YAElFhYSZbEjDvcxNKxY+Qool5x5B94YDFbJaoJ5B1/pslRF6FLRFvCxU21ub7iPdAz3
         96c9q4iWwzc/yN6tL25DYHXJmGCjMFrzlQpdYTohNxqgraM9Qf22FYBKd9zHt7Fyq/xM
         vQ24833yapFfGPN+764KA9h+El4M/ezq0yCvI6/ZPQpGrnWnVv9v1XCJaXdKs8hByQE6
         C89jCtC/0TyukD8QBQv6eHC5H9siiLhSp7eoZEkZCMBf4iBefZumXWbAONrkUSxq+M3X
         LUug==
X-Gm-Message-State: AA+aEWYvjD/PRKrL7T6neqst3lLmsoZ0PveeFhFiGNEK/Mi75V4MqyGU
        +dBHq5oR7tZaorj8nbELMDZ4gg==
X-Google-Smtp-Source: AFSGD/UeNnlSm3ZnphgHZOKVpWWbdtyBpBZIAk+t7JJA5KCwWFeAOD8rOR3PCo9bg4qHSd2+CyOqug==
X-Received: by 2002:a24:e302:: with SMTP id d2mr13379770ith.155.1543963044283;
        Tue, 04 Dec 2018 14:37:24 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id r21sm6111390ita.27.2018.12.04.14.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:37:23 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH] iommu: fix amd_iommu=force_isolation
Date:   Tue,  4 Dec 2018 15:37:16 -0700
Message-Id: <20181204223716.214159-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter is still there but it's ignored. We need to check its
value before deciding to go into passthrough mode for AMD IOMMU.

Fixes: aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/iommu/amd_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..3e4219e6cff0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2195,7 +2195,8 @@ static int amd_iommu_add_device(struct device *dev)
 
 	BUG_ON(!dev_data);
 
-	if (iommu_pass_through || dev_data->iommu_v2)
+	if (iommu_pass_through ||
+	    (!amd_iommu_force_isolation && dev_data->iommu_v2))
 		iommu_request_dm_for_dev(dev);
 
 	/* Domains are initialized for this device - have a look what we ended up with */
-- 
2.20.0.rc1.387.gf8505762e3-goog

