Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239888-2-13823415751637695569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239888; b=XJtvgUKew1kqKmDuzbeR9RXF5A3L+sfslzLvsRR9LXt8pvo/JB
    L3P5qoJLSMX+x0CwYwPBexSlpVDCpd1VcSmFk94fhAM78oHjtzeiUDGsuKx1eVwT
    h2D0z+rquZoCWs3K7YMttSzFMbiWFKHUvgIb3hgKUjKZ7okg5AT//z4iimh7VQq9
    nMDxCiqk7IoFeQKuT1Zz/POxtRTK6+AygQ7UPNQkZsu55vBn/gJ1HmLa25MpX+vs
    pdA8Tl/ME4ftb5ZlIOQv+MoPSEe2s/qe1/TuaMTKS4p859ZrSsFiGED2Sk+4J32r
    v++NO/lHwOU2zaMg4XwcJ7ZCwOCBInfjkPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239888; bh=akIE3DNCbC
    isK8ypbCrSNwHe7ZYNZox2PsqVVSVwZY4=; b=H+V/iLGiX1Ku2YvW4vAc1cu1pH
    HRW95jGaZNTd89bfezvWLnUWx4lr3ZHkzlI6yls2jYkILSOynj68Xx1O95zKj7Uq
    XY7OWZhKuS2NyX3udWLXUZ2Kw+S2htvNgo8ys1KQxRU7qYNFL3OACTQ1UrAmWrSQ
    mo/X+yGbTQO05t9ss0P2Z2mE3Wkl+rAjWZ+j3mIascIJ4IXaZZn0ey8eYf08Vs8j
    a1MD8k4BEn81MICYzPfeEhYwBXCBiCnIC25uDFHI4cvfDXx/kzOcN6RwqWk3VZB8
    a7XjqmPPwp9I6wKmTzTUoqxXQtkP80M6kbzKUE7K+PrAUxHREBWhW228kT3A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RBWA7M6m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RBWA7M6m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJAmcv5LVPQhzN9qYxgg007r8s1J/Yb2oW9Se+WuAcbzlNu2iby92aagOf/ktf7L4I6C/T1Y+EYF3EuQHPq4DPZ0HefwC9CCh4Tmm7oBoc+OsdYFPDDP
    YdTIdHRcG3a+JyZFH4/IrOkvU0UQP3WTLkNOAc8N3v1ah/0R7suxHZWt8MTunOEsS+9Bf6Vc9dWD4SK124cVPEUfyfq5hPcu/inu0uEHB3AqHuKltXAufuDj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zAyngx5bAAAA:8 a=VwQbUJbxAAAA:8 a=hWMQpYRtAAAA:8
    a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8 a=alu17TBV0nYOAdpRZVwA:9
    a=wPNLvfGTeEIA:10 a=4LA4qAFo6bo561LpWNDU:22 a=AjGcO6oz07-iQ99wixmX:22
    a=KCsI-UfzjElwHeZNREa_:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757926AbeDICK4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:10:56 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756209AbeDIAbO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 160/293] MIPS: Give __secure_computing()
 access to syscall arguments.
Thread-Topic: [PATCH AUTOSEL for 4.9 160/293] MIPS: Give __secure_computing()
 access to syscall arguments.
Thread-Index: AQHTz5kw90QkbJtP7EiDzyohS4co6Q==
Date: Mon, 9 Apr 2018 00:24:58 +0000
Message-ID: <20180409002239.163177-160-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:/+Yi4XP4VgaZBRdcCIAFdErbQT5p9zNR6Zpsk8YKxsjAIayStHje3HDyaZcUEqOEFUxEIS9GXMyjV8/qTIdhJg4o6mO7iYs9mdkU/S8AucR0rXVTWLOLhqQjcyl4ZTys0d+WroZX8FeN+JF0D0FDzfhs5t6VEzzAkjXtSspBlvYVsooU0vYD29trLmhmneHHYMrxQftOZpuPj4PG5Ui3GiUqbwx1EqimBtrARmba3zD0ueNuBHLI3hdBZecpcwSO;20:q8NccyA9g5QlU1cT6qx71k2AXRgK7f78zkzTYpiMyH7fMN7iIfLWcanIo6NMVli0AU7s92zoZCUkMRgs9e8chVT5xuyo5ADr2pG5lsQzT4Zkui0QUxSdWIvzHPcJ9yezVJ843gNfuF0yVINU0btfnggiK7ipZWOl8ZI4E45WyEs=
X-MS-Office365-Filtering-Correlation-Id: a4f90c6b-f992-4ac8-7b35-08d59db13205
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917FAE53FF2EDCF02C8A292FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: l7R997OkgbQEl4UQl7Ro9U5+0SArx81lOssqy9vqN4pP2zH+3BxJAKdkgJFWzHpyGcyvh0dVYmFDGoTNgOEsmRHdRD0766tvty2GfraOiQ7Jp1rJxCe5/XB1MxMeknFVrAHOeqxu/1Egq0oInwUicS4SSkrkkX3TDnAoFWF7Fau4RM3aUqSHU854WhrtlC/nb33uHxSSrr6oBDzOOFOj/ODBOjle6Sb4NJlbdF45Lu8kYzbPMeoh/NaxMmsG87OY4yNRLdAZxEhrLuqkTx3gyPY0KiJYFuz0mzYQudupcx5iBx9uBlx2iSh1rr9a5jV/K5t9CjYGd8enpCLVbNGYK5JjZyS6gjoP891h57qjZiTx/bNzrUKQH7ezFFEGvkfC52ueZEI2EGPwOVZjkc2wltPL3J4wHyfk7mGAWMBiAiY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f90c6b-f992-4ac8-7b35-08d59db13205
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:58.1126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

[ Upstream commit 669c4092225f0ed5df12ebee654581b558a5e3ed ]

KProbes of __seccomp_filter() are not very useful without access to
the syscall arguments.

Do what x86 does, and populate a struct seccomp_data to be passed to
__secure_computing().  This allows samples/bpf/tracex5 to extract a
sensible trace.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16368/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/ptrace.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 0c8ae2cc6380..956dae7e6a69 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1011,8 +1011,26 @@ asmlinkage long syscall_trace_enter(struct pt_regs *=
regs, long syscall)
 	    tracehook_report_syscall_entry(regs))
 		return -1;
=20
-	if (secure_computing(NULL) =3D=3D -1)
-		return -1;
+#ifdef CONFIG_SECCOMP
+	if (unlikely(test_thread_flag(TIF_SECCOMP))) {
+		int ret, i;
+		struct seccomp_data sd;
+
+		sd.nr =3D syscall;
+		sd.arch =3D syscall_get_arch();
+		for (i =3D 0; i < 6; i++) {
+			unsigned long v, r;
+
+			r =3D mips_get_syscall_arg(&v, current, regs, i);
+			sd.args[i] =3D r ? 0 : v;
+		}
+		sd.instruction_pointer =3D KSTK_EIP(current);
+
+		ret =3D __secure_computing(&sd);
+		if (ret =3D=3D -1)
+			return ret;
+	}
+#endif
=20
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
--=20
2.15.1
