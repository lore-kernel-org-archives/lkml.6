Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E992081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E992081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbeKEXay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:30:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727481AbeKEXay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:30:54 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5377FA9F8C7D4;
        Mon,  5 Nov 2018 22:10:48 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Mon, 5 Nov 2018 22:10:43 +0800
From:   John Garry <john.garry@huawei.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <dann.frazier@canonical.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH] Documentation/ABI: Add sysfs-transport-sas
Date:   Mon, 5 Nov 2018 22:12:17 +0800
Message-ID: <1541427137-113073-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAS transport class ABI is currently undocumented.

Some systemd issues have been raised for SAS device support [1], [2].

Because of this, distros using systemd may have broken symlinks, like
/dev/disk/by-path

Unfortunately it is challenging to support SAS devices as the ABI is not well
documented and is not always intuitive, so add a stable ABI definition.

[1] https://github.com/systemd/systemd/issues/3943#issuecomment-240982482
[2] https://github.com/systemd/systemd/issues/7157

Signed-off-by: John Garry <john.garry@huawei.com>
--

I am sending this as an incomplete RFC to ensure it's the right thing to do, so
I don't bother writing the document to find it later rejected.

For now, this is just a minimal effort.

diff --git a/Documentation/ABI/stable/sysfs-transport-sas b/Documentation/ABI/stable/sysfs-transport-sas
new file mode 100644
index 0000000..6df6ffe
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-transport-sas
@@ -0,0 +1,21 @@
+What:		/sys/class/sas_phy/phy-<host>:<phy identifier>,
+				   phy-<host>:<scsi target id>:<phy identifier>
+Date:		Nov, 2018
+KernelVersion:	2.6.13
+Contact:	linux-scsi@vger.kernel.org
+Description:	SAS PHY entry directory, which includes interfaces to control
+		the PHY, physical layer information on the PHY, and other SAS
+		fabric management information asscoiated with the PHY.
+
+What:		/sys/class/sas_port/port-<host>:<port identifier>,
+				    port-<host>:<scsi target id>:<port identifier>
+Date:		Nov, 2018
+KernelVersion:	2.6.13
+Contact:	linux-scsi@vger.kernel.org
+Description:	SAS Port entry directory, with constituient PHY count and
+		other SAS fabric management information asscoiated with the
+		Port.
+
+
+
+
-- 
1.9.1

