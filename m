Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE105C71123
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3F2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA3F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJNOOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 10:14:15 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:42564 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeJNOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 10:14:14 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id E7B6B2A1C9; Sun, 14 Oct 2018 02:34:17 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <cover.1539497520.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 0/6] mac_esp, zorro_esp, esp_scsi: Various improvements
Date:   Sun, 14 Oct 2018 17:12:00 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has fixes and cleanup for mac_esp, zorro_esp and the
core esp_scsi driver.

These improvements include elimination of duplicated code temporarily
introduced for zorro_esp.


Finn Thain (6):
  zorro_esp: Limit DMA transfers to 65535 bytes
  esp_scsi: Track residual for PIO transfers
  esp_scsi: Grant disconnect privilege for untagged commands
  esp_scsi: Eliminate ESP_FLAG_DOING_SLOWCMD
  esp_scsi: De-duplicate PIO routines
  esp_scsi: Optimize PIO loops

 drivers/scsi/Kconfig     |   6 +
 drivers/scsi/esp_scsi.c  | 194 ++++++++++++++++++++++++-------
 drivers/scsi/esp_scsi.h  |  10 +-
 drivers/scsi/mac_esp.c   | 171 +---------------------------
 drivers/scsi/zorro_esp.c | 240 ++++++---------------------------------
 5 files changed, 209 insertions(+), 412 deletions(-)

-- 
2.18.1

