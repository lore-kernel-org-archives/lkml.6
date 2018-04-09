Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240548-2-10705095837356374630
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240548; b=V9NNaruovL/w5znXWxnUoph2MrZX9f0qsG12EU/sexIHb+dYUr
    l0U3RQT1YfmSuYQt4sOCs6xZ+zlTtyK/TVJ8y3AknfSldKdiPaWu1gBzmDgbqRAu
    eJD5ajXtMeTRos/WNCc+cdWjzZX4Bpi2WxnZLRwmzfWgZzn01XQu/QYqCe3R1gi0
    FcpgOJfzWmupvtNzH9vfzI8tjwuowkVQnHkWWty0PbdR2va9CTvaq4K6H+nay9/S
    tFY1J6kjpWNqcTPGIz28Whk41W8JmwTsauO+P2qTp61cijtaKJbC9hZUfrLQFOgP
    v08wfIRWgCUB1Nu9L1MuGBTAleTwmU1ldZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240548; bh=iBlo8gH/JU
    phDUPtlWiMT2YIbxmYl6Fi8ynxFFsAAIg=; b=hK0b1eM3eybLUJOMcnabHn1MmW
    /lnGH+cJPYYj37nG9jgSjs+Ui9XCVd1/HzT86EphH7e5S6u9eNqrH2GiOXqJWyDz
    cGfMv7/WbgM+yVnZxW6HYK09+NoiOlYmCRoP21az7Al7jskWVtv9J4Te0n1ALIEv
    UMUFZ4oJBUEfpJwPk+3zA3aFqsqyXBctYFD+8DPEIxa+jFGNUWbExTjH9pnxE5JV
    VrigvxEHvq/Mr9QxkAqxqSm62jPLIxxLFMMs2Bw+xBXtWNPX/fe9g9gxARCUWInB
    L24LxGqGE+s4ec7bO0DDKxLOvBQcFRHADBJ8+C5kL/amvGb/SLMiFhQLQ0RA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SdPwtQH3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SdPwtQH3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMo8DRvi1bZjvxeUuzYdPUtFZa294iLElh6lJFZWNpsWotl80xdppzevcfRASkxrwSCd0A3TtI6sexJ+olBW1ezAj5ltYp06IZ411UMVcVKeIRztTfz2
    TM2CJldyTaDimH9cDcd6/nWdq5YFWZpsDasyA/SsGZNiD8sQE7SMq/6osBapBoBVcH+GuzOZnVnWJVW8LMCm2jdIDm07GcoNeGGNDL1nDYG0JkJqRjJNo8zK
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=TYBLyS7eAAAA:8 a=SOq6UgPBAAAA:8 a=JfrnYn6hAAAA:8
    a=7CQSdrXTAAAA:8 a=6rqHouBjAAAA:8 a=LpQP-O61AAAA:8 a=PHq6YzTAAAAA:8
    a=yMhMjlubAAAA:8 a=l2L_0FsF_9ng4GhAMr4A:9 a=wPNLvfGTeEIA:10
    a=zvYvwCWiE4KgVXXeO06c:22 a=3hv5r9HjGAh9o5iR9qwG:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=Hx1yvPaMooE3kwe23bt7:22 a=pioyyrs4ZptJ924tMmac:22
    a=ZKzU8r6zoKMcqsNulkmm:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755032AbeDICV4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:21:56 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:7529
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756024AbeDIA3k (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dmitry Safonov <dsafonov@virtuozzo.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Christopher Covington <cov@codeaurora.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 112/293] ARM: 8683/1: ARM32: Support mremap()
 for sigpage/vDSO
Thread-Topic: [PATCH AUTOSEL for 4.9 112/293] ARM: 8683/1: ARM32: Support
 mremap() for sigpage/vDSO
Thread-Index: AQHTz5kaC2hKut03i0aHrsPlVgZBOw==
Date: Mon, 9 Apr 2018 00:24:21 +0000
Message-ID: <20180409002239.163177-112-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:KqI9Y8atOkKq76Fg2OeNP3C+usstaQv5Eh8qtZ2IBZKPvCelvuldsuv6f1rx0R7g2Xu6VTpGd/CIecqbPQoMDyufDWrrExCgqOan5XJ9heKkBghskIV2KQDGIkowcpq7hV++fvxPs67Y412TXKE1dASrfrEWw4Ak2b0m46n6cehRqMnvgc/mpCywbP3zQG49UMP8YwHjstt2kl/fBigN12/6fT1LOH1QrUBQRqF7puMi+CBZqt+1mosmzmzvpKSC;20:wWyVQ3PE/04f6ZQzPElwOaYFONnw6STWOVRAe2X1WQ9MQJVnLfCaXmrcIiSvMwwOQT3LEn51AOz+La1ZnJFZCE59pul6NTxwplJTf4abM4QYNcfhPHSuE/nu03SsgYSCnH93OU+jTXUHtvkPp+u5mI/OJqIqReBKz+SsAcJdCJs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d53ab3d-72d6-4ff2-27de-08d59db0fa11
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103253E023AA5856E601F87BFBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(7416002)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(575784001)(3280700002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 05ONDTU9hDWkczn/U70loxylNB0L/jBLj1LdmPEJkzvXStzuaEpZcUAl8eWwulB+zivifHXFu9ycZpXeEP/wSKn4DN5iMZKs86FK18HDuC/oRfbfO/Wt3CqfOhywOPjjfxjK2Ag7G0zLOL7muYr1sbFXiY/XLJEkUTurq4X235gNoQXwg4UtwY0SGvthEhnbx820fDYm09/jZt+lh0WUqO5jnK8N9GbmYKIr9i7bYpQRTV2oWqp5o8lRO/dVVgwvaAqAHjH1wz5zvZ1ap27hS97m9KrO6gf4vPUi6m2Zt/X0i3N9FPLg8UHyxKuvYmwh3wHmwzAjvScd20iXe7bBVj6wARJOBOq/2jP7zQXJ7vMlCgzlEn0xen+lv73YHyQufSXGo2H/k3SNAl3SCWcLyGjE56Yz7s17GY7amh5bFeU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d53ab3d-72d6-4ff2-27de-08d59db0fa11
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:21.0500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Safonov <dsafonov@virtuozzo.com>

[ Upstream commit 280e87e98c09b85b617c7b2752c8b504c4ea98f6 ]

CRIU restores application mappings on the same place where they
were before Checkpoint. That means, that we need to move vDSO
and sigpage during restore on exactly the same place where
they were before C/R.

Make mremap() code update mm->context.{sigpage,vdso} pointers
during VMA move. Sigpage is used for landing after handling
a signal - if the pointer is not updated during moving, the
application might crash on any signal after mremap().

vDSO pointer on ARM32 is used only for setting auxv at this moment,
update it during mremap() in case of future usage.

Without those updates, current work of CRIU on ARM32 is not reliable.
Historically, we error Checkpointing if we find vDSO page on ARM32
and suggest user to disable CONFIG_VDSO.
But that's not correct - it goes from x86 where signal processing
is ended in vDSO blob. For arm32 it's sigpage, which is not disabled
with `CONFIG_VDSO=3Dn'.

Looks like C/R was working by luck - because userspace on ARM32 at
this moment always sets SA_RESTORER.

Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
Acked-by: Andy Lutomirski <luto@amacapital.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/kernel/process.c |  8 ++++++++
 arch/arm/kernel/vdso.c    | 18 ++++++++++++++++++
 arch/x86/entry/vdso/vma.c |  3 ---
 mm/mmap.c                 |  4 ++++
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 91d2d5b01414..ca4a3c0f04c6 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -401,9 +401,17 @@ static unsigned long sigpage_addr(const struct mm_stru=
ct *mm,
 static struct page *signal_page;
 extern struct page *get_signal_page(void);
=20
+static int sigpage_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	current->mm->context.sigpage =3D new_vma->vm_start;
+	return 0;
+}
+
 static const struct vm_special_mapping sigpage_mapping =3D {
 	.name =3D "[sigpage]",
 	.pages =3D &signal_page,
+	.mremap =3D sigpage_mremap,
 };
=20
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp=
)
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 53cf86cf2d1a..a4d6dc0f2427 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -54,8 +54,26 @@ static const struct vm_special_mapping vdso_data_mapping=
 =3D {
 	.pages =3D &vdso_data_page,
 };
=20
+static int vdso_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	unsigned long new_size =3D new_vma->vm_end - new_vma->vm_start;
+	unsigned long vdso_size;
+
+	/* without VVAR page */
+	vdso_size =3D (vdso_total_pages - 1) << PAGE_SHIFT;
+
+	if (vdso_size !=3D new_size)
+		return -EINVAL;
+
+	current->mm->context.vdso =3D new_vma->vm_start;
+
+	return 0;
+}
+
 static struct vm_special_mapping vdso_text_mapping __ro_after_init =3D {
 	.name =3D "[vdso]",
+	.mremap =3D vdso_mremap,
 };
=20
 struct elfinfo {
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 23c881caabd1..2f10de80d76c 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -76,9 +76,6 @@ static int vdso_mremap(const struct vm_special_mapping *s=
m,
 	if (image->size !=3D new_size)
 		return -EINVAL;
=20
-	if (WARN_ON_ONCE(current->mm !=3D new_vma->vm_mm))
-		return -EFAULT;
-
 	vdso_fix_landing(image, new_vma);
 	current->mm->context.vdso =3D (void __user *)new_vma->vm_start;
=20
diff --git a/mm/mmap.c b/mm/mmap.c
index 45ac5b973459..cdef4ae94b10 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3168,8 +3168,12 @@ static int special_mapping_mremap(struct vm_area_str=
uct *new_vma)
 {
 	struct vm_special_mapping *sm =3D new_vma->vm_private_data;
=20
+	if (WARN_ON_ONCE(current->mm !=3D new_vma->vm_mm))
+		return -EFAULT;
+
 	if (sm->mremap)
 		return sm->mremap(sm, new_vma);
+
 	return 0;
 }
=20
--=20
2.15.1
