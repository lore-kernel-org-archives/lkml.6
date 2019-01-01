Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03207C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42BB2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfAAJ1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 04:27:36 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:39119 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728466AbfAAJ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 04:27:36 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07773841|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10423;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.Dg-i0Ha_1546334844;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Dg-i0Ha_1546334844)
          by smtp.aliyun-inc.com(10.147.41.120);
          Tue, 01 Jan 2019 17:27:32 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [RFC 0/2] pstore/rom: new support logger for block devices
Date:   Tue,  1 Jan 2019 17:27:23 +0800
Message-Id: <1546334845-24255-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pstore_rom is similar to pstore_ram, but dump log to block devices
rather than persistent ram.

Why should we need pstore_rom?
1. Most embedded intelligent equipment have no persistent ram, which
increases costs. We perfer to cheaper solutions, like block devices.
In fast, there is already a sample for block device logger in driver
MTD (drivers/mtd/mtdoops.c).
2. Do not any equipment have battery, which means that it lost all data
on general ram if power failure. Pstore has little to do for these
equipments.

On patch 1:
Core codes of pstore_rom, which works well on allwinner(sunxi) platform.
On patch 2:
A sample for pstore_rom, using general ram rather than block device.

liaoweixiong (2):
  pstore/rom: new support logger for block devices
  pstore/rom: add sample for pstore_rom

 fs/pstore/Kconfig          |  16 +
 fs/pstore/Makefile         |   5 +
 fs/pstore/rombuf.c         |  46 +++
 fs/pstore/romzone.c        | 965 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore_rom.h |  68 ++++
 5 files changed, 1100 insertions(+)
 create mode 100644 fs/pstore/rombuf.c
 create mode 100644 fs/pstore/romzone.c
 create mode 100644 include/linux/pstore_rom.h

-- 
1.9.1

