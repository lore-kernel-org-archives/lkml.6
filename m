Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934266AbeEIKVp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:21:45 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:16799 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934038AbeEIKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:21:44 -0400
X-IronPort-AV: E=Sophos;i="5.49,381,1520899200";
   d="scan'208";a="54081116"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <linux-kernel@vger.kernel.org>
CC: Roger Pau Monne <roger.pau@citrix.com>
Subject: [PATCH v2 0/3] xen/pvh: Dom0 support
Date: Wed, 9 May 2018 11:21:26 +0100
Message-ID: <20180509102129.14832-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following patches enable booting a PVH Dom0. So far I've only tested
them in my test box, so I expect more issues will show up as this gets
further testing. In any case, this is the bare minimum to get a PVH Dom0
working.

In order to test them Xen 4.11 RC or plain master/staging should be
used. Compile a Linux kernel with this patches and PVH support and add
dom0=pvh to the Xen command line. The following message will be
displayed during Dom0 boot by the Linux kernel if PVH mode is used:

"Booting paravirtualized kernel on Xen PVH"

Thanks, Roger.

Roger Pau Monne (3):
  xen/pvh: enable and set default MTRR type
  xen/store: do not store local values in xen_start_info
  xen: share start flags between PV and PVH

 arch/arm/xen/enlighten.c          | 7 ++++---
 arch/x86/xen/enlighten.c          | 7 +++++++
 arch/x86/xen/enlighten_pv.c       | 1 +
 arch/x86/xen/enlighten_pvh.c      | 4 ++++
 drivers/xen/xenbus/xenbus_probe.c | 5 ++---
 include/xen/xen.h                 | 4 +++-
 6 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.17.0
