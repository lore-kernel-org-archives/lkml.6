Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239521-2-12655169162900735926
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
    1523239520; b=I1/ENTXkmgaXp2PHLzr++xYokDaWzSENZhurCbLrgnXrM/R7U7
    go24fV/R5ixyVq1yOvcgYFQybIUQMwcKvT2daqNqDxTNa+/QURN1wVHfq4Dp0DGe
    gMPevmU8FWK0lR0AZYc2GUY0yEefjkTkwuFt+3KwFD0t1/IQ0STmwxOHZk5TRwW7
    +qGOIk+jrz2TTq6aWbDrmLyN62emmklYnmGF0p8Tf3ySb8eyFOr/lom8FOG4KuGA
    YFxs6NHtx+Y/bmc1+j7NSEuS/1wnuj/f6V++KcO9LkCE7tfQ4qTOJz2Vr1iqcMXD
    FM3J8L4VKlzreQb3OChW4MKD22MFiN4L94WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239520; bh=iQBo9/vsT4
    aZyQUNnFacVw/d1auuVqzWtzB1jcIxMdw=; b=nP1F2dK/u7SrToN4LFqDldsgQn
    aESsXHAIE7L2Cy0wlGHm67zHxzqsHGjTo3p5nhGoCtQ1nlvDSQqWgAnYryg4rhxd
    u4lrUqMQ8ujAopKI5/p3ptCyEGpzHFUlCePBcdnnBOuHCeqDDVUKeokaeavli4gG
    u5GyH4paS5tMmu572r5CkQEy9ucfiNJp8m0wNkpm3LKSfqwD6W42fag86pl3QSid
    PnSL+OrY52r/3G1/wVbxRvDXJ5co2ZguHwWYqDRqkJjV5ZIghvkMoPxoQOch54+s
    ciS6su4I/47qRJobpNv8BpUSlqpqZGfd1UMG/pgSirxP0xPvSFtAqYti+V1Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OoRori0Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OoRori0Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP01arVLB6wIbXam1ZwuVUq0aTvlZ0LDxu56XQw2U4qBpIfURHYrPIIuxPkey5TS/wjkq3Nj6Gm0U+2jN/GNHgRaPPvRsS590O6tuL8shpu9s6EM9WS3
    gakzqvtoaRDcLZEKcUUyDgj4ub0yx2dzxY3Y/SvwcMARbr5uGnpbK8BF2xmrRJBDndiGkjQ6ZUybIQ8AuDUpU1z0L4hzWZ02B8J+kj99WDb2vKg+gT0pKbD7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=NKXwnzS0rD8pIqZ-gkgA:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756374AbeDIAcA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:00 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:32931
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755747AbeDIAb4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 181/293] arm64: ptrace: Fix incorrect
 get_user() use in compat_vfp_set()
Thread-Topic: [PATCH AUTOSEL for 4.9 181/293] arm64: ptrace: Fix incorrect
 get_user() use in compat_vfp_set()
Thread-Index: AQHTz5k7Z0BmFY1nCkq/ubGLmB0ZXg==
Date: Mon, 9 Apr 2018 00:25:16 +0000
Message-ID: <20180409002239.163177-181-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:egZn9GEsHFoCYijPM+/T1gHJDzJJLuO53BARHXunUvrHMjsMrNSrcX3hb7lXeVbKoz4zv8q6PQojR0/uq7foaU+8TdpZKE7vjmVGnHq7IaK212uQilzAZfMZtLNpSiKDrkGjAjZyTdNp77xVnQC3bgpoupXzFnHl1EiFBHHqnpB+9JwS4of0Qhvqo5N/nrwcGhT8fTpvsPjdgkufZm84YZVAfVcARLe6sXXlkOUXcFcTBD5awuj9OYB4CLAme4fO;20:QI7Ye1NX23+qM6vSBOJajoTtCi4Vv6ik0xn6ASRqchKRzY6s5t+8PzQe5t1r1q3v3boVjnRf3lVIIehqjZ9bzFqdvUw8Ut6aaF1eThTai6fZ0jd/fSmafcAwOWmmYw+QOVZgG5wUXzp1sT8O7mk+pCLLyvlgSnoAbXaYW3VvAyQ=
X-MS-Office365-Filtering-Correlation-Id: b3069525-2f30-40ad-ab9a-08d59db14b9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1126234D8DA0C3E0A8B70839FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4e1SRd7zI+O08P/9pHEU+NCJSjdBlJ8V6wPXeii50EESGjuudTdMr7GvgTZMzchYRhWFA2p4qmaFWU1nxQ3ib8b/0J8o2fqviMktiAuNxE0VXTWF13+RGpAVy2s8RxFYBvoWg0rpEXEqsqiKIJqZ/d6eTwqm2Iy0zdhXnoqCZycxv5lprcqNR45H4JlC4C7whZmts3wnDhY2qCNlHnHw0RAGl5twkaOG1KSuJVhI0qscr1jyTsdYGSVkKbQx5eMW87gzhs3kYHS1VAunGNyMJwRsER3mjXv348KEmnGZoCn7f6ZqerAZSg8hCdZ2KcVII5Pp7PzZiCqGe/33gOR1Qtv9+qyg+DEDivG+PN/+C5tvQaLLGfhhXe2vUwpsYl4hSpT0CC4GmwL22MGVE1OlepesNyN4Eo9lxTgp2hUTSlY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3069525-2f30-40ad-ab9a-08d59db14b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:16.0189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
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
index cca95e75aaeb..df1addf104f5 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -926,18 +926,20 @@ static int compat_vfp_set(struct task_struct *target,
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
