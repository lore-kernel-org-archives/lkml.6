Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CE0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F2720855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfARJ5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:57:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:49126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfARJ5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:57:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA022AD0A;
        Fri, 18 Jan 2019 09:57:14 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 5.0-rc3
Date:   Fri, 18 Jan 2019 10:57:13 +0100
Message-Id: <20190118095713.3192-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.0-rc3-tag

xen: fixes for 5.0-rc3

It contains:
- Several fixes for the Xen pvcalls drivers (1 fix for the backend and
  8 for the frontend).
- A fix for a rather longstanding bug in the Xen sched_clock()
  interface which led to weird time jumps when migrating the system.
- A fix for avoiding accesses to x2apic MSRs in Xen PV guests.


Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c      |   5 +-
 arch/x86/xen/time.c              |  12 +++--
 drivers/xen/events/events_base.c |   2 +-
 drivers/xen/pvcalls-back.c       |   9 ++--
 drivers/xen/pvcalls-front.c      | 104 ++++++++++++++++++++++++++++-----------
 5 files changed, 90 insertions(+), 42 deletions(-)

Juergen Gross (1):
      xen: Fix x86 sched_clock() interface for xen

Stefano Stabellini (5):
      pvcalls-front: read all data before closing the connection
      pvcalls-front: don't try to free unallocated rings
      pvcalls-front: properly allocate sk
      pvcalls-front: don't return error when the ring is full
      pvcalls-back: set -ENOTCONN in pvcalls_conn_back_read

Talons Lee (1):
      always clear the X2APIC_ENABLE bit for PV guest

Wen Yang (2):
      pvcalls-front: Avoid get_free_pages(GFP_KERNEL) under spinlock
      pvcalls-front: fix potential null dereference

YueHaibing (1):
      xen/pvcalls: remove set but not used variable 'intf'
