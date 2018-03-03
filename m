Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124577-2-729892164283006453
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
    t=1520124576; b=jjS+GoZPX6v6kjMCPCJabI4UkWYT06zSwdmAUMjeD4rAV0L
    ilotz63S1fRKVxQ3JWrBF4aQG7NLeag30dddzd8bXYCDOq9WFjBhqqq5l/NtMtwq
    mx8oknq2olQQK/jDDwtJB7tEWC7jr9OicoySlmcoZ8tWGRUe8rlRhPDRO+gcyRxc
    6X0c38aLYhvNJ9v8ikEHv5mHseZ3C0sjdWIhaOga4TlUzEhlS3Jo9bLdev5zf2wH
    xNpjTzgFiOQhFp8B0zAeNyiMtqU7raqdyyV+waxOjHe1OtmaB8U152arFay4/Fcl
    KuHd38ydWuKZk92nL/qVQtcBcO+SbZq9hWYKdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124576; bh=Ae/2Q4
    wEBwOzIn+il0ZhTpdtjvz6QMz4w0flAVmfaEc=; b=o3s0CsU+Xeldi5Za1eRZy7
    h0x1ZTzfz9gThbuK4Yaw//1agv9tQlJTJivh8JoXmMnHfwU3k/2Lnwh3Vlma1m/T
    JNteTYLL289kt5yMSbEKMmqHzZKeq0WmdlBt2NqPIA5gpyppOuzVjVRrqX+Ky2Rd
    s0gjtRHj+xdtmNFeu9Eqj9ekGj7v9eV8QaodIM7vjsFvqz1Z26vH2lP9Yf812WT+
    I3cgrE2TxaguoRnao9FXD2DO7ljM1/phlUyh9aO3YS+3/zIMpHSJKmUz5SFGt/54
    KYKH4g8mtFgVc7esH/GXfOD7DRcF6/2N2F0MnUHUgCR4f+BErFrSjjamUU+DrYiQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CoQYs+vq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CoQYs+vq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeCCWYY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:24:24 -0500
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:61181
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932193AbeCCWYT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 007/102] KVM: PPC: Book3S HV: Avoid shifts by
 negative amounts
Thread-Topic: [PATCH AUTOSEL for 4.15 007/102] KVM: PPC: Book3S HV: Avoid
 shifts by negative amounts
Thread-Index: AQHTsz5bn6GAu0pfsUejp5j8JqfFPw==
Date: Sat, 3 Mar 2018 22:24:12 +0000
Message-ID: <20180303222318.26006-7-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;7:CqDXGDRkUK3KX0/XbHSQXQSzUDcZS3CrBbMzOkREtrCc7waTFo38+slN8m2+SDaB495eW/DXwGlQW0z1XLYXcqihdNcXIQvzNUa477rTiGjupEczVY9jImebO225VwGir8BB4F/fdIgQ9IYEGZrsLLnSRcz7BiKWmrBljY6YqCxQhqfFCqqic3l3SxU1oiXWr6XABP39Trt+hYpdubaCkNfB8k3HjHH43DH1Lx/ceRRV9K633CBrckCAiCaA+/Jh
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28b7e768-2bdd-4e91-1115-08d58155806d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB089051991BE3687C1667D3B7FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(59450400001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Gj6rGeuoxczxcEDvEszlj5NmFIThKSxslCifv7viRMBUb/BMGFQjfehvZL9WdKuwb1fIxsmsoxHqr+fWeIJZjlSelMsGELMrIa35y9MkjfkbKnHQOQrqR+DnIn5OD5jYffICrlQCssoQA2pmCaZxPUP7bb9tTWYM1jZTmdgb8dw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b7e768-2bdd-4e91-1115-08d58155806d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:12.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paul Mackerras <paulus@ozlabs.org>

[ Upstream commit cda2eaa35948893d70145490d5d6ded546fc3bc6 ]

The kvmppc_hpte_page_shifts function decodes the actual and base page
sizes for a HPTE, returning -1 if it doesn't recognize the page size
encoding.  This then gets used as a shift amount in various places,
which is undefined behaviour.  This was reported by Coverity.

In fact this should never occur, since we should only get HPTEs in the
HPT which have a recognized page size encoding.  The only place where
this might not be true is in the call to kvmppc_actual_pgsz() near the
beginning of kvmppc_do_h_enter(), where we are validating the HPTE
value passed in from the guest.

So to fix this and eliminate the undefined behaviour, we make
kvmppc_hpte_page_shifts return 0 for unrecognized page size encodings,
and make kvmppc_actual_pgsz() detect that case and return 0 for the
page size, which will then cause kvmppc_do_h_enter() to return an
error and refuse to insert any HPTE with an unrecognized page size
encoding.

To ensure that we don't get undefined behaviour in compute_tlbie_rb(),
we take the 4k page size path for any unrecognized page size encoding.
This should never be hit in practice because it is only used on HPTE
values which have previously been checked for having a recognized
page size encoding.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/includ=
e/asm/kvm_book3s_64.h
index 735cfa35298a..998f7b7aaa9e 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -122,13 +122,13 @@ static inline int kvmppc_hpte_page_shifts(unsigned lo=
ng h, unsigned long l)
 	lphi =3D (l >> 16) & 0xf;
 	switch ((l >> 12) & 0xf) {
 	case 0:
-		return !lphi ? 24 : -1;		/* 16MB */
+		return !lphi ? 24 : 0;		/* 16MB */
 		break;
 	case 1:
 		return 16;			/* 64kB */
 		break;
 	case 3:
-		return !lphi ? 34 : -1;		/* 16GB */
+		return !lphi ? 34 : 0;		/* 16GB */
 		break;
 	case 7:
 		return (16 << 8) + 12;		/* 64kB in 4kB */
@@ -140,7 +140,7 @@ static inline int kvmppc_hpte_page_shifts(unsigned long=
 h, unsigned long l)
 			return (24 << 8) + 12;	/* 16MB in 4kB */
 		break;
 	}
-	return -1;
+	return 0;
 }
=20
 static inline int kvmppc_hpte_base_page_shift(unsigned long h, unsigned lo=
ng l)
@@ -159,7 +159,11 @@ static inline int kvmppc_hpte_actual_page_shift(unsign=
ed long h, unsigned long l
=20
 static inline unsigned long kvmppc_actual_pgsz(unsigned long v, unsigned l=
ong r)
 {
-	return 1ul << kvmppc_hpte_actual_page_shift(v, r);
+	int shift =3D kvmppc_hpte_actual_page_shift(v, r);
+
+	if (shift)
+		return 1ul << shift;
+	return 0;
 }
=20
 static inline int kvmppc_pgsize_lp_encoding(int base_shift, int actual_shi=
ft)
@@ -232,7 +236,7 @@ static inline unsigned long compute_tlbie_rb(unsigned l=
ong v, unsigned long r,
 		va_low ^=3D v >> (SID_SHIFT_1T - 16);
 	va_low &=3D 0x7ff;
=20
-	if (b_pgshift =3D=3D 12) {
+	if (b_pgshift <=3D 12) {
 		if (a_pgshift > 12) {
 			sllp =3D (a_pgshift =3D=3D 16) ? 5 : 4;
 			rb |=3D sllp << 5;	/*  AP field */
--=20
2.14.1
