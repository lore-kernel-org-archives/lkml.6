Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeFAOys (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:54:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50967 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeFAOyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:54:47 -0400
From: Colin King <colin.king@canonical.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: rtsx: make several functions static
Date: Fri,  1 Jun 2018 15:54:44 +0100
Message-Id: <20180601145444.16769-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Several helper functions are local to the source and do not
need to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'rtsx_pm_power_saving' was not declared. Should it be static?
symbol 'rtsx_set_l1off_sub_cfg_d0' was not declared. Should it be static?
symbol 'rtsx_pm_full_on' was not declared. Should it be static?
symbol 'rtsx_comm_set_ltr_latency' was not declared. Should it be static?
symbol 'rtsx_pci_process_ocp' was not declared. Should it be static?
symbol 'rtsx_pci_process_ocp_interrupt' was not declared. Should it be
static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index e8f1d4bb806a..da445223f4cc 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -80,7 +80,7 @@ static inline void rtsx_pci_disable_aspm(struct rtsx_pcr *pcr)
 		0xFC, 0);
 }
 
-int rtsx_comm_set_ltr_latency(struct rtsx_pcr *pcr, u32 latency)
+static int rtsx_comm_set_ltr_latency(struct rtsx_pcr *pcr, u32 latency)
 {
 	rtsx_pci_write_register(pcr, MSGTXDATA0,
 				MASK_8_BIT_DEF, (u8) (latency & 0xFF));
@@ -143,7 +143,7 @@ int rtsx_set_l1off_sub(struct rtsx_pcr *pcr, u8 val)
 	return 0;
 }
 
-void rtsx_set_l1off_sub_cfg_d0(struct rtsx_pcr *pcr, int active)
+static void rtsx_set_l1off_sub_cfg_d0(struct rtsx_pcr *pcr, int active)
 {
 	if (pcr->ops->set_l1off_cfg_sub_d0)
 		pcr->ops->set_l1off_cfg_sub_d0(pcr, active);
@@ -162,7 +162,7 @@ static void rtsx_comm_pm_full_on(struct rtsx_pcr *pcr)
 		rtsx_set_l1off_sub_cfg_d0(pcr, 1);
 }
 
-void rtsx_pm_full_on(struct rtsx_pcr *pcr)
+static void rtsx_pm_full_on(struct rtsx_pcr *pcr)
 {
 	if (pcr->ops->full_on)
 		pcr->ops->full_on(pcr);
@@ -967,13 +967,13 @@ static void rtsx_pci_card_detect(struct work_struct *work)
 				pcr->slots[RTSX_MS_CARD].p_dev);
 }
 
-void rtsx_pci_process_ocp(struct rtsx_pcr *pcr)
+static void rtsx_pci_process_ocp(struct rtsx_pcr *pcr)
 {
 	if (pcr->ops->process_ocp)
 		pcr->ops->process_ocp(pcr);
 }
 
-int rtsx_pci_process_ocp_interrupt(struct rtsx_pcr *pcr)
+static int rtsx_pci_process_ocp_interrupt(struct rtsx_pcr *pcr)
 {
 	if (pcr->option.ocp_en)
 		rtsx_pci_process_ocp(pcr);
@@ -1094,7 +1094,7 @@ static void rtsx_comm_pm_power_saving(struct rtsx_pcr *pcr)
 	rtsx_enable_aspm(pcr);
 }
 
-void rtsx_pm_power_saving(struct rtsx_pcr *pcr)
+static void rtsx_pm_power_saving(struct rtsx_pcr *pcr)
 {
 	if (pcr->ops->power_saving)
 		pcr->ops->power_saving(pcr);
-- 
2.17.0
