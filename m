Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58805C7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7862087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfATQO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:14:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfATQOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:14:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FBF4D56F5;
        Sun, 20 Jan 2019 16:14:25 +0000 (UTC)
Received: from redhat.com (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5FA6A19C7D;
        Sun, 20 Jan 2019 16:14:21 +0000 (UTC)
Date:   Sun, 20 Jan 2019 11:14:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bijan.mottahedeh@oracle.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mst@redhat.com, ptikhomirov@virtuozzo.com,
        wei.w.wang@intel.com
Subject: [PULL] virtio, vhost: fixes and cleanups
Message-ID: <20190120111420-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 20 Jan 2019 16:14:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mostly fixes the fallout from the balloon changes.

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 8e5dadfe76cf2862ebf3e4f22adef29982df7766:

  vhost/scsi: Use copy_to_iter() to send control queue response (2019-01-14 20:28:08 -0500)

----------------------------------------------------------------
virtio, vhost: fixes, cleanups

fixes and cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Bijan Mottahedeh (1):
      vhost/scsi: Use copy_to_iter() to send control queue response

Cornelia Huck (2):
      virtio: fix virtio_config_ops description
      virtio: document virtio_config_ops restrictions

Pavel Tikhomirov (1):
      vhost: return EINVAL if iovecs size does not match the message size

Wei Wang (3):
      virtio_pci: use queue idx instead of array idx to set up the vq
      virtio: don't allocate vqs when names[i] = NULL
      virtio-balloon: tweak config_changed implementation

 drivers/misc/mic/vop/vop_main.c        |  9 +++-
 drivers/remoteproc/remoteproc_virtio.c |  9 +++-
 drivers/s390/virtio/virtio_ccw.c       | 12 +++--
 drivers/vhost/scsi.c                   | 20 ++++---
 drivers/vhost/vhost.c                  |  8 ++-
 drivers/virtio/virtio_balloon.c        | 98 ++++++++++++++++++++++------------
 drivers/virtio/virtio_mmio.c           |  9 +++-
 drivers/virtio/virtio_pci_common.c     |  8 +--
 include/linux/virtio_config.h          | 13 +++--
 9 files changed, 126 insertions(+), 60 deletions(-)
