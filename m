Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235134-2-14184162750975577214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235133; b=tEr/Xx38fLhI9/0FphvRO08k9hqbO62FrxykMyrNZAbQXqk2sG
    +ZO36PKhvmmfrreRGWbVVkZloZRfg+BoipJ8d+sxgdv7LCYQlw9z0AWIAUU/44Pj
    lmJGYZ1mMWhhfXTc1Z1mOqUvh00SFdI4eaNHqSxIm1PFGco+MrLYovDNIhzqGbJL
    xa0HispyME1G0DlXdtfzK+Wti5dgM0U0WSwIL0+hcsLaiiHe1GNlK0/vpdqxaK0q
    Wa0/bZJp7Mn5DUw3m6rlaN29uMLBqeMufb7jsWUyuswrL6JJ6erQL4ZoSHkTI9V7
    i+AhJrj3YUR9Lzs11IlbIskE3dDKo4QqWxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235133; bh=BgwKqsIqJG
    ecRKRGEBmF9M9WRCggHe6V7WuP2Q5IKeI=; b=sJwBjC7lhiLqcTrobEicgBOlTM
    kBXXviU+JiR2vxQjhJ69VJ0dl4/QSWcfqeWeErAGR7JqHea4+8sYmCVGbMKJC7Oq
    jtzCiyDjJQISXlepH55ywMf7L7d4gpTSq+g9QVj+embMV5h/Vgw9tz3AZyP+Oxbf
    MtL68qMhBKF8Pd76sZ4HMi/ouyodEkuN524FdsijLw9/jDN/j6cS803RpjruhBgW
    sxEZgCbA2C+r1NjtlIFlynHJEM9oCcLOXVerBcr6OzQCXfOA4hBApY4O/wNtBbcR
    jFKfk6T0yPEBkGPC/I+oTmiZmEhcYRtZb1/GqPWN+1WlXvdF4+YeuJmICkxg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cFICULwU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cFICULwU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEgz66pxoqDm6WF/Tg+TvaSx1Wnm8JV5ycJaRHKMmYRO5eVG0qswwgxwBXv98P1dABDvQ5GCVp3tl+cVyUt8s+FX3k++VN4HFACGaoFRc0us6EEKe/Bn
    AuS4dz3QXFsl+OYOPtlCtrzP9mpfJXaLdpoRSRKVVOPqoBLTeUDXnfdDKQpZPrdynjoPrWoBkgxQZxK5PrxhibMlWHZPKShplVFUvPfbdzH/qbgNSK/FOQvT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=NKXwnzS0rD8pIqZ-gkgA:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeDIAv7 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:51:59 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933422AbeDIAlZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 058/101] arm64: ptrace: Fix incorrect
 get_user() use in compat_vfp_set()
Thread-Topic: [PATCH AUTOSEL for 3.18 058/101] arm64: ptrace: Fix incorrect
 get_user() use in compat_vfp_set()
Thread-Index: AQHTz5t76SMipjwJD06/p8CgFw5LkQ==
Date: Mon, 9 Apr 2018 00:41:21 +0000
Message-ID: <20180409004042.164920-8-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:IJl0u/Uad2xt7YORKRidEez8XxADphwY0xOHqiQhNq9VROuxwAs9M/AvgOn1EEnUK7xy0AJevheJMaIQnk+0osWUv+NAyWpUZmEGV2edCMwubi0ucv+otKvZetZu9JxrJEcaYP4escLGCNmnKKKh360ofVM5xmMouv0FEWqs1VU2Q7tAw54PIipaIpsrmy/Z6et179j8DuAKCWZLNG5QNa2INSpr8azLRxLU4NJNlMDlIpXXD45eVsW6tHCEEY76;20:iYbKYprTzNU1UjDMrjFGk9vttS3gmQKCpfJd3zrjMi8z2Bb58W5r98DdYwkd/OaDkJp9NctYfPQK5OISFq1Ml1sH1rDfE89WRBOVFcf7eUBiUnrQpuQGo0uG+eLooYEtqU5vLefjmK1XGH5a3QtURyvDZd2QuTfVC5HhL4PiKeM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfc7e61a-cf02-402c-5fa2-08d59db29e55
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09017BD9048B532DE5E19C45FBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8lmh23VToYA7hEfRZntqjVA/dNV0QPVD5WT4JF71kYZwKA1aMWJZNliKyzY1iGt+CwuMutOMXs7kFNmwgz/tAp00wW20UiToNpbq3ROcMuGJWXN4cPSLcZuPRUYgl3zW4nefFHnajINi4quXxEfy9Af1KD72ud1hA+f3AbTZgNNXOpNQz+0oftetHUl+6NvSFxDZ7EISjplzFLO8pkftKaVRGQhSvH/E1Yiw99Zt5a+PuUyDvTcSIt5jLBe8MTW0B6Ifqxi4P/d5dtBDkr7rjdQuuIp5vqMMD4cUsl456OkCGPpu7zzIoBNmpYXUA9vc6kaMq9dG2P6Mk4o4FZi7DE/UWh0Eg7ryhPb1yaRhOxN1YOeAKPpMRYAyWZBQUpe3+s1wWCXRkYzdO6de+gsKYTCE79fi/glakwxmH81aIoI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc7e61a-cf02-402c-5fa2-08d59db29e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:21.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Martin <Dave.Martin@arm.com>

[ Upstream commit 5fbd5fc49fc39ac8433da62d16682a1d0217ea4f ]

Now that compat_vfp_get() uses the regset API to copy the FPSCR
value out to userspace, compat_vfp_set() looks inconsistent.  In
particular, compat_vfp_set() will fail if called with kbuf !=3D NULL
&& ubuf =3D=3D NULL (which is valid usage according to the regset API).

This patch fixes compat_vfp_set() to use user_regset_copyin(),
similarly to compat_vfp_get().

This also squashes a sparse warning triggered by the cast that
drops __user when calling get_user().

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kernel/ptrace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index a12eb17e7985..01defb4527f4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -773,18 +773,20 @@ static int compat_vfp_set(struct task_struct *target,
 {
 	struct user_fpsimd_state *uregs;
 	compat_ulong_t fpscr;
-	int ret;
+	int ret, vregs_end_pos;
=20
 	if (pos + count > VFP_STATE_SIZE)
 		return -EIO;
=20
 	uregs =3D &target->thread.fpsimd_state.user_fpsimd;
=20
+	vregs_end_pos =3D VFP_STATE_SIZE - sizeof(compat_ulong_t);
 	ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, uregs, 0,
-				 VFP_STATE_SIZE - sizeof(compat_ulong_t));
+				 vregs_end_pos);
=20
 	if (count && !ret) {
-		ret =3D get_user(fpscr, (compat_ulong_t *)ubuf);
+		ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fpscr,
+					 vregs_end_pos, VFP_STATE_SIZE);
 		if (!ret) {
 			uregs->fpsr =3D fpscr & VFP_FPSCR_STAT_MASK;
 			uregs->fpcr =3D fpscr & VFP_FPSCR_CTRL_MASK;
--=20
2.15.1
