Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D615C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC7A20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC7A20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeIYIsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 04:48:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727524AbeIYIsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 04:48:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3B9F29FC40EE6;
        Tue, 25 Sep 2018 10:43:22 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Tue, 25 Sep 2018
 10:43:17 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
Subject: [PATCH v3 1/5] scsi: libsas: delete dead code in scsi_transport_sas.c
Date:   Tue, 25 Sep 2018 10:56:50 +0800
Message-ID: <20180925025654.44053-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180925025654.44053-1-yanaijie@huawei.com>
References: <20180925025654.44053-1-yanaijie@huawei.com>
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
Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

