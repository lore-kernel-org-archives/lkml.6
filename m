Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664C8C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264462147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ict9RG7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfAGTbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:31:48 -0500
Received: from mail-eopbgr10078.outbound.protection.outlook.com ([40.107.1.78]:25466
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727369AbfAGTbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0VkuMg7xK/N4CkN0AJTNcH+x7A9tCxpTbv0K1uyAIM=;
 b=ict9RG7opXJDzRgIPeaGnIEpJ+gcWpTELpAIPf68iAiW9FJ1huAVpYmeUsO3/Ganya7Q8bYqSy2agBI6GTLWJJNQJ5T4hyBtPBZSO0WG/NuqR7+aw1IP1AGI4rIy7lQuik4vkG8LuV+IS5rWEJVQ7q+yJYra5mRYH3ticewpmaI=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5311.eurprd04.prod.outlook.com (20.177.52.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 19:31:29 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::7d6d:ce34:3439:c184]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::7d6d:ce34:3439:c184%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 19:31:29 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Michal Marek <michal.lkml@markovi.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: freescale: Use wilddt function
Thread-Topic: [PATCH 3/3] arm64: dts: freescale: Use wilddt function
Thread-Index: AQHUpr+WBeSko1D/iEyQsecAnfiAfg==
Date:   Mon, 7 Jan 2019 19:31:29 +0000
Message-ID: <3678c8f380da308469d6cdcda9938ce79f94d3ed.1546888138.git.leonard.crestez@nxp.com>
References: <cover.1546888138.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1546888138.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0502CA0030.eurprd05.prod.outlook.com
 (2603:10a6:209:1::43) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5311;6:5j/EtFqLA9NaeJqNMvbIEowZu7DN/sJQzCB6zbmz2dxCe7mSzukj1cEWoii63Yvh4qOU8IX/YvY+DW6ePEbRqsz3lWbutT0qM7r5oAoKVnRedhy+/a02Zx8VZDY0YHug9gvK8j6SmeiXc3cZXF+1gzCMLpe4XLBKivbuYyR1ScpzBj1VZCtNIroGL/kYv9NWRbsZ1lWZBau9e16YK5JJWXeDidDLS28ptj4feycIQNkIT/FVP436WyC+4+ddyRtjX6iYU3ItF7K7SST+KTXjcVi+GjytkmAE9TJbgUpMxIHEcNEjjT5jJBApa1DlyzNKtowR8sU+W5nOlItb0NSXvvTa5VOO9HI4tyY6ejdCmrqFag+CQ093N/XtAlYEr+W+eDNDDwNAagRCsPr2l4QPJU4VJ0FvTHn/VH3CmcuQJHeChhcLu1nOuXL+JyNGKBPWLpG6nG1vKp5eeDR7NyCjgw==;5:17/aLq5v98er90SEflk82gldyBfjnt/Wj/OsKZNVswPSs+tl56bD5uTmRfOz2KakU7PdiVCycryAM0g9anrN3627nL9snRHzkLXvrVk+FlVG8Z26ADybDLZicl+74fctRKiv6GEQgDrQDZ/4etZjgtUVLSZqeVXc3zHEHLOlJIL2Cb64Exd7VoqMF+2+NHUPzdvQDcg4qQMYI5ety7vAcA==;7:o9H7J8Cob5iVUniQDeP67/TtphSBUmLs1pNzojxNR39/C/JqPxPC4g1Gyk73s3YiH4Wo2a0oJYWseMd5PuCK7e0fpuAMjp/D9TtTL2LcU939u7ZIh3Snj0HnFzMeBWE0EwSwW2VHwgbytelFpbiU9A==
x-ms-office365-filtering-correlation-id: 7a14a4c1-716d-4a93-3ccb-08d674d6b8ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5311;
x-ms-traffictypediagnostic: VI1PR04MB5311:
x-microsoft-antispam-prvs: <VI1PR04MB5311D0890E925CD2B3EA010CEE890@VI1PR04MB5311.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5311;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5311;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(11346002)(5660300001)(102836004)(256004)(7416002)(6436002)(97736004)(478600001)(446003)(25786009)(476003)(2616005)(14454004)(6116002)(3846002)(8936002)(486006)(66066001)(4326008)(44832011)(305945005)(6486002)(2906002)(7736002)(81166006)(81156014)(99286004)(106356001)(50226002)(186003)(53936002)(110136005)(316002)(54906003)(8676002)(105586002)(6506007)(386003)(86362001)(52116002)(76176011)(118296001)(71200400001)(71190400001)(6512007)(68736007)(26005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5311;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QD8GnYlegwePGG8LAh946dTz0+WVcTdnj3oETPp8Fr2M1f+UJdqjJ6gOHhHiP82FJoAaPpMitD50QaVzsLN7yay3XzogL1SfiK5MtRpQMlblQKgmfQ8FbJ4/WHqUVoyn/82EEZghIEpZ5eI7GFmd7+MjK5LC9DLMyb49GiwI7kERbcqoqsoVw9WnBoKhysXcnSU94CVp2XY6fBpeCUU6/wnb49n5itlQHDT8yJ0FTYANoFLpuPX+7Pz2RBpDm1NxmwnyYrryaZU7lRwGDu+8nkKs9x595rXqnUK5tryMOLD5D3GA1cyVc160Z4ltP5WO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a14a4c1-716d-4a93-3ccb-08d674d6b8ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 19:31:28.3599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5311
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the wilddt function instead of listing dts files. This shrinks the
makefile and avoids needing future changes when boards are added.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile
index f9be2426f83c..ab28e485179d 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,22 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1012a-frdm.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1012a-frwy.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1012a-qds.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1012a-rdb.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-qds.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-rdb.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1043a-qds.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1043a-rdb.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1046a-qds.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1046a-rdb.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1088a-qds.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1088a-rdb.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-qds.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-rdb.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-simu.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-qds.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-rdb.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-qds.dtb
-dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
-
-dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-evk.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D \
+	$(call wilddt,fsl-ls*) \
+	$(call wilddt,fsl-lx*)
+dtb-$(CONFIG_ARCH_MXC) +=3D $(call wilddt,imx*)
--=20
2.17.1

