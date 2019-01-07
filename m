Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E36C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3D32085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfAGHgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:36:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:52919 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfAGHgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:36:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2019 23:36:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,450,1539673200"; 
   d="scan'208";a="107800056"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2019 23:36:13 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com
Cc:     borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com,
        wei.w.wang@intel.com, pasic@linux.ibm.com
Subject: [PATCH v3 3/3] virtio_balloon: remove the unnecessary 0-initialization
Date:   Mon,  7 Jan 2019 15:01:06 +0800
Message-Id: <1546844466-38079-4-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've changed to kzalloc the vb struct, so no need to 0-initialize
this field one more time.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/virtio/virtio_balloon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e33dc8e..f19061b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -925,7 +925,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 						  VIRTIO_BALLOON_CMD_ID_STOP);
 		vb->cmd_id_stop = cpu_to_virtio32(vb->vdev,
 						  VIRTIO_BALLOON_CMD_ID_STOP);
-		vb->num_free_page_blocks = 0;
 		spin_lock_init(&vb->free_page_list_lock);
 		INIT_LIST_HEAD(&vb->free_page_list);
 		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
-- 
2.7.4

