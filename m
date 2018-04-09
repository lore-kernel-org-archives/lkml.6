Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234272-5-15727263757239542849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234271; b=sKIsAV4nsgxjVDp8uXTBPlLwCmaBCIGuZ8ULHw/0KvKNZWl2CI
    oOp0icOsCfd/7XfMXIf+Mnfu26x0HNNeH8P1FDI9jRk+6JLq0O/HRJ0OMbd3jFm3
    VZ4sqb7P4o4QhsDO2QQai9FebFH0QDFRB3o7ZSsTkdifnQUFCj5CH1O1CyvfSR1+
    oMQllb52ZMkBD/OtyOwPtRS1ggv3xQRyF/Wz1vKhpp1dxM2Cj3bIdsvzm26w8pjW
    6ZcsBVkzt61JQTmJ0ruVElw1GEtVJjYAthHoKdZB4XZynemaExz0axcS0v67BfAX
    wIE3uBWWGMBiZObeoJHVd0PCm8lqoWtBWzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234271; bh=JHtEn1VXtQ
    +Z13mENNLagRXSk7uqP2t6QvvXoK3MZIE=; b=J/F4MaCoUWWbYEeU22kEFvtJFQ
    n9Dw0xEyDCmU2pHjU6StPyKpBqifqRWuT/u2wxts94Fe5/N8Nimht4DJj7u0nkIW
    qhct0U2PtTTJcHtzoDX9HVHIZcS8Rx4O92CJdzXtWmVQ/lkgJMZPIogTiTYB8VwA
    jCSjo3RvgahgjE6Yxm35K/wuI2V4Q9lLLns3+eVpi+EAmoz8et16YWd6/MDLl7VZ
    rDXSm8DtQxqTdeI7qWqnrB06PG/d+fpuUN+7ZBvdRCMJyl9971WwJTCMyXXnKCd4
    3Fcw36FEAQsttL9nka3Nd2623cV2hk1wsA30spl05MJ10Cg1hBnbmsJWwgVA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=npT9xW7D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=npT9xW7D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDmK0TZd6JFGyxlIZddtP9NN907B+OCSpeZCY2fQszCbvWLhJ/1bvjuJsJgiYHrb7/xUDQnsUxSBZMcNqCPthfvmOkDB/CUJL/H7Ibg5TQPii/uRDNd4
    jfj+9nXb5udXY81Hjwofp2/z1CavSzDLMSVoY7ulCzc0N7idtjOqKlvc3MDYCXu94HKPu+4JS5MiwBoo8jenMMArNCiiyn4GcOGgX3xV0hw+VM1JkcBPSebu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=NKXwnzS0rD8pIqZ-gkgA:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932821AbeDIAhp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:37:45 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:3040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754315AbeDIAhk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 091/162] arm64: ptrace: Fix incorrect
 get_user() use in compat_vfp_set()
Thread-Topic: [PATCH AUTOSEL for 4.4 091/162] arm64: ptrace: Fix incorrect
 get_user() use in compat_vfp_set()
Thread-Index: AQHTz5m7WV/WP7Q+FEy1WfSfCQyAmw==
Date: Mon, 9 Apr 2018 00:28:50 +0000
Message-ID: <20180409002738.163941-91-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:LbvF8G003+ZAKzSE9bl8BZcBHK/inbHKMht26wiNfEjOZ8S/poBdrT/J/gsMuze8XDbPbuG6EEHjVgRDrkrPtygjkWIlDENjpwxVptX+Sp3fHR4gzpuBc3YoSGWexYyGyc5BNubjqUZ9ElMZ/fQHoeQTQsEHSTgcM4zvxpq0T3cQy+XB8cgWZ6PD/5LBPLNJn2WIXUrEmNdvDL628amnhOYwMJtKFmd2/NOo3l9qry9B6cVIfUfZYKkn16PAvpGB;20:T51gm/VqXrSqX+nQWOZwA+G9GG84IrVZGT8rhPLJOglVelZYMGIOlemV1NX5wvYlATGJQhk5u/a53vGNkKdIUD0lWqFzdBUjgLVd5n7P/EQj2E0hCATtpIgbn3HEF64Mm77aljZSF3qpqMTDkXBsmYCDrWqIBrdtye0oWykGct0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: be7a7a8b-41bb-4c1d-ade3-08d59db218a6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10319DBAE102FBA21F2A1E75FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: rMEpHUP6az/HMJuM3hv4ZBB+JqN4e1sFt5daxnleEcMIJfg0O2GXwkMujTpr11WTQfjbSx1M9cFJ70zFaRKaFVv1iSU4rWMPSTvoprgcgs/8vaOJ2724CNZpQDg7E7S1wjgPFIIpFQy5jc1aTO1MS8KdPLlgqq60hvlygHHasSkeYgq0bjaKENpfIVqblw/IDofHory7c8f4DoapR3sPX1eDmJjoh8Xt7FwFuC5yq5RfCHB609oqWZbclCwNGBjVwD8XZj/1prAPweraPFdJuPn9YPBCIyBvXpDXqmxalJpQMNl6KlMHX7Ynhg5OhPz6SHvjELgIPH4fpvcSNUloyFAG3uKpRq0Kqn1kQZA+UL5rebY0uhWmALEgWbTc0SwCiMjhfnEUye7vgkRqFjOnEB2gXA7bJCJBwarxfUqHXcY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7a7a8b-41bb-4c1d-ade3-08d59db218a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:50.8646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index b81fa63bc834..f67bb64d2640 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -822,18 +822,20 @@ static int compat_vfp_set(struct task_struct *target,
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
