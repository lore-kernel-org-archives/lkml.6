Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B299CECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5094621477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nxeOeGGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5094621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeIOHJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:09:35 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbeIOGqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+coewou0ynbq0N+SU8HMqbkUvJmwk49zLYpWuSOx6Y=;
 b=nxeOeGGDdBK8ZJCsE1o44mlYzojRpQuyJQOgUXSarip77AoUy7P0WdeQSQ6Mo/KQctH7Y1sAJC0bul66d0/7Bry+DzjQhN2Yemukw4WNs32amaJwD/MNzKT0VjohH1HPApPb+7f0n+IyeFgQvjVanz8vVw4t28tXPyEbJf3tv5Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 03/92] arm64: dts: uniphier: Add missing cooling
 device properties for CPUs
Thread-Topic: [PATCH AUTOSEL 4.18 03/92] arm64: dts: uniphier: Add missing
 cooling device properties for CPUs
Thread-Index: AQHUTJOYDww9DoLOdEa8jG7S/uZEnA==
Date:   Sat, 15 Sep 2018 01:29:50 +0000
Message-ID: <20180915012944.179481-3-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:v8AKFuHJkotndYc3pZQoNY9I2FHsTOEgQTp3BHS5BFyfcEYM/KOVIu2Yxfhpq0V3lnsdMsJtyuyyWwkRlMmUqdyg7mOd58VEAvpvPVJ9J94FXELJc18fSlqxKv8ngrBkmJS+mRsliFv1NbnA0D7+K5PZrU4CL9WEmFwooPjnM7Q2Qzi2c1dxVmAHf/EgvbYxQRKKj2XAyJiKbuGuCg0y6Io3EnomqnKTzuX2IekYrhxWUce8HTKfeTT9vNBaokQJHhnKRRuIC42qFCWMDNbOhvlBQDpX+c5u7pw5G/zj2bb6XS0M6Y3WW4h5IbdC/JYF5A2JpHPF+o1EHlKG7EhH9VXOFtglI1MAHUnGzt1G8y98JFI4TaPNEB+0517olXpCwAWdVoWLiDPDRPJktjPCHjWQFX/9NAL3rd430jIHBifF12na/jkQX0KCCWlpk1Itu7jLMSF9oZnbYkEUAZsuoA==;5:hHF22ymuM6CRsduZuT5TK9PP+XJxpVibPFlAoag4iOsk54bXesyvkkbX2rfCJS2IAhCH4fJsNN3UGQMKglDk5/M+JWOIbqDx7A2oZE+AloqHhhYqNM3aAugQ5puPJsbCQ0th3HKywI+nYCZd/ogHhtEgtLpkNODzFsBJBztj0og=;7:KGft6GazySF2tahO73xOUR9X1EbIvkESeEpgRB5n43GLt3MZyMDNCV4LDzaXW60dK0k6fsLhMWvEwNuDLuewfGOK3578jAVwCcFfS6FC80jqPMpJr2Qz5uDCdq6XrvBgsO8BCUaI49ZBFfdwjy0f+91OTehaOOBj7Yz0vH/MckC5mN7n/XdmrI9Xf1DBtZUGkCJEhFPgu7vGPmDu+OBo/FxmWwWMjQIrduXhQWFNbSRAHpM4QoMj3iBUvbTOdAUN
x-ms-office365-filtering-correlation-id: f6609983-3466-4ac9-c69f-08d61aaabaf0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840FD5AB430994056847811FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(575784001)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: efHN+zkKhWKvAkIUpp8BMHRpn0flnynEEjx/Nxfc9NZIfUcIU/hBinnS5XMaIS53G/gSttLn5jynbR03MtCG1wdXU/SrqUiUyOSdxqmuWtm4OnsKsREmtYEHJ0zSHmw6mt/y7yL1ek5cpnCHlE2gt1rJIeBvxQJzcsThrM2vvQaO/bS8rCIVdAQIo1/a7mobRO6pxbkpL4R2PRU4iDyTz97ZREGdSOPoLkGZZSP09PuRDmOD38DGm4nu1kR8vibypUAH3cal6VnQM7VklmOIJX0CRKwLP/Md4bLejvI5T4S7J94PAf0Y6FWksulOhNUgrq13lJv/S0WU2Ggm3ssUUZBXdRLbZt0q1LZyqS8zgpI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6609983-3466-4ac9-c69f-08d61aaabaf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:50.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit af0e09d0c6762e486b0eb5cc4737396964c34fad ]

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/=
boot/dts/socionext/uniphier-ld20.dtsi
index 0298bd0d0e1a..caf112629caa 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -58,6 +58,7 @@
 			clocks =3D <&sys_clk 32>;
 			enable-method =3D "psci";
 			operating-points-v2 =3D <&cluster0_opp>;
+			#cooling-cells =3D <2>;
 		};
=20
 		cpu2: cpu@100 {
@@ -77,6 +78,7 @@
 			clocks =3D <&sys_clk 33>;
 			enable-method =3D "psci";
 			operating-points-v2 =3D <&cluster1_opp>;
+			#cooling-cells =3D <2>;
 		};
 	};
=20
--=20
2.17.1
