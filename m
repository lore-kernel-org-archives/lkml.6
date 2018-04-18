Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeDRLan (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:30:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56878 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeDRLal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:30:41 -0400
From: Colin King <colin.king@canonical.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mptfc: fix spelling mistake in macro names
Date: Wed, 18 Apr 2018 12:30:38 +0100
Message-Id: <20180418113038.1239-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Rename macros MPI_FCPORTPAGE0_SUPPORT_SPEED_UKNOWN and
MPI_FCPORTPAGE0_CURRENT_SPEED_UKNOWN to add in missing N in UNKNOWN

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/message/fusion/lsi/mpi_cnfg.h | 4 ++--
 drivers/message/fusion/mptfc.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/message/fusion/lsi/mpi_cnfg.h b/drivers/message/fusion/lsi/mpi_cnfg.h
index 4e9c0ce94f27..059997f8ebce 100644
--- a/drivers/message/fusion/lsi/mpi_cnfg.h
+++ b/drivers/message/fusion/lsi/mpi_cnfg.h
@@ -1802,13 +1802,13 @@ typedef struct _CONFIG_PAGE_FC_PORT_0
 #define MPI_FCPORTPAGE0_SUPPORT_CLASS_2                 (0x00000002)
 #define MPI_FCPORTPAGE0_SUPPORT_CLASS_3                 (0x00000004)
 
-#define MPI_FCPORTPAGE0_SUPPORT_SPEED_UKNOWN            (0x00000000) /* (SNIA)HBA_PORTSPEED_UNKNOWN 0   Unknown - transceiver incapable of reporting */
+#define MPI_FCPORTPAGE0_SUPPORT_SPEED_UNKNOWN           (0x00000000) /* (SNIA)HBA_PORTSPEED_UNKNOWN 0   Unknown - transceiver incapable of reporting */
 #define MPI_FCPORTPAGE0_SUPPORT_1GBIT_SPEED             (0x00000001) /* (SNIA)HBA_PORTSPEED_1GBIT   1   1 GBit/sec */
 #define MPI_FCPORTPAGE0_SUPPORT_2GBIT_SPEED             (0x00000002) /* (SNIA)HBA_PORTSPEED_2GBIT   2   2 GBit/sec */
 #define MPI_FCPORTPAGE0_SUPPORT_10GBIT_SPEED            (0x00000004) /* (SNIA)HBA_PORTSPEED_10GBIT  4  10 GBit/sec */
 #define MPI_FCPORTPAGE0_SUPPORT_4GBIT_SPEED             (0x00000008) /* (SNIA)HBA_PORTSPEED_4GBIT   8   4 GBit/sec */
 
-#define MPI_FCPORTPAGE0_CURRENT_SPEED_UKNOWN            MPI_FCPORTPAGE0_SUPPORT_SPEED_UKNOWN
+#define MPI_FCPORTPAGE0_CURRENT_SPEED_UNKNOWN           MPI_FCPORTPAGE0_SUPPORT_SPEED_UNKNOWN
 #define MPI_FCPORTPAGE0_CURRENT_SPEED_1GBIT             MPI_FCPORTPAGE0_SUPPORT_1GBIT_SPEED
 #define MPI_FCPORTPAGE0_CURRENT_SPEED_2GBIT             MPI_FCPORTPAGE0_SUPPORT_2GBIT_SPEED
 #define MPI_FCPORTPAGE0_CURRENT_SPEED_10GBIT            MPI_FCPORTPAGE0_SUPPORT_10GBIT_SPEED
diff --git a/drivers/message/fusion/mptfc.c b/drivers/message/fusion/mptfc.c
index 6d461ca97150..06b175420be9 100644
--- a/drivers/message/fusion/mptfc.c
+++ b/drivers/message/fusion/mptfc.c
@@ -693,7 +693,7 @@ mptfc_display_port_link_speed(MPT_ADAPTER *ioc, int portnum, FCPortPage0_t *pp0d
 	state = pp0dest->PortState;
 
 	if (state != MPI_FCPORTPAGE0_PORTSTATE_OFFLINE &&
-	    new_speed != MPI_FCPORTPAGE0_CURRENT_SPEED_UKNOWN) {
+	    new_speed != MPI_FCPORTPAGE0_CURRENT_SPEED_UNKNOWN) {
 
 		old = old_speed == MPI_FCPORTPAGE0_CURRENT_SPEED_1GBIT ? "1 Gbps" :
 		       old_speed == MPI_FCPORTPAGE0_CURRENT_SPEED_2GBIT ? "2 Gbps" :
-- 
2.17.0
