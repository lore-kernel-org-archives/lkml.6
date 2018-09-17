Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E8DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839FE208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QnC68U4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839FE208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbeIQIzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:55:51 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:47904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729459AbeIQI1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxVIYrQzmeuxbRdJqexAkcNNJNOyeSDB3AyEVK0Xg1k=;
 b=QnC68U4sZoGomTqY0r+kxxCOAhOP2Va07dAMZwA3an9/UfXCxhRL/S0i8tEo1hoC4jw+FDwjqi0CSPBFCHSz02+eC9F43OddvnrRw+pu3dRrLxdTAIS6fO+r0h5eN+HuIPBnrLNd9bFXIaSBaSARPPx+Xez4CKBOsvOLcU0HiFM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 101/136] arm: dts: mediatek: Add missing cooling
 device properties for CPUs
Thread-Topic: [PATCH AUTOSEL 4.18 101/136] arm: dts: mediatek: Add missing
 cooling device properties for CPUs
Thread-Index: AQHUTjKz5AeCIkCNVUiXWW9FPWUq1Q==
Date:   Mon, 17 Sep 2018 03:01:16 +0000
Message-ID: <20180917030006.245495-101-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:QKulYuiij2MAWDYktvHmzJB1G047Uiiti1hKAwiLBo/Tm9W48KcQlbvyBovwCifkh33sTgA8/qjDYJmkUNGW6lkxZpJCbVhUYv5z6YSZ+gLs9Bv5iKMFUR8riPimaaaiGNTyc7dvHQw1xfYzdqrDh6byxa8hgOlTPi8Z3bi+s5ZxmBxOSekuQjCR92MtL+26rSIxoY6pgU0AIe7kgfpuGmXed8QFEEUT+HS5k8+jQhj8wx3l9/M0seAvFrZhXlcKX69DJtIoknxV9i1nL0PdJVuckJqtGO7ih94KutBjZ+Fy0df21QAUMK+trWjPVaxvTOFFKhUYe3/7lYwvJAHyr4fjo05okSDw3n6DGYDRCSEQU2Dalu9URbBYoJl3U2f+IsDgCLJZ9R8/yDLPwmyUTQc1xRhJ3WmNwLWTvu51/IJcolquAzhdcvLQ7L+5ioh8qy5iRLT+pVaLFx1NENEG9Q==;5:x+vo7Rge8XaoDAEvPtZa/OFR21f7Qoy9iZKcpJyephMJRYiDeeAjCAOZiroZLZQkvnGOuJ9y10IQlo4G9eByNHsvwsVzong62RVOspVigIAF4JViSuttEolegzMBewVpNI6GDBB27TsWh+q3hbapiZ32RoGwwecNrBt5JKtf3xQ=;7:GhGNEPJGcjn+OQAkTJTVlnWtyBATwrkZVcNh6EJpCwDxrzUQipon5ALSbEfzMkS4fMqh6B5yNzuxNsFGBRy5PB0GI8jwDwskS5krds1lWuYxNzRjYUeYlrU8C4B/ETN14HXoUidGN6d4z3ZG2GLIKP03OLGw9c9KqF3REEpB1zXkaFGyUryvzNTdVQrnAzMFUFuiKYUJhjmK2Sx57XD+3fjM5XI73iWgbFtCrYrKJuTzjbHJXxfRv6r3feBT65mn
x-ms-office365-filtering-correlation-id: 032ec712-468e-4a05-fd20-08d61c4a0677
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB01681FA8A353C090B9F52F14FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(39060400002)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(575784001)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(14444005)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7LRNU6ALZmTvOXL2j5SwrcPxY4RxMneHaF8NH0SF4zA68h4IDhL+avm50/bDORO2yVo6KQrnyP8QUzEnfidhqAexaAVrMARWdE5niKQy8U87qzGhHBIKwe7B1cQR1SkoKP5L1Zssn2Cm0NN2jguzTQLW4IUf8loVtDVdhHrCEGmI0qGbXD8Dh2mDq+hxvFxvxtb2sHDH/n4b2tiapPdVyNkVrVHKalZqwhopIgDoV2dLbRUTPF5nCSRfUjOvnooGV1iUiieKNPgvCSFJPfHG2XruFIedDgTtx4E11xOTg3KAkwkism3U+eU1T3AfVqXopIV8YDK9P5aHUAfcw7hhYlt1mBNwrHHbBSDl5+NK+Nc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032ec712-468e-4a05-fd20-08d61c4a0677
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:16.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 0c7f7a5150023f3c6f0b27c4d4940ce3dfaf62cc ]

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index d1eb123bc73b..1cdc346a05e8 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -92,6 +92,7 @@
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names =3D "cpu", "intermediate";
 			operating-points-v2 =3D <&cpu_opp_table>;
+			#cooling-cells =3D <2>;
 			clock-frequency =3D <1300000000>;
 		};
=20
@@ -103,6 +104,7 @@
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names =3D "cpu", "intermediate";
 			operating-points-v2 =3D <&cpu_opp_table>;
+			#cooling-cells =3D <2>;
 			clock-frequency =3D <1300000000>;
 		};
=20
@@ -114,6 +116,7 @@
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names =3D "cpu", "intermediate";
 			operating-points-v2 =3D <&cpu_opp_table>;
+			#cooling-cells =3D <2>;
 			clock-frequency =3D <1300000000>;
 		};
 	};
--=20
2.17.1
