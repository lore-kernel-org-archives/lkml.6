Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEBEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158BE2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K9myo+nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158BE2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbeKFNET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:04:19 -0500
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:62644
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387424AbeKFNER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9MxGiFI+LqEa8FAvV4u+HcapLd0LIgTYCjt86e9SaI=;
 b=K9myo+nvhkt6EGZG6XD6rLzbFIqoZHNLGVrYSRSYyypUiCPpEHRmfAIm7b7S+yvfB5yjngjH4pwtlNbYJfWyPJUbdSDZsoJ0MaIA9xj2RoIWq6CwNz0+OiJzzMe05QIgjpNbFhHMkd86LuMeHWM3ZiotjEGs/KmC+sH5tDv3k3Y=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (52.135.138.28) by
 DB7PR04MB5226.eurprd04.prod.outlook.com (20.176.236.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 03:40:28 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::1d00:effc:853f:267]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::1d00:effc:853f:267%3]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 03:40:28 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 2/4] Revert "dmaengine: imx-sdma: alloclate bd memory from
 dma pool"
Thread-Topic: [PATCH v3 2/4] Revert "dmaengine: imx-sdma: alloclate bd memory
 from dma pool"
Thread-Index: AQHUdYJ2bDLbdd0rSkGoiw5ixWtFhQ==
Date:   Tue, 6 Nov 2018 03:40:28 +0000
Message-ID: <1541504525-25720-3-git-send-email-yibin.gong@nxp.com>
References: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:36::16) To DB7PR04MB4538.eurprd04.prod.outlook.com
 (2603:10a6:5:35::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5226;6:Ktt/6CQLuFlZzOOIitwpE0uQrHx5QbTqFDJKZKYq0U4Ag6FH9HecNIjfwHmhVlQC3HzceGIVdhFarLoTaWSUuYzdSABJpYvBU6+2vYgj2Nf7WntFr+WNnelUMBm3ekIMHh72OA0V5vuDA8SK51RtcFow7OZalS1dtp1NfqeEa1quflXybVPEYEIwQrYP9HVJygvfF5glJc5XHk6Be5Nj57AL/tpjQRB9MK8gegVC81JzFpr12vwrIFxKjWbIRgh+LxTAIRTCcbCMJy8Gz/5LN3cQTg3UAekc1anAeBMyz6shDtGnZS7cBtR/BrYy6i78ReTsU+R2FpZKv39YFV0Gz6qZFffmoHxkJH3C/M8TODABAO4gP+eUF3LE7DI8FF4DM6J8RknJurRKtjJY7zeYDT589QiCknVueZAanTHftApkUQh4+0u3lRvdOChmV4jPOv9nrSMaKClLIaWOebRZjA==;5:qGWA3iYGHgpkOoOJVmrz+J2Mb7TXlevIIfnfoRJbXbZMaG7AaMuXYiYeFp3W+Xh7kK/eoqgvrg1B6ErqDLz5qr4Pa5I1R7x69jH6Z9rODBVw+kAr8JqjmWAjn2pv//HwNVRHN9IQtlFp/grnh47F7GvGWgPfqHIOP2MJYEwi+gc=;7:NHZk6Z/SnYQ+q842B0rRazdvoyhbx7KnvpOAONmxkYchD1HyqGqaxEVn93XkM0JOSgiWlu5V+N+r2W3y5O3Npj7MYRN8sCVbqpE1L8IQSSvr25kGKmM9SnCQ9FJdIOeM6K1NznKH3gTgJHCWJ5tFsA==
x-ms-office365-filtering-correlation-id: 25666b70-c02f-49d8-e3ec-08d64399986c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5226;
x-ms-traffictypediagnostic: DB7PR04MB5226:
x-microsoft-antispam-prvs: <DB7PR04MB5226C598C30C9C590DFCD57589CB0@DB7PR04MB5226.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5226;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5226;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(81166006)(54906003)(316002)(186003)(446003)(25786009)(478600001)(2501003)(71200400001)(6116002)(3846002)(2906002)(71190400001)(110136005)(99286004)(7736002)(11346002)(305945005)(6486002)(4326008)(476003)(86362001)(50226002)(6506007)(14444005)(486006)(6512007)(106356001)(36756003)(386003)(5660300001)(26005)(105586002)(256004)(2616005)(66066001)(102836004)(8936002)(68736007)(76176011)(53936002)(52116002)(6436002)(14454004)(8676002)(97736004)(81156014)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5226;H:DB7PR04MB4538.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g99c0H1PvC5vQDFo/DMHJvcOic8hYQGNpZHoW/FqMkgJ5G5dRN6vGA8i5GAlLUMvN+D4YVB9FL1aXaNl250h9YnstGueRrpP37sU8s00mndZAeSnzOvze9yrKIHuRT3h0el0L4YIdjzA5nzMH7RWUc4wvcvXps32zm0QKq+VuPUQ8WHeo8d7YpNj+FxFdRCaR3ZRUyaIgiCqluUd07smuL9+2zCxH1grBUg/VcBxIHBBfBuJt0eYW0vG1V0edbZjN4R2d5haRKoeHoqJAunG2twv3gAxBshguTqkH4ZtSOt33eTyo8iWl+en7k6a88ZTMVYNFYLL5u6FSEjQ415/utHrqREm2cOGaS9MTQ+v5Ss=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25666b70-c02f-49d8-e3ec-08d64399986c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 03:40:28.7975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This reverts commit fe5b85c656bc. The SDMA engine needs the descriptors to
be contiguous in memory. As the dma pool API is only able to provide a
single descriptor per alloc invocation there is no guarantee that multiple
descriptors satisfy this requirement. Also the code in question is broken
as it only allocates memory for a single descriptor, without looking at the
number of descriptors required for the transfer, leading to out-of-bounds
accesses when the descriptors are written.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3bca5e0..8d2fec8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -24,7 +24,6 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
-#include <linux/dmapool.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -376,7 +375,6 @@ struct sdma_channel {
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
 	struct imx_dma_data		data;
-	struct dma_pool			*bd_pool;
 };
=20
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -1192,10 +1190,11 @@ static int sdma_request_channel0(struct sdma_engine=
 *sdma)
=20
 static int sdma_alloc_bd(struct sdma_desc *desc)
 {
+	u32 bd_size =3D desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 	int ret =3D 0;
=20
-	desc->bd =3D dma_pool_alloc(desc->sdmac->bd_pool, GFP_ATOMIC,
-					&desc->bd_phys);
+	desc->bd =3D dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
+					GFP_ATOMIC);
 	if (!desc->bd) {
 		ret =3D -ENOMEM;
 		goto out;
@@ -1206,7 +1205,9 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
=20
 static void sdma_free_bd(struct sdma_desc *desc)
 {
-	dma_pool_free(desc->sdmac->bd_pool, desc->bd, desc->bd_phys);
+	u32 bd_size =3D desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+
+	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
 }
=20
 static void sdma_desc_free(struct virt_dma_desc *vd)
@@ -1272,10 +1273,6 @@ static int sdma_alloc_chan_resources(struct dma_chan=
 *chan)
 	if (ret)
 		goto disable_clk_ahb;
=20
-	sdmac->bd_pool =3D dma_pool_create("bd_pool", chan->device->dev,
-				sizeof(struct sdma_buffer_descriptor),
-				32, 0);
-
 	return 0;
=20
 disable_clk_ahb:
@@ -1304,9 +1301,6 @@ static void sdma_free_chan_resources(struct dma_chan =
*chan)
=20
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
-
-	dma_pool_destroy(sdmac->bd_pool);
-	sdmac->bd_pool =3D NULL;
 }
=20
 static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
--=20
2.7.4

