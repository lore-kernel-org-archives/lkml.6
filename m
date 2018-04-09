Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246510-2-3832990084554083478
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
    1523246510; b=f15OUJF4CfI/8+UkdfWVUAHmKFTmmCvGbLrwgHAJRGWM5beM/S
    wf1z3KahBPpXO53HHQEtnuEUv4Z5DgfLKPQTxtl4vkXHfuZh8jDziKoA0IWK3zoX
    igkyi+0EetA8sGKOJLD77hvdGJ3O23sEzSnaRojHewCe+1X8y5t3ZG5d5lfPSP1f
    +j9FITTrageck2isp5Pm6oWErliIY6RR7oMVws8w7pnHhcU1dXdXy6Fc7YnFJ5Ac
    2rJoA+1O6cBLcmYIli9HSoLiTBHKcVUL2Z38YScwyaNW5rDehcK9ke/Lj5eufGtB
    RoJPklwJ/oSG1v+s6vqKBs2k/HZHXVtkIpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246510; bh=55g3CtRwTR
    TxkO1SFI12hC8jjFV8xX4m1Tys/Aa5Vhc=; b=EAJNh46WqQvN7qnT/1Q2T8ZNo6
    5G+dx1ZO+qnJO2P7NMEC2oM14JO7GP+G3T0G4tjp90/xR0oi9ztJKR7KpBfRvi43
    R07V8d4UkyEv+aGjO+FJwGNOtSTcM+loImZfmYtey9/yxJ+qK8NsZ1Pn3xVbyeS0
    FpgtYQ6NSqKf8QGvm4Cr9MI/IkLa0Yoi3lxqXeXGy9Jfv+zGUEyqrQTrrvW8/PZE
    POwk/UQhtnyGxGIiJDZJ9/Ryd5qIkRDUjxPxZ/Y/j/DvfQDmRoPliQPFceOpLI2l
    LTweey1n5WJMBnBJerwu2ioo3m1qZkyPL0VWQZdokr5qrtmqrt6tD10qfqkA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J2aHbb3v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J2aHbb3v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKvWiZ6lJTYrgUajeVN47+0HTTvE+2Y8dlf25KLe+0zoKKGNzfpjIh/92WyOzOnPiE1rEFeOh9oH75JPKSgGckGedZzorel/EEiKKcFqRZZDrLpoVQ5U
    5U6Ng9ca6B2FrFZ+fA3Fue8NubeMZyd4KhEMMxRXU7KeyWk0F6hcN2pSN1hRoSZ9wbQs7i3pQqWghSKCLRmAKR1bLCBzz9qQGB+vKgIbAUizxVdWu0/f+xPy
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=G4e22ONjEbAcsDgq7yUA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeDIEBo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:01:44 -0400
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:43410
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753399AbeDIASJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Gustavo Romero <gromero@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 057/189] powerpc/tm: Fix endianness flip on
 trap
Thread-Topic: [PATCH AUTOSEL for 4.15 057/189] powerpc/tm: Fix endianness flip
 on trap
Thread-Index: AQHTz5gmvlbKkkVfE0CUHTfuM7QNIA==
Date: Mon, 9 Apr 2018 00:17:30 +0000
Message-ID: <20180409001637.162453-57-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:3IkQP4oeCiwXpKibZIYT5bTG7dxcre7S50DWUtTxQ5lhHKU8HN6Yk63dKN6ynB2wYn7ACsRSpEJkKBlKjQMPsGEVPvz2feDa7q5J5hAjAT9B472fcY5LokQDl/f2fL83CWpGKicji2sK6YYRDReyQjGEppNSRwCWQzhyGuznoBpEdSXXn5rLyp46194YQlPAXECiojNt3WnCv6+o8YstVWXMAw15ZcseAsxQjSTkCZEjJ1qSyTpIYvTm3FbisegM;20:Ga2zKcr2Ih6HgaPJMcA4Ww2Au6/VZb5VdV7Ds03JtcNZ+6LAWyVdXYOKl9lsqzrbvEhUC6gxLLN5hz/c5SuPNxEuHIJRUmSCyAp4P8vKBZPXnFDhz2zKzS7JeIKATdnc3GqMyed7Hz9e5IBlaufrTl3DjYYvHqIeauBtTMBsgr0=
X-MS-Office365-Filtering-Correlation-Id: 7892cb1c-ca87-4ee9-4de2-08d59daf57a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046B993B0E14A8EC54B7E22FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(551934003)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001)(357404004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fc/Ll1u/0G/KRRVzBVWvhxoshYjGSN31rOfmAme8BjWIJvTotghj2KykETTyZeOshW5CHLY2Vatqia1yVS1r+S0x2WvJZb/idGZhGrxtDDRRUnl6VzML6lp5jUFlknKUyfgUXovROTjK5PZcJHWreGFhA1mY8+O5Z4ur8+fbgzkLDzUl0ObO56Av0sU7K/Fret4/CCyCee4rbIRnVrdLCTJ3MY6c+CqfrPt0sIzli8PMP5pTPkRwKBa+1JU7m7AR4iOe0uKiOWXBNojExR7LnhclevglRAk8vw0RyKA4F0QYedwGsREfYmG7hauuklW0L+yiMdtdQgXqQIWON5FWDgMMB18kKQXs2YQyzLWG91iOWwxT+hyRLhTzkJirz6XUKZblqKFrADCmQhlThcoR2IST2Gp7Xnpt9thwGstOE1Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7892cb1c-ca87-4ee9-4de2-08d59daf57a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:30.6656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gustavo Romero <gromero@linux.vnet.ibm.com>

[ Upstream commit 1c200e63d055ec0125e44a5e386b9b78aada7eb3 ]

Currently it's possible that a thread on PPC64 LE has its endianness
flipped inadvertently to Big-Endian resulting in a crash once the process
is back from the signal handler.

If giveup_all() is called when regs->msr has the bits MSR.FP and MSR.VEC
disabled (and hence MSR.VSX disabled too) it returns without calling
check_if_tm_restore_required() which copies regs->msr to ckpt_regs->msr if
the process caught a signal whilst in transactional mode. Then once in
setup_tm_sigcontexts() MSR from ckpt_regs.msr is used, but since
check_if_tm_restore_required() was not called previuosly, gp_regs[PT_MSR]
gets a copy of invalid MSR bits as MSR in ckpt_regs was not updated from
regs->msr and so is zeroed. Later when leaving the signal handler once in
sys_rt_sigreturn() the TS bits of gp_regs[PT_MSR] are checked to determine
if restore_tm_sigcontexts() must be called to pull in the correct MSR state
into the user context. Because TS bits are zeroed
restore_tm_sigcontexts() is never called and MSR restored from the user
context on returning from the signal handler has the MSR.LE (the endianness
bit) forced to zero (Big-Endian). That leads, for instance, to 'nop' being
treated as an illegal instruction in the following sequence:

	tbegin.
	beq	1f
	trap
	tend.
1:	nop

on PPC64 LE machines and the process dies just after returning from the
signal handler.

PPC64 BE is also affected but in a subtle way since forcing Big-Endian on
a BE machine does not change the endianness.

This commit fixes the issue described above by ensuring that once in
setup_tm_sigcontexts() the MSR used is from regs->msr instead of from
ckpt_regs->msr and by ensuring that we pull in only the MSR.FP, MSR.VEC,
and MSR.VSX bits from ckpt_regs->msr.

The fix was tested both on LE and BE machines and no regression regarding
the powerpc/tm selftests was observed.

Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/signal_64.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_6=
4.c
index 4b9ca3570344..b1b9962db3dd 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -207,7 +207,7 @@ static long setup_tm_sigcontexts(struct sigcontext __us=
er *sc,
 	elf_vrreg_t __user *tm_v_regs =3D sigcontext_vmx_regs(tm_sc);
 #endif
 	struct pt_regs *regs =3D tsk->thread.regs;
-	unsigned long msr =3D tsk->thread.ckpt_regs.msr;
+	unsigned long msr =3D tsk->thread.regs->msr;
 	long err =3D 0;
=20
 	BUG_ON(tsk !=3D current);
@@ -216,6 +216,12 @@ static long setup_tm_sigcontexts(struct sigcontext __u=
ser *sc,
=20
 	WARN_ON(tm_suspend_disabled);
=20
+	/* Restore checkpointed FP, VEC, and VSX bits from ckpt_regs as
+	 * it contains the correct FP, VEC, VSX state after we treclaimed
+	 * the transaction and giveup_all() was called on reclaiming.
+	 */
+	msr |=3D tsk->thread.ckpt_regs.msr & (MSR_FP | MSR_VEC | MSR_VSX);
+
 	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
 	 * just indicates to userland that we were doing a transaction, but we
 	 * don't want to return in transactional state.  This also ensures
--=20
2.15.1
