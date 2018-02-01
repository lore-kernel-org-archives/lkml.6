Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeBABti (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:49:38 -0500
Received: from mail-eopbgr00093.outbound.protection.outlook.com ([40.107.0.93]:59104
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932118AbeBABth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:49:37 -0500
From: "Zhang, Shile (NSB - CN/Hangzhou)" <shile.zhang@nokia-sbell.com>
To: Russell King <linux@armlinux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] mm/hugetlb: Implement ASLR and topdown for hugetlb
 mappings
Thread-Topic: [PATCH] mm/hugetlb: Implement ASLR and topdown for hugetlb
 mappings
Thread-Index: AQHTVIT81tf+ySpvtUyIfKL/J47BkaMR1yPAgH18VdA=
Date: Thu, 1 Feb 2018 01:49:33 +0000
Message-ID: <HE1PR07MB3097A80B2FF0E2CB72C97FD8A1FA0@HE1PR07MB3097.eurprd07.prod.outlook.com>
References: <1509700757-34420-1-git-send-email-shile.zhang@nokia-sbell.com>
 <VI1PR0701MB2846C892037A515D0B3F4EF8A12B0@VI1PR0701MB2846.eurprd07.prod.outlook.com>
In-Reply-To: <VI1PR0701MB2846C892037A515D0B3F4EF8A12B0@VI1PR0701MB2846.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.168]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR07MB1259;7:ZPtX0RKRm3knDKH8ieIstCgHB3wWHr/JbbOqSXGBrsmv1JOX72GZFxGGfCCUF74ZAoVwUTpgdtE9Z0/x5vkPjFDF1GxodC4Z8Zs/vc6KLNYtW7McmxBeXAADtI4lcVP0diazztJCsFPHR7JQfsHCDUaPpjcHGap52XkwGqIe6fMOD8v4ykglyZPmLI82PiV0DrvSTA6qKaymW7SUhbfxYR68j9kEfGdg653ccdZdbXBR8gVtbyUvgdBLx7kO6Bsu
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87cae618-fc50-4117-f1a8-08d569160ad2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:HE1PR07MB1259;
x-ms-traffictypediagnostic: HE1PR07MB1259:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shile.zhang@nokia-sbell.com;
x-microsoft-antispam-prvs: <HE1PR07MB1259274562760C10E369E8D8A1FA0@HE1PR07MB1259.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(11241501184)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR07MB1259;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB1259;
x-forefront-prvs: 0570F1F193
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(189003)(199004)(13464003)(81156014)(81166006)(8936002)(97736004)(53936002)(575784001)(305945005)(86362001)(6436002)(7696005)(99286004)(9686003)(8676002)(7736002)(6916009)(4326008)(5660300001)(55016002)(66066001)(76176011)(2950100002)(105586002)(102836004)(229853002)(3280700002)(14454004)(316002)(6246003)(74316002)(59450400001)(478600001)(53546011)(6116002)(3846002)(106356001)(6506007)(54906003)(2900100001)(25786009)(3660700001)(2906002)(26005)(5250100002)(33656002)(186003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB1259;H:HE1PR07MB3097.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
x-microsoft-antispam-message-info: riPn4BbA61ekSgNzuRKRbCjmluut+tx2jSpnCJHvHJrrlGEisJTZ4twWffULYA4VWgnDybq/84iS1Psi9eom8w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cae618-fc50-4117-f1a8-08d569160ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 01:49:33.2711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB1259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w111njPt008756

Hi, Russel

Sorry for spam!
I'm not sure if you got this patch I sent before. Could you please help to check if it still available?

Many thanks!

BR, Shile

-----Original Message-----
From: Zhang, Shile (NSB - CN/Hangzhou) 
Sent: Monday, November 13, 2017 1:32 PM
To: Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Subject: RE: [PATCH] mm/hugetlb: Implement ASLR and topdown for hugetlb mappings

Hi, Russell,

Have you any time to check this patch?
I found this issue/missing in my works, the application cannot mmap big hugepage (about 360MB) due to no more contiguous vm from the default "TASK_UNMMAPPED_AREA" by legacy bottom-up.
We need this patch to fix this issue.

Could you please help check this patch?

Thanks!

BR, Shile

-----Original Message-----
From: Shile Zhang [mailto:shile.zhang@nokia-sbell.com] 
Sent: Friday, November 03, 2017 5:19 PM
To: Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org; Zhang, Shile (NSB - CN/Hangzhou) <shile.zhang@nokia-sbell.com>
Subject: [PATCH] mm/hugetlb: Implement ASLR and topdown for hugetlb mappings

merge from arch/x86

Signed-off-by: Shile Zhang <shile.zhang@nokia-sbell.com>
---
 arch/arm/include/asm/page.h |  1 +
 arch/arm/mm/hugetlbpage.c   | 85 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 4355f0e..994630f 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -144,6 +144,7 @@ extern void copy_page(void *to, const void *from);
 
 #ifdef CONFIG_KUSER_HELPERS
 #define __HAVE_ARCH_GATE_AREA 1
+#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #endif
 
 #ifdef CONFIG_ARM_LPAE
diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index fcafb52..46ed0c8 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -45,3 +45,88 @@ int pmd_huge(pmd_t pmd)
 {
 	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
 }
+
+#ifdef CONFIG_HUGETLB_PAGE
+static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
+		unsigned long addr, unsigned long len,
+		unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = current->mm->mmap_legacy_base;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
+}
+
+static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
+		unsigned long addr0, unsigned long len,
+		unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+	unsigned long addr;
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = current->mm->mmap_base;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	if (addr & ~PAGE_MASK) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		info.low_limit = TASK_UNMAPPED_BASE;
+		info.high_limit = TASK_SIZE;
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
+}
+
+unsigned long
+hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	if (len & ~huge_page_mask(h))
+		return -EINVAL;
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED) {
+		if (prepare_hugepage_range(file, addr, len))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (addr) {
+		addr = ALIGN(addr, huge_page_size(h));
+		vma = find_vma(mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+	if (mm->get_unmapped_area == arch_get_unmapped_area)
+		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
+				pgoff, flags);
+	else
+		return hugetlb_get_unmapped_area_topdown(file, addr, len,
+				pgoff, flags);
+}
+#endif /* CONFIG_HUGETLB_PAGE */
-- 
2.6.2
