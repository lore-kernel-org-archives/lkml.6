Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C378C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281E1214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fmV5AKfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281E1214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJJRyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:54:15 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:51520
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbeJJRyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvsMCoZnT3EkT0vE0giMLrMPi26dtdTJ8gFNLYTBWN0=;
 b=fmV5AKfiZsHGzVW1gbCqZGKomSLCRwZYISTTfSHDxerdCkfsAhqMubQZiY8i4SZupRLrsLCFmN/5jCgsRMPq5MOw2chTALb6txuh0SSj2Whg+xkhTuIRZPVxuZhxI0dQzOcyOxfNqgwWZQZx8q+mGKECZscxopnvvwTbilQ8U/8=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB1088.eurprd04.prod.outlook.com (10.161.109.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.22; Wed, 10 Oct 2018 10:32:39 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::b0a6:19e5:90b1:5831]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::b0a6:19e5:90b1:5831%2]) with mapi id 15.20.1207.029; Wed, 10 Oct 2018
 10:32:39 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v1 0/3] Correct wml setting for spi-imx in dma mode
Thread-Topic: [PATCH v1 0/3] Correct wml setting for spi-imx in dma mode
Thread-Index: AQHUYISREtWaG9cSeE+Glt9Bi1VWgw==
Date:   Wed, 10 Oct 2018 10:32:39 +0000
Message-ID: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1088;6:FZe9wXOBav6O/lX/ftu1tPh4OKbgRdTcVtPxOEmMknrZF2Bu3nRdzZ26JMhsIFVgDWVnzvpHkb2k4jf3zNU/N1T88BMQ0sCYjQ/wk7BO4P/I/Q3OygnIuGTa+ex3AtR0e6jcSdiNbjdVx2nApmKj3mcuteiX1TlE0fD1lTthI6bRUyFGTB63xkuRaFMNW2dHYEp+26P1lVQakFqheS54q8wgPSdyKHOq1kGGthTS9T4eL5gmTKOINPglG7ZFRYQ9/X5jxH5TCSz2KB41cMUenilCLVRbNlE4q4tRsa69Wk9Y1ON6/YEfX6fo5+VE0aUvVltJG35FLr8Eq0BIOqkhdnK4eRmDaUJMNqGTP0P4eQ3ksYyaOEi8u0NrzBMU+T/zWJkhH13Y9+SDcaHbYMrnwcXd3wtXQsd5LD21pyvaF4ruPqJn4cEUuOi8N30WmQ2Ra3n//IAcrQnhhl2fA0nr3A==;5:DOxGUcB1oJt9xcOYtefTTqGQDAuRUjhwWnO4C6mtXeHU3eJ3z754YIPCUO8fHIEimPlt6JMfHNDPrjsxDGEPF74H+3120ttrvZnV2W9NFeQ6JKz3UhYErxq99V2pvP8EOGF+LXJctOA/VbLbeWoCQZ8QwIV8P1BLzQBeaT4128g=;7:ywxte32P2snQWHxhLukFlPF0wJPTlpcWZDZABL4JR1TdjF3wVe6Y2KDBoJ4UL7uy9aULWSs0EAd+OLRR7j3TE54RUlJtxxcs12kV5vm3llpR2C5JjpK5GELz97IWu+nodk6xpTsk0hZ7/VPEcJarJzr74hyqDevUSVrBf5o6xndvX20VKt8B01/5LZ7846HVYu2VVEo7ka/Lg6QIETgfxnWqX7nQ77JreH9kKD5bEDV9HeR4npmYE9F2p6W0zZ+x
x-ms-office365-filtering-correlation-id: 0425506a-e6ec-43b2-32af-08d62e9bb363
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1088;
x-ms-traffictypediagnostic: VI1PR04MB1088:
x-microsoft-antispam-prvs: <VI1PR04MB1088706435B169E2D4C0073889E00@VI1PR04MB1088.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB1088;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1088;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(376002)(396003)(199004)(189003)(45904002)(486006)(5640700003)(71190400001)(71200400001)(476003)(7736002)(305945005)(186003)(2616005)(26005)(6486002)(102836004)(66066001)(2900100001)(6436002)(6512007)(86362001)(6116002)(25786009)(4326008)(106356001)(3846002)(105586002)(2906002)(478600001)(99286004)(14454004)(2351001)(52116002)(6506007)(386003)(54906003)(5250100002)(2501003)(316002)(97736004)(8676002)(1730700003)(81156014)(81166006)(8936002)(68736007)(6916009)(36756003)(5660300001)(50226002)(256004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1088;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AmkZ/PkzbJ9Df+oXyed1e8hZBFWfpZmTEffX2VFgqzNtEdYZOMAi1F3uUQqiBSV/oOJNh4Etv9sgf0efyEE+eR/sRpD8PzkS78ZIskG4TiFdNLEjrRV7H2SBNe1wUSdSjxB6Ie+fHWVuF45cwyYgEyTtjr136vP7sss/KQwpLCTycIKVgbIkHIY9+xw6LjdHxh6VCdwVYpPRM4TpU89nRhMzUdlPG/4W350saxyaixx71pDjQ0CIsksHZKnpUC9X9T1Kb7WWY/lZHyf+PaGN1cE8I9AqBbv3+qs0cQmBgFjY1IY3HJkLVQK445h5RmYy/Sz7GTNvzghM2LxMe1swcv5/bWzrW3flmaFHnCIkh9E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0425506a-e6ec-43b2-32af-08d62e9bb363
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 10:32:39.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Current dynamic burst length is based on the whole transfer length,
that's ok if there is only one sg, but is not right in case multi sgs
in one transfer,because the tail data should be based on the last sg
length instead of the whole transfer length. Othwise, the last dma
done interrupt will never be triggered. It could be caught in
mtd_stresstest case without this patchset as below:

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

Robin Gong (3):
  spi: imx: move wml setting to later than setup_transfer
  spi: imx: correct wml as the last sg length
  spi: imx: use PIO mode if size is small

 drivers/spi/spi-imx.c | 53 ++++++++++++++++++++++++++++++++++-------------=
----
 1 file changed, 35 insertions(+), 18 deletions(-)

--=20
2.7.4

