Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CE321C1A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CE321C1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeGFQst (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933635AbeGFQsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:48:47 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00082308A955;
        Fri,  6 Jul 2018 16:48:46 +0000 (UTC)
Received: from t450s.home (ovpn-116-113.phx2.redhat.com [10.3.116.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E00E2010CF3;
        Fri,  6 Jul 2018 16:48:46 +0000 (UTC)
Date:   Fri, 6 Jul 2018 10:48:45 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO fixes for v4.18-rc4
Message-ID: <20180706104845.71211867@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 06 Jul 2018 16:48:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v4.18-rc4

for you to fetch changes up to d7ef4899d7182f9d4267b4e4a5cc3689c1a04f25:

  sample/vfio-mdev: Change return type to vm_fault_t (2018-07-04 10:42:04 -0600)

----------------------------------------------------------------
VFIO fixes for v4.18

 - Make vfio-pci IGD extensions optional via Kconfig (Alex Williamson)

 - Remove unused and soon to be removed map_atomic callback from mbochs
   sample driver, add unmap callback to avoid dmabuf leaks (Gerd Hoffmann)

 - Fix usage of get_user_pages_longterm() (Jason Gunthorpe)

 - Fix sample mbochs driver vm_operations_struct.fault return type
   (Souptick Joarder)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/pci: Make IGD support a configurable option

Gerd Hoffmann (2):
      sample/mdev/mbochs: remove mbochs_kmap_atomic_dmabuf
      sample/mdev/mbochs: add mbochs_kunmap_dmabuf

Jason Gunthorpe (1):
      vfio: Use get_user_pages_longterm correctly

Souptick Joarder (1):
      sample/vfio-mdev: Change return type to vm_fault_t

 drivers/vfio/pci/Kconfig        | 12 ++++++++++--
 drivers/vfio/vfio_iommu_type1.c | 16 +++++++---------
 samples/vfio-mdev/mbochs.c      | 19 ++++++++-----------
 3 files changed, 25 insertions(+), 22 deletions(-)
