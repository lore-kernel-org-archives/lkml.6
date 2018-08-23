Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928BDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5168621566
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5168621566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeHWVNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:13:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726297AbeHWVNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:13:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C51DE4023827;
        Thu, 23 Aug 2018 17:42:31 +0000 (UTC)
Received: from redhat.com (ovpn-125-165.rdu2.redhat.com [10.10.125.165])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1FE1610EE78A;
        Thu, 23 Aug 2018 17:42:25 +0000 (UTC)
Date:   Thu, 23 Aug 2018 20:42:24 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, cdall@kernel.org, gedwards@ddn.com,
        jasowang@redhat.com, jean-philippe.brucker@arm.com,
        marc.zyngier@arm.com, mhocko@kernel.org, mst@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, peter.maydell@linaro.org,
        suzuki.poulose@arm.com, wei.w.wang@intel.com
Subject: [PULL] virtio,vhost: fixes, tweaks
Message-ID: <20180823204224-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 23 Aug 2018 17:42:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 23 Aug 2018 17:42:31 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:

  Linux 4.18 (2018-08-12 13:41:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 864d39df09b43f9d09d80bc29d8e8888294b3c4b:

  vhost/scsi: increase VHOST_SCSI_PREALLOC_PROT_SGLS to 2048 (2018-08-22 01:01:47 +0300)

----------------------------------------------------------------
virtio, vhost: fixes, tweaks

No new features but a bunch of tweaks such as
switching balloon from oom notifier to shrinker.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Greg Edwards (2):
      vhost: allow vhost-scsi driver to be built-in
      vhost/scsi: increase VHOST_SCSI_PREALLOC_PROT_SGLS to 2048

Suzuki K Poulose (2):
      virtio: mmio-v1: Validate queue PFN
      virtio: pci-legacy: Validate queue pfn

Wei Wang (3):
      virtio-balloon: remove BUG() in init_vqs
      virtio-balloon: kzalloc the vb struct
      virtio_balloon: replace oom notifier with shrinker

 drivers/vhost/Kconfig              |   2 +-
 drivers/vhost/scsi.c               |   2 +-
 drivers/virtio/virtio_balloon.c    | 125 ++++++++++++++++++++-----------------
 drivers/virtio/virtio_mmio.c       |  20 +++++-
 drivers/virtio/virtio_pci_legacy.c |  14 ++++-
 5 files changed, 99 insertions(+), 64 deletions(-)
