Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179FFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F5C214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttj67r8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F5C214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbeHVOWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:22:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46923 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbeHVOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so1078756ljj.13;
        Wed, 22 Aug 2018 03:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GLADAV5Bu6qP9JrgenZw0Bf8K/h589j+ltrInzvhajY=;
        b=Ttj67r8DyGAr9UIXXSZ2M+JVMmOoHjG29VhLU03+6Yn+A1bWJQbrqJU3gG+kLn/tf/
         /zjouDMmhfct6hzZjcftv9L6EmPxhJkbjuxQIThnIU4wDzLBtCD2Zr6afxFXheNJrr6b
         RXx3VAUcpTzNboer+0cZzZkmUad/dqhXF0mvXnwWnFugyOZeXVoiNVN9dtcoKap1p+VU
         xm+AN4/FefWXLK4U9e882CNcGIy/vb/PFDm+m2Bfvxr7YaMMJCvstaski4DF5krNk9+0
         p9jpMWq3aoAXhdWqJ3laK2c1TGPJzjU9nR5FoSMAIxc882HfAy/tQTwc8lokEeRwWD4c
         /7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=GLADAV5Bu6qP9JrgenZw0Bf8K/h589j+ltrInzvhajY=;
        b=YgWc/eeDOTnngtO9+k2sHlDyFbOoDeFlcc887snQQwFZGpn2sJVG64ypOgTd0rUIfR
         PVFxMW1L7JvYWI+qG0mnha6Bu4sAc+n4p4AUho4gn0dgQqTfJBi/U3HphPn8bdtnFCLK
         wv/dtjyoO4KlUAxzDRf3FjQ3yDXxlaKa9Qx0PtYLE+/FAT2W1KT0NnrKpzK9VLkWQc62
         jV0F/naHYE4LDeE5iwbcs5EX9hwULG8FpQDNeOQoHsb5kLHGno4YGMsKqfkVQox8jyFp
         mOqIkLVqOkxNOTC4nfXwe5PL/KanWijNwM77kFhfSG2kTuAr0QR7Eqj4n8SniIVV+lSx
         oAuA==
X-Gm-Message-State: APzg51BXacXGDfsRWn3Pq5aMjKFp0njZb3OamO0hVTiG6Fx556014roP
        YK5mQypabz8F95V0Xj8yObv9DU1g
X-Google-Smtp-Source: ANB0VdZl2f8BGlyos3uY54cE9JLl01corAZOzvO6hMhxXEKOQB5HQrNZ1/UcDrdcNFedSTOBHx/NeA==
X-Received: by 2002:a2e:8807:: with SMTP id x7-v6mr2529929ljh.98.1534935438939;
        Wed, 22 Aug 2018 03:57:18 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id i1-v6sm236829ljg.43.2018.08.22.03.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 03:57:16 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsQpC-0002XO-Pf; Wed, 22 Aug 2018 12:57:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH 3/9] drm/msm: fix OF child-node lookup
Date:   Wed, 22 Aug 2018 12:55:41 +0200
Message-Id: <20180822105547.9634-4-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822105547.9634-1-johan@kernel.org>
References: <20180822105547.9634-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the legacy
pwrlevels child node instead of using of_find_compatible_node(), which
searches the entire tree and thus can return an unrelated (i.e.
non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the probed device's node).

While at it, also fix the related child-node reference leak.

Fixes: e2af8b6b0ca1 ("drm/msm: gpu: Use OPP tables if we can")
Cc: stable <stable@vger.kernel.org>     # 4.12
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index da1363a0c54d..93d70f4a2154 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -633,8 +633,7 @@ static int adreno_get_legacy_pwrlevels(struct device *dev)
 	struct device_node *child, *node;
 	int ret;
 
-	node = of_find_compatible_node(dev->of_node, NULL,
-		"qcom,gpu-pwrlevels");
+	node = of_get_compatible_child(dev->of_node, "qcom,gpu-pwrlevels");
 	if (!node) {
 		dev_err(dev, "Could not find the GPU powerlevels\n");
 		return -ENXIO;
@@ -655,6 +654,8 @@ static int adreno_get_legacy_pwrlevels(struct device *dev)
 			dev_pm_opp_add(dev, val, 0);
 	}
 
+	of_node_put(node);
+
 	return 0;
 }
 
-- 
2.18.0

