Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236091-2-4019356682850391932
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236091; b=Qa7oNTLbKcK4ku8eZcb1taiGOJagRkZDQhC7+gIHKeqS0O07u1
    WiU7bP2cjcD23Q0DnjK34fJpJ3hYsZqcST5Mz2F7QjH3kV1LXUceCE1f+zUv33VW
    Wy30tvbR4RfutJSRGVi3DW9urOBZWoOe5okUhzvcKoHJhOU763vIFyy8ZfYoCPlh
    /YyZGI3P16ssSW3d6v7TmBn5A2tue6/+X2Rm9YwzxDy3l1RkahIsFc5AraKpqklO
    x8WXYWfsc0OaIGzxMc2dn5CxsMAQXW1mfdwU+/u2SMYxFdcHw4Q3UmGdIAIu354q
    fSj7KvxtLI6Ed7l8AlIAjDCs7qZZid2eKDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236091; bh=68tkhRq7+r
    8q/18tY5nTGVF0xUH6VD/UZVfjAtUY2SA=; b=l4Q+RSEqC6iONITurGxJhTWKMY
    qtmZYngBdVq5/E4LwWCrqi8ZmhCHaqWUlt9nxcofTdO7WmJcuetSwU/sMhM4ju1W
    UGuJ5BHNicfCcvdfePDqA7PlExBTyLK4McEdoABXOAm5bRsdvzIzaROALUDJMmhA
    VRIHebjtFFUdmLQxApuyP1Afm0UFHmaLBLrMtZuHRpyNboPIjxNKehQtmEIFbD1s
    54NwhulxmtzukPqYH3eTUmVSj7RsnBcIFXknqX6eYmUCx/DIM1G+ArUuYnTSagqB
    PeEWaG7X6liatvFaDZJrQpHYVvM6b0PjLBahUgaKO1kq0E2lsJYPYanNjZVQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PNTZHC21 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PNTZHC21 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHm5E+X3p+mKilKgEL0rzwFEOzlZhljDoe0TD5iGSWLIkZc7v3cILqpXrnOBumRq2mss/mm36YDWwIMdktWdQWXFPbMulSLCvo3KYBoZc6g/L8S9fP2z
    Ya3+H4cGwf/eTycGtdtNbr7f4TtX3UmAOqZoCJom4jIPVN8VpSGYZGnx/emhCe4WmnpL8LE4coWo7GOxXdYogmjVgCimlTMYUe0X7SV+PjCq/FxBktEFC4bO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=FOH2dFAWAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=sadFhfGTjmPsfTvmsL4A:9 a=wPNLvfGTeEIA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756281AbeDIBHz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:07:55 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:64416
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933052AbeDIAiw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 147/162] bpf: fix selftests/bpf test_kmod.sh
 failure when CONFIG_BPF_JIT_ALWAYS_ON=y
Thread-Topic: [PATCH AUTOSEL for 4.4 147/162] bpf: fix selftests/bpf
 test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y
Thread-Index: AQHTz5nbADQHHJZsG0GMuXtP5nQcOw==
Date: Mon, 9 Apr 2018 00:29:44 +0000
Message-ID: <20180409002738.163941-147-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:1ktKjLhWjh33y3c7yrMUJk9T6WX9FrRQffTDX449VNhkZ5RO9TkKNNQOMzie13pTVi/2/ZJGsAt/6PiaGp+AficEHqHeI9ExDq6jTLHlhbrkbBGKBXFTecC7Vj7+fNSJNFT2KIMOARl5ubOIArLwRh7k6DGh2rH+LWTQE0zH+MLug9hkuCFE4yMxxDVM85rc88HaAzsgOnLfK/21GAIginRwdc3pKQ3RbGowCj0eCuyM20Xubi+wsFRO3MUi6rTf;20:NAjf2eQi1pNXtiZfR1hO1oARbuC+NO/SoSC5v38rGaoLI8Aek8WAL56dqWBs+R28ce2jGQlHPjR9+awp5vvCtp0U0Qd0Srh3ow5pmd2dc66LnCjASmsAr/JY6Z3aEQ2LjnjFKWysppdqTSiacUYQ5jqRpiL6vDXQKY9MuT0bM5M=
X-MS-Office365-Filtering-Correlation-Id: ad359415-0ccd-404c-b32a-08d59db240d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11255249E84F1B1E9F1F1A12FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(265634631926514)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jg0affQSWy+IFaC73YUQ5uafb6mfwhLTteWa6uFI2nQxGeTrOD91hcKXXEb2ZFeMLmvYc0iGTNT/8fxTLcWjSlaW6fBGD0EHWpkEtUs1ZwCN8sFZ7eN/kI/w6m2CRCRN8RhyxZTqwQti2CSKPnvwa3DPpVRv1t7ym/+YKb7XEOGRaCrAhArZmN3jUdfQj6zxl67tNOzcC0fbDbO/Ww5uD7PQZUs6gE61JZsWFMxB9FqjKst7SfcTBdupBXlbQXudYdj+vPw0pQjaaao7T07lVO3JfQ5X3Q2EbIK1Oja/dDpdaERSpQ/mfxiNtjV1O/CIBD8k6G+rPzl9bL57PBdW0qm5A34S3cT6e001blZ7VEYrdNy7u2+bmF+wKdR3t2XUH+qVFhfQJswVLmNlO3hOujKcsyrF5SM1AoQVqCN1lk8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad359415-0ccd-404c-b32a-08d59db240d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:44.5370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index b7908d949a5f..b1495f586f29 100644
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
@@ -1780,7 +1781,9 @@ static struct bpf_test tests[] =3D {
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
@@ -1790,7 +1793,9 @@ static struct bpf_test tests[] =3D {
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
@@ -1801,7 +1806,9 @@ static struct bpf_test tests[] =3D {
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
@@ -1811,7 +1818,9 @@ static struct bpf_test tests[] =3D {
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
@@ -1903,6 +1912,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{
 		"check: LDX + RET X",
@@ -1913,6 +1924,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"M[]: alt STX + LDX",
@@ -2087,6 +2100,8 @@ static struct bpf_test tests[] =3D {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper =3D NULL,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Passes checker but fails during runtime. */
 		"LD [SKF_AD_OFF-1]",
@@ -4462,6 +4477,7 @@ static struct bpf_test tests[] =3D {
 		{ },
 		{ },
 		.fill_helper =3D bpf_fill_maxinsns4,
+		.expected_errcode =3D -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Very long jump",
@@ -4517,10 +4533,15 @@ static struct bpf_test tests[] =3D {
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
@@ -5290,7 +5311,7 @@ static struct bpf_prog *generate_filter(int which, in=
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
