Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234220-2-11760674891652090765
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234220; b=RnYZREF5yjer8CGBPtTs4pcyiw0z6a7WLRE18Zh9wqENyAcHyA
    izLt/8hJ4VG2DNnzRwp/hlJM0byCDF456fFAUUNkvc2LMDEvdqUi9zoYLxZqnXu/
    NY+ElQJvRVHs8vDtt8WLthYKD6InmLsWN0IZHm10soSh9FeUgXYTIfYc2KjhKMNA
    pXGDe2L14idASdYxKE4SrVG9TCufbSf8zDJJSBKpmXxjd/tIw7eqzZoMfIsugXka
    CeCBtrS2/sMTiMoZSSF9q7mvl0qyEgHCPi/DO7/XTVeQM50G1t7odj75Jjca5cbe
    8X8O+IjxNI3epGwgHag1T0oV4ScWBQ/ml8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234220; bh=ys872/B69u
    TbolxfIuU4mmtiX5KsHZJsyIs9I3ggGCw=; b=acXZuSQqndAo1VT34bmwSl/5za
    eeIdfg2A9aCmFo5GUENsttEBO1ZId6L/0S33jTKJjDdRH6s5av6MtOVFGzvgRRjX
    dO1LPThu3zDa4zNJo3ITrRgvAS8yOA8tKkcj/t+XPVGVztpZRfFnBs2+2arLFj+T
    dVSIPxJrQM05M0gyhf8gRAjvzMorGDytRzWDMIeVtG6ARakeTnJmwmE1LGSGpRyu
    ZSPDxcW46FvNFcTv+c6N32kR8VsQl1/3ZIAH9YmHK275E3vMai7vNfmdDFzfYFHS
    9OStdThT1+1zWppUFTzPMZ8getr9GY9VXOkX1hurez9PGJSXO4N+VSWgXilA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h16zL0Rl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h16zL0Rl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP9TnXdmjimB04cKrltGft5q0YXiHhMH+jj1lsTPHElHul3fLksx7WAXA2l3If4TCfmJoZvWbpB8mE2B+2jEOyGcOHCGXizOeQvUqzhHgU+EOsIbLl5N
    3F/gDITVEB5qZCwo7n+458YnKVBi3LrSKqhustlq0GkafdPKslWCeWKa3ddjdWjF1IROK3BAMAu4hLcmpHv9OK6ES709PDV5fSCzKSOJTr65qzimThNSJtRP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=NmvBBtLJq5dQsfxwa00A:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932676AbeDIAgv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:36:51 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:39469
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932665AbeDIAgt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 064/162] arm64: ptrace: Fix VFP register
 dumping in compat coredumps
Thread-Topic: [PATCH AUTOSEL for 4.4 064/162] arm64: ptrace: Fix VFP register
 dumping in compat coredumps
Thread-Index: AQHTz5muW+y4xslqkke6D4XIhA6m+w==
Date: Mon, 9 Apr 2018 00:28:28 +0000
Message-ID: <20180409002738.163941-64-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:5hYA6rL4zuHrPKnYQ9F+yfEzOStqofsGAql8cfwBOsvXqvhisEgmnEQofcBATitLO1V0uu4RBqsiXJb1ux6M6gymAFcXYtSNLXKeP/MyXyDd1AeCSgc6Ldt6GYja7mxG+QCm9BO4MxIN8TeCalNAmJmBaV2QJEeKRysUUUeht0coN+azbwX+HYVxnWnVd5NXdiAbx4ShJyhyLgLB29hIqvKSatgjHHIXBVI+HX2jCdyeSWuM9TCzNqLmB5cKNO2K;20:AoNzqhKj3FiSe3RCymiL3lpZOEDWX3XiBHY2mNYkHfJSFM1ysMt0VQ1R5uuGSZp2FzKnAvuRe+QClTYMQch2fk8LOfvz6SG8tlRF/uFhiNlx8OBs5872m+2HsMTU4+ceZE62uogpaQpuGAcuyOlYkOis9CYDTnmyndxIMzSmW5k=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: acdb73aa-38e6-401d-8cfa-08d59db1f99e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885180B2509ABEB37584082FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(3846002)(6116002)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sLfM48Ndq1Km1LYT+tiATOzNPluRwGa1Dc+PSuTKWvLY8GOg28MV6JHxcFuE0sm0D/3hGDv1gAuOXXXJIdMHwvVI/keUQaeiM3kfD9vUGPKPeQGjgx47ArU6QlmxJEylVXp9/BWZWfGtAmw2BO9Udw0KRUvptcUZOiohkS9CU2XK5MH1ihaVru5VOkP/clW/vYtWdDBy57IMVNJgQ5Bnxmj2O+BjzQal1KP+/1DPZJCPNr5XdDepS+rKy+AVLryoVWj6W2rb5DCT+lgHrx9SAazXgIRru/fjyqEopB5X09vS/2YSekoUHmlAu7NUTyp/8sMZ5NAKzVnO9PtU1ahL/+6/4PeJMzvG7UuxzFYrTofYXXMjLzShsMQTVvdYwd9khmycKclqDPO5Shrn9hLhunumtbNMwBhgp2tiUlm4FX4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdb73aa-38e6-401d-8cfa-08d59db1f99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:28.9582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Martin <Dave.Martin@arm.com>

[ Upstream commit af66b2d88a76574d55e81d712292abd34beb6178 ]

Currently, VFP registers are omitted from coredumps for compat
processes, due to a bug in the REGSET_COMPAT_VFP regset
implementation.

compat_vfp_get() needs to transfer non-contiguous data from
thread_struct.fpsimd_state, and uses put_user() to handle the
offending trailing word (FPSCR).  This fails when copying to a
kernel address (i.e., kbuf && !ubuf), which is what happens when
dumping core.  As a result, the ELF coredump core code silently
omits the NT_ARM_VFP note from the dump.

It would be possible to work around this with additional special
case code for the put_user(), but since user_regset_copyout() is
explicitly designed to handle this scenario it is cleaner to port
the put_user() to a user_regset_copyout() call, which this patch
does.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kernel/ptrace.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 55909b2208cc..183f39384e4c 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -792,7 +792,7 @@ static int compat_vfp_get(struct task_struct *target,
 {
 	struct user_fpsimd_state *uregs;
 	compat_ulong_t fpscr;
-	int ret;
+	int ret, vregs_end_pos;
=20
 	uregs =3D &target->thread.fpsimd_state.user_fpsimd;
=20
@@ -800,13 +800,16 @@ static int compat_vfp_get(struct task_struct *target,
 	 * The VFP registers are packed into the fpsimd_state, so they all sit
 	 * nicely together for us. We just need to create the fpscr separately.
 	 */
-	ret =3D user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0,
-				  VFP_STATE_SIZE - sizeof(compat_ulong_t));
+	vregs_end_pos =3D VFP_STATE_SIZE - sizeof(compat_ulong_t);
+	ret =3D user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs,
+				  0, vregs_end_pos);
=20
 	if (count && !ret) {
 		fpscr =3D (uregs->fpsr & VFP_FPSCR_STAT_MASK) |
 			(uregs->fpcr & VFP_FPSCR_CTRL_MASK);
-		ret =3D put_user(fpscr, (compat_ulong_t *)ubuf);
+
+		ret =3D user_regset_copyout(&pos, &count, &kbuf, &ubuf, &fpscr,
+					  vregs_end_pos, VFP_STATE_SIZE);
 	}
=20
 	return ret;
--=20
2.15.1
