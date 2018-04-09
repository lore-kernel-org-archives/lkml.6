Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233822-2-1261415629480434034
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
    1523233822; b=J0vd6Jpr9mFIr6PLnf++dxXDQbD4nzfZiW6YuqvQaME7Cm47iS
    yOct8FeHrQSkieKQpubg4mp6Qu17Q3DI12k1EnH88zFMb5NX5Zqeh34qOwU4Vw2u
    kPGRkZgwXHp/zlPM0/DSfZT7d0ZLY7P+c3SFQ9NM91nbd13p1kOzZ9PUSlftXx5o
    LMQIBaMgkZ8mgkOu/afve9JaWE2FfmgB5Txx5x7k/7kJiXn0TXmpSghzplTh5Vyi
    +ogjdNe5cbm9ygu76bK4C9/Ebvz4iEbfJGuPf06pAmM2UdYd95HAfAO1UdSKXCF3
    7tuWStspSBqNssMyXNvld9OjGiEK9fjzwCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233822; bh=2EGIMksSo+
    7vcZSA5cIcSDECJNIfWsRxKy3I4+8n9Ks=; b=rhF8y2yOX34fZbAdf+XsGSbMSQ
    0QvCrQqrql1agaSGzPg0sKzH79KVVgBBtD7VgOg3shqRtN/m+2W1EqO2JAdeX0g3
    dOsQiS7D95ZrTPBvy+JFLogkT6AUkxqvaY0EBNjsRtmm2E//++kUrrwp27ZY9zPq
    sl2iO92+OvH2rbOXCQruysVGGe3Bvqc8Iq4jicMUnVmRBjAOUpCD7MLv1ETJGev7
    joD8sqUmhG8G9urJ2CEEPxiVDp5xZsxGJtQUIygpJEMUa3z/vHwKsCS25JlDrixk
    xaGKKVRIyL5S7RivmUJNTc9iP4BaGamKT2r0Exm5pNM11PBG/z+SvpEBsqVg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WyTt+Z1W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WyTt+Z1W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC+MZKmUq5SbPuzRzJC51+FHMbXFnEpxg0Iez8Sp3cO2M4yj3rM8TCE7FdSrZmCaQYqFyDw7ymlKW7kHqjQFRQ/ZMJSuEo0VjB+Pt+kAtMpdJq1le2hp
    MyhmhXaEOtBM2TpexVglDywDzJuzMd08iUXROe/fqNiEMu0IdEiQvHaAaZKs+TkdoM2Am8p7zdBaea9W6disLRrDYQp+3dzHKGSOrhlpJxR6UzK9DWFsDurm
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=NmvBBtLJq5dQsfxwa00A:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755137AbeDIAaS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:18 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753157AbeDIAaQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 121/293] arm64: ptrace: Fix VFP register
 dumping in compat coredumps
Thread-Topic: [PATCH AUTOSEL for 4.9 121/293] arm64: ptrace: Fix VFP register
 dumping in compat coredumps
Thread-Index: AQHTz5kekh3e+yDfDUiAdhGxujLg3Q==
Date: Mon, 9 Apr 2018 00:24:27 +0000
Message-ID: <20180409002239.163177-121-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:+cMFxhihnrSPpcWG6TIHCCsC0S8VLcPq0GppIuiPukgJp3V2DHrhbTOrjHBXb4HpULpU8oCTC6gJYSS81B1I3hWqw+V4O3RyoVirM5B/IN01jkCdeJcNDt4hkin0lGYdtuTHi9QlGTWqkhswuocQNd8PjU4UP1dcMBnLBP4+5RVy/HtAuvIDudt9DSxfZMGZmZgWZO+wREq5Xgwp/yl2K+ab0JWWjqRRsNJtST2GvmZXYGHsymMPULc0pGPc3H6g;20:ezUVueUuh1x8grdHfTVD/v1y6AlMHvUbiLnb4W0xKQ5BMjp9NI/BChfgKa0Gy3iAwUXZm/mGYG+9/ckAMVFMlMTgk+KGCuUYRNZ1t8oH2WrYw8qpNTbM4gfB7u2u5MUUKQ3tgC/5NiuvGgvqtEoB7O6nsPls8dABaxX4ulMtbr8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69e26b49-fbae-4c22-0fec-08d59db10f97
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032917C5CC43F8985DD1D04FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(3280700002)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kADEPeQYF3xCrXDacJkGaoXvo5yLyhClXdis4JPuWrrN1GdRrch90VDSgZlzobxpzemfPjvFRTSKK/Y2oI9hIIWhLPcD6MowcsQuvlFb8at/PtjkVk70D9Wl7rnD7DXV8TgkRbfoglkKSa7aBDH6PfBka0BlmclQbv6ucrs+EsFDWwvXMiXAfKQUFVXOZvxb8VHkYQl+zb0eTsK9Zow4rot0FZ/JLNcJiMiiANX0k05EBr+WWI/SxH03JM/vu+TA4a/dmCTrkcALNBw9+25YctSI8c9a81NeQRzSRwbiqpApG1w5xcVZtlKe037pgrpqM0l6Vfg8aUYDcNw96m/UqMGCvjAALrMZnvyKb8Vtm0dVWYVmI1xxi5R3wakyqt53ttVia4SF/XbxxwYYEMlsKvcDTbyms/0WhMc+av7uDSI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e26b49-fbae-4c22-0fec-08d59db10f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:27.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
index d1fd560b3a2a..5c78b64369cf 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -896,7 +896,7 @@ static int compat_vfp_get(struct task_struct *target,
 {
 	struct user_fpsimd_state *uregs;
 	compat_ulong_t fpscr;
-	int ret;
+	int ret, vregs_end_pos;
=20
 	uregs =3D &target->thread.fpsimd_state.user_fpsimd;
=20
@@ -904,13 +904,16 @@ static int compat_vfp_get(struct task_struct *target,
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
