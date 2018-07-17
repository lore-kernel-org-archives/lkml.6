Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD25ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608022083D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="L9M2QZ6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608022083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbeGQJNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:13:41 -0400
Received: from onstation.org ([52.200.56.107]:58256 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbeGQJNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:13:38 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id EB6391A4E;
        Tue, 17 Jul 2018 08:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531816927;
        bh=um2Z3W76lC47jafzSShwo7kXpT48l6auN67NjP+7Zl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9M2QZ6Hy6id8paGR2MXyn7UFgZG4/izoXVHd8xvZwkMqduJlhnPs8bnukhNaS5ut
         MnhBMM+WAalpyY/Hd5bEC+1B8CQVmDiovKyUYup4aXGgpLwiwrrTl1HYRDNDfU23p4
         7Il/TGfVpx0Wfbawe/wBjy4UxbGbD+SmKmfSXohQ=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: [PATCH v2 6/7] iio: tsl2772: add device tree binding for avago,apds9930
Date:   Tue, 17 Jul 2018 04:41:57 -0400
Message-Id: <20180717084158.23532-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717084158.23532-1-masneyb@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Avago APDS9930 has the same register set as the TAOS/AMS TSL2772 so
this patch adds the correct device tree bindings and the appropriate
LUX table values based on the values in the datasheet. Driver was tested
on a LG Nexus 5 (hammerhead) phone.

avago,apds9930 datasheet:
https://www.mouser.com/datasheet/2/678/avago_AV02-3190EN_DS_APDS-9930_2014-03-25[1]-1217273.pdf

tsl2772 datasheet:
https://ams.com/eng/content/download/291503/1066377/file/TSL2772_DS000181_2-00.pdf

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../devicetree/bindings/iio/light/tsl2772.txt  |  1 +
 drivers/iio/light/tsl2772.c                    | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
index bfde8b2c8790..e842db749ab2 100644
--- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
+++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
@@ -13,6 +13,7 @@ Required properties:
 		"amstaos,tmd2672"
 		"amstaos,tsl2772"
 		"amstaos,tmd2772"
+		"avago,apds9930"
   - reg: the I2C address of the device
 
 Optional properties:
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index f6a27f8b3ca7..e5b449aec20c 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -119,7 +119,8 @@ enum {
 	tsl2672,
 	tmd2672,
 	tsl2772,
-	tmd2772
+	tmd2772,
+	apds9930,
 };
 
 enum {
@@ -201,6 +202,12 @@ static const struct tsl2772_lux tmd2x72_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
 	{     0,      0 },
 };
 
+static const struct tsl2772_lux apds9930_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
+	{ 52000,  96824 },
+	{ 38792,  67132 },
+	{     0,      0 },
+};
+
 static const struct tsl2772_lux *tsl2772_default_lux_table_group[] = {
 	[tsl2571] = tsl2x71_lux_table,
 	[tsl2671] = tsl2x71_lux_table,
@@ -212,6 +219,7 @@ static const struct tsl2772_lux *tsl2772_default_lux_table_group[] = {
 	[tmd2672] = tmd2x72_lux_table,
 	[tsl2772] = tsl2x72_lux_table,
 	[tmd2772] = tmd2x72_lux_table,
+	[apds9930] = apds9930_lux_table,
 };
 
 static const struct tsl2772_settings tsl2772_default_settings = {
@@ -262,6 +270,7 @@ static const int tsl2772_int_time_avail[][6] = {
 	[tmd2672] = { 0, 2730, 0, 2730, 0, 699000 },
 	[tsl2772] = { 0, 2730, 0, 2730, 0, 699000 },
 	[tmd2772] = { 0, 2730, 0, 2730, 0, 699000 },
+	[apds9930] = { 0, 2730, 0, 2730, 0, 699000 },
 };
 
 static int tsl2772_int_calibscale_avail[] = { 1, 8, 16, 120 };
@@ -287,7 +296,8 @@ static const u8 device_channel_config[] = {
 	[tsl2672] = PRX2,
 	[tmd2672] = PRX2,
 	[tsl2772] = ALSPRX2,
-	[tmd2772] = ALSPRX2
+	[tmd2772] = ALSPRX2,
+	[apds9930] = ALSPRX2,
 };
 
 static int tsl2772_read_status(struct tsl2772_chip *chip)
@@ -501,6 +511,7 @@ static int tsl2772_get_prox(struct iio_dev *indio_dev)
 	case tmd2672:
 	case tsl2772:
 	case tmd2772:
+	case apds9930:
 		if (!(ret & TSL2772_STA_PRX_VALID)) {
 			ret = -EINVAL;
 			goto prox_poll_err;
@@ -1325,6 +1336,7 @@ static int tsl2772_device_id_verif(int id, int target)
 	case tmd2672:
 	case tsl2772:
 	case tmd2772:
+	case apds9930:
 		return (id & 0xf0) == SWORDFISH_ID;
 	}
 
@@ -1852,6 +1864,7 @@ static const struct i2c_device_id tsl2772_idtable[] = {
 	{ "tmd2672", tmd2672 },
 	{ "tsl2772", tsl2772 },
 	{ "tmd2772", tmd2772 },
+	{ "apds9930", apds9930},
 	{}
 };
 
@@ -1868,6 +1881,7 @@ static const struct of_device_id tsl2772_of_match[] = {
 	{ .compatible = "amstaos,tmd2672" },
 	{ .compatible = "amstaos,tsl2772" },
 	{ .compatible = "amstaos,tmd2772" },
+	{ .compatible = "avago,apds9930" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tsl2772_of_match);
-- 
2.17.1

