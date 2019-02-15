Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD951C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834B3222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="WRcajbpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390991AbfBOUOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:14:24 -0500
Received: from mail-eopbgr700091.outbound.protection.outlook.com ([40.107.70.91]:40096
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390667AbfBOUOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAYJvweJO52SnUzzJwO3VW/UkhT/zhfX0oytuWwkhAM=;
 b=WRcajbpmJQ8Dn34tpWhvxjSbvbOR4BW493O/wxGdHx882uTw8pq/PCwLE+iZRluJfb6kFICz2nejN99TY+yt5JFa9S9y+QQW6EzTs2jkx6r9xfxtL4GIHsa3XdL1WEVFoo8KuZlLtmIttqM4ZJ0cGv8ufKE9zkFMTMPwcGEZEwM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1582.namprd22.prod.outlook.com (10.174.167.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 20:14:16 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 20:14:16 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiong Wang <jiong.wang@netronome.com>,
        Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 2/2] MIPS: eBPF: Remove REG_32BIT_ZERO_EX
Thread-Topic: [PATCH 2/2] MIPS: eBPF: Remove REG_32BIT_ZERO_EX
Thread-Index: AQHUxWsGSv3U5Mub50SxgUEaRy+wZQ==
Date:   Fri, 15 Feb 2019 20:14:16 +0000
Message-ID: <20190215201321.15725-2-paul.burton@mips.com>
References: <20190215201321.15725-1-paul.burton@mips.com>
In-Reply-To: <20190215201321.15725-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f86e0e67-8488-42c4-6deb-08d6938228b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1582;
x-ms-traffictypediagnostic: MWHPR2201MB1582:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1582;23:/8KPaz3cKnn8W5gtxx2Pu8gT5jtcPHoyNUGBz?=
 =?iso-8859-1?Q?wMAwsBwYISryXvzypaKxopw2pdI4/EJcvfvbsIK8PsKpeN+0SE4Ch1y2VZ?=
 =?iso-8859-1?Q?F3fye1C+9sB1JTQaXXqwXSCQivB0yUtyGNGE9+rdqRlEmxef68NwWEECHI?=
 =?iso-8859-1?Q?2yzT2RuwzMWy7AbQUh/1aCBasJPadVWLOFlbR8IjelNFsO5RPWaaK7ziYq?=
 =?iso-8859-1?Q?MMc0jnBHyfdy7pqzWzQUrY+sAwXe6LDCv2aVcdspHY/PxrcLWC7RIWDdQS?=
 =?iso-8859-1?Q?OIJb65sdUPAIWpSaqgbEQJAR6o0b7MPaBSda2OvftAtMjNJyezarwKoHj4?=
 =?iso-8859-1?Q?zBaXbqxzSYVCk83413h2hT/8Ci9hdDt07uaR2jgxLFSnvD/cKWtMuVjX4W?=
 =?iso-8859-1?Q?10vTLZoOmoeBvaiE0f5pTZM1vCg7EtZeJsgcC3L7rhiUTy9VYtONIIBMzw?=
 =?iso-8859-1?Q?Il7PFoTb8JV7oY/GDnMCea/OV3RUq7JKNACLaD7wqiF1oDQ+7E08klBVCb?=
 =?iso-8859-1?Q?ZJ8JfGkCjuHYLadKN+4uQTheKDG2IyNzrcOeo4l7D3I5r5PDYQJX/N3SO+?=
 =?iso-8859-1?Q?bWGyBhoeNQ67klOk6eSxMgPtkMXZCS7dhRDUaJI8DlfCTnOg/Z1S+wp+PV?=
 =?iso-8859-1?Q?BHMoqwKZ+qDCVQxOxCl6RUB8YWVYCAqqX0A0YU1uEDJMVOWMnQWaI5dD5K?=
 =?iso-8859-1?Q?sehMQuEv3mxsWecr/1/QBEu3p0qHwZH/fc7uRWZHpbKNpvT6tSt6eSJYBa?=
 =?iso-8859-1?Q?9+BjPIWmVSAuKdcgyJ41Eiufb++W+IybBSqjwFb8XGQXdqDKu430pSQb1M?=
 =?iso-8859-1?Q?BiaHDfzEaTscNG8huh2vQ+ma3tzXfUUf491Cg5oUiaGXA2BpGRs5H5rfiJ?=
 =?iso-8859-1?Q?ljrOTF+SkEaaXCD3tj6Y+2WVHI/oWzkzLndtrMx/H6eijbXHB7AonmQKu0?=
 =?iso-8859-1?Q?slnliwHtIJRRNykw0FF7ydgwB3bPfRVkgbL6t6N9JfamHetG+UziWI1U9n?=
 =?iso-8859-1?Q?GeTN+7FfLjcZucrIhmZYK9sSBgD0GN0e+xd1QCVP9aNfIJhQllTKGiGs/Y?=
 =?iso-8859-1?Q?BasGTnHTyHdZF4nxYhJ6hZ+V1OZJpA712QRdnFaqm6fOBdhTp5jlNap1vM?=
 =?iso-8859-1?Q?0RwNMvq5aL/v/WdYAWmVmO4Zg6KWK7heVXhokvaJtvTTRp6Av6K5iiAP3i?=
 =?iso-8859-1?Q?ETXBerTlnr3EUR11AZzqyxtSDQQDgFkyFCyfOLJqaWFVqBovE9vseIh+Ab?=
 =?iso-8859-1?Q?FRPydIG/KMzIzyWSUk/uDJCmhINb1XHOuVJykbAXBH2fhqlo10aYkswzQY?=
 =?iso-8859-1?Q?JZtw=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB15823173EFC50A8F704611F2C1600@MWHPR2201MB1582.namprd22.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39850400004)(396003)(366004)(199004)(189003)(71190400001)(76176011)(256004)(186003)(66066001)(68736007)(50226002)(36756003)(486006)(107886003)(102836004)(71200400001)(386003)(6506007)(7736002)(305945005)(4326008)(316002)(1076003)(6116002)(3846002)(25786009)(44832011)(11346002)(478600001)(2501003)(105586002)(97736004)(446003)(52116002)(42882007)(2906002)(476003)(53936002)(26005)(2616005)(110136005)(8676002)(81156014)(99286004)(8936002)(6512007)(14454004)(54906003)(6436002)(106356001)(6486002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1582;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sYavKm3EnElS9JWUfsrN2gieQpdn0mUlQUDe7rQMmdPTTffVkVhmzPWprCMVtvMNouMnu9zxz3EtyDqB0kpXoiip32eyCGd1q5d2788cvhOeCTuyRQQNfcwYxtGLlFcNN4KNYDTj1OJtxEw3qRTM4iRbgRkpoR03nDt5Cj25KlmkdI92aDzanYjPdV7CrulqZCekuXEqBFwTi7uxJl2vsABTl2lUs3DzahTEkYy5W8D9I9wh9xcqzkzkzGh7jXCrvkDOIORAwlDQiitONrdW4GvgUMFaV9ffH6RTdR/I4RABf5MAZIO+uMMcGIiB5M5mP2e/m/EiiYzRJhgnao7s0LrE2tsDGiDB3Lmc46C8pE4Q2KGZT6NEG5UUxckzsxztUxZNMN+Fy7rsTeQePp9tRDDrwd0MAJMGHCQKaTLNx/g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86e0e67-8488-42c4-6deb-08d6938228b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 20:14:15.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REG_32BIT_ZERO_EX and REG_64BIT are always handled in exactly the same
way, and reg_val_propagate_range() never actually sets any register to
type REG_32BIT_ZERO_EX.

Remove the redundant & unused REG_32BIT_ZERO_EX.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/net/ebpf_jit.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 715415fa2345..76e9bf88d3b9 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -79,8 +79,6 @@ enum reg_val_type {
 	REG_64BIT_32BIT,
 	/* 32-bit compatible, need truncation for 64-bit ops. */
 	REG_32BIT,
-	/* 32-bit zero extended. */
-	REG_32BIT_ZERO_EX,
 	/* 32-bit no sign/zero extension needed. */
 	REG_32BIT_POS
 };
@@ -349,7 +347,7 @@ static int build_int_epilogue(struct jit_ctx *ctx, int =
dest_reg)
 	if (dest_reg =3D=3D MIPS_R_RA) {
 		/* Don't let zero extended value escape. */
 		td =3D get_reg_val_type(ctx, prog->len, BPF_REG_0);
-		if (td =3D=3D REG_64BIT || td =3D=3D REG_32BIT_ZERO_EX)
+		if (td =3D=3D REG_64BIT)
 			emit_instr(ctx, sll, r0, r0, 0);
 	}
=20
@@ -695,7 +693,7 @@ static int build_one_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx,
 		if (dst < 0)
 			return dst;
 		td =3D get_reg_val_type(ctx, this_idx, insn->dst_reg);
-		if (td =3D=3D REG_64BIT || td =3D=3D REG_32BIT_ZERO_EX) {
+		if (td =3D=3D REG_64BIT) {
 			/* sign extend */
 			emit_instr(ctx, sll, dst, dst, 0);
 		}
@@ -710,7 +708,7 @@ static int build_one_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx,
 		if (dst < 0)
 			return dst;
 		td =3D get_reg_val_type(ctx, this_idx, insn->dst_reg);
-		if (td =3D=3D REG_64BIT || td =3D=3D REG_32BIT_ZERO_EX) {
+		if (td =3D=3D REG_64BIT) {
 			/* sign extend */
 			emit_instr(ctx, sll, dst, dst, 0);
 		}
@@ -724,7 +722,7 @@ static int build_one_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx,
 		if (dst < 0)
 			return dst;
 		td =3D get_reg_val_type(ctx, this_idx, insn->dst_reg);
-		if (td =3D=3D REG_64BIT || td =3D=3D REG_32BIT_ZERO_EX)
+		if (td =3D=3D REG_64BIT)
 			/* sign extend */
 			emit_instr(ctx, sll, dst, dst, 0);
 		if (insn->imm =3D=3D 1) {
@@ -863,13 +861,13 @@ static int build_one_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx,
 		if (src < 0 || dst < 0)
 			return -EINVAL;
 		td =3D get_reg_val_type(ctx, this_idx, insn->dst_reg);
-		if (td =3D=3D REG_64BIT || td =3D=3D REG_32BIT_ZERO_EX) {
+		if (td =3D=3D REG_64BIT) {
 			/* sign extend */
 			emit_instr(ctx, sll, dst, dst, 0);
 		}
 		did_move =3D false;
 		ts =3D get_reg_val_type(ctx, this_idx, insn->src_reg);
-		if (ts =3D=3D REG_64BIT || ts =3D=3D REG_32BIT_ZERO_EX) {
+		if (ts =3D=3D REG_64BIT) {
 			int tmp_reg =3D MIPS_R_AT;
=20
 			if (bpf_op =3D=3D BPF_MOV) {
@@ -1257,8 +1255,7 @@ static int build_one_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx,
 		if (insn->imm =3D=3D 64 && td =3D=3D REG_32BIT)
 			emit_instr(ctx, dinsu, dst, MIPS_R_ZERO, 32, 32);
=20
-		if (insn->imm !=3D 64 &&
-		    (td =3D=3D REG_64BIT || td =3D=3D REG_32BIT_ZERO_EX)) {
+		if (insn->imm !=3D 64 && td =3D=3D REG_64BIT) {
 			/* sign extend */
 			emit_instr(ctx, sll, dst, dst, 0);
 		}
--=20
2.20.1

