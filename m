Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C5AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556A920652
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfABVXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:23:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfABVXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:23:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1298B8E3FB;
        Wed,  2 Jan 2019 21:23:34 +0000 (UTC)
Received: from redhat.com (ovpn-120-148.rdu2.redhat.com [10.10.120.148])
        by smtp.corp.redhat.com (Postfix) with SMTP id 705A45D75E;
        Wed,  2 Jan 2019 21:23:24 +0000 (UTC)
Date:   Wed, 2 Jan 2019 16:23:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        changpeng.liu@intel.com, dongli.zhang@oracle.com,
        dverkamp@chromium.org, jasowang@redhat.com, mst@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, wangyan122@huawei.com
Subject: [PULL] virtio, vhost: features, fixes, cleanups
Message-ID: <20190102162323-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 02 Jan 2019 21:23:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to a691ffb46edd7cb12a17ff0965ab59dbc95f48de:

  vhost: correct the related warning message (2018-12-19 18:23:50 -0500)

----------------------------------------------------------------
virtio, vhost: features, fixes, cleanups

discard in virtio blk
misc fixes and cleanups

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Changpeng Liu (1):
      virtio_blk: add discard and write zeroes support

Dongli Zhang (1):
      virtio: remove deprecated VIRTIO_PCI_CONFIG()

Michael S. Tsirkin (1):
      virtio: fix test build after uio.h change

Paolo Bonzini (1):
      vhost: split structs into a separate header file

Stefan Hajnoczi (1):
      vhost/vsock: switch to a mutex for vhost_vsock_hash

wangyan (1):
      vhost: correct the related warning message

 drivers/block/virtio_blk.c         |  83 +++++++++++++++++++++++-
 drivers/vhost/scsi.c               |   4 +-
 drivers/vhost/vsock.c              |  16 ++---
 drivers/virtio/virtio_pci_legacy.c |   6 +-
 include/uapi/linux/vhost.h         | 113 +-------------------------------
 include/uapi/linux/vhost_types.h   | 128 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_blk.h    |  54 ++++++++++++++++
 tools/virtio/linux/kernel.h        |   4 ++
 8 files changed, 283 insertions(+), 125 deletions(-)
 create mode 100644 include/uapi/linux/vhost_types.h
