Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B936C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EFE21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ne7UzdSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EFE21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbeITIau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:50 -0400
Received: from mail-dm3nam03on0132.outbound.protection.outlook.com ([104.47.41.132]:11584
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732415AbeITIau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+mov5QcteXocqeBBvPRkegfg9f1xBXGdQHuqd1a5Sw=;
 b=Ne7UzdSrpCx1YmqNsEzDl1cJMF1n0G3XMW6qGY7J3+jHTZiNZRK+aUYG+n2Y4NoU+s/7zinfzaqS52zGtLDnvrvtxLjsrr15CtSvp/fbyykUyNtRu7SuKPZZd3l4vSUaH1K3n/6TvwqkORcqN67xbgrT1NcAkfZwGuwqpEl6h+o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 52/56] arm/arm64: smccc-1.1: Make return values
 unsigned long
Thread-Topic: [PATCH AUTOSEL 4.18 52/56] arm/arm64: smccc-1.1: Make return
 values unsigned long
Thread-Index: AQHUUIxabG9POztZFUOgOLHU0pBtfw==
Date:   Thu, 20 Sep 2018 02:48:04 +0000
Message-ID: <20180920024716.58490-52-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:ZV7Y2AAucKIOmVtu9ImRI+Lyq0hUzgbzicSthMF3owFdMTTd57bORGY+1QF2bR8W1rBWqa7hBH+VcuAjXvmx74W3KjjTMeMmhX3aQHnLnE96LdackG5hDYJ7WbQ+C7mBwvvTtNH+EMwNK0/1rH7TUFO7smoqHz133swL9YaQ2FRkuGcl3lh2e/e34HWqShW/dolBXWHy5575S6FiUePL0euUhRKMr9bbDjekGihL41+qTb/mTL1LvwsNY08GDJbq/i51dBX3W8ALzUyFi/Kl2tmGQ+4S8JWM0u6vfyo3HJsJ7WwxbMtdD07JXpNXB90NhC2oxYZ3mG14O5P0IUhUPsRVtKmIro4CO0L81Q9WqvPuAAVppHRqG6UfCniD4+gx2V7XCErrVdKdj5WIfs15IhEiq3sxGsia4EP9e3abh8RWM1BBBt+sE3TMwfgT6kptwLGqTB1JtvJbvD5DhY9RrQ==;5:q339+vKFXVL2EZxVwCzsUraDGVwL5CS/HYypxOUBeSJc+Q9nt6xoA7QpSrS32Wd4ZA8+PM/SGE16uPeZJuw0JtaH++3Sv/MafGhbBMZR443L81/jGHFUnPG51Bhgm0XhUWxKVHMGA6dqhNjEDumT9MCpdzwma0GIBQcj5y0d758=;7:Xz3O7PKiz6o0aujO/yrmyn7XGYxUpYNOFVjPEJAdEBqsvHaKFoRxbQ/tDYq42EP9bmCOmG1HScKirKSp6lk4g9z8AeLqHFEbvv8Ryd3o5SXcgxYFEQaF8A8DiR2/xLaY6guDN6iYtEMaCuZYY1TnpfTG37uLGozjjyWIOqJSkFZEBApY/EIjNPf9n8gzcSWyvfhXj80JkG8O78hahAEM1W++ISMsWDIrRFmchJmh6vfbskP5RY6N5CMiYEW5gX5/
x-ms-office365-filtering-correlation-id: 5dc8077e-b22b-4e8e-eb9b-08d61ea38e80
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01191DA6D6A70EF229885EDFFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(575784001)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LKeeNEaVud/XJXTjpkl9aOeszgx+FBw0ji4LX6LL7nN4PN7epJXmkzLMDkwx+BlNHwGcLdZE8p8Vw9VB2tXpC8UdyZK8Sgp9wENviXkv2EG006FaZXEg05tlGq3QEPMcGIxyDzc8qvZ4NegG0YpHvSVTv4JdNiJvXM4oNGIHGBoHBxdEI74yBiSt9AeFaYx+PmNrf3tLEvRkYdMRgf5gREnUy3Na3SvY49hh9s3bn5tvNSl19NF5+UOjh3Qt6CcMgbt+Wb2y5RX3+Fi7tGiY2eEp18Jcm5dQto+38pibg0jgFVYQsJRRkA2FYh60K4buh9QgrRt4x/Khl1bt/H05D7iPt2Vf9AEyyedLPsFnkG8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc8077e-b22b-4e8e-eb9b-08d61ea38e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:04.3511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
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
