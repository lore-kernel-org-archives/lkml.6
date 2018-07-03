Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5278F2404A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5278F2404A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeGCUGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:06:48 -0400
Received: from anholt.net ([50.246.234.109]:42512 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbeGCUFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:05:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 05CCD10A1772;
        Tue,  3 Jul 2018 13:05:17 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id yqiK1AyZG5I0; Tue,  3 Jul 2018 13:05:15 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C9C0C10A1860;
        Tue,  3 Jul 2018 13:05:12 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 9A4EE2FE2FDE; Tue,  3 Jul 2018 13:05:11 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 2/4] bcm2835-drivers-next-2018-07-03
Date:   Tue,  3 Jul 2018 13:05:09 -0700
Message-Id: <20180703200511.2725-2-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180703200511.2725-1-eric@anholt.net>
References: <20180703200511.2725-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-drivers-next-2018-07-03

for you to fetch changes up to 5bfdc1097654eb31bcf2d10421ed769ef3b161c6:

  firmware: raspberrypi: Remove VLA usage (2018-07-03 12:56:12 -0700)

----------------------------------------------------------------
This pull request brings in the new HWMON driver for getting
under-voltage detection from the Raspberry Pi firmware, and a change
from Kees to remove another instance of VLA stack usage.

----------------------------------------------------------------
Kees Cook (1):
      firmware: raspberrypi: Remove VLA usage

Stefan Wahren (3):
      ARM: bcm2835: Add GET_THROTTLED firmware property
      hwmon: Add support for RPi voltage sensor
      firmware: raspberrypi: Register hwmon driver

 Documentation/hwmon/raspberrypi-hwmon      |  22 ++++
 drivers/firmware/raspberrypi.c             |  29 ++++-
 drivers/hwmon/Kconfig                      |  10 ++
 drivers/hwmon/Makefile                     |   1 +
 drivers/hwmon/raspberrypi-hwmon.c          | 166 +++++++++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |   1 +
 6 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/hwmon/raspberrypi-hwmon
 create mode 100644 drivers/hwmon/raspberrypi-hwmon.c
