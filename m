Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D82ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD3E208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD3E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbeGQMdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:33:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731087AbeGQMdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:33:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0BA0AE4F;
        Tue, 17 Jul 2018 12:01:18 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/4] xen: various cleanups
Date:   Tue, 17 Jul 2018 14:01:09 +0200
Message-Id: <20180717120113.12756-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Xen related cleanups:
- move some pv-only code from CONFIG_XEN to CONFIG_XEN_PV
- use CONFIG_XEN_PVHVM in Makefile instead of #ifdef around a complete source
- add SPDX identifier where missing

Juergen Gross (4):
  xen: move pv irq related functions under CONFIG_XEN_PV umbrella
  xen: move pv specific parts of arch/x86/xen/mmu.c to mmu_pv.c
  xen: link platform-pci-unplug.o only if CONFIG_XEN_PVHVM
  xen: add SPDX identifier in arch/x86/xen files

 arch/x86/entry/entry_32.S          |   8 +-
 arch/x86/entry/entry_64.S          |   8 +-
 arch/x86/xen/Makefile              |  41 ++++++--
 arch/x86/xen/efi.c                 |  14 +--
 arch/x86/xen/enlighten.c           |   2 +
 arch/x86/xen/enlighten_hvm.c       |   2 +
 arch/x86/xen/grant-table.c         |  25 +----
 arch/x86/xen/mmu.c                 | 188 +------------------------------------
 arch/x86/xen/mmu_pv.c              | 140 +++++++++++++++++++++++++++
 arch/x86/xen/p2m.c                 |   2 +
 arch/x86/xen/pci-swiotlb-xen.c     |   2 +
 arch/x86/xen/platform-pci-unplug.c |  18 +---
 arch/x86/xen/vdso.h                |   2 +
 arch/x86/xen/xen-pvh.S             |  15 +--
 include/xen/interface/memory.h     |   6 --
 include/xen/xen-ops.h              | 133 +++++++++++++++++---------
 16 files changed, 287 insertions(+), 319 deletions(-)

-- 
2.13.7

