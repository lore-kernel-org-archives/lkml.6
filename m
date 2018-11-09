Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF88220883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qUb/imFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF88220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeKIUXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:23:11 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:59885
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727532AbeKIUXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVp+gp0Zjd1+fwjQt2FwYTF8TDBkcjEX1B1nF+oLYmE=;
 b=qUb/imFssJKpy7xDZv7KNKGYWEUQN+paS1D6XxKxALesg5rdxIphQ3rsFxgK2R/E+woPqTnS+IupoMpa25F+0K6aOZcLFQMu5bOZXptd4mnG7ZJjUkiyeyzvS/EBp9rvzyoAVqOu7wQS0rTuQAYjX1HrDGjWSQb7kmo6o05mWo8=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB2702.eurprd04.prod.outlook.com (10.175.22.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 10:43:06 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::d3b:2db7:e2cb:cc45]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::d3b:2db7:e2cb:cc45%2]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 10:43:06 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Doc: bindings: Add binding doc for nxp system counter
 timer
Thread-Topic: [PATCH 1/2] Doc: bindings: Add binding doc for nxp system
 counter timer
Thread-Index: AQHUeBj/Wwlaqk7LyUC/Qc2INink6Q==
Date:   Fri, 9 Nov 2018 10:43:05 +0000
Message-ID: <1541760402-17274-1-git-send-email-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::25) To VI1PR0402MB3519.eurprd04.prod.outlook.com
 (2603:10a6:803:8::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2702;6:j+r88V5uUW3JKa3U2vYXkKIcvOEvB0LmmnPQPZqQQdEy2bBpINC6cXE70WQlJbkFq/c3u4O3FVedK9j42Y8qHlwHCoBmiluxpMIH21d7zvUY/lLXbACGiVzxPPVe9bwWr9HS+BuwjFQ04UeQc1X0HdEp1TqQfqtJ5mlwGiWlLMq0e4Ck+7AFeOaiTvfKRU0peHGFyEEbY/JsKMbkhUuuLUCO+Q0z6lK+GviuXiSKXtEVADXXgTr/rpL2XbNiECPeY1iFMw3QlC0Y4oyFeojogHaXxFJbStnrQekCJn8RogSogwkusxV+khOn9kJlV40CrmP6G989by7hm+LjRGipuui2bMrAdQNNCsuef9bA21uFzOdAp93Qj1e10n0PBKWhpL0YJNZ9solP2CDMwLQmspr+MIUUWqN6MZ+ez4MoaPJSLOIM7onazqR8R1aGMvjXyNZ53MibqjR8Zm1FwlDCbQ==;5:gM7uiPiqsBAgfv7FWdiJovuHFw+XW3dm6j5/YIxBNa1PgtE+vITAdwfCc0WyZyWWwwJmybwWM3x7oqwBzVO3dKXyBuuJdpDG1v5T6vYcWM/WZyUlLIHJSBrj1lFpwGMK1hfFM3q03hHis16ICy0YK8ALy0TjM3fw0MSaj4yn1GI=;7:DRRi2Ip+z1AOTFzIFS00ve60fMJonZwEctXqFdR+tZ9LcTgcB/urS1lj3TJJKJSerjXsC1/mKb+t++GK0pS8lcEmwiBjQi9HO8SOzF4Zd+e7OkI68xf5NV6SgmuZjjtVL47KZsuiGMnrE5MZhJdizA==
x-ms-office365-filtering-correlation-id: afbccefe-15f3-416c-ba14-08d64630217f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2702;
x-ms-traffictypediagnostic: VI1PR0402MB2702:
x-microsoft-antispam-prvs: <VI1PR0402MB2702C69095B67D0FAB3821A887C60@VI1PR0402MB2702.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2702;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2702;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(346002)(39850400004)(189003)(199004)(486006)(14454004)(476003)(2616005)(3846002)(6116002)(25786009)(102836004)(305945005)(99286004)(71190400001)(26005)(2501003)(81166006)(386003)(6506007)(6436002)(7736002)(71200400001)(2900100001)(52116002)(5660300001)(6636002)(4326008)(81156014)(256004)(36756003)(8676002)(478600001)(54906003)(66066001)(110136005)(2906002)(97736004)(6512007)(53936002)(8936002)(186003)(50226002)(6486002)(575784001)(86362001)(68736007)(106356001)(316002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2702;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RMWQT+Zp/GPX4QYAuKyOJz1kiqVHRGqNxaUV+VCo+q3RH9m+G0ekiq3013epsuIqEwnxYhRIp6q2SLbvDsbTUSLdgY49+eHTG7aGBBYt84Xd3FlACwFOneXETbVCJ4DzJYkyg7mMHjrTywOb4jYp8wnYYlDFV5syfptJjE0iUnSgJrVc1JRwAM8/eNXtYQPEt7tkRcG6Spot4GytzrO/nN4IRFIjiX4KaaV2AsHXouO1HhAGj0f9ane8MQI3YuBE7Mth1xNJDx2MwwQWXqbRfAZTvM1N4RNM2NqEo/MrEoarVH4LIN8e4BTsl6SfxN8PNgyZgN+BRVD8YSmjmj73CdXBzAPwMzgP7D00chYoBWs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbccefe-15f3-416c-ba14-08d64630217f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 10:43:06.0147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2702
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding doc for nxp system counter timer module.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 .../devicetree/bindings/timer/nxp,sysctr_timer.txt | 28 ++++++++++++++++++=
++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr_time=
r.txt

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr_timer.txt b=
/Documentation/devicetree/bindings/timer/nxp,sysctr_timer.txt
new file mode 100644
index 0000000..6c0aeed
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr_timer.txt
@@ -0,0 +1,28 @@
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
+
+
--=20
1.9.1

