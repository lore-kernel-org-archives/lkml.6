Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234740-2-10021674831182048827
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
    1523234739; b=qq7r7+oylvMxkscqmBogkzd4JNPhPO9aTfVKotF0fQvOB/uBoJ
    P1DsUvifIwtl5NJNYmr7oeSvnphkm6ZqpL+B073yc+Zx/s2OzD6WlyAu0AlKsLt8
    SAQ+Uvf/VPy6bDRQbjoNHh4tUEavpqFp3MBOXEjrB6YRHBqpr1uanUcQJmuc7fYE
    8tld/GR/YCcgvMbSavOoMGWhi3Uc6xAgrkRoSB/n6WwC3rKX0ns0428ymiYr08yp
    c5htH0dEBXgG/8Rmwku7xyKXvFgr3fU/+lEWIvBcmzSRxt3Kd00KlLHkO24v2ZwR
    u6T7skUrqaEeyqMi3VUMM82sEZ8Ul7eZD8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234739; bh=b3eY0P8DhY
    7iJhgRJiBcEfCBvsiv5hb12k5fUHqEWSk=; b=flgx4lhQq3x9L9/lqa/MdDMGxG
    kU/3grNKPA1qQQ37AdLhRJCnwTeQ8Vi6mKWxpPZmPk7DyDS6Bo1yrIv3eY74eIJn
    kpb07w156NhY8vPSniYJeB9ibEVcggzUXzcxueUFus0jmYEMDjjbk1sGGhGVYrqf
    /yqmD4An9j4CbXjZAP+vN0Ap6Evepkd8Of6lCqawYjvmcdBd/CT27rkQyiEURqub
    R+RkDJlwpKSIGg1Fs98kRzrVU0PseLTs8fuaYasTSY0x3dOIBu4ZNG5d9ggkpOh9
    Fw63q3VenfSFviIM+ffo7vr+XL/ZVADNhEBsRW2Qv4C3uTA+ELsL+yj3htww==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IH+/EaqQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IH+/EaqQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGYjwAwja0a+3zpCl2sVapFBLWlFsJmesOkHcgbRmFVbLg1bRCFAu0jLm2iVNAMKUHl78M+9/z5HAByh4Z1VmFcdkfyTPdT6MUfAR2UxEVpeWpIpolNJ
    7siW07jlR6moWfVqSym/OwMAifvq9GFhRJASRZakeaD42I3WtIh4SLIxhr67Laoe/VyoMxi9mv7JQArzkhC89Yq9+f96Qh6Fkf8dMaz+f9RwGI+Fk4oiYWFU
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1753575AbeDIAm0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:42:26 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:32283
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753392AbeDIAmV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:21 -0400
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
Subject: [PATCH AUTOSEL for 3.18 086/101] asm-generic: provide
 generic_pmdp_establish()
Thread-Topic: [PATCH AUTOSEL for 3.18 086/101] asm-generic: provide
 generic_pmdp_establish()
Thread-Index: AQHTz5uItHHU7Tvp7UiH2lAUhDod6w==
Date: Mon, 9 Apr 2018 00:41:44 +0000
Message-ID: <20180409004042.164920-36-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:FErgCJEn9YEPgZKdJrX1GXGcaFZZp9nUz9gE52B1A8Z1rOGhgacs74Pp4XvVEDq+4SWHiKvifCbqghgE8rA2ru/btZyiD2ZzLt08ntxTq3K6s4+4KEbWrrEptMWaW1R+lgvdJpJZfJ2GCy56dJSzRsLbQhB96d4XFxgpTf3cs2Z8KQ/uISYhfpoOPelJvBdYtm3y1Fr/2zkaSLuhlvhkaFS/ZcOZa5IGlLIqUcu4xKubLWHeXlZNUPVDoWvN4IIc;20:Xi/iheddKAUcOXwGggze4NfrPeViwEqf3lC+1sgnup6qP0hu906SUg1NY3qm7bNA7cJXhiCg4ep67JfWXr8TDFrbMb7IBelz/ajGi+IeRRYPva9JL5x4QS4FG75ZtivKdj9GSUiMkkC+1xQeXmpFGAeFTW1xoR6WuQJRHiP+G9A=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24f74432-3888-4749-1cbe-08d59db2bd7a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062DC3E2CE4B7C51B912E37FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(20558992708506)(89211679590171)(190383065149520)(211936372134217)(42068640409301)(153496737603132)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(6306002)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(7416002)(6116002)(575784001)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(966005)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 200eUb/DnBJUcoJJ/dhu4hNGko+hYBBo2gaxZ8+gYs0IseBihztn98fyNFnQQmP/b2me89UaZ0htsV9FiJAH9py0QyeWk+KsbcbwU+6GNcbFs73uQjme/tVyNMOFeMZSJrkdiCPTqSX+In0QjitfkT7hjkzU8jrVHTSdQH4veuzvzTbt85zic8+R7b+7uJE+xRfnU9M0ebYYSblI9JjfhL3seevbhIrXvxR1CJgJMPPg1hP0Bdd78k4NLP2B3BjXJ7n6G2Pt8wuCXfnEYpkdhxfsYWv9rNUQ2YzNNf6H+UqExhGyUgYo1DRWiUp5CUb+vDcJR5VkNZQoHVuQBVTqRZNf73fx6Pfgt8ZCEqzBebkCaUTowbuLerrW2OiUt6yD+JhBbbJUT7a5lqrGW58LhJT6aG5hs9NHEvaaX5bMXV8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f74432-3888-4749-1cbe-08d59db2bd7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:44.8616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
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
index 752e30d63904..d33fdaee5523 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -181,6 +181,21 @@ extern void pgtable_trans_huge_deposit(struct mm_struc=
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
