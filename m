Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAFCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C798E222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfBPI3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:29:09 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:44622 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfBPI3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:29:08 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 1BBD8E18DA360B86C2CF;
        Sat, 16 Feb 2019 16:29:05 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1G8Sta9021004;
        Sat, 16 Feb 2019 16:28:55 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021616290744-251062 ;
          Sat, 16 Feb 2019 16:29:07 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V5 0/4] add pvpanic driver framework
Date:   Sun, 17 Feb 2019 00:50:39 +0800
Message-Id: <1550335843-108902-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-16 16:29:07,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-16 16:28:36,
        Serialize complete at 2019-02-16 16:28:36
X-MAIL: mse01.zte.com.cn x1G8Sta9021004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QEMU community requires additional PCI devices to simulate PVPANIC
devices so that some architectures can not occupy precious less than 4G
of memory space.
Previously, I added PCI driver directly to the original version of the driver,
which made the whole driver file look a bit cluttered. So Andy Shevchenko suggests:
"I would recommend to split it in a way how it's done for ChipIdea USB driver,
for example. (drivers/usb/chipidea if I'm not mistaken)".

v4 ---> v5 : Merge some patches to one for avoiding bisectability issues.
             Make sure that just one pvpanic device is working.

v3 ---> v4 : add help text info in Konfig.
             adjust structure definition position.
v2 ---> v3 : add change infomation.

v1 ---> v2 : add patch 0000 to descript the whole patch series.
             modify text infomation.
             modify "SPDX-License-Identifier: GPL-2.0-or-later"
             to "SPDX-License-Identifier: GPL-2.0+"

Peng Hao (4):
  misc/pvpanic: preparing for pvpanic driver framework
  misc/pvpanic: Add pvpanic driver framework
  misc/pvpanic: Avoid initializing multiple pvpanic devices
  misc/pvpanic: add new pvpanic pci driver

 drivers/misc/Kconfig                |   9 +-
 drivers/misc/Makefile               |   2 +-
 drivers/misc/pvpanic.c              | 192 ------------------------------------
 drivers/misc/pvpanic/Kconfig        |  34 +++++++
 drivers/misc/pvpanic/Makefile       |   8 ++
 drivers/misc/pvpanic/pvpanic-acpi.c |  77 +++++++++++++++
 drivers/misc/pvpanic/pvpanic-of.c   |  53 ++++++++++
 drivers/misc/pvpanic/pvpanic-pci.c  |  56 +++++++++++
 drivers/misc/pvpanic/pvpanic.c      | 140 ++++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  15 +++
 10 files changed, 385 insertions(+), 201 deletions(-)
 delete mode 100644 drivers/misc/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 create mode 100644 drivers/misc/pvpanic/pvpanic-acpi.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-of.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

-- 
1.8.3.1

