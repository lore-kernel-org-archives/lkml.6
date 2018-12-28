Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A83C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35B221741
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeL1DBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:01:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:21063 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbeL1DB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:01:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 19:01:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,407,1539673200"; 
   d="scan'208";a="113768279"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by orsmga003.jf.intel.com with ESMTP; 27 Dec 2018 19:01:26 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com
Cc:     borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com,
        wei.w.wang@intel.com
Subject: [PATCH v1 0/2] Virtio: fix some vq allocation issues
Date:   Fri, 28 Dec 2018 10:26:24 +0800
Message-Id: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some vqs don't need to be allocated when the related feature bits are
disabled. Callers notice the vq allocation layer by setting the related
names[i] to be NULL.

This patch series fixes the find_vqs implementations to handle this case.

Wei Wang (2):
  virtio_pci: use queue idx instead of array idx to set up the vq
  virtio: don't allocate vqs when names[i] = NULL

 drivers/misc/mic/vop/vop_main.c        |  9 +++++++--
 drivers/remoteproc/remoteproc_virtio.c |  9 +++++++--
 drivers/s390/virtio/virtio_ccw.c       | 12 +++++++++---
 drivers/virtio/virtio_mmio.c           |  9 +++++++--
 drivers/virtio/virtio_pci_common.c     |  8 ++++----
 5 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.7.4

