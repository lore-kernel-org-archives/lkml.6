Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245689-2-14293487563651706972
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
    1523245688; b=wUGSPQ3VCSzwv5pEu9JLDX6JabGWN1+pFftq3kX7N+DKgXhA8K
    T8xApZiDlFjNQtEGo0kNFTKiLoWg6qzHDaqitNJyWp+naFhc0PTTKh4irJO2hGEe
    X7gAIV5iyiCozuKDO/8RnA1P8SGEUZ0Uusec+d6NaQdFaaEKFKd36wlaiXo/ZO9w
    gi4lBeirjy6kBxH5Bhxwynu3EkdZ42MJkOPmUEhum328PjNIArqY+FcELwpfd25s
    kkWvFDEllivIz9LATv5Nm7wSTFTvmS3Bek4eDIHn+vkuYiMLfAT8TeiS5/hOLyuG
    WRGRmpH/b214UW95eSKjaXCE0KPDI6R59/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245688; bh=of/OwLR+z+
    L7pxR+36w5a3prPacve2iynm+T6CQV700=; b=RutaxtRBkRzZqZx142IojTBdf3
    WB9TDbHxBa9f/Sx+p5bhvrnzVNCuSn+eI1ymrX7Of+9Vu/Bs6/VfQSEjYKfSf1/E
    CLRWBtI6bwMnp76BLrGOCsPBjF+zv44gkmSfuWpUVV5EESfk02upRang1DZCAPo9
    iowEsSBP/wsaQTzkBvLUUNs9oepcIWMMO02l4bTFoxCCY31KkyAWsMk9NcDpqU8Z
    qK09kAiJDfrWsa43/qphrRnjLOJBTF6DP/DclU+OltqWcYIwHp3iXfJ2rHTpJSun
    8dy/37N2BtBZpblfkNPqKSJ+dfhP4YpB/s88+o6HRCDiinJfnxXmZ4S0yvxQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lIu3FSQI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lIu3FSQI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCf24MRv+KHvSTNl7FmYQ7IzNtU6derWfgfTf2BFtznyZMKLDPhgQXqAGoKa25g7A2PYSeBDgp4o9NtUsvMpPz82jZfdnqvoSesn6jS+1mQpE0NKmSl1
    DIMfYOED6kIYVTI9b64Fx5atCLD17X2kqli97zxb6jzfQrthJDCQ7WvTh7VnZuuLcVU5unpvaXpzFqPKnbrD9QyutsofXDLA3os+WHBiRLkIKs4XJbF2tAGE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1754139AbeDIAUH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:20:07 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:5792
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754087AbeDIAUE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:04 -0400
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
Subject: [PATCH AUTOSEL for 4.15 121/189] asm-generic: provide
 generic_pmdp_establish()
Thread-Topic: [PATCH AUTOSEL for 4.15 121/189] asm-generic: provide
 generic_pmdp_establish()
Thread-Index: AQHTz5hF/sYYiH4NNki7wGSwjH2M+Q==
Date: Mon, 9 Apr 2018 00:18:23 +0000
Message-ID: <20180409001637.162453-121-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:6PytLbHqMhAs8cHBBdk0LuPegKjhkJuO9PSJTPFmiPAQQBVa0J9eWPAYWTQItLaBgf3WMTOgi0bSWaVDKSJH6ZNylL0jPqSZkxjhmiK1hg2jjhOhqm1pvo8KR45sVJBFdCeq0Whicg1pkzW9x2jol/xBnxwRZj6EUbvPgAvSPSybKibnWosB1kFzAp+/BJVP4nZHR6CbRozw8wfndLtZtOXA3952wfyMkBJhA7EPFXMS5+9WeSYtHl7egZdldWHw;20:mDNwoVDZaC81BxMnIg9XMopaBUyrTDD7xbTkyLHdJU9wcm3qMs3+wO0bT7fo+pNK6Y6lPVR60AO0IUcOmqsMH9y0H+zzgOuHyavo1KRRP9+8BYRrn6NNbWlCTO6nYs2c5w9A2QuCBrzW8XYcRVrT60qYJJveddRe+SMfTC/jm7o=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb4d941f-503f-4e96-25bd-08d59dafa2b7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07269E6C03B2CF0E6E6A7E0EFBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(20558992708506)(89211679590171)(190383065149520)(211936372134217)(42068640409301)(153496737603132)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6306002)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(575784001)(76176011)(7416002)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zzcM0I1UDBKsOvd+eackZEqi0LNpQIaoH3IdQaCPLXNtj/WSJdddMztbRXIeetRBkTJ9S9T89Q8NDwpVRUJEFfq5ohQFh40Qpe7YsXyh5RPIh02mExKxwX66izFzEdB6BzaeBJsbFg80ogJ+4H1X6ER8ljzGKWSD54yabAARUnHCGT07edwortVpHXKOfK7u+J8VHTSrHs3sHDx63CuXYuajBPgP9eRQgiKi5J7ZGufNlxTEqTD3gOrZEpOm7cJ9th/lNCWnmbnzFMT5MFGDyOIsfCbI2Y6hhPgfI+rBhiVYqwGAME5rkVXgblKdkSdk2Y85bvajvNcglUc6QCmrK3zza6AZSPX98O5RAD+UHYjq3VBijrZqwjh6ug5oO1YKAgLaY2M4a0/UiXgnJAupauoLomyox0rqSIrqc4AGik8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4d941f-503f-4e96-25bd-08d59dafa2b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:23.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
index dfc861caa478..b891134abd39 100644
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
