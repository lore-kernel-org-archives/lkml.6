Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeBLTqk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:46:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752231AbeBLTqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:46:33 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] extcon: axp288: Constify the axp288_pwr_up_down_info array
Date: Mon, 12 Feb 2018 20:46:28 +0100
Message-Id: <20180212194630.7216-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the axp288_pwr_up_down_info array const char * const, this leads
to the following section size changes:

.text     0x674 -> 0x664
.data     0x148 -> 0x0f0
.rodata   0x0b4 -> 0x114

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-axp288.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 0a44d43802fe..c8f7b6435679 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -106,7 +106,7 @@ struct axp288_extcon_info {
 };
 
 /* Power up/down reason string array */
-static char *axp288_pwr_up_down_info[] = {
+static const char * const axp288_pwr_up_down_info[] = {
 	"Last wake caused by user pressing the power button",
 	"Last wake caused by a charger insertion",
 	"Last wake caused by a battery insertion",
@@ -124,7 +124,7 @@ static char *axp288_pwr_up_down_info[] = {
  */
 static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
 {
-	char **rsi;
+	const char * const *rsi;
 	unsigned int val, i, clear_mask = 0;
 	int ret;
 
-- 
2.14.3
