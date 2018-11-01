Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993F4C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67505205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67505205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKBGY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:24:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeKBGY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:24:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA8DF307D85B;
        Thu,  1 Nov 2018 21:19:46 +0000 (UTC)
Received: from redhat.com (ovpn-124-238.rdu2.redhat.com [10.10.124.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEF5D5D6AA;
        Thu,  1 Nov 2018 21:19:38 +0000 (UTC)
Date:   Thu, 1 Nov 2018 17:19:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, bijan.mottahedeh@oracle.com,
        gedwards@ddn.com, joe@perches.com, lenaic@lhuard.fr,
        liang.z.li@intel.com, mhocko@kernel.org, mhocko@suse.com,
        mst@redhat.com, stefanha@redhat.com, torvalds@linux-foundation.org,
        wei.w.wang@intel.com
Subject: [PULL] vhost: cleanups and fixes
Message-ID: <20181101171938-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 01 Nov 2018 21:19:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:

  Linux 4.19 (2018-10-22 07:37:37 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 79f800b2e76923cd8ce0aa659cb5c019d9643bc9:

  MAINTAINERS: remove reference to bogus vsock file (2018-10-24 21:16:14 -0400)

----------------------------------------------------------------
virtio, vhost: fixes, tweaks

virtio balloon page hinting support
vhost scsi control queue

misc fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Bijan Mottahedeh (3):
      vhost/scsi: Respond to control queue operations
      vhost/scsi: Extract common handling code from control queue handler
      vhost/scsi: Use common handling code in request queue handler

Greg Edwards (1):
      vhost/scsi: truncate T10 PI iov_iter to prot_bytes

Lénaïc Huard (1):
      kvm_config: add CONFIG_VIRTIO_MENU

Stefan Hajnoczi (1):
      MAINTAINERS: remove reference to bogus vsock file

Wei Wang (3):
      virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
      mm/page_poison: expose page_poisoning_enabled to kernel modules
      virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON

 MAINTAINERS                         |   1 -
 drivers/vhost/scsi.c                | 426 ++++++++++++++++++++++++++++--------
 drivers/virtio/virtio_balloon.c     | 380 +++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_balloon.h |   8 +
 kernel/configs/kvm_guest.config     |   1 +
 mm/page_poison.c                    |   6 +
 6 files changed, 688 insertions(+), 134 deletions(-)
