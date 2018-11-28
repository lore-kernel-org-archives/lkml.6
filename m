Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE861C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A952A2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D8TOSkqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A952A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeK1QVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:21:30 -0500
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:53888
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbeK1QVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXPRTBfu4X9+eX2ItXBC/jirovDTufRCrKQ0s+zApNA=;
 b=D8TOSkqaqIwo/0thDifKIbT3McjB4afXz4GhT7XBPlA2hM1Aji3LFRe+6qP2ns4bNpjeubex8I68UXr94LDEyRVCSeqHkkzQ6F+8xr5GDCpTjIQRTda9WWLNnw5pG1QJ4HajN9qqZgQeDqf6Pa4M3y26fe1bRhqOcJpHJloue9A=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3801.eurprd04.prod.outlook.com (52.134.65.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 05:21:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 05:21:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 1/4] dt-bindings: rtc: add binding doc for i.MX system
 controller RTC driver
Thread-Topic: [PATCH V2 1/4] dt-bindings: rtc: add binding doc for i.MX system
 controller RTC driver
Thread-Index: AQHUhtooEacGrJO9bkq/2zozpkzlcA==
Date:   Wed, 28 Nov 2018 05:21:04 +0000
Message-ID: <1543382119-2918-2-git-send-email-Anson.Huang@nxp.com>
References: <1543382119-2918-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543382119-2918-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3801;6:gUAePTaTTR8HoT9DtzvSFbt810oRUF4uzOVTyAffQ/zssyaLFuq03iEG8x/ZMcfUA/D8WdMf/KZt5ZjovyfgHqnF6LmGfmZ8woOY5+gtT9hwN7yy7DheeJ3d0A7Dx9nkQ5ld1aeC/jjQU103okiQ1IU5NVvcz9+Ggfup+tCTFsLqMl2V3deX/A/gWvUqzFPkCnmcrlSLfAczghy201vS11VY+DTlowYqkx8Xk1awDPh3j1nlkwDXe79AGBVW3AHsZGG5NpkFppVgNAA82oQPHo1SiSTrK7cm0nKrAHXnWoxoDiZntYoHmHcCRBKzcbuBza7v3UcsB4VqKwiw9NPbjWhs/hnShWEN82Xdjyf2SZnbVxOPUZuZy3CMPo3x+enrpK+GgTdLMYt69U6sXj3BVtfcmVW7cM95HmerfVqmF4Cqbf8rdqp70g/jiOgP/MqbAg3sOruMBqzZjagSjFd1EQ==;5:JcpS3ogrXALpTWJz7NbjmU5oBpCM259NTKPO/9Ptve6El+aqqqsM+iG6XanZIUDbd6EwYOmFEvunmrWV3yyGBr5udDi2Cv4D2PfyEYiJIhDa4Z2hE8gMMSldoOnLZtvkYhvijYt8I7je7e8JHQHQfGR4an2Ej1zG1kYXN3ednqw=;7:WHch8NAieIK3o67x+3LpqPQWUnMlZYPYYHHrQzp9TDBOrLuN6uewSZR09ePJFT/SrlmNv64+n8147FcMkmn1U2qOXwVdZCwR3L9YPU/V9sLV4eHm75taZ7VlDplAVTRlImcQNoE+Lybz58zEKEqxhg==
x-ms-office365-filtering-correlation-id: 68afb0f8-1509-488a-6f7c-08d654f14b3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3801;
x-ms-traffictypediagnostic: DB3PR0402MB3801:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB38015528704CA5119DECC064F5D10@DB3PR0402MB3801.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231443)(944501436)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3801;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3801;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(99286004)(2906002)(53936002)(5660300001)(36756003)(4326008)(25786009)(14454004)(6512007)(386003)(11346002)(305945005)(76176011)(6506007)(186003)(446003)(256004)(26005)(52116002)(7736002)(486006)(7416002)(2616005)(102836004)(66066001)(316002)(476003)(478600001)(50226002)(81166006)(8936002)(68736007)(110136005)(8676002)(106356001)(86362001)(105586002)(71190400001)(81156014)(6116002)(97736004)(6436002)(71200400001)(2201001)(3846002)(6486002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3801;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rO47S/ef/VlA4qz0PRX2GNiucxLkZenyEon8bQmjIrvRl8K5GePsjIPLbmXhFfJdbV+cTJ/4WvEVVIweuzh9JL0SxLsqFrfwcJw6u4P/H5YcdNKpIumUSyPtxsEQL10U1J0JpmLu5JcoJS2s5y5jtEwciUjdtb39TGFZF9KbvaO5HIhdSu2znC2tylONu/elcLI1UrJTxOie4Ata+tF9DkEfYBTdgamv8iBt2u/HOZPwqq+v8leeikYQlE5Bhcsx6njB5iGIlKRWL/HuIgJCMOAwe6rArV6P+sEpIvXhoC/Y83LNQ+BiHypnjWTtSeNyzh4JZ6/WzBCvTp2PME5Hl2Fb7K4k2UhrSRHwpsjZacs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68afb0f8-1509-488a-6f7c-08d654f14b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 05:21:04.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and secure RTC etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to do RTC operation, this patch adds binding doc for i.MX
system controller RTC driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
	no change since V1.
 Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt b/Documen=
tation/devicetree/bindings/rtc/rtc-imx-sc.txt
new file mode 100644
index 0000000..d6e2353
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
@@ -0,0 +1,10 @@
+* NXP i.MX System Controller Real Time Clock
+
+Required properties:
+- compatible: should be "nxp,imx8qxp-sc-rtc";
+
+Example:
+
+rtc: rtc {
+	compatible =3D "nxp,imx8qxp-sc-rtc";
+};
--=20
2.7.4

