Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38982C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128C421871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfADQBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:01:04 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.113]:14321 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727192AbfADQBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:01:02 -0500
Received: from [67.219.250.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-west-2.aws.symcld.net id 1C/4A-21206-C338F2C5; Fri, 04 Jan 2019 16:01:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRWlGSWpSXmKPExsXi5LtOQNemWT/
  GoG8Bk8XhRS8YLb5+u81ucfPTN1aLy7vmsDmweOycdZfd49e2NSwenzfJBTBHsWbmJeVXJLBm
  TDt8ir3gpVjF26cNjA2MD4S6GLk4hARWMUosen2bHcLZwiix7vR/IIeTg01AR2LK/sMsILaIg
  LjEtSNnweLMApUSz35vZgOxhQVsJX5Nm8EKYrMIqEjcfrCGCcTmFXCT2LjoN5gtISAncfNcJz
  OIzSngLrHv0zRGEFsIqObjjw9sEPWCEidnPmGBmC8hcfDFC2aIGmWJLSsuMELMUZBYe+A80wR
  G/llIWmYhaVnAyLSK0SKpKDM9oyQ3MTNH19DAQNfQ0EjX0NhE19DSQC+xSjdJr7RYtzy1uETX
  SC+xvFivuDI3OSdFLy+1ZBMjMIBTCtr27WB8sTz9EKMkB5OSKG8as36MEF9SfkplRmJxRnxRa
  U5q8SFGGQ4OJQnemY1AOcGi1PTUirTMHGAswaQlOHiURHhvg6R5iwsSc4sz0yFSpxgVpcR5zz
  YAJQRAEhmleXBtsPi9xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYdxPIFJ7MvBK46a+AFjM
  BLTaR0AFZXJKIkJJqYGwKeCX+sCFh5sPuUOVV02TfXww0tlvIJabert276qRi4GX/Y2/0Z1+b
  dy1ufpmnjpfs880xaszXI44Ws+/YJ7a0TfrFRj6n9u9vPf5XsPREvroUwP/BLieCR03g8SufC
  bmLz/1uX/JuSlBn7PG7C7vrAz0V5veweE6Nj5y37DSX61KDWQ//WSixFGckGmoxFxUnAgC7Q8
  tX2gIAAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-6.tower-345.messagelabs.com!1546617658!6169452!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3039 invoked from network); 4 Jan 2019 16:00:59 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-6.tower-345.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Jan 2019 16:00:59 -0000
Received: from MTK-SMS-XCH01.digi.com (10.10.8.195) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 4 Jan 2019
 10:00:58 -0600
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 MTK-SMS-XCH01.digi.com (10.10.8.195) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 4 Jan 2019 10:00:58 -0600
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <hadess@hadess.net>
CC:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex.gonzalez@digi.com>
Subject: [PATCH] Input: goodix - decouple irq and reset lines
Date:   Fri, 4 Jan 2019 17:00:48 +0100
Message-ID: <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Goodix touch controller allows the use of two optional GPIOs (RESET
and INT) to reset the touch controller, select the I2C address of the
device and exit the device from sleep mode.

The current implementation requires both GPIOs to be provided, however,
it is possible to provide only the INT line and not to have the RESET line
available but pulled-up.

Designs that only provide the INT line are able to operate the touch on
the default I2C address but will not be able to reset the touch via
software or place the device in sleep mode.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 drivers/input/touchscreen/goodix.c | 59 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..8d96b0b771b6 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -484,34 +484,39 @@ static int goodix_reset(struct goodix_ts_data *ts)
 {
 	int error;
 
-	/* begin select I2C slave addr */
-	error = gpiod_direction_output(ts->gpiod_rst, 0);
-	if (error)
-		return error;
+	if (ts->gpiod_rst) {
+		/* begin select I2C slave addr */
+		error = gpiod_direction_output(ts->gpiod_rst, 0);
+		if (error)
+			return error;
 
-	msleep(20);				/* T2: > 10ms */
+		msleep(20);				/* T2: > 10ms */
 
-	/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
-	error = gpiod_direction_output(ts->gpiod_int, ts->client->addr == 0x14);
-	if (error)
-		return error;
+		/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
+		error = gpiod_direction_output(ts->gpiod_int,
+				ts->client->addr == 0x14);
+		if (error)
+			return error;
 
-	usleep_range(100, 2000);		/* T3: > 100us */
+		usleep_range(100, 2000);		/* T3: > 100us */
 
-	error = gpiod_direction_output(ts->gpiod_rst, 1);
-	if (error)
-		return error;
+		error = gpiod_direction_output(ts->gpiod_rst, 1);
+		if (error)
+			return error;
 
-	usleep_range(6000, 10000);		/* T4: > 5ms */
+		usleep_range(6000, 10000);		/* T4: > 5ms */
 
-	/* end select I2C slave addr */
-	error = gpiod_direction_input(ts->gpiod_rst);
-	if (error)
-		return error;
+		/* end select I2C slave addr */
+		error = gpiod_direction_input(ts->gpiod_rst);
+		if (error)
+			return error;
+	}
 
-	error = goodix_int_sync(ts);
-	if (error)
-		return error;
+	if (ts->gpiod_int) {
+		error = goodix_int_sync(ts);
+		if (error)
+			return error;
+	}
 
 	return 0;
 }
@@ -786,13 +791,11 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	if (ts->gpiod_int && ts->gpiod_rst) {
-		/* reset the controller */
-		error = goodix_reset(ts);
-		if (error) {
-			dev_err(&client->dev, "Controller reset failed.\n");
-			return error;
-		}
+	/* reset the controller */
+	error = goodix_reset(ts);
+	if (error) {
+		dev_err(&client->dev, "Controller reset failed.\n");
+		return error;
 	}
 
 	error = goodix_i2c_test(client);
