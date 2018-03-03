Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117233-2-17261335710071061434
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
    t=1520117232; b=lbpG922mKbEiENhmFkkpFRa9Y6Q3MB+5ztijWt0/3dTifwx
    qjh8RJ/loErO+jcb6FFQ1wCJRPR/RA52TOH4AsyXwKSZBr2Dru3yjM/gN91cVYaT
    P/4jOBIdndIUEvgGtuLZxP9Dme+auStJ5upetpyPJQht/8s9J9fZRCLyJ4b0Ww4R
    ++V3pnJhwbM2f+yikBJnqIw+186wMbNQ7FpNMpS0tDRV8+4urBO3BqnTQzJwRVvH
    c5ffolK+P4eGjb9z6SQuVstPBDnhVzabM17viAuzWaambFP4gXd/8hBGnhyAnWoa
    xr2ZzrPqNRBA6r0woBtD6RtY13r/nA38isuHS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117232; bh=6y7Gti
    ZtGF8QeZk/kLg5WsbwFjnp5hSSLgeS1kNypvY=; b=ZXx3h6Eyp2AGrv8azGrRgI
    GhR4t+VWayTHgHzzjFPXWsjBFCB1Or+7GUS4GbNDAukQLHGakAaRmc/RVMOL2KPO
    7gzGVkKCTRb8b8Qa0NNpAb5mmM9tQG3gP0hLWoHAFe1KPKr/Bt76g3OtUbTVY6Jk
    7cE2pJZ5r1iXvCk3vHiO/C8R0XFd2rAtlm7R5LrL+bEpS6V0RkJGhmNxg/2KvTvc
    lkaSq1yH/IugVgDdtnc3T5U5iSezQ9NjW6mFabDvp49+UR65Grh7YvY3ZTqJmgh+
    Li67GNy6Id6M+0+30FCMTYmAwpzg6BibOAoUYkLRtHjIiUwRJd0b3SQq+mfPeBpg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XQqwSicT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XQqwSicT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935546AbeCCWly (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:41:54 -0500
Received: from mail-by2nam01on0129.outbound.protection.outlook.com ([104.47.34.129]:5824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935036AbeCCWlr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:47 -0500
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
Subject: [PATCH AUTOSEL for 3.18 37/63] MIPS: BPF: Quit clobbering callee
 saved registers in JIT code.
Thread-Topic: [PATCH AUTOSEL for 3.18 37/63] MIPS: BPF: Quit clobbering callee
 saved registers in JIT code.
Thread-Index: AQHTsz+omvDj87Tuv0ac29XhI3Glhw==
Date: Sat, 3 Mar 2018 22:33:31 +0000
Message-ID: <20180303223228.27323-37-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:7HnFek8IOp7MIABiA2I+h9GtYmO2qF4NESNNftq55WkQgT3zGrYztGng2VdN7RHpQdKJ2+REOJnIVDcgwckz/ChkSvXB56c+oxcMsm+B0z0KfQgHtZlUhZgF1L+vUyYxmxOD74s+2PuIPotAMSGS2HUcMjjikks+HJ8cTPwb7rrNloCtYPF/WVMhKcEL1nZyVYzvRxisycFLWLW7CEcFi27qK+OoYNjCYupgzPgIeIWKTpgnEvif59gNZY00t0QO34u33Ii6duU4mRZoaaeo2ixbZYELkQulrN9/NhYx+tjf9WnfmfATak19TfzDc4KQNxxHRoGsKFZurFEqM1xvwqCWAS9TOX840xokTIChJ8Xu3U0855ZVwCiGdcKGoC2b;5:6Gz98N6+B+Dt9YEa1S9+Q707xtU8Tieut5zz6XXbdJhdwYcUOgTiat+jGP/nTwRAegnLFqVkyJB0J/RqlWt75jt6/wW6BEOC9ocx4vDDTgFA0/VJ2Qa8hRIhka5AS/TXpTPVkNXIkNE0MXqFzm+l7G3Oh7c1RwmvR5DvDiqH9Do=;24:NeJVGF+mu2RXf8KSii8CA05eiDD48xW5ac8A9Gb0kY+NzkuqT07FqzlVB4UIe3Y11uDB3c3IGc9hQp6ddM8EbIpG3fsXFku1CFfJZICPYNw=;7:MmifM+6uaxZoVzdVwU2OWsL/5PnnwYouh4h8iR7pLbdJSJX9MdxQXF3i4DhCDhPTmNTf27/2aN9QJMfAoQiMMFy6tfiJs3gp4ZRbzJLwAbSXoqoJpuKqEUUISqklGlSgrmfOajy7y4l5TNaOHNxZXE0uTguixl3NOZ396HbpsoDuWvlsGEQ73N27hoUq33S5FNNgWxKtluzuYJYIIQqRtJYfJDrB9Z53Ed3y7UxrZ9c18A96YMlm7GgIlWeXcFl5
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 869f10f1-83a3-42fb-b1e3-08d58157f184
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0682AB9C8415A9B0F87012FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(966005)(6306002)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: NB3uLXoiYmEM/Ogf3dzu+uE8+E+N3nER2edUaXA4JHk5w/cS3bu+aOqGDdR1B8KjkXlbLH/5a1Bfk/YdAXObvl0jMkWgzpx8M1XfkZg/PW4ibeyB8i8fDBoJBywlWAa7LhtYZFK/ih+NjU/pklUClzfg9uHtMKcetjOaHmm8mzw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869f10f1-83a3-42fb-b1e3-08d58157f184
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:32.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index 9fd82f48f8ed..32d2673439ad 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -562,7 +562,8 @@ static void save_bpf_jit_regs(struct jit_ctx *ctx, unsi=
gned offset)
 	u32 sflags, tmp_flags;
=20
 	/* Adjust the stack pointer */
-	emit_stack_offset(-align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(-align_sp(offset), ctx);
=20
 	if (ctx->flags & SEEN_CALL) {
 		/* Argument save area */
@@ -641,7 +642,8 @@ static void restore_bpf_jit_regs(struct jit_ctx *ctx,
 		emit_load_stack_reg(r_ra, r_sp, real_off, ctx);
=20
 	/* Restore the sp and discard the scrach memory */
-	emit_stack_offset(align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(align_sp(offset), ctx);
 }
=20
 static unsigned int get_stack_depth(struct jit_ctx *ctx)
@@ -689,8 +691,14 @@ static void build_prologue(struct jit_ctx *ctx)
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
