Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9254C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9313520827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9313520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeJaFoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:44:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeJaFoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:44:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DC7B85362;
        Tue, 30 Oct 2018 20:49:11 +0000 (UTC)
Received: from w520.home (ovpn-116-133.phx2.redhat.com [10.3.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AA0C5EDE3;
        Tue, 30 Oct 2018 20:49:10 +0000 (UTC)
Date:   Tue, 30 Oct 2018 14:49:10 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v4.20-rc1
Message-ID: <20181030144910.460a8635@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 30 Oct 2018 20:49:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v4.20-rc1.v2

for you to fetch changes up to 104c7405a64d937254b6a154938e6151f91c9e0d:

  vfio: add edid support to mbochs sample driver (2018-10-11 10:22:36 -0600)

----------------------------------------------------------------
VFIO updates for v4.20

 - EDID interfaces for vfio devices supporting display extensions
   (Gerd Hoffmann)

 - Generically select Type-1 IOMMU model support on ARM/ARM64
   (Geert Uytterhoeven)

 - Quirk for VFs reporting INTx pin (Alex Williamson)

 - Fix error path memory leak in MSI support (Li Qiang)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/pci: Mask buggy SR-IOV VF INTx support

Geert Uytterhoeven (1):
      drivers/vfio: Allow type-1 IOMMU instantiation with all ARM/ARM64 IOMMUs

Gerd Hoffmann (2):
      vfio: add edid api for display (vgpu) devices.
      vfio: add edid support to mbochs sample driver

Li Qiang (1):
      vfio/pci: Fix potential memory leak in vfio_msi_cap_len

 drivers/vfio/Kconfig               |   2 +-
 drivers/vfio/pci/vfio_pci.c        |   8 ++-
 drivers/vfio/pci/vfio_pci_config.c |  31 ++++++++-
 include/uapi/linux/vfio.h          |  50 ++++++++++++++
 samples/vfio-mdev/mbochs.c         | 136 +++++++++++++++++++++++++++++++------
 5 files changed, 204 insertions(+), 23 deletions(-)
