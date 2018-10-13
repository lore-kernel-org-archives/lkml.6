Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FECDC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AA22098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AA22098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJMIqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:46:53 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47168 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeJMIqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:46:52 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 938F029FC4; Fri, 12 Oct 2018 21:11:48 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <cover.1539391876.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/6] mac_esp, zorro_esp, esp_scsi: Various improvements
Date:   Sat, 13 Oct 2018 11:51:16 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has fixes and cleanup for mac_esp, zorro_esp and the
core esp_scsi driver.

The improvements include elimination of duplicated code temporarily
introduced for zorro_esp.

Michael, would you please regression test this series on elgar,
if convenient? So far, only mac_esp has been tested with this code.


Finn Thain (6):
  zorro_esp: Limit DMA transfers to 65535 bytes
  esp_scsi: Track residual for PIO transfers
  esp_scsi: Grant disconnect privilege for untagged commands
  esp_scsi: Eliminate ESP_FLAG_DOING_SLOWCMD
  esp_scsi: De-duplicate PIO routines
  esp_scsi: Optimize PIO loops

 drivers/scsi/esp_scsi.c  | 192 +++++++++++++++++++++++++++++--------
 drivers/scsi/esp_scsi.h  |  10 +-
 drivers/scsi/mac_esp.c   | 171 ++-------------------------------
 drivers/scsi/zorro_esp.c | 240 +++++++----------------------------------------
 4 files changed, 201 insertions(+), 412 deletions(-)

-- 
2.16.4

