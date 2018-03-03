Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120225-2-9814850848744309775
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120224; b=sLwR8HN/XiOOwKSl0KchMojjci1zdVXvDKJhxMwV9VN5f0T
    sRB+txHvy24FT76cXC4EALivi1+hOqv1jRamJm+cAf2nNXIBZJDFTrwT9vk2dDtM
    fyeXtGsbuJ6UE/ybAgsQJBUmYxX52ELmX+42i8+QEej+P4AHgWPleQenxKQ8tvFe
    lL3+W0aIWKWhtJEueq8YAC2mT7+YvcBwWg+aFJgUc45aFfA4RmvpwGRQPlzkigbG
    adlcNBv29qRpIDpcAy+2rasCwnHfNCmFHht0MXVP1lxCBfSk3LhZKeKJJItQWHHy
    T2ODD9t/GM5ij2E2EhBcLhMqYcZgXBD+90qgHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120224; bh=sd4gbD
    GvuTP8uce9Zd7kcRmt147rCNKml4/lIBq/RvU=; b=ZazXRVyY06FFBkyTVlDLL0
    ZKJTHqpFK1YwY8hPgv4FrHV6w8fVpSea2bsHy5i1aPFvt9zd+pjQjJMAiMQ73pvL
    HYXgL6SfDVKMRYMPiz+XZiqxR64/4y9tol9m01oMJ0DDinNgR/qvmQJxnJcc1igW
    E0399jS5U5THXsHbwG0lan/Mw6wEh0g0PVHg+vtoYuZcIm6SlqtP9dOBl2I+uMuX
    5eAzgdVHSKMTvFPZnsj5SwWtmywEnWEoiOVaky+hRFZsCiPR2YF9W5hySSaYNgBg
    /XOH2iabKs3L6EVzSNVdbHl0bfiGQN6Lm6XxvW9YedRQo6yyQSdY0CpUYMTvbktg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nWHY7FBR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nWHY7FBR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934375AbeCCWfP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:35:15 -0500
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:45030
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934341AbeCCWfL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:11 -0500
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
Subject: [PATCH AUTOSEL for 4.9 137/219] MIPS: BPF: Fix multiple problems in
 JIT skb access helpers.
Thread-Topic: [PATCH AUTOSEL for 4.9 137/219] MIPS: BPF: Fix multiple problems
 in JIT skb access helpers.
Thread-Index: AQHTsz8QdLxyySlwWEu+oufZVP8dTQ==
Date: Sat, 3 Mar 2018 22:29:15 +0000
Message-ID: <20180303222716.26640-137-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:nqKRoKP1ZCfeyQgBR9HpepXf92133uoEDt9T37FVoaujcpsUPEqABdqVk5tWOOmaLSIjypeFvllmPGwIwF0NtuRcyHglohdRuf3KziVZJnaE2fYfYhiS1FnpTSlkNx3sc5GQdVFxe96ZSZXgHW2EjHBDiM4RTEDpOF8naSiVLjQTxByXE6ujdVht8Os0sR7ryQK5PGikHsOBnoc29z4mQmDmosd8Xj3yq/rZwJv/y4VltmhnUDQiIYpjW7smbFGJwvd/t7sAkjopfWdWhj4TKQ7cQFUaMeKFBE3yfh0nOJKALBFeJre2Na7pa6u1Mzd8xY0G9CXuAZyqGxzCC6gjwcaGsh7MWk2+WYNi0pBi4o0=;5:KCxm4/Mx7LI6Y3bwVRJoU7/WCx3WbAVqUTu2s5VULLXdjLVj4pYYDUcSnbmGE10jxzzguSH/tDI3oxRVY4rns506VEHAj+pKkBxNd54lXY0HrTiRi7LUWK/7w2mT+/dsCrg9euXMwpMnDTd359Ufl0/TFuRoIlCCmvfjNGUeDMw=;24:w7rgpracERFaNmik8eNV2/hOTxraahm0k3Gb2iWBIQp+xjlNYCiT5Q9tIb+h14y9txmPOsVniKRSFrOwhQ7igDZGbqqraNsIDaZpkxLfQKc=;7:k6aVh9tGVF5tRjElei7eMOOq1PT4YNxghNG5Gu1GU8ta8IJCUweZ7cLLAa3AXUwj/PhO82I90WAIFYkb2rKYl5LbJnIVBmqHKB0V44a3bkF2hoHxkC/kQhXLNyUdPaC6YA+N4vo4M8gb4oVuGKavvrko8Jqb533BN80YmLefMz7QU8I3yIMzcMbu83Hx7510Rg96femUF1QvZuzbpd5XTj16pQhgkd6BcD01raywZ4PB1NXC6cuoT/zh8ZqgMlzI
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5724acc-4a1a-4000-531f-08d58156fc53
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09245541CAF0E213EDB3820EFBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(7736002)(4326008)(305945005)(5250100002)(86362001)(575784001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(966005)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(6306002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5724acc-4a1a-4000-531f-08d58156fc53
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:15.9944
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

[ Upstream commit a81507c79f4ae9a0f9fb1054b59b62a090620dd9 ]

o Socket data is unsigned, so use unsigned accessors instructions.

 o Fix path result pointer generation arithmetic.

 o Fix half-word byte swapping code for unsigned semantics.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven J. Hill <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15747/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/net/bpf_jit_asm.S | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/mips/net/bpf_jit_asm.S b/arch/mips/net/bpf_jit_asm.S
index 5d2e0c8d29c0..88a2075305d1 100644
--- a/arch/mips/net/bpf_jit_asm.S
+++ b/arch/mips/net/bpf_jit_asm.S
@@ -90,18 +90,14 @@ FEXPORT(sk_load_half_positive)
 	is_offset_in_header(2, half)
 	/* Offset within header boundaries */
 	PTR_ADDU t1, $r_skb_data, offset
-	.set	reorder
-	lh	$r_A, 0(t1)
-	.set	noreorder
+	lhu	$r_A, 0(t1)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 # if defined(__mips_isa_rev) && (__mips_isa_rev >=3D 2)
-	wsbh	t0, $r_A
-	seh	$r_A, t0
+	wsbh	$r_A, $r_A
 # else
-	sll	t0, $r_A, 24
-	andi	t1, $r_A, 0xff00
-	sra	t0, t0, 16
-	srl	t1, t1, 8
+	sll	t0, $r_A, 8
+	srl	t1, $r_A, 8
+	andi	t0, t0, 0xff00
 	or	$r_A, t0, t1
 # endif
 #endif
@@ -115,7 +111,7 @@ FEXPORT(sk_load_byte_positive)
 	is_offset_in_header(1, byte)
 	/* Offset within header boundaries */
 	PTR_ADDU t1, $r_skb_data, offset
-	lb	$r_A, 0(t1)
+	lbu	$r_A, 0(t1)
 	jr	$r_ra
 	 move	$r_ret, zero
 	END(sk_load_byte)
@@ -139,6 +135,11 @@ FEXPORT(sk_load_byte_positive)
  * (void *to) is returned in r_s0
  *
  */
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define DS_OFFSET(SIZE) (4 * SZREG)
+#else
+#define DS_OFFSET(SIZE) ((4 * SZREG) + (4 - SIZE))
+#endif
 #define bpf_slow_path_common(SIZE)				\
 	/* Quick check. Are we within reasonable boundaries? */ \
 	LONG_ADDIU	$r_s1, $r_skb_len, -SIZE;		\
@@ -150,7 +151,7 @@ FEXPORT(sk_load_byte_positive)
 	PTR_LA		t0, skb_copy_bits;			\
 	PTR_S		$r_ra, (5 * SZREG)($r_sp);		\
 	/* Assign low slot to a2 */				\
-	move		a2, $r_sp;				\
+	PTR_ADDIU	a2, $r_sp, DS_OFFSET(SIZE);		\
 	jalr		t0;					\
 	/* Reset our destination slot (DS but it's ok) */	\
 	 INT_S		zero, (4 * SZREG)($r_sp);		\
--=20
2.14.1
