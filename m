Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795082147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F3Uby4kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795082147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbeIQIaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:17 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729508AbeIQIaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2TwQsNOQSN+B0042PY3lDADrP4y6S0zkeN7XK2B+KY=;
 b=F3Uby4kBHU+Y4BsMY1KQJ3Pp55cvH8vavOYbuMB5+fV/QsB4wtvGt1XyVjoLOp1xlYyVt9bqARermItW+kTZxM9z4Cz8LAWUGpZLEFDWfutrCYA1pe4QVoIKLpo4Kc/eft6Y9GAZvVRCiRMHxvEswQEcwyIwbQqMFpTm0XGxm+Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:04:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 69/87] arm: dts: mediatek: Add missing cooling
 device properties for CPUs
Thread-Topic: [PATCH AUTOSEL 4.14 69/87] arm: dts: mediatek: Add missing
 cooling device properties for CPUs
Thread-Index: AQHUTjL2zJXXVqC/PUSG5VPk/IY5MA==
Date:   Mon, 17 Sep 2018 03:03:08 +0000
Message-ID: <20180917030220.245686-69-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:HY4hSrebNwQRgtP89NPO9ChldWz6zFykk1U16Ou1AINioQwh/eIu7f1PrQrQvMju6unB0J5m1T56LptOS/8VW1LvKHhz0uzVWHJDSaw8Vl+lfZ1thDQya8Y/o5qtrIgeyNU+4MXHFhuc5sHKJ0C/eL/hOFE6RR8Ej8ZPS7Zo/Ug1fL4aIVhMSRP8+wnvJUPX5ttWzPnNsokui7cCNSArqcooX3p8OOiIsNjCHeVASWnb20VW0fRk6dVTcQqAAaOPoR1nCDJcSuN/67e57Z0poYlGcPLZ/ZEBQDp+8RCXxT0ExEwEKhHhexsTA9UVYqPB5qL0OLRjZmhWBNUYqdled4Zt3+yWeFUw1vrmNSzJc/8DKF0YK6sR4OkeFq98ToOemVjzGjoKIiujFffTAsbx3B3GCQ/Y3p+dksp3zp+7Xo98c5ycroydS5jmk9At8rCE077hqW31uLDrXqgJSijxcg==;5:xhF8kJ41Pe2BfMScyJhF+Qq7HkQdQLMxd9n+6XZWildOMUlSeas28Bhjf0UK5H42XFYITbfU1WMKj5CPzJVGM6Q3VifgE9exPeM8wSdVAU5hQAxBESzPeEFdliF56SrXL6U37o15SC2y8BnSnpi7nY0stuWdp9t8bJ2VP436U3o=;7:QGhB+BSAkrMXlQfkGJWcsE4MRa3CdkiAgmDW8MUDyoUrsNOTCh3vz+27VxvaNuQ2Uz9IU/bOkNwBsf5o2WPrJT+8YPON67Vya3RSnKD62ukEnsfU2wJsEKrIK5FGkM4GRKOAiTnAS4gNtYbo/yID5r+1xJIek2TbZsA+OqSrB6lSDmjkxeNMMVZjkFSXVHGfkPvCqY8uwlT2DxoqOJKuXJsqgD3rIqjk+lWf5VkAimh/kCQI45GMw2vFee7tCWV2
x-ms-office365-filtering-correlation-id: e8274b86-ff17-4f55-66db-08d61c4a597c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0133601156D0BAF98B09C337FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(39060400002)(110136005)(2501003)(10090500001)(14444005)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M9B3GE2RinAn75tMpc4sAwleLqor3i6ZngU4RW2Ok+nmK42qUrHWQlyN8npg6mFKR8EvfnYeDgbRmLDlDv2O5TQzwB9xMN1FpW6ZrDxH1EwnvnCDbEtFIBrv9pWRVUvKmbWu8UE+unUvWaxi/OUYUa7ZATcrI9AkitS9+DIi8PDRZFoISjkQMfNsh4FUHrXojhtehzO8fDuT8T0K00cfYF5wRv4DfqbOK9QlK+z+cvWAbDZBjKWtMiG+7Dgh24FTwE47zRyWgnnEIRko+z0j/jf/glt5XGk8WGm8gJD8EQnwxQM1X0vcmYZQR0rLn6HFBFAqev7JAvLso8yGhIhSE9ismHZ/gkxm8ZV6GCoryVw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8274b86-ff17-4f55-66db-08d61c4a597c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:08.7903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
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
index 185357323572..028cf4a5887f 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -98,6 +98,7 @@
 			compatible =3D "arm,cortex-a7";
 			reg =3D <0x1>;
 			operating-points-v2 =3D <&cpu_opp_table>;
+			#cooling-cells =3D <2>;
 			clock-frequency =3D <1300000000>;
 		};
=20
@@ -106,6 +107,7 @@
 			compatible =3D "arm,cortex-a7";
 			reg =3D <0x2>;
 			operating-points-v2 =3D <&cpu_opp_table>;
+			#cooling-cells =3D <2>;
 			clock-frequency =3D <1300000000>;
 		};
=20
@@ -114,6 +116,7 @@
 			compatible =3D "arm,cortex-a7";
 			reg =3D <0x3>;
 			operating-points-v2 =3D <&cpu_opp_table>;
+			#cooling-cells =3D <2>;
 			clock-frequency =3D <1300000000>;
 		};
 	};
--=20
2.17.1
