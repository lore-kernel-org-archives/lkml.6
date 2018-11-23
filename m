Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6257CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C2F206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gEyXtRpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C2F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502282AbeKWSIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:08:23 -0500
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:40864
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502240AbeKWSIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09Ph+VOY1dZ4/lHV4nEu0Rr9KF9OG8Rm+e5RBAtCGEM=;
 b=gEyXtRpkzyl4YvMAruV6UkU8zwOMOTNhMWb5WyBp1gAJnIM4FsrpbLrMYYlBCXyhnYpmkuEcHjKrwtLgPvulNCclDcG9A+BK4lGzi8I4em9ckamWVYJlWD4JHsHau+P5VjcDc8o4flMaSzpkU+KKxJYg8OY2dH7sToS/i3oBHRA=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4409.eurprd04.prod.outlook.com (52.135.137.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Fri, 23 Nov 2018 07:25:17 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%3]) with mapi id 15.20.1339.029; Fri, 23 Nov 2018
 07:25:17 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND V2] Documentation: can: flexcan: add stop mode property
Thread-Topic: [PATCH RESEND V2] Documentation: can: flexcan: add stop mode
 property
Thread-Index: AQHUgv2uniFxiGPsD0qYPV4M2+BqFw==
Date:   Fri, 23 Nov 2018 07:25:17 +0000
Message-ID: <20181123072305.18236-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4409;6:55zgEqP6uv/GBRKiaxn+UYdS/UbkIihM75mXvChx8zqwYuxj67FR/NZGz6rinu3WXdkc3s3MZuae5bfy9E8c2GZOpFqG7lB/3gDOSO0F4oPQXN7digyCHW4VqZz9/gdXneGiR3aoxmccxO4uMODB62F67mqK/FL3mW5tWUOhINkOEEeNy6+UCRe6WuiWLmg0NPPd8wWTF3m7OZhstHTjOCOIw8modhjm2vwlc1fG4KmRKZcBvxN9T/qVv5CT+g0fBoOvBWKpyZh2gwsSt4JNEKAn+CTx576k2AMzvdAZzQKCfHpaKeTjE+/YWVylT4gsP7X9qO43AovY5DSV+mAWCuL5U/3CIBaurRtWBQYzL5lve6XMcUjRKqwdMNI2k8A+A90wrWrsVER7blu0ksaMrW2Y073vLCZnhZK8LSdLbHThst8diuN22Y6zn4/gsIGfdSwXKhfM4Nm2xelcYWV6kA==;5:mo91PfwKYePGPCmBZLVxxRqLAHDuIB//Xr2fQQ/niaDd8DQxQlq3zrWOqJfdAO2xbjv0lkDRfeA5Xk+tptc6prfJgDiG3k2gSye3ERdW6wI7/NInQXOCpebLQkdkvhJ8ahRElTA6g9MXSku9M9bCfyEovSH3p5Ki5Zf9OqHkRK4=;7:/vTpWxypoGERcEK4nVsXYhJOAhMbZ0JXVaXbJv/JqsTs1uv/I5plJ+s7AvZJzJ4dN4Q7Jesd07y9Z0/BehFUE/nGl2A4S0bhZGw+WXFAkt/8077xmmSt+1pbL7xuhrIQ5CO3/SqAx8MLqBwUatJzpQ==
x-ms-office365-filtering-correlation-id: 1d9bae3b-a23d-4b52-a227-08d65114d135
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4409;
x-ms-traffictypediagnostic: DB7PR04MB4409:
x-microsoft-antispam-prvs: <DB7PR04MB44099951F06DB272B0A65C36E6D40@DB7PR04MB4409.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4409;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4409;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(54534003)(66066001)(53936002)(6512007)(1076002)(6116002)(36756003)(3846002)(14454004)(2616005)(6436002)(54906003)(476003)(2906002)(97736004)(4326008)(316002)(2900100001)(8936002)(6916009)(2501003)(5640700003)(6506007)(386003)(26005)(186003)(106356001)(99286004)(105586002)(5660300001)(305945005)(52116002)(102836004)(2351001)(8676002)(486006)(71190400001)(6486002)(71200400001)(14444005)(256004)(50226002)(7736002)(217873002)(1730700003)(575784001)(81156014)(86362001)(68736007)(478600001)(81166006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4409;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7DgYpgm4bKW8ofcviIWrhJdMNqNw3Lst4Ywvigmne3fFz0TDZgIoyuaD39181LeAxb0EhLz5xES/T4rfv/zgtJqIlFIdYIZ1BDneRvWwC1hQT/ujjVPcAR+WFYW+3vFD0YM9QABrUSY8HCbxpL21LWAL4Lk9B/qT65QnNCpGsBWU1QEdZm4i+4rO3M+c66Efje4z+bFG+ZZflfLzbZTly/cGJ+PyNxF/WDSJSHKLkrSWHJH1vZiHcvmc80FoD/fQJsBaJiA/GXdSPWBFpBQ7iVo603UncjBvuk0L8xm3jPHndgaPJjhlHVISQw0Jx3mS7ibsH9fHV1geccBrIqRDKjPiIb6epM/GqrbGRMGOqX8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9bae3b-a23d-4b52-a227-08d65114d135
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 07:25:17.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4409
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The FlexCAN controller can parse the stop mode property to enable CAN
self wakeup feature.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
ChangeLog:
V1->V2:
	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Do=
cumentation/devicetree/bindings/net/can/fsl-flexcan.txt
index bfc0c433654f..bc77477c6878 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -24,6 +24,14 @@ Optional properties:
               if this property is present then controller is assumed to be=
 big
               endian.
=20
+- fsl,stop-mode: register bits of stop mode control, the format is
+		 <&gpr req_gpr req_bit ack_gpr ack_bit>.
+		 gpr is the phandle to general purpose register node.
+		 req_gpr is the gpr register offset of CAN stop request.
+		 req_bit is the bit offset of CAN stop request.
+		 ack_gpr is the gpr register offset of CAN stop acknowledge.
+		 ack_bit is the bit offset of CAN stop acknowledge.
+
 Example:
=20
 	can@1c000 {
--=20
2.17.1

