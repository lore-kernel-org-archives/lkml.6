Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF5DC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EC82085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfAWDOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:14:50 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:6324 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfAWDOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:14:50 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BC181ED496CEDC05D35E;
        Wed, 23 Jan 2019 11:14:46 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0N3Eg9g000641;
        Wed, 23 Jan 2019 11:14:42 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012311150170-23654282 ;
          Wed, 23 Jan 2019 11:15:01 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V2 0/6] add pvpanic driver framework
Date:   Wed, 23 Jan 2019 19:37:51 +0800
Message-Id: <1548243477-60654-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-23 11:15:01,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-23 11:14:34,
        Serialize complete at 2019-01-23 11:14:34
X-MAIL: mse01.zte.com.cn x0N3Eg9g000641
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


Peng Hao (6):
  misc/pvpanic: preparing for pvpanic driver framework
  misc/pvpanic: Add pvpanic driver framework
  misc/pvpanic: add API for pvpanic driver framework
  misc/pvpanic: add pvpanic acpi driver
  misc/pvpanic: add pvpanic mmio driver
  misc/pvpanic: add pvpanic pci driver

 drivers/misc/Kconfig                |   9 +-
 drivers/misc/Makefile               |   2 +-
 drivers/misc/pvpanic.c              | 192 ------------------------------------
 drivers/misc/pvpanic/Kconfig        |  25 +++++
 drivers/misc/pvpanic/Makefile       |   8 ++
 drivers/misc/pvpanic/pvpanic-acpi.c |  77 +++++++++++++++
 drivers/misc/pvpanic/pvpanic-of.c   |  53 ++++++++++
 drivers/misc/pvpanic/pvpanic-pci.c  |  56 +++++++++++
 drivers/misc/pvpanic/pvpanic.c      | 131 ++++++++++++++++++++++++
 drivers/misc/pvpanic/pvpanic.h      |  14 +++
 10 files changed, 366 insertions(+), 201 deletions(-)
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

