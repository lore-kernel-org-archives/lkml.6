Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78217C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F7C205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sZ6UjcSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F7C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJ3RfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:35:07 -0400
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:61277
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbeJ3RfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqtoISKdmhUaBQGnS5CEKA56s80R9o9OgchDsCLyAPM=;
 b=sZ6UjcSoAIvKxUZWNgJEZwsJTYAz91DcJnqBIJyUCurkcsJxYHoe1qMFpljFLCWBjUDEM0Qi2ANPM0tUwsC8YmTeeYpu9B3kKuoIYvfiB3K8ZnXkd6l6IxIr5MQ3HqdTQTkUf0BK7io6Q34Qp+5VdcdeDPAdyFS3HCCkLdfKInk=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4122.eurprd04.prod.outlook.com (52.135.130.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Tue, 30 Oct 2018 08:42:34 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 08:42:34 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 0/3] ARM: dts: sabreauto: Add flexcan support
Thread-Topic: [PATCH V2 0/3] ARM: dts: sabreauto: Add flexcan support
Thread-Index: AQHUcCyADUIVvC44GE6JoLmFX6Z4yg==
Date:   Tue, 30 Oct 2018 08:42:33 +0000
Message-ID: <20181030083954.26440-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:3:2::32) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4122;6:0rbANDiTL21R3MV888WJQbKvtgBz7YGjoHNm5Pq1CYOQXBr/8C6/yq2/ww1uIS28mC/PZCtwfZ8YJiYgTsyrY7x2C6EgKcTjBjJBg/94xp28i09itTPnTfhn3ek305tFtz4SNlVX2eIDkIV8vyMXgLY2Lez/PqmeNA2j1o9aTLgHIRVH2KCa1aM9E9MSibQKM576Vw8FYyKMdc2WEC0M7u4IHc+aQhu4DDg10bFf7/H0lmV64WJ8Vowqj37HagFM70aCjV7qGr4MJxOzyOoRG1TYJwXa1yuHfyoKzQQ3ngdJjjuOQV0WDjloTtdoByhBwFnwZCnNDMrx7FpEn13zuVKdgMFdQAQEdFhhKUGeKf6i7cPkOW0g0U3ANSdV0+XMpODSWiRnNHddk2enNPbWFXQRS1ety6rA1tezqaRCvDI61DPvMVZp+lZqzUN3yq9z6Y7J5CxWfRr9JyEfzC2JRg==;5:SQqXH0x3KRTGEyLhx2MQDRDCJ+1XRF6ECeJBahYYEXi0fd93wjkR5FOiPqwZRdsMqTZreffp6Lu/smXPgN6Hl+eLEVK7IIWrKyt/+w0pP+U6EQ4UYVZOsktxYHjCJuYUcxGDQx6EUrLJnFClUjutDqEhHM42NxSQrKaFxosMgKk=;7:GYWjcuaq5bZ8wePI8EeSx1KJHEFfulmNo3oP1ea7wWpL9ZPQK6zfLOzArxytw14ueOeweSXzVJQ3beZ8vvdWoADmK5p1tUZZLgfLuLTTSYLoVUIQzGyyePROjTsXSNVweyHkk3509pSOcyNzB8gdCQ==
x-ms-office365-filtering-correlation-id: f946a598-2ae0-4c86-0f4d-08d63e43a2af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4122;
x-ms-traffictypediagnostic: DB7PR04MB4122:
x-microsoft-antispam-prvs: <DB7PR04MB4122583937F6B80CEF4E964DE6CC0@DB7PR04MB4122.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4122;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4122;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(54534003)(189003)(199004)(6436002)(8676002)(36756003)(97736004)(6512007)(478600001)(6486002)(68736007)(2906002)(50226002)(14454004)(99286004)(476003)(6506007)(2900100001)(66066001)(5660300001)(386003)(2616005)(2501003)(5250100002)(86362001)(53936002)(1076002)(6116002)(3846002)(256004)(102836004)(52116002)(316002)(105586002)(8936002)(81166006)(81156014)(106356001)(25786009)(110136005)(486006)(54906003)(4326008)(305945005)(71200400001)(71190400001)(186003)(7736002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4122;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sDG7fhPJ9ADG1sCv4kf7H1gAC9tbq/o9IH8MUNucF7ljMANDn0nra0jKHH5vNhnfvQE2hI+AJtvgqRO34SxNpm7myOuVpsEJ/i65ZIQrSFq5YYLSbrUtH/Eaxv58jYJXNO7F/G1gcLxUMG6zqUt298hT+V7dTAz2Qca1NJ7WSkq9AG7nUihgZWn5h+G70YkVEP+Q27xa6uGIrJMurC2ryW8RDLwxtFiomfPRhj6lnud6IiPDzLjvM5IftrSdRyKn4ZSiDj9Gzawt2ChXr3d2s5g3Z/jKt6/e4mNYzGPkkFZoQtzogSzXGycLSKqSm8RssCNcrmbDqDFa5vag8r4yavmeqF9i+qJljNiQ+aCLGIc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f946a598-2ae0-4c86-0f4d-08d63e43a2af
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 08:42:33.9691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series intends to add flexcan support for IMX6 platforms.

ChangeLog:
V1-V2:
 *using SPDX tag for new files and remove pinctrl-assert-gpios property.

Dong Aisheng (3):
  ARM: dts: imx6sx-sdb: Add flexcan support
  ARM: dts: imx6sx-sabreauto: Add flexcan support
  ARM: dts: sabreauto: Add flexcan support

 .../boot/dts/imx6dl-sabreauto-flexcan1.dts    | 14 +++++
 .../arm/boot/dts/imx6q-sabreauto-flexcan1.dts | 14 +++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi      | 47 +++++++++++++++
 arch/arm/boot/dts/imx6sx-sabreauto.dts        | 57 +++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb-reva.dts         | 12 ++++
 arch/arm/boot/dts/imx6sx-sdb.dts              |  5 ++
 arch/arm/boot/dts/imx6sx-sdb.dtsi             | 42 ++++++++++++++
 7 files changed, 191 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts

--=20
2.17.1

