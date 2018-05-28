Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032426AbeE1KTI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030676AbeE1KTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:19:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 082/268] scsi: storvsc: Increase cmd_per_lun for higher speed devices
Date: Mon, 28 May 2018 12:00:56 +0200
Message-Id: <20180528100211.385480794@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>

[ Upstream commit cabe92a55e3a12005a4ac4d3954c9a174b0efe2a ]

Increase cmd_per_lun to allow more I/Os in progress per device,
particularly for NVMe's.  The Hyper-V host side can handle the higher
count with no issues.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/storvsc_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1538,7 +1538,7 @@ static struct scsi_host_template scsi_dr
 	.eh_timed_out =		storvsc_eh_timed_out,
 	.slave_alloc =		storvsc_device_alloc,
 	.slave_configure =	storvsc_device_configure,
-	.cmd_per_lun =		255,
+	.cmd_per_lun =		2048,
 	.this_id =		-1,
 	.use_clustering =	ENABLE_CLUSTERING,
 	/* Make sure we dont get a sg segment crosses a page boundary */
