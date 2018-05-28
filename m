Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165424AbeE1Nma (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937470AbeE1Kn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:43:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dong Bo <dongbo4@huawei.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 063/496] libata: Fix compile warning with ATA_DEBUG enabled
Date: Mon, 28 May 2018 11:57:28 +0200
Message-Id: <20180528100322.440604317@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dong Bo <dongbo4@huawei.com>

[ Upstream commit 0d3e45bc6507bd1f8728bf586ebd16c2d9e40613 ]

This fixs the following comile warnings with ATA_DEBUG enabled,
which detected by Linaro GCC 5.2-2015.11:

  drivers/ata/libata-scsi.c: In function 'ata_scsi_dump_cdb':
  ./include/linux/kern_levels.h:5:18: warning: format '%d' expects
  argument of type 'int', but argument 6 has type 'u64 {aka long
   long unsigned int}' [-Wformat=]

tj: Patch hand-applied and description trimmed.

Signed-off-by: Dong Bo <dongbo4@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4287,7 +4287,7 @@ static inline void ata_scsi_dump_cdb(str
 #ifdef ATA_DEBUG
 	struct scsi_device *scsidev = cmd->device;
 
-	DPRINTK("CDB (%u:%d,%d,%d) %9ph\n",
+	DPRINTK("CDB (%u:%d,%d,%lld) %9ph\n",
 		ap->print_id,
 		scsidev->channel, scsidev->id, scsidev->lun,
 		cmd->cmnd);
