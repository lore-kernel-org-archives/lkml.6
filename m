Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F19AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C91208E3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfABBEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:04:15 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:51884 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfABBEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 20:04:14 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07709014|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.DgGqrkE_1546391044;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DgGqrkE_1546391044)
          by smtp.aliyun-inc.com(10.147.42.253);
          Wed, 02 Jan 2019 09:04:11 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [RFC v2 0/2] pstore/rom: new support logger for block devices
Date:   Wed,  2 Jan 2019 09:03:56 +0800
Message-Id: <1546391038-31967-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why should we need pstore_rom?
1. Most embedded intelligent equipment have no persistent ram, which
increases costs. We perfer to cheaper solutions, like block devices.
In fast, there is already a sample for block device logger in driver
MTD (drivers/mtd/mtdoops.c).
2. Do not any equipment have battery, which means that it lost all data
on general ram if power failure. Pstore has little to do for these
equipments.

[PATCH v1]
On patch 1:
Core codes of pstore_rom, which works well on allwinner(sunxi) platform.
On patch 2:
A sample for pstore_rom, using general ram rather than block device.

[PATCH v2]
On patch 1:
Fix build as module error for redefinition of 'romz_unregister' and 'romz_register'

liaoweixiong (2):
  pstore/rom: new support logger for block devices
  pstore/rom: add sample for pstore_rom

 fs/pstore/Kconfig          |  16 +
 fs/pstore/Makefile         |   5 +
 fs/pstore/rombuf.c         |  46 +++
 fs/pstore/romzone.c        | 965 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore_rom.h |  61 +++
 5 files changed, 1093 insertions(+)
 create mode 100644 fs/pstore/rombuf.c
 create mode 100644 fs/pstore/romzone.c
 create mode 100644 include/linux/pstore_rom.h

-- 
1.9.1

