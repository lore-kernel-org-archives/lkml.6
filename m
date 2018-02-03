Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517680998-2-2261571740152444952
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517680997; b=VYqEu1a4wtJqBNt1qwba+OmeGBbiheuCwAjPZKjgCIJd4ms
    4d7VNOfgIqDNY905Wr+04FdbunE6nkwJutmtimGXzIYc664uPUEUdRt0GufnTutv
    asuElKszFGgu8IY70RPsWC3PXl9InLu+lbwzyFEm1ZGNwdmXa+kErd+gH0gfYF9f
    ugZcNH2gAGX8zPTdNfIims4MKvO2+lXbp1F3kQRM8NJB7NTRYuoQpIEkx3mKjTDZ
    4R1Zjj3gZYGhJk8GuxechVO3W3ikC+CerHJZ38EDuQEJ3/HSMd0ULmwa6P6zOrk7
    LFCvVtkqvyPEvvQ9+8Z53JBwmlW27k/JcwvMjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680997; bh=nW56Zw
    0WGJuxGSKYErT+nmR5kRrinS8LBFLtoppAY0I=; b=FVoh57kixoub+3JczrqyZ3
    4BKSG5ynVTmizQmMWLfKE6yH3H9S19prq5UEr6adxLv8sJypuMgQeMhIwWl7nHDF
    yoQ6wSSQEN0JcbBrht6YgbCstBLbOwRkCUpAaEMCOh7x5dyHQVdruU+G/p8VQg6/
    /3YU41Y0F4KUWXegQiPXX77ypioQoeXE+Fes2G8O7DeBJZ8E7hnhBpsd08UJnAwV
    ZAIEjA4lKeKt6qmyIqGgLBrsPKhNLyJURN9qfwbYSCtNeMIFV6cKRIrgqYSggw1N
    frEwoOmMnX9kfGjnhtTvvryXLswyPfuzK2v2twtgScrtIeLEBHAD1D9/Ozy1fxjw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mxBjnHsM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mxBjnHsM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeBCSDO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:03:14 -0500
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:35168
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753039AbeBCSCJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jan Beulich <JBeulich@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 032/110] x86-64/Xen: eliminate W+X mappings
Thread-Topic: [PATCH AUTOSEL for 4.14 032/110] x86-64/Xen: eliminate W+X
 mappings
Thread-Index: AQHTnRjpq3Cg5KBExUigs8UY8U2g1w==
Date: Sat, 3 Feb 2018 18:00:44 +0000
Message-ID: <20180203180015.29073-32-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;7:uhSuGwJf1wHxclZfrstrJ/4pio4NPG7m98YdgNa50+IXVzAhJ3kph5Sy1s4goLP+V4R8BermfFAHSnWWPJm8fj0bLP2PdwyjysueSjAFOq5yMhai8xJb3CQB9iy4O8k4IQX3uKDJ4PiYu6JkppKzd1gFjyA/jNoSTkYrHKOPX5bqfboTquHrrhwPJNjXXH1hfiNnWdb+aHcjQy1B7bbPJ8HJTJe8ZP+sUaKc1myiZDTqqMl3rZ+JjoDkZCXcuhoO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b720456-d4ab-4683-3a2f-08d56b301ec2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB1090B0FDEDE736FE0071ECB3FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(575784001)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 6esIjxau7OUFiyBgclvea39jVe2r1YuX6Ua1gtjEyC68xWwqLrChkwKEH3KI8zFlJPNyGwWF6T3mJKPhL+K8mQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b720456-d4ab-4683-3a2f-08d56b301ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:44.0971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jan Beulich <JBeulich@suse.com>

[ Upstream commit 2cc42bac1c795f75fcc062b95c6ca7ac1b84d5d8 ]

A few thousand such pages are usually left around due to the re-use of
L1 tables having been provided by the hypervisor (Dom0) or tool stack
(DomU). Set NX in the direct map variant, which needs to be done in L2
due to the dual use of the re-used L1s.

For x86_configure_nx() to actually do what it is supposed to do, call
get_cpu_cap() first. This was broken by commit 4763ed4d45 ("x86, mm:
Clean up and simplify NX enablement") when switching away from the
direct EFER read.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/xen/enlighten_pv.c |  3 +++
 arch/x86/xen/mmu_pv.c       | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 899a22a02e95..f896c2975545 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -88,6 +88,8 @@
 #include "multicalls.h"
 #include "pmu.h"
=20
+#include "../kernel/cpu/cpu.h" /* get_cpu_cap() */
+
 void *xen_initial_gdt;
=20
 static int xen_cpu_up_prepare_pv(unsigned int cpu);
@@ -1257,6 +1259,7 @@ asmlinkage __visible void __init xen_start_kernel(voi=
d)
 	__userpte_alloc_gfp &=3D ~__GFP_HIGHMEM;
=20
 	/* Work out if we support NX */
+	get_cpu_cap(&boot_cpu_data);
 	x86_configure_nx();
=20
 	/* Get mfn list */
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index a0e2b8c6e5c7..44950ef57c10 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1902,6 +1902,18 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, u=
nsigned long max_pfn)
 	/* Graft it onto L4[511][510] */
 	copy_page(level2_kernel_pgt, l2);
=20
+	/*
+	 * Zap execute permission from the ident map. Due to the sharing of
+	 * L1 entries we need to do this in the L2.
+	 */
+	if (__supported_pte_mask & _PAGE_NX) {
+		for (i =3D 0; i < PTRS_PER_PMD; ++i) {
+			if (pmd_none(level2_ident_pgt[i]))
+				continue;
+			level2_ident_pgt[i] =3D pmd_set_flags(level2_ident_pgt[i], _PAGE_NX);
+		}
+	}
+
 	/* Copy the initial P->M table mappings if necessary. */
 	i =3D pgd_index(xen_start_info->mfn_list);
 	if (i && i < pgd_index(__START_KERNEL_map))
--=20
2.11.0
