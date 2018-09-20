Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10304C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFAC21524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a66DBn8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFAC21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbeITIbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:04 -0400
Received: from mail-bl2nam02on0120.outbound.protection.outlook.com ([104.47.38.120]:37182
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387736AbeITIbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+mov5QcteXocqeBBvPRkegfg9f1xBXGdQHuqd1a5Sw=;
 b=a66DBn8ovO92ZVQYv4aPFMkuoPDChSCjIHAiBBpsMEZKxv3UqgTOBe7ZwPK49r/1iuuHLMhL3PTeDux3fq+FBxCV0iQXy7+Jf8b2sIHvT6Sl7eh75Opp4iZLupslt1peGbALvqgoqE50IjRgDfDtfm/c/U2FBnwXmTkbh5w2JIg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Thu, 20 Sep 2018 02:49:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 12/14] arm/arm64: smccc-1.1: Make return values
 unsigned long
Thread-Topic: [PATCH AUTOSEL 4.9 12/14] arm/arm64: smccc-1.1: Make return
 values unsigned long
Thread-Index: AQHUUIx1EHZ+ZzdA00i9dbC43x9gzw==
Date:   Thu, 20 Sep 2018 02:48:49 +0000
Message-ID: <20180920024838.58666-12-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:fdT5QKOjptJ6kIT1Md9YYMAmY2oFDr2HsrJ+6P0CeZ+qHLw3EcNtNrv76TC8RNUbD9lSg+AU3aZ07+c3MKsR7DB4k5/5+yMJU9W3BSdaVwntZxEvWEa8Kw/X2rb6NneehUEnqPZmVoPoIt1QjIUjZ4CeSAJrE925GQ12sHaZuEOUNj+WP4Ik6jglpSyBa01Q5Lh9OFRPc9GCpprzv2CLE7ZZFZcsoSzhkv7V/krKUGFAsNICSiTAjKE1gJqfTf884NqBdTSbefoDb5Iy6n2o+hF99SKGi1gpj0jTCCZrhrsKaY/Cusl051V32gI3fxmvbJwdjvEqGotZQCB6/C9lTNXo4hcIYa8lYXFPslSCem5IT5V/sJ860Nb2HrJkrbXVahB8sctYO7A0wNl0BI2Z9vkAZ5wopDXm/ZQsdKJKofi+9jWKEHah9UKFTvd3mzlT036h0rcvPPnNEKekYfHUbw==;5:5jedA+67+6gQsuHVMdsojBJ3O0YMnp/b+OZ/D8WjDK/m0Vl7kc1hL+W0/+Xtf1BQRFcwwp2TedGmBrX9a4t9/UX0YkpFILTCutP5ZyaCeNgig6IfEyHjPZr2ObaFKYVJol9M38fsxKx2sbGZ8uW1uMrHh9l9BVP+X/0sBy+du0U=;7:7rEa64kre0yzqKWK+LHLAaNE7cKBsGTdycbGLWp4hHs0pBuzkSZ89LR3GmRX1svXR55IOjUl/HOS8sBfYq/zdQMUAwaNBquK55icJVneVDbSo0ROWmIVIaMjOJPO8EE/DwJ2sDb3mU0eMtsJ7tOcmZKIWn6S2+B3rSurufTIKKbk1Y7PFAgIK0yNpfjpBVfJIkx5iY8R4VrReZP7Qp1QX1Dw3sAgVWez7msU2RIacPmL5jFuBubC5ZgNTiQeq8Go
x-ms-office365-filtering-correlation-id: 5d6ed6b2-c737-4886-fa4b-08d61ea3bf60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB0469A613DED01CEE21B5AF4DFB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(76176011)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(11346002)(6486002)(6436002)(446003)(6346003)(81156014)(26005)(102836004)(86362001)(54906003)(575784001)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(316002)(10090500001)(107886003)(1076002)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ghO2rgutUx/nJBsCO7ObVMxVm+8kLwWbXV8iMAvihVQC0HMtCZ7IABvbJ3UmAGIP2UbIRKW8vGpvN8jrhL/gNxSuaa16FgbVPOfq2pF7JhzpQeSRqzF8uF86Y+rzuj45RvaROWCr33dlBzLmIgMYFZnACXhDE0OECBMWKs7ijo09lZqiYdXph2c5YD9qOvqiWyC5ny5Cb0Tg5tVkeHTl0ac4nSuuoGXHTPDNLjfnev4lekDA7HKq/rEsyLevcD+uGMV22CTP8L9PLe9o8fMNi4FA+/U8SV/COJ39X3SaEW2MMK5Q++JwCGzA5EVUiFMdTd4kbR7UKgWBQmYymLbU03Ot9mFrwhG64VlpNIeGHcU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6ed6b2-c737-4886-fa4b-08d61ea3bf60
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:49.8349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 1d8f574708a3fb6f18c85486d0c5217df893c0cf ]

An unfortunate consequence of having a strong typing for the input
values to the SMC call is that it also affects the type of the
return values, limiting r0 to 32 bits and r{1,2,3} to whatever
was passed as an input.

Let's turn everything into "unsigned long", which satisfies the
requirements of both architectures, and allows for the full
range of return values.

Reported-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/arm-smccc.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index ca1d2cc2cdfa..5a91ff33720b 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -199,31 +199,31 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, uns=
igned long a1,
=20
 #define __declare_arg_0(a0, res)					\
 	struct arm_smccc_res   *___res =3D res;				\
-	register u32           r0 asm("r0") =3D a0;			\
+	register unsigned long r0 asm("r0") =3D (u32)a0;			\
 	register unsigned long r1 asm("r1");				\
 	register unsigned long r2 asm("r2");				\
 	register unsigned long r3 asm("r3")
=20
 #define __declare_arg_1(a0, a1, res)					\
 	struct arm_smccc_res   *___res =3D res;				\
-	register u32           r0 asm("r0") =3D a0;			\
-	register typeof(a1)    r1 asm("r1") =3D a1;			\
+	register unsigned long r0 asm("r0") =3D (u32)a0;			\
+	register unsigned long r1 asm("r1") =3D a1;			\
 	register unsigned long r2 asm("r2");				\
 	register unsigned long r3 asm("r3")
=20
 #define __declare_arg_2(a0, a1, a2, res)				\
 	struct arm_smccc_res   *___res =3D res;				\
-	register u32           r0 asm("r0") =3D a0;			\
-	register typeof(a1)    r1 asm("r1") =3D a1;			\
-	register typeof(a2)    r2 asm("r2") =3D a2;			\
+	register unsigned long r0 asm("r0") =3D (u32)a0;			\
+	register unsigned long r1 asm("r1") =3D a1;			\
+	register unsigned long r2 asm("r2") =3D a2;			\
 	register unsigned long r3 asm("r3")
=20
 #define __declare_arg_3(a0, a1, a2, a3, res)				\
 	struct arm_smccc_res   *___res =3D res;				\
-	register u32           r0 asm("r0") =3D a0;			\
-	register typeof(a1)    r1 asm("r1") =3D a1;			\
-	register typeof(a2)    r2 asm("r2") =3D a2;			\
-	register typeof(a3)    r3 asm("r3") =3D a3
+	register unsigned long r0 asm("r0") =3D (u32)a0;			\
+	register unsigned long r1 asm("r1") =3D a1;			\
+	register unsigned long r2 asm("r2") =3D a2;			\
+	register unsigned long r3 asm("r3") =3D a3
=20
 #define __declare_arg_4(a0, a1, a2, a3, a4, res)			\
 	__declare_arg_3(a0, a1, a2, a3, res);				\
--=20
2.17.1
