Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238399-2-1806483995859080312
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
    1523238398; b=EFHg7yL1t+/JAxyKj2ftEjc4l69xjUJpihV3ls3aRfdiuJLUlM
    rWW+ITBYpRY3UqNJVN6/baJd80gU3iEpBzPALEs1qS9QjpDAyU4eRClVmEoSNciv
    Ark/zbUY+0nWelIRoKLr1u4bfZtdk0EMnxRVFaKGRnF/V/1U4ussRjT5szmqHnCj
    YtG1+uvjAp24njhl0KsDLxGOnBmIZaT+xY9pgNeTrQrsizbpTV8qlUf8t8DTsgYC
    4jbs4w/jdVARxev9UM8hGIYxVvSf8sGPWVQRuJBTfzd85xsIEv/aFA1U79qwDHHM
    Pg1oXrCRA23mDBGD3AJO9oIQlQRotrIbvfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238398; bh=w5pntFqxEK
    0g2iVpeLEv7/LkYRZmPpjrpE0Ut9lCSpo=; b=XVoyKsKt1wG7UL5Y/Ga7CrQn5E
    g7ZNBy4QImWPFqXPk+nKsLzUHY/KJXio8PK3oW7GhQaKSDG7Q9QerOQEm70ll+RJ
    dQWgxdE/kazR+6BjAvvZSQrQ0qXOjuF20oOxhNL1CiLmzxSBYBkzEtSG6ad4b3l7
    QrdR6miaiknC/KFyB1Hr5Fp3d8LOO8fgG3HlLjUqLhCUe1oiAcBlQ38DnIMRmyro
    P084gDu7RUrAyM3L21lItH4wtsd/Wr1KEstMFJqoqRVoy6si0O+bpmw7AOGoJabJ
    ChQ9+U+7DhyS3gOptgjBPDw28cNuqbsGgopUQ8pSQKzp+1xnuLiNSQR74DUw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vocgb9QO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vocgb9QO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGZ+LuEKJf3JeDQekpJhWuJVxOIwl2gKfjJd0qMzbEd3IJOSs30S4mPmCmvSAt0PKaH/p15Wkk88zkZ/ecTEuWOw1tlcUrB8A7NzffxwCZXOVrgVQoTD
    ZuTpLTLI7ylutUF0UrmPNA88uSDcqyxW8Ykc1LMWeF1NthL5IRAs77y0I/uV3f1x0SRFP0cHDrV8nkS4rvfMUl9qqWhWNgRUv2bprzcMKdA88aK4r90Z3HKe
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=FOH2dFAWAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=sadFhfGTjmPsfTvmsL4A:9 a=wPNLvfGTeEIA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756542AbeDIBqT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:46:19 -0400
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:14317
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932471AbeDIAej (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 272/293] bpf: fix selftests/bpf test_kmod.sh
 failure when CONFIG_BPF_JIT_ALWAYS_ON=y
Thread-Topic: [PATCH AUTOSEL for 4.9 272/293] bpf: fix selftests/bpf
 test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y
Thread-Index: AQHTz5lm2UCPUaEyv0Ws2L+A7gIfDg==
Date: Mon, 9 Apr 2018 00:26:27 +0000
Message-ID: <20180409002239.163177-272-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:v5FVpQOpyTKRdwro9li+/jt9AHy+Z5MbYUEj533081kwSvlzE3rkqg2S1zdW/idBgCzMNZ5Fu7Y82PmDijS0yLMeXUg1zbGNI1CW4RcNNKWddPtOZ9UNyGEH1TdTcC115FaYtV/icbvl9+e2wV1oNbZbuZeHDuqcHwmvAy6BGs5uMufRMWCDmFkob6HlF3ceucZsUf3KE1olW8cDrqg8JfpYwWlHZ4LbIR3d4xpZhFk3Jmf+6hQLOMiOESAmRMWc;20:hRZoKagJroS/+v7Cva8GI8zl7Pv+6AHZseraoFN0cN8ImEvrscZDFEMoBh226vrOBMi0WgDRB57K73qN6BgbiFNqUaUIAY+tWRheWKvuJhIouaMUjDudcrAzaALb3k+KsxOHJmOVXP36/mAQuLhmEV/Ia2EP/8LjHgAod7OuOrg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4eb69a25-7a57-4ca7-a002-08d59db1abdc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098421BDD7AFEA3F6328FE94FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(265634631926514)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5NlCR/BEPcrjHxn71OxPj71i85/j6hPpw+aN++Fmfbq1CM18WtVVUmPktvJTIr8ES0ddy691gVtckEQhERfXkW9CPLDGFX/WZqMYYzK1IfXOU7Wh/7lKBTBNn+APpoSFxK4u3lMDQkUUuRQILKpR47aIRvYWVLjJTSRWOVkQTn5Gx/VrD4D6QKwwCpyxkSegeel+4R0z/mP4zY0UQ5dOHCdc4BbKIC0hIanZq2rC8+UpiD7IIVB2mj3fjDtKqv7AnJWlk280sqvduGjMOUIJfnn3aY3M2wSvhOPik0MJBhNi/05dOcfurCBHLjjknqiKacK5vduf/HdAERksPM8oAylGhjG/qihu/l43rOMypACg8XygVGSY4CNX+lhtsPFg24eIDWxEwIjg+SuqPN+wPAdoxUZ6mQJd65QlMVF8hm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb69a25-7a57-4ca7-a002-08d59db1abdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:27.9414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index 98da7520a6aa..1586dfdea809 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -83,6 +83,7 @@ struct bpf_test {
 		__u32 result;
 	} test[MAX_SUBTESTS];
 	int (*fill_helper)(struct bpf_test *self);
+	int expected_errcode; /* used when FLAG_EXPECTED_FAIL is set in the aux *=
/
 	__u8 frag_data[MAX_DATA];
 };
=20
@@ -1900,7 +1901,9 @@ static struct bpf_test tests[] =3D {
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
@@ -1910,7 +1913,9 @@ static struct bpf_test tests[] =3D {
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
@@ -1921,7 +1926,9 @@ static struct bpf_test tests[] =3D {
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
@@ -1931,7 +1938,9 @@ static struct bpf_test tests[] =3D {
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
@@ -2023,6 +2032,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{
 		"check: LDX + RET X",
@@ -2033,6 +2044,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"M[]: alt STX + LDX",
@@ -2207,6 +2220,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Passes checker but fails during runtime. */
 		"LD [SKF_AD_OFF-1]",
@@ -4803,6 +4818,7 @@ static struct bpf_test tests[] =3D {
 		{ },
 		{ },
 		.fill_helper =3D bpf_fill_maxinsns4,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Very long jump",
@@ -4858,10 +4874,15 @@ static struct bpf_test tests[] =3D {
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
@@ -5632,7 +5653,7 @@ static struct bpf_prog *generate_filter(int which, in=
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
