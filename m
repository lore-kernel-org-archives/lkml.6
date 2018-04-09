Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245472-2-15164134381294528442
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245471; b=gNa2zzhP2TfQ/Zwxzicv3whXR5D6Pn3PiX7RzkEcK39pdMsuzq
    Z+FO6/U861+NYL/C+Nwt7GGqq2mwFhfsKCLvpmRVqFRNFFjQzx4+17I5WZbrezli
    itaAaBPxrHvnZW3o2SxsVtIS4c6SbFkllEFgFGsRXeRhmdoTXbm31ZMe1gE2qvam
    nUXKi153u5NxYNX5TugY+d6sJIdRb2EJ54ABLwlUP/4XJkkKJJzWVKEK3WSaaoLp
    Gq6huikMASi1tLz13SDVMaUBVjoRA5wqkXQaCBW8jr3L4UfpnmyjsrLgYsV4GWu/
    RT1sGb9WEM6r23mNJcI6gRYzNv2lrL/U9pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245471; bh=6PO0VCwBaN
    /ke5BayvF3aASdcV0OGyoqJRMUfrEWs/c=; b=hY9PDqwvGGFmqNYcBXvlMk5umP
    xlbWldoSse2gYWThVRTbI4U2lmQoavz3Wt+PPJ1nh2FPJ3kV77HfIz9j8k0Bz2gB
    PI3jFBSQ3Ddc7uAR0b3PtoPQqhl4ceRHTkBmF478ny4fE6fus15DgXDPVSotNEkJ
    XgQcFOj1Rlzkipy+cVDmB1KcTrC922AfUcPysmk9OpCnRCOWB0bi+S9NJKvDGMYO
    jYx88B/d/x6bmVn6p1+4yaUalTA7Qa5OslvsLTxO/iJOr1YYpWfs0LMDwLpBSTTB
    B6ZAU02srxt2GjQAsNOlW2yHNijWkWLcVN02YFreRzAXucIqfDcV6v79yqkQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ihsGbtql x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ihsGbtql x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFrzFKYuXYp8iokdhmk+Xn+f2e+Se4GJQqkhdAx+m26YSxN9e8N6F2Kq0cKckU600VCp/YeYS3SRIGWkDXn9+4U/GOCjVlIwTJjb9Nxl/Dft1X3yRMxw
    ko06ZvAYVK6EZ8bfaB5UJLU3elaCvT6Tzbc/gUFHCvZvx7PMriTJhzKJ35qitdWO3h/pxP0GRnPRuWXzQBsCPzA7YkHZY2pD6Md4JGX+F9X4sXWgii3hzUol
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=FOH2dFAWAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=sadFhfGTjmPsfTvmsL4A:9 a=wPNLvfGTeEIA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754394AbeDIDnk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:43:40 -0400
Received: from mail-dm3nam03on0097.outbound.protection.outlook.com ([104.47.41.97]:45238
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754239AbeDIAUc (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 146/189] bpf: fix selftests/bpf test_kmod.sh
 failure when CONFIG_BPF_JIT_ALWAYS_ON=y
Thread-Topic: [PATCH AUTOSEL for 4.15 146/189] bpf: fix selftests/bpf
 test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y
Thread-Index: AQHTz5hS3k/2uZqiGk6g8hGX9ok/Sg==
Date: Mon, 9 Apr 2018 00:18:45 +0000
Message-ID: <20180409001637.162453-146-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:o4xQlcACN2GpmbmBPqrKz/SOsmhxi26u4YwJZT1tI1i1JueyZoUrFGu7htUuMGXIMwRkycToN4+W0AWBPEVnAGK0Q00h+e7SYg5urqdC4y79m5FWjyVROe3mQs0W6pnxCLnuQ8eTS1S5JEbiXpxL1QLtIH6OX1kwe/ZVWV0lJTBfZi3+/+73qEfI1f7bMW78aMzv8lGKtu5rEb3lgBUDuxRC0BPMphQBMgFrJPLef/djMGHCrkCZr5/rHmxbFDzN;20:82Rcu4rknQySI967ia0AT+BpOoIKr4/7DINp8bNClTrX1kr0hQqXJgnmUgfqbC8A99vkHSHeKpoG6f8LYKZushmTZwRYvrwBb6izORWyy6Z49LJctYYz5xV12idosNsfs8aulQu5oXziHKI2+XJ3fumfngAmWvWGyIao2iJcebE=
X-MS-Office365-Filtering-Correlation-Id: 5a8466a2-d306-42cf-071a-08d59dafaf96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920484F767F0B23D9778215FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(265634631926514)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(5660300001)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: nyT+De3YU7GTMTqVO3fhgpkXskeag9tgj6tC55JVezmEMBTXdL+ZdAsr7zZ1V2fgr15Nu6p8Aomd+odLXmNYmHre+KdB8fTMGSm36wuNrJYyvMowWsCfDpTQWTqwPsrsnDVShTFEtVYcMjCZptp75ehki0vaUlgYUdN/KE+m8B9STd99V761CL2yawjOJd7b2vGcLItKpl4/wLmkbb2KndtJ9cKvSILG/lUHPHDyzlPDoXrfiFOjIy79vaVAJN8O5P/UOKaSSzTl5ZJO6yhENwgKNDg4OopvA7bLEZyOOQEnmrkverPmZhL2/zlasxmQCAZm0fYhzbvFef1ueh3I5/xO/7bVUabihrWIOe5wL5SWZLihUA3PlUKXVHeOeAfntbfeS3mH1xlGrwGIZ9ulSgc1Kh8QIDfk4g0pkWo4jCA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8466a2-d306-42cf-071a-08d59dafaf96
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:45.8311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 09584b406742413ac4c8d7e030374d4daa045b69 ]

With CONFIG_BPF_JIT_ALWAYS_ON is defined in the config file,
tools/testing/selftests/bpf/test_kmod.sh failed like below:
  [root@localhost bpf]# ./test_kmod.sh
  sysctl: setting key "net.core.bpf_jit_enable": Invalid argument
  [ JIT enabled:0 hardened:0 ]
  [  132.175681] test_bpf: #297 BPF_MAXINSNS: Jump, gap, jump, ... FAIL to =
prog_create err=3D-524 len=3D4096
  [  132.458834] test_bpf: Summary: 348 PASSED, 1 FAILED, [340/340 JIT'ed]
  [ JIT enabled:1 hardened:0 ]
  [  133.456025] test_bpf: #297 BPF_MAXINSNS: Jump, gap, jump, ... FAIL to =
prog_create err=3D-524 len=3D4096
  [  133.730935] test_bpf: Summary: 348 PASSED, 1 FAILED, [340/340 JIT'ed]
  [ JIT enabled:1 hardened:1 ]
  [  134.769730] test_bpf: #297 BPF_MAXINSNS: Jump, gap, jump, ... FAIL to =
prog_create err=3D-524 len=3D4096
  [  135.050864] test_bpf: Summary: 348 PASSED, 1 FAILED, [340/340 JIT'ed]
  [ JIT enabled:1 hardened:2 ]
  [  136.442882] test_bpf: #297 BPF_MAXINSNS: Jump, gap, jump, ... FAIL to =
prog_create err=3D-524 len=3D4096
  [  136.821810] test_bpf: Summary: 348 PASSED, 1 FAILED, [340/340 JIT'ed]
  [root@localhost bpf]#

The test_kmod.sh load/remove test_bpf.ko multiple times with different
settings for sysctl net.core.bpf_jit_{enable,harden}. The failed test #297
of test_bpf.ko is designed such that JIT always fails.

Commit 290af86629b2 (bpf: introduce BPF_JIT_ALWAYS_ON config)
introduced the following tightening logic:
    ...
        if (!bpf_prog_is_dev_bound(fp->aux)) {
                fp =3D bpf_int_jit_compile(fp);
    #ifdef CONFIG_BPF_JIT_ALWAYS_ON
                if (!fp->jited) {
                        *err =3D -ENOTSUPP;
                        return fp;
                }
    #endif
    ...
With this logic, Test #297 always gets return value -ENOTSUPP
when CONFIG_BPF_JIT_ALWAYS_ON is defined, causing the test failure.

This patch fixed the failure by marking Test #297 as expected failure
when CONFIG_BPF_JIT_ALWAYS_ON is defined.

Fixes: 290af86629b2 (bpf: introduce BPF_JIT_ALWAYS_ON config)
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 lib/test_bpf.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index f369889e521d..8076e693f86e 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -83,6 +83,7 @@ struct bpf_test {
 		__u32 result;
 	} test[MAX_SUBTESTS];
 	int (*fill_helper)(struct bpf_test *self);
+	int expected_errcode; /* used when FLAG_EXPECTED_FAIL is set in the aux *=
/
 	__u8 frag_data[MAX_DATA];
 	int stack_depth; /* for eBPF only, since tests don't call verifier */
 };
@@ -2022,7 +2023,9 @@ static struct bpf_test tests[] =3D {
 		},
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
-		{ }
+		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{
 		"check: div_k_0",
@@ -2032,7 +2035,9 @@ static struct bpf_test tests[] =3D {
 		},
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
-		{ }
+		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{
 		"check: unknown insn",
@@ -2043,7 +2048,9 @@ static struct bpf_test tests[] =3D {
 		},
 		CLASSIC | FLAG_EXPECTED_FAIL,
 		{ },
-		{ }
+		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{
 		"check: out of range spill/fill",
@@ -2053,7 +2060,9 @@ static struct bpf_test tests[] =3D {
 		},
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
-		{ }
+		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{
 		"JUMPS + HOLES",
@@ -2145,6 +2154,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{
 		"check: LDX + RET X",
@@ -2155,6 +2166,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"M[]: alt STX + LDX",
@@ -2329,6 +2342,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Passes checker but fails during runtime. */
 		"LD [SKF_AD_OFF-1]",
@@ -5391,6 +5406,7 @@ static struct bpf_test tests[] =3D {
 		{ },
 		{ },
 		.fill_helper =3D bpf_fill_maxinsns4,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Very long jump",
@@ -5446,10 +5462,15 @@ static struct bpf_test tests[] =3D {
 	{
 		"BPF_MAXINSNS: Jump, gap, jump, ...",
 		{ },
+#ifdef CONFIG_BPF_JIT_ALWAYS_ON
+		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
+#else
 		CLASSIC | FLAG_NO_DATA,
+#endif
 		{ },
 		{ { 0, 0xababcbac } },
 		.fill_helper =3D bpf_fill_maxinsns11,
+		.expected_errcode =3D -ENOTSUPP,
 	},
 	{
 		"BPF_MAXINSNS: ld_abs+get_processor_id",
@@ -6236,7 +6257,7 @@ static struct bpf_prog *generate_filter(int which, in=
t *err)
=20
 		*err =3D bpf_prog_create(&fp, &fprog);
 		if (tests[which].aux & FLAG_EXPECTED_FAIL) {
-			if (*err =3D=3D -EINVAL) {
+			if (*err =3D=3D tests[which].expected_errcode) {
 				pr_cont("PASS\n");
 				/* Verifier rejected filter as expected. */
 				*err =3D 0;
--=20
2.15.1
