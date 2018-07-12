Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E496CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C44B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="OB8/7En5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C44B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbeGLMHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:07:23 -0400
Received: from mail-by2nam01on0068.outbound.protection.outlook.com ([104.47.34.68]:46612
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbeGLMHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9GomfFzqdCEarsczV2SGr5eV8Alq6Q9epa6MWbfslA=;
 b=OB8/7En5m9TcjCJWsO+o7DAChpjXK1NLwjFtr4FtGu128tmdqhy9joN9SecaR7/iOb3u19qwp5Bz8Hz1+cVglzWyv3HZz4zLr//yDTTJxsEqqA0X2Mk0FVuHXKeFoDmxIeigy1pF7I6nVxLisexXaO1tX8WdeGmDxUl+wE3W36M=
Received: from BN7PR07MB4676.namprd07.prod.outlook.com (52.135.249.153) by
 BN7PR07MB4194.namprd07.prod.outlook.com (52.135.244.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 11:58:05 +0000
Received: from BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::dbc:2355:dd0a:fe48]) by BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::dbc:2355:dd0a:fe48%4]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 11:58:05 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: ufs: Add UFS platform driver for Cadence
 UFS
Thread-Topic: [PATCH v2 1/2] dt-bindings: ufs: Add UFS platform driver for
 Cadence UFS
Thread-Index: AQHUGdeX9venWtNnJUqnECBpRhT1bQ==
Date:   Thu, 12 Jul 2018 11:58:04 +0000
Message-ID: <B652B768-D5BC-460F-B0A4-64A2A76064CC@cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4194;7:pjfpcQbq9UVPTp9Qf9vn3s90p7rFGL8fdEulIyVBrYMyWG7O/Gkt3x1YgXFFvoRbLtsz4/cjvqar8b3WAGMCuW/id7vgAwqw1+gKq4J3QxhRxc5/FfZXpP9la3Ua+czJS1AGCG+zj93YITkvRx7TVo6jtQkk93ZV3+tjGjbz+/JghZGnvEz1yb+V7uJHtLbsNYN8BmKaKQz0znqETHVkQ+40sy1eeied2KQDszPSmPFDL91NdG1vrL02MQMkVwJG;20:JB5LpOq3PGlqdsxYzkrAAWizf7T1X25Y4tLzXSqjuMTfX4H4BjZNrNTZMgAcn1GeWZSx5hiz2p7D3ZZO6V9kwrd7SMr7LkHktN8Mfn7bRMB1ZKl7ycHItnvgEf1yiMj0oMLCsRtZHMXn7pyjdL4pM1H2JT6gM9VUSJCpV0QXLp8ACWLYPV/F+6tfu53S7GzpRnhiKFTVmR3TO5ThIrc2rKqOWTT8bhTvEQvlBfM0LcEH32X4HH+bZLOn5MaTA2oB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1865a772-069b-47ea-15d3-08d5e7eeb9ef
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4194;
x-ms-traffictypediagnostic: BN7PR07MB4194:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jank@cadence.com; 
x-microsoft-antispam-prvs: <BN7PR07MB419429D9095E1B88BADC9E8ED0590@BN7PR07MB4194.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4194;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4194;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(36092001)(4326008)(86362001)(486006)(83716003)(6512007)(68736007)(2900100001)(39060400002)(53936002)(476003)(2616005)(82746002)(6486002)(2501003)(5250100002)(105586002)(106356001)(14454004)(2201001)(97736004)(478600001)(36756003)(305945005)(8936002)(3846002)(6116002)(99286004)(33656002)(6436002)(54906003)(7736002)(186003)(26005)(316002)(6506007)(8676002)(81166006)(81156014)(2906002)(66066001)(25786009)(102836004)(110136005)(5660300001)(14444005)(256004)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4194;H:BN7PR07MB4676.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 63IN3MzTJ0hf5dLn+u7NuJvH4AEwue81CF4yqHOsfeLXM+S7iSUQH1DQDxpxNzgbDD6KQSaFFrcrADJaOjbHZYiel0GvAoUK2hQBjpLctZuYSS2OmuiunOteJw/XuZrXY5RXiriMI68rNWSGNurJQjMh1MBMov+9NCuDODlC7CY26/g2UKcrCNkrIlo+HRwtqAg9mYXL8DqaTn2DD+YKDcrFq5q99IfplQHpI/elJPXnP5Q9VpSNRf9vU+hrrRQrt8Mvle5FEQ5mTOL5evdY3A1tuTmHWEEj+V/vEAbvV4oLOkR1f9kyXUBmvo2lzKvyCGgp+zd1WnBtmOAjB1elgGrvy3XvjrP4Fdi04RSuq20=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BB539BA0F3B754E9C2006A6E5D380F1@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1865a772-069b-47ea-15d3-08d5e7eeb9ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 11:58:04.8604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device tree platform
driver description for Cadence UFS Controller.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 .../devicetree/bindings/ufs/cdns,ufshc.txt         | 31 ++++++++++++++++++=
++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt

diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt b/Documen=
tation/devicetree/bindings/ufs/cdns,ufshc.txt
new file mode 100644
index 0000000..cb6d62a
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
@@ -0,0 +1,31 @@
+* Cadence Universal Flash Storage (UFS) Controller
+
+UFS nodes are defined to describe on-chip UFS host controllers.
+Each UFS controller instance should have its own node.
+
+Required properties:
+- compatible	: compatible list, contains the following controller:
+			"cdns,ufshc"
+		  complemented with the JEDEC version:
+			"jedec,ufs-2.0"
+
+- reg		: address and length of the UFS register set
+- interrupts	: one interrupt mapping
+- clocks	: List of phandle and clock specifier pairs.
+- clock-names	: List of clock input name strings sorted in the same
+		  order as the clocks property. "core" is mandatory.
+- freq-table-hz	: Array of <min max> operating frequencies stored in the s=
ame
+		  order as the clocks property. If this property is not
+		  defined or a value in the array is "0" then it is assumed
+		  that the frequency is set by the parent clock or a
+		  fixed rate clock source.
+
+Example:
+	ufs@fd030000 {
+		compatible =3D "cdns,ufshc", "jedec,ufs-2.0";
+		reg =3D <0xfd030000 0x10000>;
+		interrupts =3D <0 1 IRQ_TYPE_LEVEL_HIGH>;
+		freq-table-hz =3D <0 0>, <0 0>;
+		clocks =3D <&ufs_core_clk>, <&ufs_phy_clk>;
+		clock-names =3D "core_clk", "phy_clk";
+	};
--=20
1.9.0

