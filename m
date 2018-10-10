Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E176FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA23214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HSE8a+KP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA23214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJRyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:54:22 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:56128
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbeJJRyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzTMREj5GE+983AYtgfRbOM15pcrOZ+AghUfveuiNEc=;
 b=HSE8a+KPyjg1mqrktORM9ng4F8qTpO4cvxQN6jD+HOUiwT0va1UMBWbUk2HSmCjfycP888Tj23yKlKIgMenaR/lrMai4r6bS8S3+CoWQoz5cU+ElsUa7wEquqQfL/3SHZI7I7lV84IFQL9P3+AqKo1OsR/Lt3i2cItjRQjt1PVw=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4592.eurprd04.prod.outlook.com (20.177.56.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Wed, 10 Oct 2018 10:32:45 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::b0a6:19e5:90b1:5831]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::b0a6:19e5:90b1:5831%2]) with mapi id 15.20.1207.029; Wed, 10 Oct 2018
 10:32:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v1 2/3] spi: imx: correct wml as the last sg length
Thread-Topic: [PATCH v1 2/3] spi: imx: correct wml as the last sg length
Thread-Index: AQHUYISUkQFNShIjXEaLw5EpcC0uhw==
Date:   Wed, 10 Oct 2018 10:32:45 +0000
Message-ID: <1539196453-8704-3-git-send-email-yibin.gong@nxp.com>
References: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:203:36::34) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4592;6:2+5X4cXCQEMgAnSHeyK6SvSBpboMkz9+7zDVhAe7oLNcDqK044iqaDGuzjHH7t+iVyfbMCJe7Gd9SYjStv6C+JDb3vG+UuzBEJ9UufqxBDx+IvnS4muS6eSDM98aY62GM/omHILYhk/moDKnOLSYtpzPnX/+V837b3kvq+BbiKhGdCwwTqHHadGYeBVbh20NZpGrZIbvqDHSjG+W3kix1XjO3bRSVh9e5Je1dKaKmRmltDgrH4TNKvCtzrRIO9CbCGc7pvHsHyk7z9Uv4SudYZei9/aPrY8VqkMvBEvyDPp0ykecY4tKAP3WYPKn4aMGL88DNGRC7CyI4/Izy5oL/2wLUsQ9MJUD68RZIvq0FahwLvnY9pz69XHFFbid6IWPfkEIyrUimH3tzjUghUFk7KeVmrO4c4PZYNx2fpwAk8limXBs2KIOI3p++vQZ0jE8VAT8wWnxh4nvtHJlE6E1CA==;5:pfWLOWhQ8TVk7zpBO3MUuwaX2qNwKs24ifcrunn/ORkEHZKlotndDkZ50hoI45teqTxxY81F9DOMpv/Onjv/xkPDIm0SMPl5XB6ZYTUwioZ2rrsNTGCXLNld6oDOLkdniH2a/xDMEVzzZCVU2/cATe/WP9bGpXAUNpZxIS+J6zY=;7:Ee9rVWIPemkT60KaMNANce0iULnYnprT+qkdqkUs+U5EaAF/MNYMk9jLweLGftsLMUZXeo//f3ltOsmAvwDUkrQojsOwPjIQkVSQxT6zs9/pZ7e4jTxtemx1ulOck5DOiPdG9WQVR8SDt9i4rEdyJhuPc0cCin25SESLnkLGY1CNAsgDxrh3aTt2VAqkb3qQhTzQrIFi0shytpslo0cn6m/GLK95t6tQsDbN9rEI62BX9mpBQNn8wS58YCYSEyDF
x-ms-office365-filtering-correlation-id: 92024861-035c-42dd-7a23-08d62e9bb739
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4592;
x-ms-traffictypediagnostic: VI1PR04MB4592:
x-microsoft-antispam-prvs: <VI1PR04MB459212DB38E599DA5A08A10A89E00@VI1PR04MB4592.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4592;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4592;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(199004)(189003)(45904002)(86362001)(6436002)(5640700003)(6512007)(486006)(71190400001)(71200400001)(446003)(2616005)(476003)(11346002)(7736002)(305945005)(102836004)(26005)(186003)(6486002)(66066001)(2900100001)(25786009)(4326008)(3846002)(6116002)(105586002)(106356001)(2906002)(478600001)(99286004)(54906003)(14454004)(2351001)(76176011)(52116002)(6506007)(386003)(2501003)(5250100002)(97736004)(316002)(50226002)(8676002)(1730700003)(81156014)(81166006)(8936002)(68736007)(6916009)(36756003)(5660300001)(53936002)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4592;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T7fdPnWm1OgKNA+qb/SrUA9zcClsHREykCyfsRfMsAMjGGQmN0j215GLjSGMXldcNH1XsPm32CApmY7Ccx6I7ZPvcXH8A4yHBh+hPYuAjiZjO8yshh4msjUDhrgZsBh/X7EKo1V3GRDlcgCEYexCuyAN+VATJFceAgBlIlDt7QNQ2FJBDJrHpk1WYZCkGpqD8SjEBVY/SDuh21Uq3c396jJtsMuBJn24wgRisJktU7BWolkrZxSTr1wIULka5hJZsDzDoiseUo6qHkUnbaXhjnyRXJmEmRKjBeYBZ8GKUlV/onU7XqrD8jXd2QskXhiaR09EfGoldgTVmPWYdpGXQJlTczmIYxpw81EXDmfJ864=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92024861-035c-42dd-7a23-08d62e9bb739
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 10:32:45.1747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct wml as the last rx sg length instead of the whole transfer
length. Otherwise, mtd_stresstest will be failed as below:

insmod mtd_stresstest.ko dev=3D0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mtd_stresstest: MTD device: 0
mtd_stresstest: not NAND flash, assume page size is 512 bytes.
mtd_stresstest: MTD device size 4194304, eraseblock size 65536, page size 5=
12, count of eraseblocks 64, pa0
mtd_stresstest: doing operations
mtd_stresstest: 0 operations done
mtd_test: mtd_read from 1ff532, size 880
mtd_test: mtd_read from 20c267, size 64998
spi_master spi0: I/O Error in DMA RX
m25p80 spi0.0: SPI transfer failed: -110
spi_master spi0: failed to transfer one message from queue
mtd_test: error: read failed at 0x20c267
mtd_stresstest: error -110 occurred
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
insmod: ERROR: could not insert module mtd_stresstest.ko: Connection timed =
out

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/spi/spi-imx.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e861157..037abbb 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -217,7 +217,6 @@ static bool spi_imx_can_dma(struct spi_master *master, =
struct spi_device *spi,
 			 struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx =3D spi_master_get_devdata(master);
-	unsigned int bytes_per_word, i;
=20
 	if (!master->dma_rx)
 		return false;
@@ -225,14 +224,6 @@ static bool spi_imx_can_dma(struct spi_master *master,=
 struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return false;
=20
-	bytes_per_word =3D spi_imx_bytes_per_word(transfer->bits_per_word);
-
-	for (i =3D spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
-		if (!(transfer->len % (i * bytes_per_word)))
-			break;
-	}
-
-	spi_imx->wml =3D i;
 	spi_imx->dynamic_burst =3D 0;
=20
 	return true;
@@ -594,7 +585,7 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx=
)
 	 * and enable DMA request.
 	 */
=20
-	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml) |
+	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
 		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
@@ -1287,12 +1278,30 @@ static int spi_imx_dma_transfer(struct spi_imx_data=
 *spi_imx,
 	unsigned long timeout;
 	struct spi_master *master =3D spi_imx->bitbang.master;
 	struct sg_table *tx =3D &transfer->tx_sg, *rx =3D &transfer->rx_sg;
+	struct scatterlist *last_sg =3D sg_last(rx->sgl, rx->nents);
+	unsigned int bytes_per_word, i;
 	int ret;
=20
+	/* Get the right burst length from the last sg to ensure no tail data */
+	bytes_per_word =3D spi_imx_bytes_per_word(transfer->bits_per_word);
+	for (i =3D spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
+		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
+			break;
+	}
+	/* Use 1 as wml in case no available burst length got */
+	if (i =3D=3D 0)
+		i =3D 1;
+
+	spi_imx->wml =3D  i;
+
 	ret =3D spi_imx_dma_configure(master);
 	if (ret)
 		return ret;
=20
+	if (!spi_imx->devtype_data->setup_wml) {
+		dev_err(spi_imx->dev, "No setup_wml()?\n");
+		return -EINVAL;
+	}
 	spi_imx->devtype_data->setup_wml(spi_imx);
=20
 	/*
--=20
2.7.4

