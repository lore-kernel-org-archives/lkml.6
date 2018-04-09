Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245379-2-1270548979335193090
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
    1523245379; b=ULVL/wNFRPUeKN7M9g8EbE54KDQrIN4IkolWaueAl/4q2/V6TY
    Bq1o+4ssAaHctOVvi2m7wxuXoDnY50HPiI1eviANNTpwYFBJiajDWDOXqvVz2LBB
    KbOOYD379sBRdjRwXQjMLR3wP4+caF0aZ8QsCD4QkzSk+QBkzh7wvdS5V0uFuAZP
    yu3W7fv3bhJaHQRuwrrvYWtBx6vSEV6qJd/a+PEb+LMWewVWD657y23/EJbA3Jbj
    UrCqPbdB52M601hBgcaZaQ5CSiTW/mhB/VqCv96UerycGTqkKt2ff/QeLQrUwuFl
    hYfVely4cG8BllWzuqgrdfnQXdwKma0TR6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245379; bh=D8Q5W03mgN
    ZuzBZTpOGSmyjkp8KsscGI7ISYH3ffmko=; b=DpbuaoAZpaLWeFYCzpBI1+hY4k
    9FpPfWqgI8LTA+a0c/+7nKu6qHuJ8woKGK2dOtgrLXas1iBBKS0DXq4kVe8CsWp5
    U0929VVwe+CuCkTH7huq156S0FS3pYfdD5cHzwqF3kswKeC9nsxEfxFF4zRo5xy3
    68MB/FiENCxXl3cvCS3RP214QzK+172OlnF/94TaAti/WknFYw9JeTmJRvS5fdxi
    2KDha9JBYIoEtpySFUT3MbRAWaM8dXflVfSygcefPMcPLJWvq74m5oWqxw46TEN0
    XrtXOE0jKQ7PjZthMEGHq0EAW/o6fghxtcdTeCjvYZ1TuT4ZRxY16Mf06tPw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GA/bzgqz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GA/bzgqz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKQT2NrBSQH1g/VnDd2zEIUV0p5U7O8CgNgbRZDHiW4nlcuHYgomB6WX+kYKP6CY72GaA1p51tJ5dUWBqModNj9A40ynmMm+IMN+ivXnyyrS19S5Cgp8
    7EQ1FFqJxbo0euoRSMM1rIR2brJyeSMM8TGaQwQGgjvofIsFoSXsZwaIGApLPjNUpBsq+Ks4lWhyPaGoPnQ13RnpqVbd/m+7b2GOoNqz/trIewqQswxnpv+O
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gPJu0pBYAAAA:8 a=WPyIoOwQAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=bXTVU1rvmwoYY_QPZfUA:9 a=wPNLvfGTeEIA:10
    a=AlIIF0cMT2hfDT4axODj:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeDIDml (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:42:41 -0400
Received: from mail-sn1nam01on0138.outbound.protection.outlook.com ([104.47.32.138]:56136
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754265AbeDIAUg (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 150/189] MIPS: Generic: Support GIC in EIC
 mode
Thread-Topic: [PATCH AUTOSEL for 4.15 150/189] MIPS: Generic: Support GIC in
 EIC mode
Thread-Index: AQHTz5hUwC6tf/p33kSe6T2vklBYLA==
Date: Mon, 9 Apr 2018 00:18:49 +0000
Message-ID: <20180409001637.162453-150-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:jFjNDB5vyvd8I6SANA7eD/Q02GiBixoJJc/3EGFj9IyHh4wOwNYgtOSTy8GmaAEd/0H0syeavU+JbMVztmU29BUEdEpiH4JuXMguC+qcK59O52DdRiyHeNNYPWFsK/o5u9Z7I8xWfvypbIuxHQOEo2EzGZzuabsPKjF6zzq85G/aJbODcHD9Ab8dL69qJSO070BnFiOhEISzQW+bC1wd+yYMgyy/kzutggE6n+y/UGV8RRyRGg2E72FFjsurpEv5;20:Eawla2eZlvuASHh4XVtpf4EDqtN1+3LqOKgVB1orK7zAhZOVfuJZijhXnaQ+SOpZgSjpQqYV7NjEzzX4th2kncSmhHT0iuuo+4psG8VqcdO6oJ2s0WGPDWYq6tyBN23eHpyBvhIThW0RZ6/HO70bLsbXqAYBJkDFAOsqu2w/h7A=
X-MS-Office365-Filtering-Correlation-Id: b3338b6b-23ba-4db7-7aa1-08d59dafb151
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09200844CB1D8C9C8041854CFBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(6306002)(5660300001)(478600001)(6436002)(105586002)(10290500003)(966005)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ntIDHqERxAIBmO9bSJUDUQORkPILXQo0fT7SAkImzBRwv4bTVMTLJJkdskQcpUegam7poe1yjz3td+7q2wTLMeSDXQgKWGIrp/+QAVabPF54ZJkL1eqrgeveanj3gI/nZj+cRdfoCFVetpJjhMd8JLF2FePu8nmJ0Ak8QGCLuiWQQz1kcZFWcuuatYqMqwgu0n0wFiyg+A2ZsY9wWpTtik0S3YMtBU8DKXrraCIUUGkgZzXqy6KgcF4MuQ6yIAg7NxEMa+/KwpbJC5EyPFjzt5AmPSJPTCqsc7y7AXLdsHXw4AFfLLrdry0OBDMONJ6LOMvtq+QS9xgXaFlntLMmM38V1qlxzlIFZcyM7xTmeYlhR1fW6vu2+WLvabXYJL+tdSZoqZE1OPMzvR+rBjDpQfw5x6jVqNtDwr0Lg9uOCkE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3338b6b-23ba-4db7-7aa1-08d59dafb151
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:49.2216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matt Redfearn <matt.redfearn@mips.com>

[ Upstream commit 7bf8b16d1b60419c865e423b907a05f413745b3e ]

The GIC supports running in External Interrupt Controller (EIC) mode,
and will signal this via cpu_has_veic if enabled in hardware. Currently
the generic kernel will panic if cpu_has_veic is set - but the GIC can
legitimately set this flag if either configured to boot in EIC mode, or
if the GIC driver enables this mode. Make the kernel not panic in this
case, and instead just check if the GIC is present. If so, use it's CPU
local interrupt routing functions. If an EIC is present, but it is not
the GIC, then the kernel does not know how to get the VIRQ for the CPU
local interrupts and should panic. Support for alternative EICs being
present is needed here for the generic kernel to support them.

Suggested-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18191/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/generic/irq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/generic/irq.c b/arch/mips/generic/irq.c
index 394f8161e462..cb7fdaeef426 100644
--- a/arch/mips/generic/irq.c
+++ b/arch/mips/generic/irq.c
@@ -22,10 +22,10 @@ int get_c0_fdc_int(void)
 {
 	int mips_cpu_fdc_irq;
=20
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_fdc_irq =3D gic_get_c0_fdc_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else if (cp0_fdc_irq >=3D 0)
 		mips_cpu_fdc_irq =3D MIPS_CPU_IRQ_BASE + cp0_fdc_irq;
 	else
@@ -38,10 +38,10 @@ int get_c0_perfcount_int(void)
 {
 	int mips_cpu_perf_irq;
=20
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_perf_irq =3D gic_get_c0_perfcount_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else if (cp0_perfcount_irq >=3D 0)
 		mips_cpu_perf_irq =3D MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 	else
@@ -54,10 +54,10 @@ unsigned int get_c0_compare_int(void)
 {
 	int mips_cpu_timer_irq;
=20
-	if (cpu_has_veic)
-		panic("Unimplemented!");
-	else if (mips_gic_present())
+	if (mips_gic_present())
 		mips_cpu_timer_irq =3D gic_get_c0_compare_int();
+	else if (cpu_has_veic)
+		panic("Unimplemented!");
 	else
 		mips_cpu_timer_irq =3D MIPS_CPU_IRQ_BASE + cp0_compare_irq;
=20
--=20
2.15.1
