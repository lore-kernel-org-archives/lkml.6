Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12A3C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFB82170E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFB82170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbeHNRIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:08:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:52832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732246AbeHNRIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:08:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 674C8AD67;
        Tue, 14 Aug 2018 14:21:27 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: features and fixes for 4.19-rc1
Date:   Tue, 14 Aug 2018 16:21:24 +0200
Message-Id: <20180814142124.25184-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.19-rc1-tag

xen: features and fixes for 4.19-rc1

It contains the following:

- a series to add dma-buf functionality to Xen grant table handling
- a fix for booting the kernel as Xen PVH dom0
- a fix for booting the kernel as a Xen PV guest with CONFIG_DEBUG_VIRTUAL
  enabled
- some other minor performance and style fixes


Thanks.

Juergen

 arch/x86/include/asm/xen/hypercall.h |  25 +-
 arch/x86/kernel/cpu/common.c         |   2 +-
 arch/x86/kernel/cpu/cpu.h            |   1 +
 arch/x86/xen/enlighten_pv.c          |   3 +
 arch/x86/xen/multicalls.c            |   6 +-
 arch/x86/xen/spinlock.c              |   4 +
 drivers/xen/Kconfig                  |  24 +
 drivers/xen/Makefile                 |   2 +
 drivers/xen/balloon.c                |  75 +--
 drivers/xen/biomerge.c               |   2 +-
 drivers/xen/gntdev-common.h          |  94 ++++
 drivers/xen/gntdev-dmabuf.c          | 857 +++++++++++++++++++++++++++++++++++
 drivers/xen/gntdev-dmabuf.h          |  33 ++
 drivers/xen/gntdev.c                 | 220 ++++++---
 drivers/xen/grant-table.c            | 151 +++++-
 drivers/xen/mem-reservation.c        | 118 +++++
 drivers/xen/xen-balloon.c            |   2 +-
 include/uapi/xen/gntdev.h            | 106 +++++
 include/xen/grant_table.h            |  21 +
 include/xen/mem-reservation.h        |  59 +++
 20 files changed, 1634 insertions(+), 171 deletions(-)

Colin Ian King (1):
      xen/gntdev: don't dereference a null gntdev_dmabuf on allocation failure

Gustavo A. R. Silva (1):
      xen/biomerge: Use true and false for boolean values

Juergen Gross (2):
      xen: don't use privcmd_call() from xen_mc_flush()

M. Vefa Bicakci (1):
      xen/pv: Call get_cpu_address_sizes to set x86_virt/phys_bits

Oleksandr Andrushchenko (8):
      xen/grant-table: Make set/clear page private code shared
      xen/balloon: Share common memory reservation routines
      xen/grant-table: Allow allocating buffers suitable for DMA
      xen/gntdev: Allow mappings for DMA buffers
      xen/gntdev: Make private routines/structures accessible
      xen/gntdev: Add initial support for dma-buf UAPI
      xen/gntdev: Implement dma-buf export functionality
      xen/gntdev: Implement dma-buf import functionality

Roger Pau Monne (1):
      xen/balloon: fix balloon initialization for PVH Dom0

Waiman Long (1):
      xen/spinlock: Don't use pvqspinlock if only 1 vCPU
