Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30247C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B7B20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="u9+4uClL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B7B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJWNi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:38:58 -0400
Received: from mail-db5eur01on0043.outbound.protection.outlook.com ([104.47.2.43]:61492
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727507AbeJWNi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9OzGQ5MIFhSYDB3Kgz4EEmxXia+91K6OaTezQU6VBI=;
 b=u9+4uClLmjhWt5ByifS1pLQr4fZS4IEwyInJGWN1xxFx9i+IXevutYSvThvWasMMYM24YYLVxgbHmc55oUzFs4JKe7VhHEOPFWjBv6yYkp5lmkdlcPCiziXOyH/eijU8tQ2gzmJ9hJZzVtS/aootSsQKZ0uvNelNZwpGx73DKD8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4299.eurprd04.prod.outlook.com (52.135.131.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 05:17:10 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 05:17:10 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V1 2/2] Documentation: can: flexcan: Add stop-mode property to
 device tree
Thread-Topic: [PATCH V1 2/2] Documentation: can: flexcan: Add stop-mode
 property to device tree
Thread-Index: AQHUao+mI3l7tN6zL0KclxHnH2Attw==
Date:   Tue, 23 Oct 2018 05:17:10 +0000
Message-ID: <20181023051449.2116-3-qiangqing.zhang@nxp.com>
References: <20181023051449.2116-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181023051449.2116-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4299;6:AkKR+Pfufl5JQPwuv8sBXbGFrNNjrdl9oI/MUd9M6E7y1/qJtT/27BBNfc2iXUTCFIYkeQvl0sc8LUhTgj73yyd/wrNLj3Dn1+2B4ixE0pP3trntMlIIUxqR9+r47jqV/t4pycvlwwsNbu8bCSKJn+Ia59Qyk683n6I980nIGjNrOt+bx6TS1k5Aot9SQZKfDQjy+2sMEbUjlx77iy3BjkNUCK3lm/92vffx0H/uJ2I+sJZPxUX+U7eelt1eQSkTjr2UNGov+yoXopzJUh2rzSB2uEP4q8agYDq/Ql9QPYoED3rSOjQy7/e356Asvh5C9oOoDHIFOkCyOk9eH68h2T7TUN4Kewzq/qjJpCLo2If+J3nBY6T93PR/2H/Udm7DMFAb5nlxfUUo7Bhnq55JdZzUYtuSP5NfF8l7rGQK24otMWz8cTHCOlMJfXEAU9DPwjJouNakG2KhfCAiRjf1kw==;5:A0NuFcM/QYtWOCjBI6lpW8FBgNt0nBMl9HGo+0zz1BZVREy2G1RQ3cQ9JVrvbpsMBHtUy6JRTrFOQ55DeZ8kuB4fsYj+JopXmgC78+VTmkC4AC9bA9fCMWafHciKp6vqCr6zAW4rM89rch2mYfUWm284zZY94vRpXlX//MxDOtA=;7:hWON59xaL/YtuZdsQ77Ur/hMiFY9JBRj7tbJQdQzyF+NzCHgD1UHybxBIbUbUYqyWgnMMqkmLQAonAIjdDBmc4pziAwtBB6dSpVS6tyWKthpNMUDFuPf0H9NjXoMo4curwmsVwwMFARmm4HsWGPHBtsexN5w6zIo9UO2o0hp+mU1HCM3rXld32l3DaDngyPX0wzE43oTwZFtmKTPkl3+ozLJz+dzMjUNDT6rMvxMu2z55RV1EhE0DrXxHGgytRnx
x-ms-office365-filtering-correlation-id: 2a4c85a4-a843-422f-7649-08d638a6c8d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4299;
x-ms-traffictypediagnostic: DB7PR04MB4299:
x-microsoft-antispam-prvs: <DB7PR04MB42994CF601ED0DD7921EE281E6F50@DB7PR04MB4299.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4299;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4299;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(136003)(396003)(199004)(189003)(486006)(52116002)(6436002)(99286004)(5640700003)(102836004)(6486002)(476003)(26005)(6916009)(186003)(71190400001)(36756003)(106356001)(5250100002)(446003)(71200400001)(105586002)(11346002)(2616005)(76176011)(5660300001)(3846002)(305945005)(2501003)(2900100001)(7736002)(25786009)(1076002)(4326008)(14454004)(6116002)(97736004)(478600001)(575784001)(316002)(68736007)(6506007)(66066001)(86362001)(386003)(2351001)(14444005)(8676002)(81166006)(54906003)(50226002)(6512007)(53936002)(8936002)(256004)(2906002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4299;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ny6EE+XPZNHiir8Q/AAAvuMMW10y27Xkr81O8oobcwv+tKkOUZpA9aBKiTrdEgwKEvPm1F5jNKTDEQxivC6CC/molqC3WdTfd31XX65/nm7dEiz6e0yYjGfgq7ho5753s5zU3doISwjYHO3QIwY8dpuubdKJ76OcSM7lh2dskrrvOlVXU9P8l4zecR6akI6/fuHcOLt0aOCEVX75TXiAHmcv2IN6PzTdKVNjbJYEsZwH8GowwUM8Pbkq3St5xrflYQeSde5WzoF3hAIoPneF845ygVnpr9HqBd7NFkVM7LtzoeQMtru+IMcpJlcMTAP35ua1kkK9yhVIzm0biwXf1R787CutxuL7ODHqcIRT5Cg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4c85a4-a843-422f-7649-08d638a6c8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 05:17:10.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4299
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The FlexCAN controller can parse the stop-mode property to enable CAN
self wakeup feature.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Do=
cumentation/devicetree/bindings/net/can/fsl-flexcan.txt
index bfc0c433654f..b5ccfc9c14fb 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -24,6 +24,14 @@ Optional properties:
               if this property is present then controller is assumed to be=
 big
               endian.
=20
+- stop-mode: register bits of stop mode control, the format is
+			<&gpr req_gpr req_bit ack_gpr ack_bit>.
+			gpr is the phandle to general purpose register node.
+			req_gpr is the gpr register offset of CAN stop request.
+			req_bit is the bit offset of CAN stop request.
+			ack_gpr is the gpr register offset of CAN stop acknowledge.
+			ack_bit is the bit offset of CAN stop acknowledge.
+
 Example:
=20
 	can@1c000 {
--=20
2.17.1

