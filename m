Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D6A2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D6A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeIZVhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:37:22 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:3082 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727157AbeIZVhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:37:21 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id A3/BA-16401-884ABAB5; Wed, 26 Sep 2018 15:23:52 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRWlGSWpSXmKPExsUSt3OpsW77ktX
  RBnseGlg0L17PZtG1eieLxeVdc9gsFi1rZbZ4svAMkwOrx7yTgR77565h99j5vYHd4/MmuQCW
  KNbMvKT8igTWjBlHbrEXPBSqWDRxKnsD41P+LkYuDiGB9YwSvyfdZ+9i5AByKiRWruUHMXkFM
  iWObqwAMTkF3CX27CvuYuQEKnCTeD63iQ3EZhOwkJh84gGYzSKgKtHbNZ0dxBYWCJPY9OAcO8
  h0EYEeRomNR5aAJZgFkiTWvu1hBrF5BQQlTs58wgIRl5A4+OIFM8QCA4nTCxrB4hIC9hLT319
  lBrlBQkBfovFYLETYUOL7rG9QJeYSXdOnMk9gFJyFZOosJFMXMDKtYjRPKspMzyjJTczM0TU0
  MNA1NDTSNbQ01jUx1kus0k3USy3VLU8tLtE11EssL9YrrsxNzknRy0st2cQIDPyUgoPaOxifL
  E8/xCjJwaQkyqvgszpaiC8pP6UyI7E4I76oNCe1+BCjDAeHkgTvmsVAOcGi1PTUirTMHGAMwq
  QlOHiURHhNQNK8xQWJucWZ6RCpU4yKUuK8VSAJAZBERmkeXBss7i8xykoJ8zIyMDAI8RSkFuV
  mlqDKv2IU52BUEub1ApnCk5lXAjf9FdBiJqDFE3pWgCwuSURISTUw9v9gdlotHrTvpOoOLpcF
  l79+fMon9P+OjYmzRXP2SflLu8zcjh40n7Fl4vEKD31xqSLmZK6F97dumHFmv/YRNsNA7+d1/
  fFmkrHzvTlZjVZPN1uR91jA6jEfyw8H16s3pzA42N+o3iVRIPODw6vhkymriMoSMR7HpSs83n
  7feGWvWNJeO71NSizFGYmGWsxFxYkAGW2BiPYCAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-25.tower-268.messagelabs.com!1537975431!167089!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16801 invoked from network); 26 Sep 2018 15:23:51 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-25.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 26 Sep 2018 15:23:51 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 26 Sep 2018 16:23:51 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 2BE5A3FBB8; Wed, 26 Sep 2018 16:23:51 +0100 (BST)
Message-ID: <8ef602efbb7ee84ec86225ae4b9e1d138154e51b.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1537975081.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Wed, 26 Sep 2018 16:23:51 +0100
Subject: [PATCH 1/2] usb: typec: fusb302: Correct spelling mistake for
 toggling state
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 26/09/2018 13:22:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a typo in the enum name of the 'OFF' state for toggling
(TOGGLINE instead of TOGGLING). This commit resolves that trivial
spelling inconsistency.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/usb/typec/tcpm/fusb302.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 6e9370a..fd851d8 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -42,7 +42,7 @@
 #define T_BC_LVL_DEBOUNCE_DELAY_MS 30
 
 enum toggling_mode {
-	TOGGLINE_MODE_OFF,
+	TOGGLING_MODE_OFF,
 	TOGGLING_MODE_DRP,
 	TOGGLING_MODE_SNK,
 	TOGGLING_MODE_SRC,
@@ -594,7 +594,7 @@ static int fusb302_set_toggling(struct fusb302_chip *chip,
 	chip->intr_comp_chng = false;
 	/* configure toggling mode: none/snk/src/drp */
 	switch (mode) {
-	case TOGGLINE_MODE_OFF:
+	case TOGGLING_MODE_OFF:
 		ret = fusb302_i2c_mask_write(chip, FUSB_REG_CONTROL2,
 					     FUSB_REG_CONTROL2_MODE_MASK,
 					     FUSB_REG_CONTROL2_MODE_NONE);
@@ -626,7 +626,7 @@ static int fusb302_set_toggling(struct fusb302_chip *chip,
 		break;
 	}
 
-	if (mode == TOGGLINE_MODE_OFF) {
+	if (mode == TOGGLING_MODE_OFF) {
 		/* mask TOGDONE interrupt */
 		ret = fusb302_i2c_set_bits(chip, FUSB_REG_MASKA,
 					   FUSB_REG_MASKA_TOGDONE);
@@ -702,7 +702,7 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
 		ret = -EINVAL;
 		goto done;
 	}
-	ret = fusb302_set_toggling(chip, TOGGLINE_MODE_OFF);
+	ret = fusb302_set_toggling(chip, TOGGLING_MODE_OFF);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot stop toggling, ret=%d", ret);
 		goto done;
@@ -1292,7 +1292,7 @@ static int fusb302_handle_togdone_snk(struct fusb302_chip *chip,
 		tcpm_cc_change(chip->tcpm_port);
 	}
 	/* turn off toggling */
-	ret = fusb302_set_toggling(chip, TOGGLINE_MODE_OFF);
+	ret = fusb302_set_toggling(chip, TOGGLING_MODE_OFF);
 	if (ret < 0) {
 		fusb302_log(chip,
 			    "cannot set toggling mode off, ret=%d", ret);
@@ -1388,7 +1388,7 @@ static int fusb302_handle_togdone_src(struct fusb302_chip *chip,
 		tcpm_cc_change(chip->tcpm_port);
 	}
 	/* turn off toggling */
-	ret = fusb302_set_toggling(chip, TOGGLINE_MODE_OFF);
+	ret = fusb302_set_toggling(chip, TOGGLING_MODE_OFF);
 	if (ret < 0) {
 		fusb302_log(chip,
 			    "cannot set toggling mode off, ret=%d", ret);
-- 
1.9.1

