Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeDRPgC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:36:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38722 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbeDRPf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:35:57 -0400
X-Google-Smtp-Source: AIpwx4/Wh+QAA72vEpTr/XO4NndNtJZZDtMRxmDudMDLc7Xf8MmEf7hwii8kmoCD3JRT8cePnljY1w==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] memory: aemif: add support for machine code
Date: Wed, 18 Apr 2018 17:35:50 +0200
Message-Id: <20180418153552.14632-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to the series that contained both changes to the
aemif driver and platform code. It contains only the driver changes.

As the first step in removing duplicate support for aemif from the
kernel we need to add support for board files to the aemif memory
driver.

First patch just uses a static string for the ti-aemif driver name.

The second adds support for board files to the aemif driver.

This series includes changes requested by Sekhar in his code review:
- made aemif the parent of each sub-device before registering it
- documented the new members in aemif_platform_data

Bartosz Golaszewski (2):
  memory: aemif: don't rely on kbuild for driver's name
  memory: aemif: add support for board files

 drivers/memory/ti-aemif.c              | 60 +++++++++++++++++---------
 include/linux/platform_data/ti-aemif.h | 25 +++++++++++
 2 files changed, 64 insertions(+), 21 deletions(-)

-- 
2.17.0
