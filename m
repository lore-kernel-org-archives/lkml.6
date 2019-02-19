Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79679C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5406E21903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfBSH5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:57:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbfBSH5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:57:03 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D7AF1B92424E6C398E6C;
        Tue, 19 Feb 2019 15:57:00 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 15:56:54 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/5] iommu/arm-smmu-v3: make smmu can be enabled in kdump kernel
Date:   Tue, 19 Feb 2019 15:54:38 +0800
Message-ID: <20190219075443.17732-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series include two parts:
1. Patch1-2 use dummy STE tables with "ste abort" hardware feature to abort unexpected
   devices accessing. For more details, see the description in patch 2.
2. If the "ste abort" feature is not support, force the unexpected devices in the
   secondary kernel to use the memory maps which it used in the first kernel. For more
   details, see patch 5.


Zhen Lei (5):
  iommu/arm-smmu-v3: make sure the stale caching of L1STD are invalid
  iommu/arm-smmu-v3: make smmu can be enabled in kdump kernel
  iommu/arm-smmu-v3: add macro xxx_SIZE to replace xxx_DWORDS shift
  iommu/arm-smmu-v3: move arm_smmu_get_step_for_sid() a little ahead
  iommu/arm-smmu-v3: workaround for STE abort in kdump kernel

 drivers/iommu/arm-smmu-v3.c | 243 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 194 insertions(+), 49 deletions(-)

-- 
1.8.3


