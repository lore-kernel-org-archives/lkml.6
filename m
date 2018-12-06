Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BE4C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9CD20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sExIuPup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9CD20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLFVjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:39:24 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39469 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeLFVjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:39:22 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so3934432itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+QhQvYRXYVTH+W6E8SN/q5muPgeALpyOYffd8C/XMk=;
        b=sExIuPupqdUmzqHBiSUgL6Rd8R3qkpUWGZdtwuTJwtljrrlr7YmeR6+ky+yX1W5L+3
         5Kf4IMMuEoXkQ4Yno3itJekIdZUddRQecXaoJRmARpdvqUReUqYxEIhhTL+lwgkBBw4L
         aSHMl3FN7BISo11nLqkCMWM8u8OUWzu0pRKVfHT1vxtBhCZgguqwgYEqj4JprBas6kwv
         L62UTXmQsYvYVpONPZfhRGG9kV3ktUnxy0EfkId6vqO7Zak+3QjFsJ5pmiH2RhK2t7o6
         F+sTLPna1KhaxnluOmN8xxDq0KvnOZcgYTOI7DC5QyB503jVJSBsn0Gd7+6zPSq6gcq3
         y/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+QhQvYRXYVTH+W6E8SN/q5muPgeALpyOYffd8C/XMk=;
        b=JSNLkSNywKwoMt/kOwT4TXRlz7w9pwQ8LsCWGBedAnH7KpSqHIcpVGp32gGnZYaWTX
         NK2hRBnsx9UWkdSKGCh4LSvJyGAlunHTE77QiURUEXTBozCFUMbcWImXh4gV031d/FNL
         Ah78M5v1ZgSfqjzeV51MmWl6Rv//5gWGuKE8nSdEsH/zJoad2EC69BVj+Mq30TaVDcd/
         i/YMSseT9w1/ZFeLhHukjoAYDA/pl6B+xMTzInYrKn/drs5voYWbl4QgHiP6KQErqchc
         KbQ4LMQyvhxX08a+MAAOHy5iqgfFT1Suz4FfJGQsWe2+65Aa82Xa+yIu/UfwIxkIAgpY
         XUWw==
X-Gm-Message-State: AA+aEWZqm/AkMwuubajWEwGUAuVESolsH+oQgRsTsVd8TRIwt2JOwybA
        Ww6R8GMabhNTA3Il4Cty4gbjFQDuMas=
X-Google-Smtp-Source: AFSGD/WsyDQQ9o6PVIbTQmzoEwLZMq4Yx57S9ak1YbpUUoyeWu2aRfq0foSt/Yw4EduSIgAN44Q6MA==
X-Received: by 2002:a24:fa05:: with SMTP id v5mr36862ith.43.1544132360962;
        Thu, 06 Dec 2018 13:39:20 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id o74sm827308itc.44.2018.12.06.13.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 13:39:20 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2] iommu: fix amd_iommu=force_isolation
Date:   Thu,  6 Dec 2018 14:39:15 -0700
Message-Id: <20181206213915.196205-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181204223716.214159-1-yuzhao@google.com>
References: <20181204223716.214159-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter is still there but it's ignored. We need to check its
value before deciding to go into passthrough mode for AMD IOMMU v2
capable device.

We occasionally use this parameter to force v2 capable device into
translation mode to debug memory corruption that we suspect is
caused by DMA writes.

To address the following comment from Joerg Roedel on the first
version, v2 capability of device is completely ignored.
> This breaks the iommu_v2 use-case, as it needs a direct mapping for the
> devices that support it.

And from Documentation/admin-guide/kernel-parameters.txt:
  This option does not override iommu=pt

Fixes: aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/iommu/amd_iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..325f3bad118b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -438,7 +438,14 @@ static int iommu_init_device(struct device *dev)
 
 	dev_data->alias = get_alias(dev);
 
-	if (dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
+	/*
+	 * By default we use passthrough mode for IOMMUv2 capable device.
+	 * But if amd_iommu=force_isolation is set (e.g. to debug DMA to
+	 * invalid address), we ignore the capability for the device so
+	 * it'll be forced to go into translation mode.
+	 */
+	if ((iommu_pass_through || !amd_iommu_force_isolation) &&
+	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
 		struct amd_iommu *iommu;
 
 		iommu = amd_iommu_rlookup_table[dev_data->devid];
-- 
2.20.0.rc2.403.gdbc3b29805-goog

