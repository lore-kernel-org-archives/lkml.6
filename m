Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523243073-2-9971313412603824831
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
    1523243072; b=NTsCKtMxqgN/C46pMjQX1pjSAm7ViZksjISgc7Gak+rrEl5e+9
    9qV1rH5Ff46FOCXRr1Bgep3fRnk67Hsyv+Ch/9qUykcWE9OcK+2xkAGf12iuofk7
    x4a+tOztuu3ZVawuPnADVvKdPCP3tu6/iKS7e3Fftl83NA/BsXQv5U7m6baUxPX4
    aXvmcePnT7CpiRVspEdnixzyEAwAMTQ93IX/VybByEgChncKF6n5jl11cQpRHx0v
    c7IKn2LPYdSSQ8Kjv2Ku2QW/x7g4RU0Ud7taNsIk60OLm4ZQyNc9RvqDx9zS2T0b
    aMNwrzel/CSfAAmezutIMZyO8N04i+9yP5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243072; bh=UgfrCpcH81
    Pod6iodZz0qYzDWUS5Hzk1T8wXqBFyItg=; b=j8msN1ValnLhLu6G41lL8K9vFV
    aGL4AbyI+AKszFh6N6FrEK6yRzLt6WNF9/KjNgFKTRs6jkK4OQWrPeTb6BC4cthF
    Ooig+FbRUuEnYBo1IhEmOMgR5f/JlHgKjC16Ivd+FPJ5B/FkOyx5jQQvl2/YSZNb
    uN5l+1AbBC5ZhC8tR/Gp9MLpRqbPEdJ8U17JTrs+plG1RbcqyhKnLEUK9SuX98M6
    GSp4LAhXL3kMo+32p5N2xYmBvMGlJosI6PRYC2yakMXD4VaUdETdlR2Y6nfA2Ua3
    V57SbJEmfNSakQYoUbbTXWYucugFOJlRWEGFaC3I2qZqTZVFZGv3CD73IjFw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZKYF2vgo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZKYF2vgo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC8mjygl4C7sSZde6mF7RhsxTgL3pmSzXMmKLfG9D3X69ibs22tfnP65zVDAm3xNV6a/GYipBU6zcifbzcVyEqegr0FSm31GP32e/yQPL0LVm9SO+b3d
    V9KowszUkD9XsmbfMFyCvbzpav9dcvdR9YlOwGyC/22uwAiT9yyRhsSVSiM8fthd9q2/Pqh4A5fpzI7ef5LqhZFHwFj+XN6HCiFNeJxftE49eg6MOiGGD0DV
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8
    a=oGMlB6cnAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=WPyIoOwQAAAA:8
    a=jIQo8A4GAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=hzj1nXxdle4KTAAxqCMA:9
    a=pXx8G1reow-gFZz4:21 a=bRviJrUD4RDb5aqL:21 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=4LA4qAFo6bo561LpWNDU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=S-HzPIwwDS8t1QcwSuWs:22
    a=Lf5xNeLK5dgiOs8hzIjU:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755076AbeDIAYv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:24:51 -0400
Received: from mail-sn1nam02on0128.outbound.protection.outlook.com ([104.47.36.128]:23328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932107AbeDIAYo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Daney <david.daney@cavium.com>,
        David Miller <davem@davemloft.net>,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Nitin Gupta <nitin.m.gupta@oracle.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 101/161] asm-generic: provide
 generic_pmdp_establish()
Thread-Topic: [PATCH AUTOSEL for 4.14 101/161] asm-generic: provide
 generic_pmdp_establish()
Thread-Index: AQHTz5irbW9ba6ZUvEGFamGTXqeKNA==
Date: Mon, 9 Apr 2018 00:21:13 +0000
Message-ID: <20180409001936.162706-101-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:ej0j+q9FrCtrQatlbYMNXCz9vQPia7KiI58fMNpzHdOzybZS7D8RX8Cqwa2hliOqdpgmeQ89iCCVUFVce+10XH7YDDn8kyVGtb3qUuhXU5KOhGIpPjhu6FF+/jLXD3ZcXPiD/WhEfv0qgarYivSM7M/C6LaAUvRC1VyyXH0wj6y3KkvHWO+mxAThUQKnSKqv+0fDeCOaMSEAYaEogpWkP/wX7cRA8Pm5ww692RWdEBrznpWEIXu/q+0L97+gLYK7;20:+i/ZPMs6lgfIJm921NZdWlIx6i5MYufO5rvN2RTvklovl5P90czeaTKjcVu1zrdfa21AQ6Ozx5mR13aizdnRgWv/ictMA4IS81UlNz1ucnIrBrjXPrnJRw3W83aDK3N7fLPSzXDhmqfVsR6+N8+aUOoJZ656Qu7nEUKl0OEuZ+E=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4cc2fb2c-7697-4ef7-313a-08d59db04a15
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983E9F826BC3CFE08235E70FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(20558992708506)(89211679590171)(190383065149520)(211936372134217)(42068640409301)(153496737603132)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(575784001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(7416002)(10090500001)(6486002)(107886003)(36756003)(4326008)(966005)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6306002)(6512007)(26005)(14454004)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jCXP4icKNRJQimvsFR26G2ORZn6Z0tmxF5IsQH4NFn4t4LBjaOBa+c+LKIZ6844OO2og9DpN5iENr+iuFgAQCPXb9WC70/0XFAS3NXDzIVcLA9ZDI05khM7VIF1QGHXkFPEF02jXR6X9ONoOKZGuprkLy5MWCA8aZrstaxZ7f6ajyViljAb5Vp9JZhG/60TWcfIOQTQQdA3F4NptFQwLwMjN0f81/FibHvBpCztklSz2d+jDFO1Iyx/KO6LgeZcQe9zWM815Xl4bzuN3OpGURD5CYEM7jSiI+L+26BKzYK2fktYjYaBUAKwcNUecqKqRDJMZ/3uabU/JuRZuc39bFeD2blVuiF3yB+oJIyzepI823siTIxXvOuJU/i4wBA6ew4lbcjtnpVHnGveRJk9mSXjb8clrDuSlb6ahlGvMcX8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc2fb2c-7697-4ef7-313a-08d59db04a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:13.8156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

[ Upstream commit c58f0bb77ed8bf93dfdde762b01cb67eebbdfc29 ]

Patch series "Do not lose dirty bit on THP pages", v4.

Vlastimil noted that pmdp_invalidate() is not atomic and we can lose
dirty and access bits if CPU sets them after pmdp dereference, but
before set_pmd_at().

The bug can lead to data loss, but the race window is tiny and I haven't
seen any reports that suggested that it happens in reality.  So I don't
think it worth sending it to stable.

Unfortunately, there's no way to address the issue in a generic way.  We
need to fix all architectures that support THP one-by-one.

All architectures that have THP supported have to provide atomic
pmdp_invalidate() that returns previous value.

If generic implementation of pmdp_invalidate() is used, architecture
needs to provide atomic pmdp_estabish().

pmdp_estabish() is not used out-side generic implementation of
pmdp_invalidate() so far, but I think this can change in the future.

This patch (of 12):

This is an implementation of pmdp_establish() that is only suitable for
an architecture that doesn't have hardware dirty/accessed bits.  In this
case we can't race with CPU which sets these bits and non-atomic
approach is fine.

Link: http://lkml.kernel.org/r/20171213105756.69879-2-kirill.shutemov@linux=
.intel.com
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Daney <david.daney@cavium.com>
Cc: David Miller <davem@davemloft.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/asm-generic/pgtable.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 77b891a8f191..2142bceaeb75 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -309,6 +309,21 @@ extern void pgtable_trans_huge_deposit(struct mm_struc=
t *mm, pmd_t *pmdp,
 extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *=
pmdp);
 #endif
=20
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/*
+ * This is an implementation of pmdp_establish() that is only suitable for=
 an
+ * architecture that doesn't have hardware dirty/accessed bits. In this ca=
se we
+ * can't race with CPU which sets these bits and non-atomic aproach is fin=
e.
+ */
+static inline pmd_t generic_pmdp_establish(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t old_pmd =3D *pmdp;
+	set_pmd_at(vma->vm_mm, address, pmdp, pmd);
+	return old_pmd;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
 extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long addr=
ess,
 			    pmd_t *pmdp);
--=20
2.15.1
