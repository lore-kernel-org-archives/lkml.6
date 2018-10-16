Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C21C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6664F208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6664F208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeJPN2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:28:05 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57164 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeJPN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:28:04 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 4095627FF6; Tue, 16 Oct 2018 01:39:21 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <cover.1539667885.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 0/6] mac_esp, zorro_esp, esp_scsi: Various improvements
Date:   Tue, 16 Oct 2018 16:31:25 +1100
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

 drivers/scsi/Kconfig     |   5 +
 drivers/scsi/esp_scsi.c  | 197 +++++++++++++++++++++++++-------
 drivers/scsi/esp_scsi.h  |  11 +-
 drivers/scsi/mac_esp.c   | 171 +---------------------------
 drivers/scsi/zorro_esp.c | 240 ++++++---------------------------------
 5 files changed, 208 insertions(+), 416 deletions(-)

-- 
2.18.1

