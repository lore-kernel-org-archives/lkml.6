Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeDSPM6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:12:58 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37979 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeDSPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:12:57 -0400
X-Google-Smtp-Source: AIpwx49FQRrVNnng83his/nuTvCxXZTxdYXPzQ6T1wHv5O2AVFYdLzY+TURdB/hPWK9QJuCJuySenA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/2] memory: aemif: add support for machine code
Date: Thu, 19 Apr 2018 17:12:50 +0200
Message-Id: <20180419151252.26212-1-brgl@bgdev.pl>
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

v1 -> v2:
- actually iterate over abus entries instead of always accessing the
  first one

Bartosz Golaszewski (2):
  memory: aemif: don't rely on kbuild for driver's name
  memory: aemif: add support for board files

 drivers/memory/ti-aemif.c              | 60 +++++++++++++++++---------
 include/linux/platform_data/ti-aemif.h | 25 +++++++++++
 2 files changed, 64 insertions(+), 21 deletions(-)

-- 
2.17.0
