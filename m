Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE9DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98B620851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DhUUr58q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98B620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeLLF23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:28:29 -0500
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:53440
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbeLLF23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32CN1dgvS4McnxaTmIP1aBagej915dzDeril+FO2HWY=;
 b=DhUUr58qAJnKHegMieoHRxKMBLIis9uHX9+ZiaK+JxBpRTKDN0kCf9uquNrukybuCHxdns1C1gAsf7g61ny4YxR5FDjW2JTw5L+C3pVqf4IOza2qVKRCYQ16uAmy/UJ38eazG/1fe42Fe4VlSLMYj+VvE2EuY800YQdJPJ5RqAg=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB2942.eurprd04.prod.outlook.com (10.175.24.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 05:28:24 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::15e0:9552:81b4:33b]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::15e0:9552:81b4:33b%4]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 05:28:23 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2 1/2] Doc: bindings: Add binding doc for nxp system counter
 timer
Thread-Topic: [PATCH v2 1/2] Doc: bindings: Add binding doc for nxp system
 counter timer
Thread-Index: AQHUkduARh16C/9X+kahxefpAnw0hw==
Date:   Wed, 12 Dec 2018 05:28:23 +0000
Message-ID: <1544592770-19996-1-git-send-email-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::13) To VI1PR0402MB3519.eurprd04.prod.outlook.com
 (2603:10a6:803:8::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2942;6:Bl/+nqm/i/mhw0TavRDDNNEcKmayMo1rFceC3CYdLsp+hAhusVmQTTeVNDvBJpoMjFlnCG2LM7XUJbMBUMCtSEqy7zAtDMHBa8LncJAoW39BqgN16vrUAZJCQdG3E9dxgrCJzHr2NmuVttmB/BUg1SYHE52EV/zLSlcOCbMo69TNWpX+O4umGHCUOsQtghN/c2iHPiLTEIa8OBrnD9hx9OxV2kEVuSDky9241XOfT2QK1G7W4Fbf0iNt1TVBsofhTeab34Ms9SpnW0cvr/eGS0G76sX/Eh5GPoDTVoVis06RMrqOCk7k6SuI+/sfkQDPu57XBS5Vfl8b3M8gRKT7i9v1DOPhENG8iCh6TYjPrp49Thk8AhfIPNibeyzgxKjuR6VmoFYIV273iSr74qdCbrMo4GiWVSkjjNYssjhptp2dOLjkm4erQEdvnzJ7oYtW9oh0m40C90ySW00jFLTbxA==;5:AR1kW/h/r8eB378Qay6bpJYxjO6PV6lkTbDNzYs41ecO+7sDuBogG/GF5+key52D/qIk9iPFs3Zeulq4sNbth9NFYiSYUi2OkXbZcYnT0tpTJqTa1J7XGqawxtNQQbUHhAe3M1RyAA56KUz+vkFt8z8oPHeTWLi9xeVZZj8TLSs=;7:oKEqqP3vEoppkv5aYEHVlwSKAuZXDeZjNTXv1Tr0MkquYbonNbWfL+Op+k1jz0PHLnBC1HgXtA93eHdFflOhgDCenqJ/uZhhi4bbHAuxC/stDiRrjG1YbobRS2/UMH1k4jp6JMf1hJz/9d0tD6OYgg==
x-ms-office365-filtering-correlation-id: 1219c83f-bd3a-4c19-d4f4-08d65ff2a26f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2942;
x-ms-traffictypediagnostic: VI1PR0402MB2942:
x-microsoft-antispam-prvs: <VI1PR0402MB29421D5E38B6FFC529A3ED7B87A70@VI1PR0402MB2942.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2942;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2942;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(110136005)(102836004)(105586002)(6506007)(386003)(86362001)(2616005)(99286004)(53936002)(316002)(54906003)(25786009)(2906002)(26005)(6116002)(3846002)(106356001)(66066001)(52116002)(256004)(6512007)(186003)(5660300001)(81156014)(4326008)(68736007)(81166006)(8676002)(8936002)(6636002)(50226002)(97736004)(305945005)(14454004)(71190400001)(478600001)(36756003)(71200400001)(6436002)(6486002)(2501003)(476003)(486006)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2942;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9077xr2Lmdx/x6omAQxGGYQdoNlOC00NVXkM6BsI12Hi5TCSEu2lCpF/yyydmQVHbQiTmwjR7698wcnkWJEaZf6MRsYrnt7YM0CMfadXGj1qKq2h/hEOHE58wRVjyOtYtHEWFVAzgXQ9bG8ZhKf0xRdlJvS+RtWgEoUsHPRrqNCJANTWdmXSwG+7qy6Ih8skYQyXb8B9FN/6Wy5MZAVFWRHZ/nIuYPJ6sHjOtiLdZ3iDdlJhnx4gFFIeL6pCXhK5xkQ594Zdgnnhzfr+jEQ7fl3gF+nkwGTvuWgedkPnYjDuZyhi3sG/CGRX3fqrgbQE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1219c83f-bd3a-4c19-d4f4-08d65ff2a26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 05:28:23.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding doc for nxp system counter timer module.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
change v1->v2
 - remove the blank line at EOF
---
 .../devicetree/bindings/timer/nxp,sysctr_timer.txt | 26 ++++++++++++++++++=
++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr_time=
r.txt

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr_timer.txt b=
/Documentation/devicetree/bindings/timer/nxp,sysctr_timer.txt
new file mode 100644
index 0000000..21f1527
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr_timer.txt
@@ -0,0 +1,26 @@
+NXP System Counter Module(sys_ctr)
+
+The system counter(sys_ctr) is a programmable system counter which provide=
s
+a shared time base to Cortex A15, A7, A53, A73, etc. it is intended for us=
e in
+applications where the counter is always powered and support multiple,
+unrelated clocks.
+
+Required properties:
+
+- compatible :      should be "nxp,sysctr-timer"
+- reg :             Specifies the base physical address and size of the co=
mapre
+                    frame and the counter control, read & compare.
+- interrupts :      should be the compare frames' interrupt
+- clock-frequency : Specifies the counter clock frequency.
+
+Example:
+
+	system_counter: timer@306a0000 {
+		compatible =3D "nxp,sysctr-timer";
+		reg =3D <0x0 0x306a0000 0x0 0x10000>, /* system-counter-rd base */
+		      <0x0 0x306b0000 0x0 0x10000>, /* system-counter-cmp base */
+		      <0x0 0x306c0000 0x0 0x10000>; /* system-counter-ctrl base */
+		clock-frequency =3D <8000000>;
+		interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+	};
--=20
1.9.1

