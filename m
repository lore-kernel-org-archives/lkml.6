Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242740-2-7987893523199808122
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242739; b=qFRQDs1afAmw47+59YDtRJ0Kx1yq3o7/r78USIevfQpAmVXOw7
    vC0Lx9SWr4wHH0hqHtDNOMVmbhcM51Q1Zy3axcN+54af3vVDPIahdzajwGLweqNH
    VhHFh46/PI1b0EzN2AtCAaOdQa2SXOpRMTTL1S719P0wJjpWIsd+8k+ENs8+NBGp
    K3ZJuEozrA0gOtRHyRHVsbESzwfWKUPxrROOjWn8Ch1k3ohG4lw0MDGzzSp9FEk+
    A45XOKXGJA674PrTZ1qc0j2EpbM3C3Qt3rkB6t+utSIwX7dS75n7U8v+horfMsSO
    bxgyEr1fw6Jvey8RzAa9n3i+RcaKToaVmgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242739; bh=FVcE7Tahqu
    AoQRjjqXAmBi5aCgBwNkKXm/z0CIM45dQ=; b=J6Ji03ZDCMJOOPjt2COF9LKm1F
    eIcQHEHoZwy7DBmDJ8zoLeUIFNiUo6PXpcKCVOXGzhJzskwNkErvF07zqIaTNQ69
    ikWTaL4JprMzpd5JWd17LBSg2r1RtL7bAdGLakd29mej3dujI+0IrvHV4ARNK1bW
    d/2NchTNp1370OntfRfhrG2KBTC4OHEA4wAt/2dXAmD9PoyoeJZxNLB6M4KXNuAl
    9FADObYRydB4qlcoXQEnSX6geX0zlXhCstATbd+EauFo0YuCYBWSmWT3diPmMJ2I
    co4MYNJ1MDBj9v7EmSVSTXcPUc3qnG9LkXg9WYHct7B+tdn3HFc9qQ+eEqPA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=au/xoO1q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=au/xoO1q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA5l7WZtorOu97Yk5jaFOx8PiSx3qp+lhL0qhZlJ/IRh9S4/kSa6eM7oNIJt9maAJXMDdkQ3QXA4+UHhDdYlSQMcwNH/1K7KvinRZxmncbBEADxx3teO
    f/I8dRt1Z0V8EBtbyVP199b55hDrKhZjtg1on5oys1B6Ur/flY+1HS1LFT7SMcsf3BrfmfYLBtBzNJgoxvpEh1knZm8GWhyHmbqaNgwhTouGBbDjbW9N0NG7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=FOH2dFAWAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=sadFhfGTjmPsfTvmsL4A:9 a=wPNLvfGTeEIA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755636AbeDIC6v (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:58:51 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:17920
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755176AbeDIAZc (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 122/161] bpf: fix selftests/bpf test_kmod.sh
 failure when CONFIG_BPF_JIT_ALWAYS_ON=y
Thread-Topic: [PATCH AUTOSEL for 4.14 122/161] bpf: fix selftests/bpf
 test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y
Thread-Index: AQHTz5i2El+NT8XpL0i8MfBuJas4Rg==
Date: Mon, 9 Apr 2018 00:21:33 +0000
Message-ID: <20180409001936.162706-122-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:G/5Nik81NCrFlWBtmXl0qujCTH6G97Q1h+4Gbrb5khSaxZOR7xCp0AMfTBi+VyDWyZ4mnx1YbmGY+n23HgEtexQ1sLX9GwQBbpAIQgLyoE285uwpjetZGRDv8/CLl0ZADC5dqqLH4hkHOWnCEc2CzDy5HeiUQ8dIzIp3aYlueUWl0mUDw5J6o4DIogwokYbfdRpXZaLDz3ZM90Tu329dbJlFV6F+lWEJiDfOuPYWoxeTppgz9Xo4CQ4dz6QgN+PB;20:Fm7djDECVcoKlovykuv5jn5+LGxzYq1I4AZvcP6T3pesGrnxYaRd8dGxF1t5yvg3pGeKiv9Qo6AY2UGgLwTD6dExL2tuJRjN/lCAv1BXeP20Y1kb8mjagTwd9r1dkySaVowMQDeWgaXI4U4c+xKJBF2JGZtSae0LB9KrxuUkoP4=
X-MS-Office365-Filtering-Correlation-Id: 7ed6c58c-0dcb-4833-ba84-08d59db06557
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10139A2A550525746CB6F2E3FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(265634631926514)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6666003)(6116002)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xHsvHZk6raKk8Cub2hpZ1btqS65kCV2nZac60B0kMIR642qIYa9JoXmuUEyhOOIZTXMx2SxxGKyI7/+9Z5SaE4MIfgWTCO9jT3a5S0/x9m9FoG0QXHB8vliEgvxSrM0RBGqStbizrMhZ9DEmaIGGuBMeu7Pyx7jmwuXzPVXVS8xCWve7Gtp4h7jMeJ4EXm9P77NEVskfudA2uOKcNS0qtLzYJc/gF9JZEiqDvsdj7qnFBLlc36gb4L6OnNuv2swu8SBDyAauYhgU24LRdbB10AxcpM2Vbot0Hle/Hab+VRQdTt1kBBp9hRXu0hQoKg7q7qj+GqkdHBOHxCM44YM1YdZNjrfEbqujvPotRiq0WFTBOeu39SXqP4DInOzmRT3eUc9VQ9IakYTUXm73gxTVV2fXDrbvs/h5IJtyocloBlo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed6c58c-0dcb-4833-ba84-08d59db06557
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:33.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index 6fbb73f3f531..64701b4c9900 100644
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
@@ -1987,7 +1988,9 @@ static struct bpf_test tests[] =3D {
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
@@ -1997,7 +2000,9 @@ static struct bpf_test tests[] =3D {
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
@@ -2008,7 +2013,9 @@ static struct bpf_test tests[] =3D {
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
@@ -2018,7 +2025,9 @@ static struct bpf_test tests[] =3D {
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
@@ -2110,6 +2119,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{
 		"check: LDX + RET X",
@@ -2120,6 +2131,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"M[]: alt STX + LDX",
@@ -2294,6 +2307,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Passes checker but fails during runtime. */
 		"LD [SKF_AD_OFF-1]",
@@ -5356,6 +5371,7 @@ static struct bpf_test tests[] =3D {
 		{ },
 		{ },
 		.fill_helper =3D bpf_fill_maxinsns4,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Very long jump",
@@ -5411,10 +5427,15 @@ static struct bpf_test tests[] =3D {
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
@@ -6193,7 +6214,7 @@ static struct bpf_prog *generate_filter(int which, in=
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
