Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeECOhT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:37:19 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:62779 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeECOhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:37:18 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520899200";
   d="scan'208";a="72565947"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <linux-kernel@vger.kernel.org>
CC: Roger Pau Monne <roger.pau@citrix.com>
Subject: [PATCH 0/3] xen/pvh: Dom0 support
Date: Thu, 3 May 2018 15:36:43 +0100
Message-ID: <20180503143646.60747-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
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
displayed during boot by the Linux kernel if PVH mode is used:

"Booting paravirtualized kernel on Xen PVH"

Thanks, Roger.

Roger Pau Monne (3):
  xen/pvh: enable and set default MTRR type
  xen/store: do not store local values in xen_start_info
  xen: share start flags between PV and PVH

 arch/x86/xen/enlighten.c          | 7 +++++++
 arch/x86/xen/enlighten_pv.c       | 1 +
 arch/x86/xen/enlighten_pvh.c      | 4 ++++
 drivers/xen/xenbus/xenbus_probe.c | 5 ++---
 include/xen/xen.h                 | 4 +++-
 5 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.17.0
