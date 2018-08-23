Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795BEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA89214FF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA89214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbeHWQPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:15:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:35770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727238AbeHWQPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:15:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E153AE05;
        Thu, 23 Aug 2018 12:45:36 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes and cleanups for 4.19-rc1, second round
Date:   Thu, 23 Aug 2018 14:45:33 +0200
Message-Id: <20180823124533.27015-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.19b-rc1b-tag

xen: fixes and cleanups for 4.19-rc1, second round

It contains some cleanups, some minor fixes and a fix for a bug
introduced in 4.19 hitting 32-bit PV guests.

Thanks.

Juergen

 arch/x86/include/asm/xen/hypercall.h | 118 -----------------------------------
 arch/x86/mm/init.c                   |  17 +++--
 arch/x86/xen/enlighten_pv.c          |  13 ++--
 arch/x86/xen/mmu_pv.c                |   2 +
 arch/x86/xen/setup.c                 |  31 ---------
 arch/x86/xen/xen-ops.h               |   1 -
 drivers/acpi/processor_core.c        |   1 +
 drivers/xen/mcelog.c                 |   2 -
 drivers/xen/xen-acpi-processor.c     |   6 ++
 9 files changed, 30 insertions(+), 161 deletions(-)

Jan Beulich (4):
      x86/Xen: mark xen_setup_gdt() __init
      xen/mcelog: eliminate redundant setting of interface version
      x86/Xen: further refine add_preferred_console() invocations
      xen/ACPI: don't upload Px/Cx data for disabled processors

Juergen Gross (4):
      x86/xen: remove unused function xen_auto_xlated_memory_setup()
      xen: remove unused hypercall functions
      x86/xen: enable early use of set_fixmap in 32-bit Xen PV guest
