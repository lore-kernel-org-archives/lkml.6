Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40577C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51CC21E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Le5c/Wb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51CC21E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbeHIPuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:50:12 -0400
Received: from mail-eopbgr730050.outbound.protection.outlook.com ([40.107.73.50]:37760
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730419AbeHIPuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM9GROXm6vMntCxSbIyseI4mo4RgvqhHJfIl+TGx1w8=;
 b=Le5c/Wb+gxtE8igc2gHOBEU460K4fi3jLA/xZBzx4L/R/TzDBob2Pvf6nwsZimo9n0R1OlSJxep95wXvBnjvlkVbrQCAFfdzqShs43aiAYVN9PvihEIv7bVKY3f30FJkvdMNtZBTtvuzilbAIyrZgYxfF0lmbfbRN0kCznivd70=
Received: from BN7PR07MB4676.namprd07.prod.outlook.com (52.135.249.153) by
 BN7PR07MB5121.namprd07.prod.outlook.com (20.176.27.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Thu, 9 Aug 2018 13:25:15 +0000
Received: from BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::e94b:eb6e:2766:3208]) by BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::e94b:eb6e:2766:3208%3]) with mapi id 15.20.1017.019; Thu, 9 Aug 2018
 13:25:15 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: ufs: Add bindings for Cadence UFS
Thread-Topic: [PATCH v3 1/2] dt-bindings: ufs: Add bindings for Cadence UFS
Thread-Index: AQHUL+RociwbGtZy+0eQ85QYMSvqhA==
Date:   Thu, 9 Aug 2018 13:25:15 +0000
Message-ID: <F39BF38C-FD85-4115-975C-8D923518A541@global.cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jank@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB5121;20:9D4DNKyTCGPYU0jPlze1aIGjC9le9IQe+dz4+5soNBdS4MHTtOQh0+MRdxjzuRGT9EBmJ9Qwcw+pS1i602F521UwTIJUSajBjL0CYyPLfrQ88Ifl+MDV7NXKfzBViPlb37ExXVqkBHeTP5LtCf0AkVZLGgixuZvUfY8s7wJCOdr/OX4Lx5yx4tuaetUTrha0nKKk/ttibAjha4P40Bcpjc0jHZbjTj9dvVoSX9pUiRRQg/+rCy5sP4/ESSyF1a9z
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6fade5d2-3291-4ae9-05da-08d5fdfb8b1a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB5121;
x-ms-traffictypediagnostic: BN7PR07MB5121:
x-microsoft-antispam-prvs: <BN7PR07MB5121B6068CBCE22B4A8E6828D0250@BN7PR07MB5121.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB5121;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB5121;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(376002)(136003)(36092001)(199004)(189003)(68736007)(97736004)(26005)(2201001)(83716003)(5660300001)(14454004)(33656002)(102836004)(99286004)(256004)(6506007)(66066001)(7736002)(81156014)(478600001)(81166006)(14444005)(305945005)(6512007)(6486002)(86362001)(8936002)(316002)(6436002)(186003)(39060400002)(53936002)(4326008)(486006)(8676002)(110136005)(54906003)(106356001)(2501003)(2906002)(25786009)(5250100002)(105586002)(2900100001)(476003)(3846002)(6116002)(82746002)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB5121;H:BN7PR07MB4676.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /R5XP5edHrbeBAdcu4JQKTpeGXYmwl1WV2pvbltUb0vcOC8Wkhg9IAtHcPi+aLRPP3ssP1ppduz240BFYfiwGOx1M82gUNXe1VU0CDCJkJSxsXg4na/Fx7ZRinodzZtZ5ycAjXnlt6xQvZK4VOkPTtzqY+l5BKn+N3wssPBnkT/d25LmF/D2KwB9IBtnSSgRUkuQA8r3364sBNPdao7YFvhl0gbjPyXHryXoIB3oANREBG+FbFI0byS0lsEsetO1s/8NDo32JxD4nJk8lc8o8L/F5w0i/t9wWeZLTloLRh/ZGMIdIkS2kuoEEylvWWpKK9KDFsd83C3yQ7xDFAC4Q9Z8pIw2iNL/X3+yRK7YtMg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FDA65D15228A2438FC47A36059969F2@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fade5d2-3291-4ae9-05da-08d5fdfb8b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2018 13:25:15.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for
Cadence UFS Host Controller.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 .../devicetree/bindings/ufs/cdns,ufshc.txt         | 31 ++++++++++++++++++=
++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt

diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt b/Documen=
tation/devicetree/bindings/ufs/cdns,ufshc.txt
new file mode 100644
index 00000000..a04a4989
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
@@ -0,0 +1,31 @@
+* Cadence Universal Flash Storage (UFS) Controller
+
+UFS nodes are defined to describe on-chip UFS host controllers.
+Each UFS controller instance should have its own node.
+Please see the ufshcd-pltfrm.txt for a list of all available properties.
+
+Required properties:
+- compatible	: Compatible list, contains the following controller:
+			"cdns,ufshc"
+		  complemented with the JEDEC version:
+			"jedec,ufs-2.0"
+
+- reg		: Address and length of the UFS register set.
+- interrupts	: One interrupt mapping.
+- freq-table-hz	: Clock frequency table.
+		  See the ufshcd-pltfrm.txt for details.
+- clocks	: List of phandle and clock specifier pairs.
+- clock-names	: List of clock input name strings sorted in the same
+		  order as the clocks property. "core_clk" is mandatory.
+		  Depending on a type of a PHY,
+		  the "phy_clk" clock can also be added, if needed.
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
2.15.0


