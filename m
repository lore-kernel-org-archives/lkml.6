Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EBAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81CF20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 13:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81CF20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbeKJXbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 18:31:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:52400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729013AbeKJXbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 18:31:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76A1DAD94;
        Sat, 10 Nov 2018 13:46:13 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 4.20-rc2
Date:   Sat, 10 Nov 2018 14:46:12 +0100
Message-Id: <20181110134612.19508-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.20a-rc2-tag

xen: fixes for 4.20-rc2

It contains several fixes, mostly for rather recent regressions when
running under Xen.


Thanks.

Juergen

 arch/x86/include/asm/xen/page.h | 35 +++++++++++++++++++++++++++++++----
 arch/x86/xen/p2m.c              |  3 +--
 arch/x86/xen/spinlock.c         | 14 ++++++++------
 drivers/block/xen-blkfront.c    |  1 +
 drivers/xen/grant-table.c       |  2 +-
 drivers/xen/privcmd-buf.c       | 22 ++++------------------
 include/xen/xen-ops.h           | 12 +++++++-----
 7 files changed, 53 insertions(+), 36 deletions(-)

Juergen Gross (3):
      x86/xen: fix pv boot
      xen: fix xen_qlock_wait()
      xen: remove size limit of privcmd-buf mapping interface

Liam Merwick (1):
      xen/grant-table: Fix incorrect gnttab_dma_free_pages() pr_debug message

Manjunath Patil (1):
      xen-blkfront: fix kernel panic with negotiate_mq error path

Stefano Stabellini (1):
      CONFIG_XEN_PV breaks xen_create_contiguous_region on ARM
