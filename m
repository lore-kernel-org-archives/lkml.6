Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8353C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF58208E7
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF58208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbeKQMy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:54:27 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60624 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729796AbeKQMy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:54:26 -0500
X-UUID: 9d2ad6aaf3d544c383648657f946df56-20181117
X-UUID: 9d2ad6aaf3d544c383648657f946df56-20181117
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 841566044; Sat, 17 Nov 2018 10:39:22 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 17 Nov 2018 10:39:20 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 17 Nov 2018 10:39:20 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v3 14/15] iommu/mediatek: Constify iommu_ops
Date:   Sat, 17 Nov 2018 10:35:41 +0800
Message-ID: <1542422142-30688-15-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

iommu_ops are not supposed to change at runtime.
Functions 'iommu_device_set_ops' and 'bus_set_iommu' working with
const iommu_ops provided by <linux/iommu.h>. So mark the non-const
structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[Yong: Change the title to iommu/mediatek: xx]
---
 drivers/iommu/mtk_iommu.c    | 4 ++--
 drivers/iommu/mtk_iommu_v1.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 63406c5..5775e8f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -119,7 +119,7 @@ struct mtk_iommu_domain {
 	struct iommu_domain		domain;
 };
 
-static struct iommu_ops mtk_iommu_ops;
+static const struct iommu_ops mtk_iommu_ops;
 
 static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
@@ -503,7 +503,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
-static struct iommu_ops mtk_iommu_ops = {
+static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
 	.domain_free	= mtk_iommu_domain_free,
 	.attach_dev	= mtk_iommu_attach_device,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 0e78084..27867b8 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -362,7 +362,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pa;
 }
 
-static struct iommu_ops mtk_iommu_ops;
+static const struct iommu_ops mtk_iommu_ops;
 
 /*
  * MTK generation one iommu HW only support one iommu domain, and all the client
@@ -524,7 +524,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	return 0;
 }
 
-static struct iommu_ops mtk_iommu_ops = {
+static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
 	.domain_free	= mtk_iommu_domain_free,
 	.attach_dev	= mtk_iommu_attach_device,
-- 
1.9.1

