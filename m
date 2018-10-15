Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10AC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5962720652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lIOp1qf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5962720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJOVNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:13:15 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:22222
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeJOVNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRKB5UJmdO5qmoXoNyqrCCHewRjSY92EKT17vA8YqHs=;
 b=lIOp1qf4Q6UX3xU7vMEU/6onuDs58kujnPKwx8G8e4wKDCKjmVQjulZ4VZGXCReJEdXJi83Bp+6eLdjE7qslePg2oflnhhuNUDiJM5z/Gn7F6LCiWmZJaSSlKCMkDB8bHlbi7M3s4JjvzqZfpG6iZ5HN8shSJe6fmO7GTNAflK0=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4676.eurprd04.prod.outlook.com (52.135.149.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Mon, 15 Oct 2018 13:27:39 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 13:27:39 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] ARM: imx_v6_v7_defconfig: Enable CRYPTO_DEV_MXS_DCP
Thread-Topic: [PATCH v2 4/4] ARM: imx_v6_v7_defconfig: Enable
 CRYPTO_DEV_MXS_DCP
Thread-Index: AQHUZIrY4oYv5ZOhIkC9fe7vsL1m3g==
Date:   Mon, 15 Oct 2018 13:27:39 +0000
Message-ID: <275ca8850bd5863f79bcafdb11cf9544318a691f.1539609921.git.leonard.crestez@nxp.com>
References: <cover.1539609921.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1539609921.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0502CA0071.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::48) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4676;6:B7ywoaL0aUGf758exVfsiW+D7EHTsXm9WnO/Y38hJoChI/If2NHe2DUQ+5mtLgTds6VGlTstQ78arwUOYFlF0TgkHR+qwBDUQKq8YtaXki+kn4fVtX18oNGWyPjSQ7Nav8WasiyhH9K8OgYNb3w0utn4k5Bhk56rx2pk8ZGc6iU87P8kOa7i6PSKJ24hjyACxbccTwHnbAzFVw7xCx4WdTgJTIgbHddWyP5wD9Q0J1GzJ3nQakMT/E4AjP1wkxGpKVnjae8XOh19WWnocM8Tq3DLLzxHCAUAI2xyEiJa1DBYnN0M7EOW12WLP46KkeJl4jB1K1tYLdT3F8TYYqTtPg7NIkbM4qd3uu1iclpemC08kiQnNWiAzMVHHb9f+Tg/x6qz1QDmpyHElE4ImwieMDSOsg6/Sx4G73ZcghV9/cvyFJLReRjCY2V93cFEM1bvK3LnSXpJUe/+zdpBRgUJeQ==;5:OwDG4PISDk3dViW5zHO1xZzqaRzxTbynTJdrs6wyvjIzM/HmsWE3ZlUNBQ26hwsHiRltMuq6V7fzG3vggHuXg0Yu75blWULNbKG2/GzIE4IjA8bDhhtK/jcwoZrw1b1lL9So3TLedslziYbCdRhO9g/qNJ4Oai6FbEHQA42hjLU=;7:At3/b8V9r4u5xJM85oSZpDJGIqXHrNILnqHwhSkgheMoZ9NjqyKqu8uMQILGNUb5xNcpPsS8wesEUkGPrGHzIOVqC4QsHUkTwZSin9UOPe2unwy1/67pU2afkJdW27S2O03Jg9+7GEWu6jncfjVa0KpVzn4UdkVt9dxKjIgP020BdTCWfZos4A1XoGo6rvj2cx9LCF/St5SYvZ9XUMjaUznVXwEeKaT4xwGEVH0NB/ibnrzk6C40u2xLQhiJ6UzX
x-ms-office365-filtering-correlation-id: c0a94c09-bfe8-4ad9-412d-08d632a1fa97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4676;
x-ms-traffictypediagnostic: AM0PR04MB4676:
x-microsoft-antispam-prvs: <AM0PR04MB467640A35F92DA490B75C13AEEFD0@AM0PR04MB4676.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4676;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4676;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(5250100002)(386003)(36756003)(25786009)(4326008)(8676002)(39060400002)(76176011)(6636002)(54906003)(486006)(110136005)(2906002)(6512007)(256004)(44832011)(71190400001)(71200400001)(97736004)(14454004)(478600001)(2616005)(11346002)(476003)(6436002)(52116002)(68736007)(81166006)(81156014)(446003)(6486002)(105586002)(99286004)(8936002)(26005)(6506007)(118296001)(102836004)(186003)(106356001)(66066001)(15760500003)(5660300001)(305945005)(7416002)(6116002)(3846002)(2900100001)(7736002)(316002)(53936002)(86362001)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4676;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jSloYV+AJ8ACo+G0hnGV/DxyfYULmE3zUpZvFUotFqpV1GWTtO1NwbGWjGqShS4/LKc4m5tTOgQEAVdU8Nn8iNnTLbxHT3fkRWzkLbcbby2iwj2FOAg1qY14sRMZIaWuhuhqWSPyrUF/ofZLHOb+09a4btvLEvB7LWJsKSEigPJbCEOb77hGA3Lbvhc4d1TCAnT2A4GO1+tMCcs6jKdp1eBqEYyDNmZQ4XuleA50mShQLusCAkiW0nh8rWRgCQz7LnMGAUI9LCKxJ8KczOF69lJR2V9PryvMwoxqusRoP7wE1S0Ec6uUfA7nRD2OI6zRcQnODRDoQHRIge15GZkY1oGZg4Vpbwzdj0En4btkpJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a94c09-bfe8-4ad9-412d-08d632a1fa97
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:27:39.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This block is present in 6sl, 6sll and 6ull so it should be enabled in
the default imx kernel config.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6=
_v7_defconfig
index 1ad5736c8fa6..57928dff9bce 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -428,10 +428,11 @@ CONFIG_NLS_ISO8859_1=3Dy
 CONFIG_NLS_ISO8859_15=3Dm
 CONFIG_NLS_UTF8=3Dy
 CONFIG_SECURITYFS=3Dy
 CONFIG_CRYPTO_DEV_FSL_CAAM=3Dy
 CONFIG_CRYPTO_DEV_SAHARA=3Dy
+CONFIG_CRYPTO_DEV_MXS_DCP=3Dy
 CONFIG_CRC_CCITT=3Dm
 CONFIG_CRC_T10DIF=3Dy
 CONFIG_CRC7=3Dm
 CONFIG_LIBCRC32C=3Dm
 CONFIG_FONTS=3Dy
--=20
2.17.1

