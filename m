Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120401-2-5849746956924080966
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120400; b=nSRjLiVsvYjrTKLIPJQHff8mmixuuo8GS1tmVbCgbatliUq
    /AEby1ExGgT9TfFKmPYLvQ1Lc7JTlL/ezWOYvciBQTBO9nmt571hWV3U5TPRQ9LU
    Yi90agVkF+kGvco6/0PhPjkKSA0w60/W0kMbj4yhqY82qltnB5IoE55n+UiNYAvW
    FOh+S1sy7cmIdPpZydad5oN554qhcepKIfi6m7PorpcugGk2WBI/1H//aKRRFfqZ
    XIWXKKetG+n7tuc7LTyEu6VeXx6D5VXPCu4FAmDRlJqpKNdT8gydl84n6iMwqmut
    bIvxjL8ZLOvSQpf28Hz+yls5E1vBYS9iNIZiOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120400; bh=lZvIOp
    xAKAUQjfTEqhcTsWAfUoi/BGMG0+3P8aO2G5U=; b=S4x7Eu7VhWFtCZdB/w1nAT
    lL5GhvGD0d27rIhIIfXjDmcxH/pS1rIaN4HLMs5qR3yblFJHb6NvXTbu0pBbQI3g
    hJ3PrtOIy3Ui23xy/tGa5OZwNTJhXu68qHbZqe/gRgmOTok9Db1CUAsxll539QhS
    dHlwgBHYe/rI6nQEDB+xE3FLZpvaul3486Fzr9XibQMmhcn7i7fbfjIDaxT1TbJC
    u/IgZR98GV4rYiIyE//GvP9Ro4ULqjiwWuPo0CaafTUOetlXFdM38moVEnxySTGS
    07o7SqDLnG8tp8qw8ddU4IwBcT8Ln/O+bWHPkpOtujiGJefmPp8hIfPzWbdqIiiQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R1IIZNWA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R1IIZNWA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933863AbeCCWfJ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:35:09 -0500
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:20800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933677AbeCCWfG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Daney <david.daney@cavium.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Steven J . Hill" <steven.hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 136/219] MIPS: BPF: Quit clobbering callee
 saved registers in JIT code.
Thread-Topic: [PATCH AUTOSEL for 4.9 136/219] MIPS: BPF: Quit clobbering
 callee saved registers in JIT code.
Thread-Index: AQHTsz8PK5JntFS4qUW775AL7VNf+g==
Date: Sat, 3 Mar 2018 22:29:15 +0000
Message-ID: <20180303222716.26640-136-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:U16MWaDrpJX6Z2hfjObAF4sLAv5wZ9DisZPa/CSY5sK0iCaJ8gOYY9DLvOEooGd7nNgCMAMfttVR2huLteVs1t0r/D0u1Wjz7U8X8eD5iFU4eAP8nXBcx+Y7xDWPDlQ8OLAZhToVeAfDFXO5mgGV0l/mRiqL5YqdjD5GNS8Q8x6jvFBaNMEoXoBQWhe1fp17n7fhctIMjc0dFpDrisnPgpAiVuNiB3MiVnvhMYPOr4OKWU9PpWjHj4B+w45g5fqOOQKjbPRyB3sWANk8oTNyQRcyabclsYngazcvDHxihEGAazXoEkmDk3xY3ODbCSb3pAln6uW2hC/3q4eI3pj6vidZsaIG8A5RHodzVd4nJPQ=;5:a3uSITIBJg2kyE/ExC83qr8h+WBHRjmSftEZAno/+7sFNrEFh5sfdaNVy2aBQydaWOU+3jh9sDr83cwWLkHD3wo2Jdmum3Uw9Oycw0errj85kyxVxVDm9K/sx3suqC8co7WxDJJebnOM6pgL19EOsEExGvVgtCYCaccgtheLOjM=;24:fqpNH8MFcoiupjdvNTtkxRsXnfVhlY2o+nnuO8Sus3Wbbk8e2LHp0EFd4O2ud8dZxkYsLla/KVktxOC4a5sw0Tid8ZYLnnHX2NjactqZsx4=;7:190pspeuHsVITWH598IT+yiq7i6LYH+LnjiHOw2LXxIBiF+tx9Xh6kuJD5RQpfok69GSiEiEtqjhmMp91RtqDDI9CkJrnhcmnknSA5XxLqzxT5DHzk71lOYvqvLe8UCbMFxU2sTr8zAWPviVhft74+Ujzg7x9vE9BXciFHO8/FiqP4zOOw1SePwyrarj7qbuWPEHiaz/I/k+BirAvRufeDPH/vtla7zvHM/QJ+XKaSfYL/+ANUEiJPGdmZ7XCHCA
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e9c1ab5-4a81-4d7b-69b7-08d58156fc09
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0924D97669081811473B848BFBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(575784001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(966005)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(6306002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9c1ab5-4a81-4d7b-69b7-08d58156fc09
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:15.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

[ Upstream commit 1ef0910cfd681f0bd0b81f8809935b2006e9cfb9 ]

If bpf_needs_clear_a() returns true, only actually clear it if it is
ever used.  If it is not used, we don't save and restore it, so the
clearing has the nasty side effect of clobbering caller state.

Also, don't emit stack pointer adjustment instructions if the
adjustment amount is zero.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven J. Hill <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15745/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/net/bpf_jit.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 49a2e2226fee..248603739198 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -526,7 +526,8 @@ static void save_bpf_jit_regs(struct jit_ctx *ctx, unsi=
gned offset)
 	u32 sflags, tmp_flags;
=20
 	/* Adjust the stack pointer */
-	emit_stack_offset(-align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(-align_sp(offset), ctx);
=20
 	tmp_flags =3D sflags =3D ctx->flags >> SEEN_SREG_SFT;
 	/* sflags is essentially a bitmap */
@@ -578,7 +579,8 @@ static void restore_bpf_jit_regs(struct jit_ctx *ctx,
 		emit_load_stack_reg(r_ra, r_sp, real_off, ctx);
=20
 	/* Restore the sp and discard the scrach memory */
-	emit_stack_offset(align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(align_sp(offset), ctx);
 }
=20
 static unsigned int get_stack_depth(struct jit_ctx *ctx)
@@ -625,8 +627,14 @@ static void build_prologue(struct jit_ctx *ctx)
 	if (ctx->flags & SEEN_X)
 		emit_jit_reg_move(r_X, r_zero, ctx);
=20
-	/* Do not leak kernel data to userspace */
-	if (bpf_needs_clear_a(&ctx->skf->insns[0]))
+	/*
+	 * Do not leak kernel data to userspace, we only need to clear
+	 * r_A if it is ever used.  In fact if it is never used, we
+	 * will not save/restore it, so clearing it in this case would
+	 * corrupt the state of the caller.
+	 */
+	if (bpf_needs_clear_a(&ctx->skf->insns[0]) &&
+	    (ctx->flags & SEEN_A))
 		emit_jit_reg_move(r_A, r_zero, ctx);
 }
=20
--=20
2.14.1
