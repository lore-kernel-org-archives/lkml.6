Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE260C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650F22085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B1LwbTJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650F22085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeJKPlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:41:50 -0400
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:47456
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeJKPlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzETWCXhvgYZrWc694IKJDirWgDkT04wk1+N0Qj4+2o=;
 b=B1LwbTJswtXeNc00TlRN2yezoI6NjYicXNVzLFcoe47blOpzVdc4xetOhBxxqg6Rlw2qq0WQq/VAA/F6gty+Ae3JCJ5ROkYFshgONNkcO8Jo8yoB+8Jo5IMQLpXLJKfSYsWUq/l55L8kpnPMvHEMokBjirLbeflQZbWIUw7+1tk=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1294.eurprd04.prod.outlook.com (10.162.121.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Thu, 11 Oct 2018 08:15:36 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Thu, 11 Oct 2018
 08:15:36 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 0/2] mtd: spi-nor: add entry for mt35xu512aba flash
Thread-Topic: [PATCH v2 0/2] mtd: spi-nor: add entry for mt35xu512aba flash
Thread-Index: AQHUYTqW2AM6S0IBs0m4Cxk9zeGhcA==
Date:   Thu, 11 Oct 2018 08:15:35 +0000
Message-ID: <1539245630-26611-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0088.apcprd06.prod.outlook.com
 (2603:1096:3:14::14) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1294;6:dR65ODz0LYraiGKeaVgCSD5OJtaP8jwLx8NHnYN9+0yXBFIBcZf1wZnWTID2JZM7xJO9IXkba4wI4dlW32OkdtxU+0uUafGkPWhZRKmhi+8wyU9Im9AFRvzOSGNB+zb5V+MBBbuHXGq0natkDOg58Y188SWIICTecX7yhUYU/cY0m7IUs7ykCfZ3cICVARrVJrav/c/4/lUmERo7J5vUwM9tIn/TD9L9zXlEj/tfpPf+kIoF880h7uyLWvrtxd9XugO5xEpA6iQ/sWKhT4sm55M3lnPwesTNfzW4YhLKr3c5c9gWdQ3YQWRBY6HSeHhh+u27YHzxZbnfiwTKXL4MIKm3KGsqqx01B3Ul7+65SL4UiIytKSOr+kOqGfIUeWAKog00nW5ay/gUWP2pIKXbmvvgREZ8Qm+Y70BRdQu+5bfdTxLSjAx0P+gFEX6Ko859ZEjCn4+D+Z47em2PE79YAA==;5:jY4wz8l2mHAVrfFgkCVlEaRuk7J8lYSeu1whXh//8MLX8UwSQOtwNTYZZhwypFeItF7Q6mXe/9pJTH2yj/wnFJbwWNxORL6URX46FtMde6yKul5PP7pbdW6uMxITWXxAhUNuxXxBXMMn7haVxTRw3HKAa3F84Zr/g/kSU9PQof0=;7:VkB3RlasTvwqUok+m7bR+gaYMM03dpemrQOIVsYoosg4/bXeOVtow6aIZBZyWYGGUwV2OZTBf4PcPHQ5jpnn6XckvrXfWUx9r410ifdnP4uCr0sCtAzdmCGqrvTxlLr+KO3TdorPNtxp0/psT+paSzzXuK1tWE4ZhYseveKdB+IWIyxNHSkFqKr6qrkQGpx28nUjgVvbgQhn+6uh6AlQ1oXoBwUJVkYjyV7R3BAXOJi8N8550yNWq/pHD/u7Vu0C
x-ms-office365-filtering-correlation-id: c77c3cad-2b70-4926-b5f4-08d62f51b826
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1294;
x-ms-traffictypediagnostic: VI1PR04MB1294:
x-microsoft-antispam-prvs: <VI1PR04MB1294B84F18D300CF4E90F07699E10@VI1PR04MB1294.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(88650276678806)(34377916053724);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB1294;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1294;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(6116002)(7736002)(36756003)(305945005)(7416002)(97736004)(3846002)(316002)(6486002)(4326008)(966005)(39060400002)(106356001)(25786009)(66066001)(14454004)(2501003)(5250100002)(2900100001)(110136005)(105586002)(256004)(478600001)(6512007)(186003)(14444005)(6346003)(102836004)(54906003)(5660300001)(26005)(52116002)(55236004)(8936002)(99286004)(6506007)(81166006)(81156014)(2616005)(71190400001)(68736007)(2201001)(86362001)(6436002)(2906002)(53936002)(8676002)(386003)(71200400001)(486006)(476003)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1294;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-microsoft-antispam-message-info: FHgaQwVTQFby/OKjxWE8D7eUTDT1dByFuNWhNzpc2uBQ8PBmBMV9D6SL35CNTfy0IEskbT87I0U1Qc3/1tRzM8n2Qn5uCC8fYI9n5RZRFMt3YV1Wvi2yHd44ENIGi7W/cJhsIeZ48s6Iouo5l42CdoJy7y4/8RtmyVAOsTp7FQFRbVKpgvcy7mU5KPUSDAZRSNYz7e9SDkKRmt1IiyfcnZrQZkLGTQRAmoB0cFw4MAaCdTEmraHHzUBlVW4gfkivjVbMxWTNXAGxe1Dh4TVx7RFPplfu15IfPgLc48oB6g71N+sxB40wkm8nXxKe3lDVfICf7wS/ufnMS+JQmCxhw2x+cgk0YKLYIRo7QMCDvJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77c3cad-2b70-4926-b5f4-08d62f51b826
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 08:15:35.8530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MFR_ID information, 0x002C, related to the Micron flash.
Currently, MFR_ID 0x0020 is being specified as Micron flash ID but
these are actually CFI ID of STMicro flashes.

Rename SNOR_MFR_MICRON to SNOR_MFR_ST and add entry for
SNOR_MFR_MICRON having CFI ID value of Micron flash.
Add entry of mt35xu512aba [1] flash in spi_nor_ids table.

[1] https://www.micron.com/resource-details/0b74b806-bbf1-4c24-b07b-35e2799=
bb6ff

Yogesh Gaur (2):
  mtd: spi-nor: add macros related to MICRON flash
  mtd: spi-nor: add entry for mt35xu512aba flash

Changes for v2:
- Removed checkpatch warning, 80 character limit, in patch
 'mtd: spi-nor: add entry for mt35xu512aba flash'.

 drivers/mtd/spi-nor/spi-nor.c | 13 ++++++++++---
 include/linux/mtd/cfi.h       |  1 +
 include/linux/mtd/spi-nor.h   |  3 ++-
 3 files changed, 13 insertions(+), 4 deletions(-)

--=20
2.7.4

