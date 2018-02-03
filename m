Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517681997-2-9587863535084181618
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681997; b=GLKmnrlIpEvuoyXxrWuSpX+woc232RTVOIiHoXgBMdijpkD
    74S2Jxg8NUlmnKcfQ6KbWTgVWbaKhqfiIFOehH+XI4ILfpNz7c8VBl+6yhdTHi9/
    pp83JgXrwP52drgzKwJfbjjOza/W0Xr6w7xK97B0XO+QKdQ9Ni1KuIe2loUgulYt
    rEumD54bJ5VS429M7eD/ynUKGRBngmrRdDKF2S07/z/SDak5sczynB+I7xiu9OPx
    VOTjH6Jpq2Kww85//WSGNGf/+fNnhzOPB16hy1Fbnintxh09283313n7a3NvKRLs
    8jMaqqFYzhrfLBO005ov28HofIBl7Rj1mnJeoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681997; bh=mVZkT0
    tgPj998nCuuUIXESQSfNjhln1CG+gJzhNCwJA=; b=BvJFykZk1zlCs+bv4vQTjL
    iVSWG7OEPaH17wpWPEuOhvJ0grWjMxEfq2shZpG2hvn5ZHDKVL76ieIsnrzrRG4p
    m7Fpjm4pDHFczGS7qlGrSB1+IwtR4yEEnogkKxxI9g1sfSbKEmtbIrCPLaNccyH1
    gDm1mUnGI8gpXaXJKYusTolR+GL5ZL7dI7aRDMRVMRM/inge1oJpoeOcLZI8xn7o
    VTKZf1yYnj8xmSlXUYyeySo5b49VYIOtgHBguLoIyO0gw3aIXlAOOPVmdIfs6rF/
    //QK75wZM8NcQ0aYbfSK/kXu2bvUiEro8UedVDxA/zlhWXcCljQHInU9BLEe21hQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iSGIq+vG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iSGIq+vG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbeBCSTv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:19:51 -0500
Received: from mail-by2nam03on0108.outbound.protection.outlook.com ([104.47.42.108]:45412
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753488AbeBCSGs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:48 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 10/32] ARM: dts: ls1021a: fix incorrect clock
 references
Thread-Topic: [PATCH AUTOSEL for 4.4 10/32] ARM: dts: ls1021a: fix incorrect
 clock references
Thread-Index: AQHTnRlvJu3soyD0lUahu2YgCvaAMQ==
Date: Sat, 3 Feb 2018 18:04:29 +0000
Message-ID: <20180203180413.7438-10-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:8ebZXOeX81XKMv3f08VfYKv7pkPzNMBLS5es+pf2+Yj48jqHm+zgy6H1MYyQkHnFeSXKFp/5xOtpBrbbt2gt367PfHDSntLOtdvXRO+S/OnEuzF35zEFKLmUfo7jR4+7/36DsdmoKlNgTRPb7GeoPG7b1uSjD0eLe0eIGVNAy62/iGYxxu07S1edbsdjpzvPEh9YHlFVVL3XXehFP4gbxDC51L43Myc3J6KYKwJdPIiz297cPCjWlC+wrIhQH2lE
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa03d5bc-cfb8-4820-e75c-08d56b30b9a7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB1089BD6B2EB7180B00381A3AFBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: E8k1OD05nC0gWlC1vK70xTo6qkluJ0f7bzJKxVRjNinrqdVSd92pRRm2Pj+qZz79XaHCCsicX9G3XUFZz+JYhw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa03d5bc-cfb8-4820-e75c-08d56b30b9a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:29.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 506e8a912661c97b41adc8a286b875d01323ec45 ]

dtc warns about two 'clocks' properties that have an extraneous '1'
at the end:

arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): arch/arm/boot=
/dts/ls1021a-twr.dtb: Warning (clocks_property): Property 'clocks', cell 1 =
is not a phandle reference in /soc/i2c@2180000/mux@77/i2c@4/sgtl5000@2a
arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): Missing prope=
rty '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle=
 (referred from /soc/i2c@2180000/mux@77/i2c@4/sgtl5000@2a:clocks[1])
Property 'clocks', cell 1 is not a phandle reference in /soc/i2c@2190000/sg=
tl5000@a
arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Missing prope=
rty '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle=
 (referred from /soc/i2c@2190000/sgtl5000@a:clocks[1])

The clocks that get referenced here are fixed-rate, so they do not
take any argument, and dtc interprets the next cell as a phandle, which
is invalid.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 2 +-
 arch/arm/boot/dts/ls1021a-twr.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-=
qds.dts
index 0521e6864cb7..76fce89d4f69 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -215,7 +215,7 @@
 				reg =3D <0x2a>;
 				VDDA-supply =3D <&reg_3p3v>;
 				VDDIO-supply =3D <&reg_3p3v>;
-				clocks =3D <&sys_mclk 1>;
+				clocks =3D <&sys_mclk>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-=
twr.dts
index fbb89d13401e..674df87629bd 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -167,7 +167,7 @@
 		reg =3D <0x0a>;
 		VDDA-supply =3D <&reg_3p3v>;
 		VDDIO-supply =3D <&reg_3p3v>;
-		clocks =3D <&sys_mclk 1>;
+		clocks =3D <&sys_mclk>;
 	};
 };
=20
--=20
2.11.0
