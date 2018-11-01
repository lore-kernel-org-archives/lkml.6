Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF41ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A60F20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3AjW5vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A60F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeKAKpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:45:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37326 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeKAKpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:45:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh10-v6so8144098plb.4;
        Wed, 31 Oct 2018 18:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BKIjweOIJDYb+D5qqQtBUGBxgB2Oy/lnCEM25usTaeQ=;
        b=u3AjW5vhfUR0XlnfHXpkXdbPoUYJKd8Q1mPj36RqETFqn975pzB6pKzwZo0RQynbJq
         cZzNJBFLIZEIJndAcA4Tsn7Qqo/XqVF06K9U4y4m+QWPv9Y5zohgfFOeCrECRjh2rl21
         EgE2Gg0gUu6gAJmO7DzQYuoJrZolmhNEjKilepXmmybSatqJ6RvkYJBIU4MthRw5Q0Yd
         fSk3fqzs4akaL0rN/qlTC3YCUjoSGMeN4CNxmRPc67+vH5GO7RFyD08v2T3kdgVStIOe
         arUEuChrca64wW7YSRYePxtU5d/iu5NTqQonqSg7eWlR+gL7rmE/LbwkIUKqv15bX075
         /pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BKIjweOIJDYb+D5qqQtBUGBxgB2Oy/lnCEM25usTaeQ=;
        b=T0quodyLw5+pGCx8dG1RoeKHnVEYfR2Vo82gSEsEGCZP5bb18duZ07VRztz0Pj8wGl
         UHNqu7IkdJrnS7d1OfV2dgPOmaO8PMrvtsQSOr0O2B05aAph/Zq9eKEjTE2fmXCnziWX
         voBc8KcvDQxFn3FO+jL+Wa6iEkfQqirGvo+O0aNDzJQ/PikRo35METoAj468tvYWxgor
         jTj3BZtffj1GIigWzq1GOzlgsRE4PSANzRGy1s1TCvUE3EKIXnEjKfEyHP6UFaQCpK1x
         qliFJLhWKXgHE+srRxynCHHZqOEnx9/dne2cI+qWGsLjJo9IpYYkq2wyL1r46xu29xCJ
         UxwA==
X-Gm-Message-State: AGRZ1gLsaEchNtpeZk15ewBO3TmSNYlt0/zQ2UXV4Uj8Dctu7zCYnWGT
        z5eAWdINTlcTeJyRlMx8VM4=
X-Google-Smtp-Source: AJdET5cDSw+3BEy+e0s1QoF/kn73jOkSqSzkREkQC9pYzGUikx8JJJUbDFu2sku3Nw/G4DXnQmmbjw==
X-Received: by 2002:a17:902:7045:: with SMTP id h5-v6mr5669796plt.211.1541036706460;
        Wed, 31 Oct 2018 18:45:06 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f68-v6sm67683524pfe.143.2018.10.31.18.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 18:45:05 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, airlied@linux.ie, jonathanh@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tegra: falcon: Validate firmware.vaddr with IS_ERR_OR_NULL
Date:   Wed, 31 Oct 2018 18:44:20 -0700
Message-Id: <20181101014420.13366-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware.vaddr might be assigned with an error code instead of
NULL, so this patch uses an IS_ERR_OR_NULL check to fix below bug.

Unable to handle kernel paging request at virtual address fffffffffffffff0
[...]
pc : falcon_load_firmware+0x80/0x358 [tegra_drm]
lr : falcon_load_firmware+0x2b4/0x358 [tegra_drm]
sp : ffff000010feb4a0
[...]
Call trace:
 falcon_load_firmware+0x80/0x358 [tegra_drm]
 vic_init+0x74/0x158 [tegra_drm]
 host1x_device_init+0x58/0x108 [host1x]
 tegra_drm_load+0xdc/0x2b8 [tegra_drm]

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/gpu/drm/tegra/falcon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/falcon.c b/drivers/gpu/drm/tegra/falcon.c
index f685e72949d1..9126d4fc5933 100644
--- a/drivers/gpu/drm/tegra/falcon.c
+++ b/drivers/gpu/drm/tegra/falcon.c
@@ -141,9 +141,10 @@ int falcon_load_firmware(struct falcon *falcon)
 	/* allocate iova space for the firmware */
 	falcon->firmware.vaddr = falcon->ops->alloc(falcon, firmware->size,
 						    &falcon->firmware.paddr);
-	if (!falcon->firmware.vaddr) {
+	if (IS_ERR_OR_NULL(falcon->firmware.vaddr)) {
 		dev_err(falcon->dev, "dma memory mapping failed\n");
-		return -ENOMEM;
+		err = PTR_ERR(falcon->firmware.vaddr);
+		return err ? err : -ENOMEM;
 	}
 
 	/* copy firmware image into local area. this also ensures endianness */
-- 
2.17.1

