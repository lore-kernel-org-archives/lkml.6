Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17988C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CBE2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CBE2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeHaSZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:25:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:57888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727432AbeHaSZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:25:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42714AE41;
        Fri, 31 Aug 2018 14:17:19 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 4.19-rc2
Date:   Fri, 31 Aug 2018 16:17:17 +0200
Message-Id: <20180831141717.17603-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.19b-rc2-tag

xen: fixes for 4.19-rc2

It contains:
- minor cleanup avoiding a warning when building with new gcc
- a patch to add a new sysfs node for Xen frontend/backend drivers
  to make it easier to obtain the state of a pv device
- two fixes for 32-bit pv-guests to avoid intermediate L1TF vulnerable
  PTEs

Thanks.

Juergen

 Documentation/ABI/stable/sysfs-bus-xen-backend | 9 +++++++++
 arch/x86/include/asm/pgtable-3level.h          | 7 +++----
 arch/x86/xen/mmu_pv.c                          | 9 +++------
 drivers/xen/xenbus/xenbus_probe.c              | 9 +++++++++
 4 files changed, 24 insertions(+), 10 deletions(-)

Colin Ian King (1):
      x86/xen: remove redundant variable save_pud

Joe Jin (1):
      xen: export device state to sysfs

Juergen Gross (2):
      x86/xen: don't write ptes directly in 32-bit PV guests
      x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear
