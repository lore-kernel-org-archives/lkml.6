Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756425AbeDYS2S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:28:18 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36193 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756206AbeDYS2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:28:12 -0400
X-Google-Smtp-Source: AB8JxZryC/wa+/su4MNI+dB5s/q5Wbs49X7BpbZzEdsLLLqiiU8xzr+UW7TSlYDBVe7D9RyEdkehAQ==
From: Kamal Dasu <kdasu.kdev@gmail.com>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jon.mason@broadcom.com, yendapally.reddy@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v1 0/2] spi: bcm-qspi: Fix spi-nor chip select logic for BSPI
Date: Wed, 25 Apr 2018 14:28:03 -0400
Message-Id: <1524680885-4600-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi-nor master controller driver needs to verify the chip select bit in the
cs register for any cs change during trasfers. Also CDRAM PCS field not used
in BSPI mode, set defualt to ~1 indicating active low for zeroth bit.
Also always enable/disable BSPI_MAST_N_BOOT_CTRL when using BSPI mode.


*** BLURB HERE ***

Kamal Dasu (2):
  spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
  spi: bcm-qspi: Always change BSPI_MAST_N_BOOT_CTRL state

 drivers/spi/spi-bcm-qspi.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

-- 
2.7.4
