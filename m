Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918FCC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7D72083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7D72083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeJYXnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:43:01 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.211]:45709 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727357AbeJYXnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:43:00 -0400
Received: from [67.219.247.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-d.us-east-1.aws.symcld.net id 22/83-11391-ABCD1DB5; Thu, 25 Oct 2018 15:09:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRWlGSWpSXmKPExsXi5LtOQHfXnYv
  RBv8WKVn0njvJZDH/yDlWiytf37NZbNx8m8Vi1dSdLBabHl9jtej6tZLZ4vKuOWwWS69fZLJo
  3XuE3eLv9k0sFi+2iFv83DWPxYHXY828NYweO2fdZffYtKqTzWP7twesHve7jzN5bF5S77Hx3
  Q4mj/6/Bh6fN8kFcEaxZuYl5VcksGbsPzuLqeCkUMXz9ZsZGxhv8ncxcnEICaxmlFg2cQkrhL
  OGUWL+ye1sEM4WRok7X++wdzFycrAJ6EhM2X+YBcQWEciV2P14B1gHs8AUJonT33axgSSEBbw
  lHj0/wwRiswioSsz5upgRxOYVcJNoejEDrFlCQE7i5rlOZhCbU8Bd4srU+awgthBQzYJL/9gh
  6gUlTs58AlbPLCAhcfDFC2aIGmWJLSsuMELMUZBYe+A80wRGgVlIWmYhaVnAyLSK0TypKDM9o
  yQ3MTNH19DAQNfQ0AiIdY0MTfQSq3RT9EqLdVMTi0t0DfUSy4v1iitzk3NS9PJSSzYxAmMtpY
  D72g7GnV3phxglOZiURHkTUy5GC/El5adUZiQWZ8QXleakFh9ilOHgUJLgTboNlBMsSk1PrUj
  LzAFGPUxagoNHSYT3HEiat7ggMbc4Mx0idYpRUUqctx0kIQCSyCjNg2uDJZpLjLJSwryMDAwM
  QjwFqUW5mSWo8q8YxTkYlYR5NUGm8GTmlcBNfwW0mAlo8QyFCyCLSxIRUlINjAfTt9ZzXeZve
  q9lyZd6zXoyn/jaxKjIq52H1lxcnei+bX1htsq9nY0BSkpd9h1ctiaZAsdkw/QWLun3/S9mp7
  jGpaW0pejCSe4wQ6npLydW/oz45O09wyBny7eCnQuKDvVy+zOWXfc+KKS3SOjYB2EV81XPl79
  gT682lpulwbFscaJo+MISJZbijERDLeai4kQA0bdNjC8DAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-28.tower-425.messagelabs.com!1540480185!1231612!2
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7606 invoked from network); 25 Oct 2018 15:09:46 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-28.tower-425.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Oct 2018 15:09:46 -0000
Received: from MTK-SMS-XCH02.digi.com (10.10.8.196) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct 2018
 10:09:45 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH02.digi.com
 (10.10.8.196) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct
 2018 10:09:45 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 25 Oct 2018 17:09:43 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v1 1/4] drm/panel: simple: Add AUO G101EVN010 panel support
Date:   Thu, 25 Oct 2018 17:09:30 +0200
Message-ID: <1540480173-12009-2-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change adds support for the AU Optronics G101EVN010 10.1" TFT LCD
panel.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 .../bindings/display/panel/auo,g101evn010          | 12 ++++++++++
 drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g101evn010

diff --git a/Documentation/devicetree/bindings/display/panel/auo,g101evn010 b/Documentation/devicetree/bindings/display/panel/auo,g101evn010
new file mode 100644
index 000000000000..bc6a0c858e23
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,g101evn010
@@ -0,0 +1,12 @@
+AU Optronics Corporation 10.1" (1280x800) color TFT LCD panel
+
+Required properties:
+- compatible: should be "auo,g101evn010"
+- power-supply: as specified in the base binding
+
+Optional properties:
+- backlight: as specified in the base binding
+- enable-gpios: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..65a0dd166637 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -631,6 +631,30 @@ static const struct panel_desc auo_g104sn02 = {
 	},
 };
 
+static const struct drm_display_mode auo_g101evn010_mode = {
+	.clock = 68930,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 82,
+	.hsync_end = 1280 + 82 + 2,
+	.htotal = 1280 + 82 + 2 + 84,
+	.vdisplay = 800,
+	.vsync_start = 800 + 8,
+	.vsync_end = 800 + 8 + 2,
+	.vtotal = 800 + 8 + 2 + 6,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc auo_g101evn010 = {
+	.modes = &auo_g101evn010_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 216,
+		.height = 135,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct display_timing auo_g133han01_timings = {
 	.pixelclock = { 134000000, 141200000, 149000000 },
 	.hactive = { 1920, 1920, 1920 },
@@ -2355,6 +2379,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "auo,g104sn02",
 		.data = &auo_g104sn02,
 	}, {
+		.compatible = "auo,g101evn010",
+		.data = &auo_g101evn010,
+	}, {
 		.compatible = "auo,g133han01",
 		.data = &auo_g133han01,
 	}, {
