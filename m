Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F7AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27ABB208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F6iALp4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27ABB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeIQI1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:17 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:6704
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbeIQI1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQvDHqFLWLiwUCcw+D4Ys0YdE7mZA9nsZBtsH/OpWIc=;
 b=F6iALp4oB76oCAdNgpc7gp/qblqsUgUUBI7RH+yH5klVqMBgNGCLSVWAwGe5K0dUEafmcjGXg8mdrVDW2ZrSVzVwkeyWFcGMzaykoHosyjnUA1P8uqnxW4DWgIlWMoNM09pNGRqQ1ZS2YKdmFIBHm0189hrFgCPILj2SbvcmHZk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rosen Penev <rosenp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 081/136] staging: mt7621-dts: Fix remaining pcie
 warnings
Thread-Topic: [PATCH AUTOSEL 4.18 081/136] staging: mt7621-dts: Fix remaining
 pcie warnings
Thread-Index: AQHUTjKrhPY/medtQUSMn6uekuPJOg==
Date:   Mon, 17 Sep 2018 03:01:02 +0000
Message-ID: <20180917030006.245495-81-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:JbZvh2V1lwnRfNg/ywvbpnBAOGpC8skXBD69+DbKiTIP99KRMn0D5uZPwgkRTCqpYwFJSXLySu0i9qn6vE9rNVkPQ8ZaL7Vlg1kIHw1dgws19UCtnke52oG92kuONQLpvqHlB5aLhtJP7PcXJHqblt7wQS7opogeRUdurpdg9lZL5ep96234jYEa75V85Z/mqcWwdojwh00p6dZm+f1yg83IQfyTatu/zy52NwmaNgmM5I1e7qvjtA8sblga4e652V5V81dXqs8up+lzzTEufwX/Mnt8vUuDF4MWNKtTyNxuhcBbdqMk+Oour77uJUnKYZUfxPszklI0lovgijRcwCSDX8Zfh/TW/Ksj2hh/u117w7I35j26JtkBieu9spjdc6eOOmQs9ow4+n92IuN+zwdDaUYzoNqkdO28lvmujjtJkmyxPWqFb5wnhGaG4VFL3vLm7bov2TP172m/x0S5Ew==;5:4DAJ1hPYAc7kNCLtyCOmJ6ojjCj3dSC5QSRI7h6yTw6TRLi64rjNewa8EHLfQBM1435GL87ewBTQCnuDcA1HrhRT4bvqzt9nfgyoB81ZIKyK5nh4N3eD49hc/PTUDe9j6za+voUFV7Ch3pXMZJvg5Va/r59nTPQYuhkHB1Azxsw=;7:ob28i3IWkAecioblS5yPqebB4hJ2ubQFrWtVY1latmku4xAzcAUoygQbi1P7L+Zz7FpQV2UC7t4UwJjWJ4z/5bws7ofeVFyZaMYaC0g6a8H01aV9FtAO+ASG/PVkqdXpTkED2znNLC3zszejKJ7CK+eSh0T+WpgUsHb0hJGtO0SPANmydz4eMJiaVTW1s+PouPBokC3w3K8ZA+sB+K0kd+moauzP/gUnAofPlFC2bCvgEA65jxHX/YXCUHlkYCw4
x-ms-office365-filtering-correlation-id: a5829200-6633-4e0b-15aa-08d61c49f031
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB079083EB795D52BEC91671BEFB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(97736004)(86362001)(66066001)(305945005)(486006)(39060400002)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ady46gPA3Z0Q+Fj+MOSWJEefP9EkXqUFVYg3q58RDe/YtGgLMxxb1BysNOZaaJRJ6unKwhHHz6qw25YRWzez8qXbxBhdVdUJ0hFr8NbxmFYn5d1rFpvvBusFPvrbX2SQDeV6q3StvIhLGRUoL7+7Qz9fQ6BpodWhmB7BKdAwNyMBPpYZo/gbQ0ooZfjek7Eg+18hokgpvuMDNJSZF2NjHHPP371o3ttw7dPWSnDL0piByH9U8roNZ870w+GQemWFH4CFA5LF/FAe3PAVT35ZaCvBMIlbVNI9IVcaDBAodGyT091rJ6jvjhsCWA5Bg29zr++fUzguSy/KEiqrvVoH83g/C1VohwvCwL6vNK/yvDU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5829200-6633-4e0b-15aa-08d61c49f031
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:02.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit d0233204fbc10f003d1ef077f57341c2feca4002 ]

This currently fixes the remaining dtb warnings:

Node /pcie@1e140000/pcie0 has a reg or ranges property, but no unit name
Node /pcie@1e140000/pcie1 has a reg or ranges property, but no unit name
Node /pcie@1e140000/pcie2 has a reg or ranges property, but no unit name
Node /pcie@1e140000/pcie0 node name is not "pci" or "pcie"
Node /pcie@1e140000/pcie0 missing ranges for PCI bridge (or not a bridge)
Node /pcie@1e140000/pcie0 missing bus-range for PCI bridge
Node /pcie@1e140000/pcie1 node name is not "pci" or "pcie"
Node /pcie@1e140000/pcie1 missing ranges for PCI bridge (or not a bridge)
Node /pcie@1e140000/pcie1 missing bus-range for PCI bridge
Node /pcie@1e140000/pcie2 node name is not "pci" or "pcie"
Node /pcie@1e140000/pcie2 missing ranges for PCI bridge (or not a bridge)
Node /pcie@1e140000/pcie2 missing bus-range for PCI bridge
Warning (unit_address_format): Failed prerequisite 'pci_bridge'
Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'

device_type was removed since according to documentation, it's deprecated
for pci(e) devices.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/mt7621-dts/gbpc1.dts   |  2 ++
 drivers/staging/mt7621-dts/mt7621.dtsi | 21 +++++++++------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/mt7621-dts/gbpc1.dts b/drivers/staging/mt7621-=
dts/gbpc1.dts
index 6b13d85d9d34..87555600195f 100644
--- a/drivers/staging/mt7621-dts/gbpc1.dts
+++ b/drivers/staging/mt7621-dts/gbpc1.dts
@@ -113,6 +113,8 @@
 };
=20
 &pcie {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pcie_pins>;
 	status =3D "okay";
 };
=20
diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt762=
1-dts/mt7621.dtsi
index eb3966b7f033..ce6b43639079 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -447,31 +447,28 @@
 		clocks =3D <&clkctrl 24 &clkctrl 25 &clkctrl 26>;
 		clock-names =3D "pcie0", "pcie1", "pcie2";
=20
-		pcie0 {
+		pcie@0,0 {
 			reg =3D <0x0000 0 0 0 0>;
-
 			#address-cells =3D <3>;
 			#size-cells =3D <2>;
-
-			device_type =3D "pci";
+			ranges;
+			bus-range =3D <0x00 0xff>;
 		};
=20
-		pcie1 {
+		pcie@1,0 {
 			reg =3D <0x0800 0 0 0 0>;
-
 			#address-cells =3D <3>;
 			#size-cells =3D <2>;
-
-			device_type =3D "pci";
+			ranges;
+			bus-range =3D <0x00 0xff>;
 		};
=20
-		pcie2 {
+		pcie@2,0 {
 			reg =3D <0x1000 0 0 0 0>;
-
 			#address-cells =3D <3>;
 			#size-cells =3D <2>;
-
-			device_type =3D "pci";
+			ranges;
+			bus-range =3D <0x00 0xff>;
 		};
 	};
 };
--=20
2.17.1
