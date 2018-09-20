Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135FFECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14AF21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eYnVsCQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14AF21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbeITIaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:25 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:36192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388232AbeITIaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K2ogBWjQFlrYmCUX8e00jAzTysnOWvCFGzsOrCi7OE=;
 b=eYnVsCQnxqXbFA7x5VSQ8rQHVj9dKkCBSwEA+LoRVbm9RoWsTtXvuSuIRBpnrVJRdYvWCCa9bMr/aiGxG1608flslUTzL9pIxvR7MEcm0LDPEAsEpLjgYIFYMZT+4FiIX/bqDOsmPAEPQ7zTFUHEKi0MsbzDNzvLuOYjTB3Ou1k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 16/25] Revert "ARM: dts: imx7d: Invert legacy PCI
 irq mapping"
Thread-Topic: [PATCH AUTOSEL 4.14 16/25] Revert "ARM: dts: imx7d: Invert
 legacy PCI irq mapping"
Thread-Index: AQHUUIxn4VpdRGgANUCk/hxRG8NA8A==
Date:   Thu, 20 Sep 2018 02:48:26 +0000
Message-ID: <20180920024810.58594-16-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:whZPCjRcFw8DLv24gggY3mEwTki2w3MJgOMFbGVDHeAJT5oyRTnN6KYdM4kUSMSbQ5e2LfOAIiLe9QKNqLCKiQwG4GwtVdhZPxQplxEpwNyCPdYtHz4j2n25NzWWfNStlEE4dRP/odXOpJ7THJISe+NaW4MUnWq4tf6uJjfq1sb80lIiOIqmjzs6tmUG1k34PEuA87L8pxGUZ5HtsadEI9i5MgAWe/xkOxpRZrVoonEsTxdfLs3/CB6YJwytHteEWL7guC601VoUGLv7gVDoL0VYEnK1Yvz8Zelwhynu5eHXjMSYqcbHcNYd1BLcxEw91nfRvtIy8G3HAubqLbYsJ/0eOWyiPlqxkC6PC+vuqTjiLdwM5uOiH2f3RAoQBU9xgh1ACKr+68o3bMCTMKVOlf01zwXA1tzke2m/NHRnKTLNIndnusG2TqOF8pRpNbBViM7W7XygLv2uZXD1aTgGyA==;5:6q3ZFo7UiKMzCwlA6iOtp/eisOSP//R2GQ93/ubT898gbYBUkw0BF3YTSrkFFukdRkt3/lp9zSfy1YfCjb7hRuf2Z3tIlz6jsRm6VTX++dIvJl1MBQckDXBDnvT4GX9Jsu4RQOZGBLInORkzEmlDrPrwUbK2esCLKL2a+arzU7M=;7:QGlHvL/EfHVG59+VL/BtVAtavvqGLHRWXpjPhGRDv6jCMh1gQzf9q91eNQIgv65UJ3y3rgnRUS/Lyodkd3+NkjjYnwtFPNV1GSQdcoR/fIKmRK8PeZaegAin8fw6cZSXuI+tQ4I2UCMx8ytxmfXnEpOg7eD4Z8Xe8kjLvVw+4OWRytVr+d4Frh0KOdM2Utymo+zq9uGBdmiluqUaBIil7mW2lxFQJ0FJDdsa2Xrf8d08/Q3ocxzNS7kFicCh4PF3
x-ms-office365-filtering-correlation-id: 8317bf8c-506d-49f6-4db8-08d61ea3a78e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07443D9472F26DA44F99231AFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(575784001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KkwUzEeu4t0hEtHbOVX0gL5GcYjmTcHePN6PqxAliSkdkOsBuLWeFPAUxBXaMxRO+NOBrsya+8BmAg52Mq0SkQ6lDNI1CbnA4Nbbsb6RiJQA4aTrFHffIWpoSJLqqPsiPyZU24ENan7h7PVjP1vqwa2I39AzPt/2/77OLvYTCu0Z3h0nSKDvx/rfn5GM2kVwL9lruNYmEYGnELEK4iwHg/60Ym81a2giE5Um1dSRZKlpJ0usMhbKmJgDa/+IBEHMFXj/UnSSrgl0xxngY+wkekCbpBNqw/XyXjnlqvfhfxRuvphm5i8gVAXAu50Pa7t0//cNiAjwNjjbsxN5bv+Lw4XuxjQ0JfnjBh6iUrvSZb4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8317bf8c-506d-49f6-4db8-08d61ea3a78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:26.4914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit 538d6e9d597584e80514698e24321645debde78f ]

This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.

That commit followed the reference manual but unfortunately the imx7d
manual is incorrect.

Tested with ath9k pcie card and confirmed internally.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
Fixes: 1c86c9dd82f8 ("ARM: dts: imx7d: Invert legacy PCI irq mapping")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 4d308d17f040..119b63ffb0fe 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -144,10 +144,14 @@
 		interrupt-names =3D "msi";
 		#interrupt-cells =3D <1>;
 		interrupt-map-mask =3D <0 0 0 0x7>;
-		interrupt-map =3D <0 0 0 1 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 2 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 3 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 0 4 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		/*
+		 * Reference manual lists pci irqs incorrectly
+		 * Real hardware ordering is same as imx6: D+MSI, C, B, A
+		 */
+		interrupt-map =3D <0 0 0 1 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 2 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 3 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 0 4 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 		clocks =3D <&clks IMX7D_PCIE_CTRL_ROOT_CLK>,
 			 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>,
 			 <&clks IMX7D_PCIE_PHY_ROOT_CLK>;
--=20
2.17.1
