Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C0FC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E249420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B/VSx42Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E249420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeLMHIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:08:05 -0500
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:48784
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbeLMHID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph81R+A3kNDDvtmLfC1J/OB8tc/KpBFapkAKd8klNE4=;
 b=B/VSx42ZDZ6NbQb2xcvxdYfK7fcVxWngqFDXIe15xJRpvKeRarnillTBzFY5sFnOhINwtWAiS2A/deUu1MMz9/luWZZ/JugMxvyKARs73yBxFm5CcHyf6W2YomLS1WZEu3ivQ1lr2Alazvm1R3hThnCR/s1xGV3sJVgwRu6sIow=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4985.eurprd04.prod.outlook.com (20.176.234.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 07:07:57 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9%3]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 07:07:57 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 1/2] Documentation: can: flexcan: add PE clock source property
 to device tree
Thread-Topic: [PATCH 1/2] Documentation: can: flexcan: add PE clock source
 property to device tree
Thread-Index: AQHUkrKTIckHgyi7wUKqieTSsLQm4w==
Date:   Thu, 13 Dec 2018 07:07:57 +0000
Message-ID: <20181213070537.25095-2-qiangqing.zhang@nxp.com>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0128.apcprd04.prod.outlook.com
 (2603:1096:3:16::12) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4985;6:NbmewxZv/bY2od0/dKzwIqLc1np8j5wWnijEBJkl0TGukODHBd0oOgs+S+OINaXZ7u4RDgtRB/6fuiaU8tr7NjO1HhypBrYS3MuvWHshxNfpvv5lWhLb9cWiUo6lEwJMnovGF68tRvGXH5p27hOhnFs4UDDKzudijoy1xBm9jYXfKycAHNoOfqPp1K72+DoEyo48W0sXIer2UKVLJ7/mfpFdltwXryUKf10bU9a9G1qJyLEhbWoQQ+yS23s5yRm5Uv2EsjabmmoLY766iMxkK3IiSfSxlUX0ADN4wIDMHn/+HhS0X2hI82AZd1aJboUvulAfRu/wnZxfq/qO311sU1S/d3H4JV+AVVUdmMzFY68PM/wxQ2hSPX4vapIoAg71AC/xsJHad/y7Vt2EhYytpnbPSwNe2vAg8wb9zAumuzpoWwhAB4TM8Mnf5Qo0+U7LYS/kjovYRtUJgQmPzVb6rA==;5:IfCo1Pi23IuqEvBORQbr1kF0P4zN46zosTbiIN5AuiU1KAYugSuMFo+B6W1jqIXFY9Nm0xCGSdHl2qBj+C2KxLywRAx5yWZnrylLR7iz6ic2BuVMscPxHcbuFQdLWXddttOW/Xfd0GggxZl4VH+qYWJrLVw6Z8NhsRcD4dh5XY0=;7:apyl9VnBVFLrrAM/iXAiqA7QYuMOMQ5Nt0WCg51u4q3gs6XNxtraiRZVIOL+gvXmuOBc+fuyhMvPDQSvg/OyrlIV2yFhxECEgt+BZdEtgjcHq6Q1WEbocngmvJmbHpYL2BqG8fDYC1EABKlrn9PQLw==
x-ms-office365-filtering-correlation-id: 95b67485-70fd-4c70-c5a0-08d660c9b56c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4985;
x-ms-traffictypediagnostic: DB7PR04MB4985:
x-microsoft-antispam-prvs: <DB7PR04MB4985F677B85F9DA586442008E6A00@DB7PR04MB4985.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4985;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4985;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(97736004)(36756003)(71200400001)(106356001)(71190400001)(81166006)(8676002)(81156014)(52116002)(66066001)(486006)(256004)(2616005)(476003)(316002)(446003)(11346002)(86362001)(76176011)(50226002)(105586002)(54906003)(110136005)(8936002)(2501003)(3846002)(6486002)(4326008)(6116002)(53936002)(6512007)(25786009)(68736007)(26005)(186003)(6506007)(102836004)(99286004)(386003)(1076002)(478600001)(14454004)(5660300001)(2906002)(7736002)(305945005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4985;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DsoFDF+4vOgssqkS+wf3bcxkRpldEbxekhOYGwnxjBXbRTehdARU3nzE7EOXrVKPDslg1BowOesvFRU5FOITq31uq8PWQAt3roOvg/VtTIr1Uiyw7BCp8nLqo6HmzTZdrbVtARM1HdgKUwIVe4ObCs4FP16QMHCeTqvfQgeM6ynwHQcMLvuvgcyKpr4C4LBwZ3tpCbkftxdFmxUrDw7CBOZO+YvNpotknYKNpqtCGc8qzOzwzxiL2V3L9NyJk9L5hl+2Ndcx0t62qsyrCHMJrN2amjooitnJoLDZaFyFlFv9l0DeaIdTAhqg1R8AkQVD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b67485-70fd-4c70-c5a0-08d660c9b56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 07:07:57.0813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The FlexCAN controller can parse clock source property from DTS file to
select PE clock source.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Do=
cumentation/devicetree/bindings/net/can/fsl-flexcan.txt
index bc77477c6878..a04168605998 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -32,6 +32,13 @@ Optional properties:
 		 ack_gpr is the gpr register offset of CAN stop acknowledge.
 		 ack_bit is the bit offset of CAN stop acknowledge.
=20
+- fsl,clk-source: Select the clock source to the CAN Protocol Engine (PE).
+		  It's SoC Implementation dependent. Refer to RM for detailed
+		  definition. If this property is not set in device tree node
+		  then driver selects clock source 1 by default.
+		  0: clock source 0 (oscillator clock)
+		  1: clock source 1 (peripheral clock)
+
 Example:
=20
 	can@1c000 {
@@ -40,4 +47,5 @@ Example:
 		interrupts =3D <48 0x2>;
 		interrupt-parent =3D <&mpic>;
 		clock-frequency =3D <200000000>; // filled in by bootloader
+		fsl,clk-source =3D <0>; // select clock source 0 for PE
 	};
--=20
2.17.1

