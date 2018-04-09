Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235306-2-7439377942394226699
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
    1523235305; b=ncuRU13xMy0+rCujAGiHKzubq6XZ8OpX9CcyaHbtVCfNV9CQOz
    pUCnkWBDr7ByWsVsRBnJ+qylcbBO6thTImRFiJg7PIO+TDNFoZxratyslXon811F
    DGzwENmnuEJY06AYh5kPuCQB4jYgtLF8xY/wDUEOhnZimH2Bng+gvOC0FT7ngGsn
    FbMHoPQtigUliRElMNHOZ7XrXJo98ei4atMZepXlEjx24rMv8dXqmTVb+JBVc2hg
    ibMN4Hb4y/G0hysRfh84lT2Ai5dY9fk9OA9HsbMYg1E+oWN8TysLdWUfA/52tqvJ
    8FDrTQminYitM+y6SiNj2mbROdbycZBMudsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235305; bh=4Ne8w0HRkx
    Crw/E0Gr3V4zpFdUfGCZ3W0mP1640jD0k=; b=b09nsLCcBoI9Ny9ur8nEsrRDb4
    DhcM6yjrUFr+BkTV7v+ipt3ArXkj6kQzpAdGJhVoqOxItKUiJXH9C1VJ76ywTVvp
    H1tvDqe5KjDJsgov9iJWkUe94Ia4ef88nisCw9VD1KVPemJRlbzPkGzS9xar/Qwp
    +pFBSr+LjML350rWD43dN3IzGu0Pl3dwUXvgeAYD7ktll8Z+cauF2l7KZFX+Q6GX
    JqKfCfv58WL4iy9diJxxoGLCXVbwX8AaYM8+ie4RCFnw9R2FcqhyJw8nCma59efi
    gXzoVaVDWsMUzdSZKJXrVCi32+XqpLK9Dru7g4Q2fY4Q62kegcDHebucAxrg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E8BSGSoQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E8BSGSoQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFGNfhoPgGEzcaTMFX61s49xsmEZT3MNm16gjLKb+GfkFcfyQ81sllcJL9dp0d+23LdhZERuUwh6R9ZIWMiFthp1iLt45gKz6V3sDb0E8wV31inwuiBR
    GKsbFL3I3rwM0V4fno3CbiKSvcw//5Q9Qm9i+SaJivyyT7LlIlD/d1XWZ5AC4SYR2J4dmE2ftnEZbFkjofk1j4qYPuY3tQXwZ6K6VlPdUD67bfCTRakzEvRa
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=NmvBBtLJq5dQsfxwa00A:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932946AbeDIAk1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:40:27 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:64040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932553AbeDIAkY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 043/101] arm64: ptrace: Fix VFP register
 dumping in compat coredumps
Thread-Topic: [PATCH AUTOSEL for 3.18 043/101] arm64: ptrace: Fix VFP register
 dumping in compat coredumps
Thread-Index: AQHTz5q3zd9FJXLC+0+g/ZQSfV0hyQ==
Date: Mon, 9 Apr 2018 00:35:53 +0000
Message-ID: <20180409003505.164715-43-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:Q7OIQOQK4EJ1uwvU5VSR9qCjG5vsI6yYWoRa6o9qvgGNOW3dLLTLI0CaNCLtv43rFcmIiKkeAyNVsj6nLSlMGJ30JnnhGetHPzn4Pf1Q2KFnzOxYkQXq0ax0c++ZRSxvrHhvlFw5KhjJfNIAPeUaMpSwo2TsWTCuzmTk6znueb+He8KXpPkej/pLCHcavCWESA1Soc1E2I9QMs7yvzHnEcmRw/mpHAHiPIE20JK55GWiqPuBzZ4GhXRFe9jUnTOi;20:wWuUNdx0BmiuVpTAUEb6MWsPclt3NJ/3A8TIVtVaduS8sDYxGUGZVf53Jyfw2t4JyRFgYpFF7x0X1GMLpnzyvMvt72ISze/hnQPwKtH8UB7iayebC7k44sbjbrjDL97H/a9h4tZPwd6NqwXKiJnsfWSRXDKmKVph3PHHhEOWe6w=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13f97a45-3757-466e-e08b-08d59db279dc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08703827CB91D8A5AB80749CFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(486006)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zNZeEzhxdMEKEWH4JPoLhArxQxA4vP0BMBYkavwR9GPD7c1nlsdYefu+CPo+04ijl5uuLW2C7L8qlznf+QnIwFueMxcfmzZfHhCU/1cj/U+A6nT43kvHYxHbY/zyzDU/5qVdQu5/1zFR6Slt2HaE0U5HX/09dLSK8LLW9/718DxUTh9YtQX8g3r+Dj0YTyDM9ZsfTz/n1EzOI6c2L90mSIGZVNu+NWo2jRzhe/7RKQ5gKXqL1vO48zW3eGcJngZ3sORXUWniSXb7upWHYoWgk9u7XskonA/82hW+IND13Dcy30Kli4c0Cro0Mg0cS4oLPA6vVyPxQRyhdPUeCf5MJPBt9I++jQRbWnjGxmpe7aeB25wdHpasKwXZjPuSAGWlryhyogaRr8hicwC87pdO/1sD8UYw6Pi8uOsjc31UwFs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f97a45-3757-466e-e08b-08d59db279dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:53.5172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
index 8a4ae8e73213..2e845f5c8ab2 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -743,7 +743,7 @@ static int compat_vfp_get(struct task_struct *target,
 {
 	struct user_fpsimd_state *uregs;
 	compat_ulong_t fpscr;
-	int ret;
+	int ret, vregs_end_pos;
=20
 	uregs =3D &target->thread.fpsimd_state.user_fpsimd;
=20
@@ -751,13 +751,16 @@ static int compat_vfp_get(struct task_struct *target,
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
