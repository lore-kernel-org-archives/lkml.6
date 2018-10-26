Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE9EECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8046620834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U1dgyL44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8046620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJZRg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:36:58 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:43936
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbeJZRg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXJSpmowwoMgtUpxPyhN6zak+XiDj1tylJN5Lbwhnbg=;
 b=U1dgyL44KkZQjrpfEyDJyGL775UyURCLDPeOeV+iPRj6gUsIGMiHkihiwKWcSWA9UY4bL6F3VUGiFv0Pn7/EgE6rxNQibzhXgEgwDLW5ZSvEB7jxugflGePUMYl5mmKmkBBwb+78LBcIoSdjdrbVgSJarOeqJy9fZAvtOB4wQa8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5322.eurprd04.prod.outlook.com (20.176.236.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Fri, 26 Oct 2018 09:00:40 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 09:00:40 +0000
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
Subject: [PATCH V2 2/2] Documentation: can: flexcan: Add stop mode property to
 device tree
Thread-Topic: [PATCH V2 2/2] Documentation: can: flexcan: Add stop mode
 property to device tree
Thread-Index: AQHUbQpe5gW2beFow0Sv9y5P5048rQ==
Date:   Fri, 26 Oct 2018 09:00:40 +0000
Message-ID: <20181026085814.23370-3-qiangqing.zhang@nxp.com>
References: <20181026085814.23370-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181026085814.23370-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5322;6:DkkkOB7d46wLV+BjXZqlQ/ptWJENQysU15bDTORlonBn5z054nJtlOhJwiq2yC5d/8Mv2cMhkl4qqCrfqGwHD668WaU6EPuE5q/rk40YIsu/K8hL+wfHmQdSMVZPWJsPaUy0JzgxPbXOKqQe7vralhXhdXvkVyqonec1j4Pww0C6kqR/WVrS+xrkYKBx5KWWN/UU3SKlv1Pwb/ywr4QG++hvECFXzOzWT+WOYkcCIRAziURLACLp8GTq1vi06OTvZggWDSMDtJnH+oUjX0Un2Hgo81P/xIU9dubi/CLFlqhrkVKA02N5IR96vLCtepI7+44S58dns724lch35OgxGpuQtSD20LM7fp5dzm9F8F2JCsPUiufQ77LUwIUma9HZkOGqDKdJeh4gmZPcSD0FyZqgNJWjpvuihLEXO2Nh+IFFTrnFRMTyQXcRX7Xn64Wty3J7WBbEmuZX64O211j/wg==;5:GhyBeuSnqFm9X0A9Q4watjcc++Oxei85A/r399ZFnHQN4i2+Lz4HzV7KBxD2DwYpnm7ldTm24IFhuJxvUJIB73UG6c9W39cWymY/AOW1CPERszA7hHN7bpmNDgA8+4jjNVfVG+GKJD1PJHAS1Ma5jkbbfdQCRw5Mbr327eYGu2o=;7:Ip1fS67YADe3hBEDBOp+xtsHI8NH1mekUY3aki0W7kZ5Ji2Lby8GRDVyAshn+rEtLxyC23IBu02/ohATcWqUjIXGRfTUeFXB/T9rKCL5C7UBtJUART8Fvep81xFrG8CV04vosEIjv/gwegNeLE0E4g==
x-ms-office365-filtering-correlation-id: f70018a5-df56-4b51-0d5d-08d63b218041
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5322;
x-ms-traffictypediagnostic: DB7PR04MB5322:
x-microsoft-antispam-prvs: <DB7PR04MB5322F0355B0D3FEEEA0FF7C8E6F00@DB7PR04MB5322.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5322;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5322;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(6916009)(5660300001)(14454004)(6512007)(478600001)(53936002)(97736004)(106356001)(186003)(2900100001)(36756003)(2501003)(2351001)(5250100002)(54906003)(316002)(66066001)(71190400001)(71200400001)(105586002)(102836004)(1076002)(25786009)(14444005)(256004)(4326008)(446003)(11346002)(305945005)(26005)(5640700003)(2616005)(6486002)(7736002)(3846002)(8936002)(6116002)(575784001)(86362001)(99286004)(76176011)(486006)(52116002)(6506007)(8676002)(386003)(68736007)(6436002)(2906002)(50226002)(81156014)(81166006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5322;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yIe4JpHJVVhXpsX9dtlbe7x2HhaWRipGMo7dsw0yEG/diVBd6AGk7R+gNNEjW6TRB6ftm1+BnczQOX5yVdAAhcnVZyAHsQbAsxewe1pbK00PZmwTtWpgcQc94yrHfimDa0/QIzb+8/JNAjcecIxBbYuKru6FlCinvBr0XgeCMJojTl6JacXNNzHEKPcaADtqTkXecfJPJVsHax+zh8r912tW3yNsRKVk4Z5RuAlTKJXThLcOhbVtuedMLcix/lSP2KZbA6p6jz52BQhWLpx/w+js2mHrV44JujHrDGTf34+azSwdebSdFrvAGBO43nqzRv7oy3xW/xWuJCs0tt1HUdKTBJkAPwAS5B65NdspJb0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70018a5-df56-4b51-0d5d-08d63b218041
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 09:00:40.5480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5322
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
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Do=
cumentation/devicetree/bindings/net/can/fsl-flexcan.txt
index bfc0c433654f..23d56f7ebe3d 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -24,6 +24,14 @@ Optional properties:
               if this property is present then controller is assumed to be=
 big
               endian.
=20
+- fsl,stop-mode: register bits of stop mode control, the format is
+				<&gpr req_gpr req_bit ack_gpr ack_bit>.
+				gpr is the phandle to general purpose register node.
+				req_gpr is the gpr register offset of CAN stop request.
+				req_bit is the bit offset of CAN stop request.
+				ack_gpr is the gpr register offset of CAN stop acknowledge.
+				ack_bit is the bit offset of CAN stop acknowledge.
+
 Example:
=20
 	can@1c000 {
--=20
2.17.1

