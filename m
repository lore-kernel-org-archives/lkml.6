Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755234AbeDZSsU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:48:20 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44259 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbeDZSsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:48:18 -0400
X-Google-Smtp-Source: AB8JxZoYB8UixOZFAIYbhBzGDT/OYd/C56w3YLwb9Peqss31GmCZXYJJf4nMQDpThwFcrOJ0e0HbQw==
From: Kamal Dasu <kdasu.kdev@gmail.com>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jon.mason@broadcom.com, yendapally.reddy@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 0/2] spi: bcm-qspi: Fix spi-nor chip select logic for BSPI
Date: Thu, 26 Apr 2018 14:47:59 -0400
Message-Id: <1524768481-16347-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the spi-nor master controller always verify the chip select
bit in the cs register. Also do not use CDRAM PCS bit in BSPI mode.
Additionally make sure to enable/disable BSPI_MAST_N_BOOT_CTRL while using
BSPI mode.

V2 changes:
- Added "Fixes:" tag to 1/2 and 2/2 patches

Kamal Dasu (2):
  spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
  spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL

 drivers/spi/spi-bcm-qspi.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

-- 
2.7.4
