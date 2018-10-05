Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF52AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED7720652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="PmshtX+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED7720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeJEReJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:34:09 -0400
Received: from 8bytes.org ([81.169.241.247]:57114 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeJEReJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:34:09 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 867EC338; Fri,  5 Oct 2018 12:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1538735756; bh=wCQgjmC7zxKcsS3i6AH/w3Mkwc9I+iZAobQLVdFOeOY=;
        h=From:To:Cc:Subject:Date:From;
        b=PmshtX+GvMmALd/UmRjaz3C7gNXZX8yTv9evAetx8AIga8gmJ0DvMQqFuTz2bQLi5
         8qpKZd0u9HpkFDczfLO67Fodm04sV/58XiqyTUQnIG3PiZ8ZSMHiIJj3RGq3/4AdTp
         OdPbIV8poavtab2m7oLi7fGIMovuPSbSg5aH7YWrst0VeWuT5ebEHYUXungGXPEwP6
         M9kdORfWU2Bm6Ts3C/BAPdtyXYRNO+qs2qTMli/f7hIwcP5HIusLWdYNb5NiPie9om
         mDsaP3PGzksfrQI+dmQWs3r+dOgNTX5Z4qwJv/N8i3uAL6haWaOTbETCNxHJN7pHf4
         hE+bVqTcp05EA==
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/amd: Move iommu_init_pci() to .init section
Date:   Fri,  5 Oct 2018 12:35:54 +0200
Message-Id: <1538735754-1865-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function is only called from another __init function, so
it should be moved to .init too.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 84b3e4445d46..9c3d610e1e19 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1709,7 +1709,7 @@ static const struct attribute_group *amd_iommu_groups[] = {
 	NULL,
 };
 
-static int iommu_init_pci(struct amd_iommu *iommu)
+static int __init iommu_init_pci(struct amd_iommu *iommu)
 {
 	int cap_ptr = iommu->cap_ptr;
 	u32 range, misc, low, high;
-- 
2.13.7

