Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8879C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDB72081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ipyrM+80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDB72081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeLJAww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:52:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54734 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeLJAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:52:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBA0oPlk049012;
        Mon, 10 Dec 2018 00:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=j3jyWK1FhdP/Kpzz5tpGzF5aRHW+aZHXzvNHtcWJ/vU=;
 b=ipyrM+80GUHty7yfQqzDScdqoN5vye3Q/HgRUGKz0ijvxQe/Cy9CSuujWAILMEVEgWUh
 9abqmmoBOsYREgdy5tzMnVF940gOHdUDuMiEDqvoGayQ2TEumxGs700vN+p2PULb1p7q
 9jy9vyGVguAbNItjOt46sI4oY3/GEXHsqzzrC7m5ujQlMFBwZXnPh+AQk8Gg2TS4Dp3G
 WipEl6w0rw3kAwS32P4NcST5oM8/f7aQKFI3daluLsSYJXzU8jE/+KvnNDvTMZxUqY5r
 q8iiQzC9E2sRSR85QygPuvcAYTezyi9b92x1gRmdojEF+m6umfqhPmjHBro2v5FmY+rc xw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2p83fdudv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 00:52:37 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBA0qako022000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 00:52:36 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBA0qZmp026094;
        Mon, 10 Dec 2018 00:52:36 GMT
Received: from linux.cn.oracle.com (/10.182.71.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Dec 2018 16:52:35 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com
Subject: [PATCH v2 1/1] virtio: remove deprecated VIRTIO_PCI_CONFIG()
Date:   Mon, 10 Dec 2018 08:54:34 +0800
Message-Id: <1544403274-9238-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9102 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIRTIO_PCI_CONFIG() is deprecated. Use VIRTIO_PCI_CONFIG_OFF() instead.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
  * leave the definition of VIRTIO_PCI_CONFIG() in header file to make userspace build happy

 drivers/virtio/virtio_pci_legacy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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
 
-- 
2.7.4

