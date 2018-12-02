Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B8C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2852920660
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2852920660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeLBJDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 04:03:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:48692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbeLBJDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 04:03:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78841AD85;
        Sun,  2 Dec 2018 09:03:27 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 4.20-rc5
Date:   Sun,  2 Dec 2018 10:03:25 +0100
Message-Id: <20181202090325.9287-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.20a-rc5-tag

xen: fixes for 4.20-rc5

It contains the following fixes:
- A revert of a previous commit as it is no longer necessary and has
  shown to cause problems in some memory hotplug cases.
- Some small fixes and a minor cleanup.
- A patch for adding better diagnostic data in a very rare failure case.

Thanks.

Juergen

 arch/x86/xen/enlighten.c    | 78 ---------------------------------------------
 arch/x86/xen/multicalls.c   | 35 +++++++++++---------
 arch/x86/xen/setup.c        |  6 ++--
 arch/x86/xen/spinlock.c     |  7 +---
 drivers/xen/balloon.c       | 65 ++++++-------------------------------
 drivers/xen/pvcalls-front.c |  4 +--
 drivers/xen/xlate_mmu.c     |  1 +
 include/xen/balloon.h       |  5 ---
 8 files changed, 37 insertions(+), 164 deletions(-)

Igor Druzhinin (1):
      Revert "xen/balloon: Mark unallocated host memory as UNUSABLE"

Juergen Gross (2):
      x86/xen: cleanup includes in arch/x86/xen/spinlock.c
      xen/x86: add diagnostic printout to xen_mc_flush() in case of error

Pan Bian (1):
      pvcalls-front: fixes incorrect error handling

Srikanth Boddepalli (1):
      xen: xlate_mmu: add missing header to fix 'W=1' warning
