Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C425C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F54920882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j7GuWSJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F54920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLGHcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:32:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46884 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLGHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:32:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB77ShGh001487;
        Fri, 7 Dec 2018 07:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=uQAa6oToY8YUDVhEQnLATDT87KeGnyueOfStOCDKTOU=;
 b=j7GuWSJO+72XUlStJuhTYVSC8z4fOBZN+9+YKq92loq6jgdAT8eHbU+YesHOhJJSX403
 dpugEJHHtMbBeERN9V0uUHJLE8vNerLES216lDz2B9Xm8u37Pr0NY8ZLR8QVc55myvsD
 ZR4ql4Z2VxFn8k0TX7wUFwciuTgTSwytqCctg1I85/nckEcK3dIVk1eB24UVRiFDbcbc
 8Vd99LRguJ9S8PQ2thOaX2gRb5GggKbmFpmpGV4WZTKazNd1MZ/ItGDwYYKCG8SZF987
 /Ef+gQj0VdlNjsgBoMJ8t+3I8yNe4aG6aFuPPmSs3pg5Hu3+PL42AlA3a2Q5Wdg12BDY Ng== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2p3hqucdp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 07:32:45 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB77Wesm031388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 07:32:40 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB77WdJ9013866;
        Fri, 7 Dec 2018 07:32:40 GMT
Received: from linux.cn.oracle.com (/10.182.71.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 23:32:39 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com
Subject: [PATCH 1/1] virtio: remove deprecated VIRTIO_PCI_CONFIG()
Date:   Fri,  7 Dec 2018 15:34:41 +0800
Message-Id: <1544168081-13205-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=966
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIRTIO_PCI_CONFIG() is deprecated. Use VIRTIO_PCI_CONFIG_OFF() instead.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/virtio/virtio_pci_legacy.c | 6 ++++--
 include/uapi/linux/virtio_pci.h    | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index de062fb..eff9ddc 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -52,7 +52,8 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void __iomem *ioaddr = vp_dev->ioaddr +
-				VIRTIO_PCI_CONFIG(vp_dev) + offset;
+			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
+			offset;
 	u8 *ptr = buf;
 	int i;
 
@@ -67,7 +68,8 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void __iomem *ioaddr = vp_dev->ioaddr +
-				VIRTIO_PCI_CONFIG(vp_dev) + offset;
+			VIRTIO_PCI_CONFIG_OFF(vp_dev->msix_enabled) +
+			offset;
 	const u8 *ptr = buf;
 	int i;
 
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 90007a1..2070232 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -78,8 +78,6 @@
 /* The remaining space is defined by each driver as the per-driver
  * configuration space */
 #define VIRTIO_PCI_CONFIG_OFF(msix_enabled)	((msix_enabled) ? 24 : 20)
-/* Deprecated: please use VIRTIO_PCI_CONFIG_OFF instead */
-#define VIRTIO_PCI_CONFIG(dev)	VIRTIO_PCI_CONFIG_OFF((dev)->msix_enabled)
 
 /* Virtio ABI version, this must match exactly */
 #define VIRTIO_PCI_ABI_VERSION		0
-- 
2.7.4

