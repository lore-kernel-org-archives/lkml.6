Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492406-2-9270694054304449291
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492405; b=K4vBDownZ98LW4mJjZEQrVnbfHCyiRU5feh4ePxzvHui2CS
    8YPjEe/1VTqO0WCJWGgDdg/oHYn964nQqkmc4X80qdvfgnNjDI8vmteWe4xfIw2d
    t/qG+fWEM851ubfyY1DvnXHXchE4/iLNLKm+m/hba9brRo6fHfqnjrU5xNuQXQB+
    dKMEDuIHq1Yb5hMDhzQtamOx9TLw9M/D4JYm6icNGC2xEF43O8KqHujKKl3v4mc+
    UIlhhq4VyGFQPNJh/qBcO8+5yAEC86sMXD0/zCi0Sd0pKsbPquIdoNBfJcP87S62
    p98iPwslAkCFaFoFzL2aD9OcOJy+ZhfeSnArTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492405; bh=9eEQM/
    QfMUrr/ua5okJaWIJyZz5jaBILPUSeBy3r0VY=; b=LoLlSw3jw4OjKnpcZgtk5i
    hoOe3y5z3ptDBpKpWZbe/+8UFFpEZN6oCcOBG0s+vAjVk6ZG//f4yb+FfI16JtoL
    h2q1QmmJzmrqnMmIohM+P2ZmgtMXccw1xSzdKOO+vJj5UUnVRCrzM5E2XVC0PLDv
    brZ/23MLtEmDKFK4fgydDuhnucpJ/FQpDuI1d4HgA6NQKjrL37LYeKd3MraQXupe
    /V3ceQoN6J/tGzntKa5y9oeKg5qNUL4Pya61Zdkrz/yt3UC0tTBHgk14+jff+EV5
    cD/5gu/lICRI/X1+FAQTmO6LqhQxJmPr3cSRT9+E8FUUmvAP3NoAZUwHHwWecSIw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mTbbuFUq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mTbbuFUq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935045AbeCHHAC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:00:02 -0500
Received: from mail-bn3nam01on0119.outbound.protection.outlook.com ([104.47.33.119]:51237
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934995AbeCHE5V (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 45/78] bpf/cgroup: fix a verification error
 for a CGROUP_DEVICE type prog
Thread-Topic: [PATCH AUTOSEL for 4.15 45/78] bpf/cgroup: fix a verification
 error for a CGROUP_DEVICE type prog
Thread-Index: AQHTtpnNk1GoKJML+06VaB0E0WOz9g==
Date: Thu, 8 Mar 2018 04:56:21 +0000
Message-ID: <20180308045525.7662-45-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;20:98Rcd5M+4Ckay6PrD3SNX2RD1Z2SgBBUzOuEimk6J6zhX828iw1tYnilR4GEHbWG8nDDlyiAljfT+IYkjy6R/eSE78resROSow3wjp1lCBOe263yXDCOX7xeBQBx4uDWfOm0Qt2+Mo+IqRUAtnAnuxsOGaErC8A48Dh9zPAJ62E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a3eb4f1-1d33-42cd-e7c7-08d584b10d05
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10799AA319CB8EBAB28563E0FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(575784001)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xEFjM4wXPMNu7VjKqhcK5GYMNv9w+SF310ShSI9suWHcD75qcWDj1qFnM1YC5UA6Io40FEmG2zaNmfZSwz/65xt0QCQB72zpJ0RAl8sFfK9EG6efI4/wcTtJeveqFNoM4S1erY72bX+4QXnPyWNTM6meTcgKTPMDXck4uJn2RLQWn/F+B7oSnqSi7rphInRwmpOCP6/3BcLUOW2nDSlTVke4wug873IB6evnakFDOg8nWpaCB2px1wr2ryKHAOku69FLbmXko7OJemorDLfe7umhJMVBWPVKr70zvgoD7GJQmuC4oJqXazTiAwBbYkat/DCiGRiSkQPdeV1PTwzwKg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3eb4f1-1d33-42cd-e7c7-08d584b10d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:21.2697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 06ef0ccb5a36e1feba9b413ff59a04ecc4407c1c ]

The tools/testing/selftests/bpf test program
test_dev_cgroup fails with the following error
when compiled with llvm 6.0. (I did not try
with earlier versions.)

  libbpf: load bpf program failed: Permission denied
  libbpf: -- BEGIN DUMP LOG ---
  libbpf:
  0: (61) r2 =3D *(u32 *)(r1 +4)
  1: (b7) r0 =3D 0
  2: (55) if r2 !=3D 0x1 goto pc+8
   R0=3Dinv0 R1=3Dctx(id=3D0,off=3D0,imm=3D0) R2=3Dinv1 R10=3Dfp0
  3: (69) r2 =3D *(u16 *)(r1 +0)
  invalid bpf_context access off=3D0 size=3D2
  ...

The culprit is the following statement in dev_cgroup.c:
  short type =3D ctx->access_type & 0xFFFF;
This code is typical as the ctx->access_type is assigned
as below in kernel/bpf/cgroup.c:
  struct bpf_cgroup_dev_ctx ctx =3D {
        .access_type =3D (access << 16) | dev_type,
        .major =3D major,
        .minor =3D minor,
  };

The compiler converts it to u16 access while
the verifier cgroup_dev_is_valid_access rejects
any non u32 access.

This patch permits the field access_type to be accessible
with type u16 and u8 as well.

Signed-off-by: Yonghong Song <yhs@fb.com>
Tested-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/uapi/linux/bpf.h |  3 ++-
 kernel/bpf/cgroup.c      | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4c223ab30293..04b2f613dd06 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -995,7 +995,8 @@ struct bpf_perf_event_value {
 #define BPF_DEVCG_DEV_CHAR	(1ULL << 1)
=20
 struct bpf_cgroup_dev_ctx {
-	__u32 access_type; /* (access << 16) | type */
+	/* access_type encoded as (BPF_DEVCG_ACC_* << 16) | BPF_DEVCG_DEV_* */
+	__u32 access_type;
 	__u32 major;
 	__u32 minor;
 };
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b789ab78d28f..c1c0b60d3f2f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -568,6 +568,8 @@ static bool cgroup_dev_is_valid_access(int off, int siz=
e,
 				       enum bpf_access_type type,
 				       struct bpf_insn_access_aux *info)
 {
+	const int size_default =3D sizeof(__u32);
+
 	if (type =3D=3D BPF_WRITE)
 		return false;
=20
@@ -576,8 +578,17 @@ static bool cgroup_dev_is_valid_access(int off, int si=
ze,
 	/* The verifier guarantees that size > 0. */
 	if (off % size !=3D 0)
 		return false;
-	if (size !=3D sizeof(__u32))
-		return false;
+
+	switch (off) {
+	case bpf_ctx_range(struct bpf_cgroup_dev_ctx, access_type):
+		bpf_ctx_record_field_size(info, size_default);
+		if (!bpf_ctx_narrow_access_ok(off, size, size_default))
+			return false;
+		break;
+	default:
+		if (size !=3D size_default)
+			return false;
+	}
=20
 	return true;
 }
--=20
2.14.1
