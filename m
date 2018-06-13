Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A1360C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1CB208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 23:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1CB208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935966AbeFMXpN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 19:45:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935589AbeFMXpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 19:45:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 069ED87AC7;
        Wed, 13 Jun 2018 23:45:11 +0000 (UTC)
Received: from redhat.com (ovpn-122-133.rdu2.redhat.com [10.10.122.133])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4B44F1C5AF;
        Wed, 13 Jun 2018 23:45:06 +0000 (UTC)
Date:   Thu, 14 Jun 2018 02:45:06 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        stable@vger.kernel.org, kevin@guarana.org, mst@redhat.com,
        ohad@wizery.com,
        syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com,
        tiwei.bie@intel.com
Subject: [PULL v2] vhost, virtio
Message-ID: <20180614024506-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 13 Jun 2018 23:45:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 13 Jun 2018 23:45:11 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page hints are reworked - I dropped them for now.

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 2eb98105f8c7f4b867f7f714a998f5b8c1bb009b:

  virtio: update the comments for transport features (2018-06-12 04:59:29 +0300)

----------------------------------------------------------------
virtio, vhost: features, fixes

VF support for virtio.
DMA barriers for virtio strong barriers.
Bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (2):
      virtio_ring: switch to dma_XX barriers for rpmsg
      vhost: fix info leak due to uninitialized memory

Tiwei Bie (2):
      virtio_pci: support enabling VFs
      virtio: update the comments for transport features

 drivers/vhost/vhost.c              |  3 +++
 drivers/virtio/virtio_pci_common.c | 30 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_modern.c | 14 ++++++++++++++
 include/linux/virtio_ring.h        |  4 ++--
 include/uapi/linux/virtio_config.h | 16 ++++++++++++----
 5 files changed, 61 insertions(+), 6 deletions(-)
