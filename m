Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685ACC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2951320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2951320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeILNUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:20:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeILNUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:20:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B94CCA3D075FE;
        Wed, 12 Sep 2018 16:17:27 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Wed, 12 Sep 2018
 16:17:21 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
Subject: [PATCH 1/5] scsi: libsas: delete dead code in scsi_transport_sas.c
Date:   Wed, 12 Sep 2018 16:29:42 +0800
Message-ID: <20180912082946.34814-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180912082946.34814-1-yanaijie@huawei.com>
References: <20180912082946.34814-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is dead and no clue implies that it will be back again.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Hannes Reinecke <hare@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/scsi_transport_sas.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 0cd16e80b019..0a165b2b3e81 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -612,7 +612,6 @@ sas_phy_protocol_attr(identify.target_port_protocols,
 sas_phy_simple_attr(identify.sas_address, sas_address, "0x%016llx\n",
 		unsigned long long);
 sas_phy_simple_attr(identify.phy_identifier, phy_identifier, "%d\n", u8);
-//sas_phy_simple_attr(port_identifier, port_identifier, "%d\n", int);
 sas_phy_linkspeed_attr(negotiated_linkrate);
 sas_phy_linkspeed_attr(minimum_linkrate_hw);
 sas_phy_linkspeed_rw_attr(minimum_linkrate);
@@ -1802,7 +1801,6 @@ sas_attach_transport(struct sas_function_template *ft)
 	SETUP_PHY_ATTRIBUTE(device_type);
 	SETUP_PHY_ATTRIBUTE(sas_address);
 	SETUP_PHY_ATTRIBUTE(phy_identifier);
-	//SETUP_PHY_ATTRIBUTE(port_identifier);
 	SETUP_PHY_ATTRIBUTE(negotiated_linkrate);
 	SETUP_PHY_ATTRIBUTE(minimum_linkrate_hw);
 	SETUP_PHY_ATTRIBUTE_RW(minimum_linkrate);
-- 
2.14.4

