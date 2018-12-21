Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B336A21916
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbeLUQbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:31:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeLUQbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:31:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 196BB7FDE4;
        Fri, 21 Dec 2018 16:31:31 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B648E1001F3D;
        Fri, 21 Dec 2018 16:31:30 +0000 (UTC)
Date:   Fri, 21 Dec 2018 09:31:30 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] VFIO updates for v4.21-rc1
Message-ID: <20181221093130.3c2fc1dc@x1.home>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 21 Dec 2018 16:31:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

An early pull request for the next merge window.  Happy holidays!

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v4.21-rc1

for you to fetch changes up to 8ba35b3a0046d6573c98f00461d9bd1b86250d35:

  vfio-mdev/samples: Use u8 instead of char for handle functions (2018-12-17 11:07:13 -0700)

----------------------------------------------------------------
VFIO updates for v4.21

 - Replace global vfio-pci lock with per bus lock to allow concurrent
   open and release (Alex Williamson)

 - Declare mdev function as static (Paolo Cretaro)

 - Convert char to u8 in mdev/mtty sample driver (Nathan Chancellor)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/pci: Parallelize device open and release

Nathan Chancellor (1):
      vfio-mdev/samples: Use u8 instead of char for handle functions

Paolo Cretaro (1):
      vfio/mdev: add static modifier to add_mdev_supported_type

 drivers/vfio/mdev/mdev_sysfs.c      |   4 +-
 drivers/vfio/pci/vfio_pci.c         | 160 ++++++++++++++++++++++++++++++------
 drivers/vfio/pci/vfio_pci_private.h |   6 ++
 samples/vfio-mdev/mtty.c            |  26 +++---
 4 files changed, 157 insertions(+), 39 deletions(-)
