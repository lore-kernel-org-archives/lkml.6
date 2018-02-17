Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeBQIsT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 03:48:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:57423 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbeBQIsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 03:48:18 -0500
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 4.16-rc2
Date: Sat, 17 Feb 2018 09:48:15 +0100
Message-Id: <20180217084815.4662-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.16a-rc2-tag

xen: fixes for 4.16-rc2

It contains fixes for the Xen pvcalls frontend driver, a fix for
booting Xen pv domains and a fix for the xenbus driver user interface.


Thanks.

Juergen

 arch/x86/include/asm/smp.h        |   1 +
 arch/x86/kernel/smpboot.c         |  10 +-
 arch/x86/xen/smp.c                |   2 +
 drivers/xen/pvcalls-front.c       | 197 ++++++++++++++++----------------------
 drivers/xen/xenbus/xenbus.h       |   1 +
 drivers/xen/xenbus/xenbus_comms.c |   1 +
 drivers/xen/xenbus/xenbus_xs.c    |   3 +
 7 files changed, 101 insertions(+), 114 deletions(-)

Joao Martins (1):
      xenbus: track caller request id

Prarit Bhargava (1):
      x86/xen: Calculate __max_logical_packages on PV domains

Stefano Stabellini (2):
      pvcalls-front: introduce a per sock_mapping refcount
      pvcalls-front: wait for other operations to return when release passive sockets
