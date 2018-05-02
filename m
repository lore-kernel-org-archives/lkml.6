Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-115724-1525240590-2-4395491839277844234
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525240589; b=CNVAKEUYZbqCWcxigJooQ4gBK59nwuX2DJ7PKamLAvq9CvOE20
    FJ1C9sbk0SDVLtKOdKCWzUlFXBJJqUVaue8OkOctrkdnFFfeylUlcXLGwozGSGAm
    /JVihQYi4wOKS631rFfjyhq0hAKzFRE2lnaK261a2V0O5zj8g7SlQW9ydrKk2CBK
    Ed+sTOMxZ1WJYdTElEW0V5axvnJmEVbPfkCjq8B6ZsWJoI2F5FiG0odI2xm2MZBX
    BGNl3HFXdbAlfnq/Uzv95qDrW2Qzn/mMdc9zvcV/OtId5r68h+7u8hDsMZl/NH8V
    66fcsko44H3Y7MsDd6Yv6lvYBR+i/tml7Q7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525240589; bh=yRtUkqL2OMgdsgTGrN2ESM8Ad9Q2m4
    6ZkPgkcKFTDDM=; b=VRSJGC0rgbpnVXmCFSkqgQa5qnyKnqZZ9qlMKEh4F8dnKE
    xbYecqHTqzaN7dhP364QdbVGTEMF4vW2afuUJIIR1mFRwalpXUocC7dmbz72lHFJ
    I1zh93MuT/8up1IV4Rjo5zVJzgO0KPGehcamFwX0IB1gxr3758tg+CtdGohpBs/i
    JqsoQ8Ge67UT5RUVffKIXbvg2CxbpYSaxvtO9NRO3vjWTTNI1jkllZSOFBjr9hY2
    NEAc3Re5lpLhFo22ZZkxXZhJQJfH516563Fm01eKyj9XMrHmsvQ2R87/PW+MktU4
    uaDNp2mKoxq0u60RQemggXBnRiKHoXFPmLUL4H8g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=dNQq52+D x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=40 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=dNQq52+D x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=40 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOuyPxd8rdcA8BxeK5PMMcWFJWYD2dD5TxIUEdU+N8bkRE/22CU+uSpDVGjgCZ1/q3qbebHF2U2yX58dnABVaqIip8O7J2c2mxmxdqQ2eblejZs5pMPr
    jhmnHlcAhW4IKvEcuELVgSf+2VapKh3VrO4+LC7pvHtRItjbhno+yRLCeDFt1bpAOeFrGnvQyPncQY9yF8X3/W204ux5dC/Mo4eNa1zrbFj/WpGwXU1AX/AZ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=gu6fZOg2AAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=wnRLpWgB52Rf8lSRARcA:9
    a=ODMkTsyIlxBu4VOH:21 a=a5V0_rPgxTh0tBvB:21 a=x8gzFH9gYPwA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750925AbeEBF40 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 01:56:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58480 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeEBF4Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 01:56:25 -0400
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Cc: akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com, prakash.sangappa@oracle.com
Subject: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
Date: Tue,  1 May 2018 22:58:06 -0700
Message-Id: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8880 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020059
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For analysis purpose it is useful to have numa node information
corresponding mapped address ranges of the process. Currently
/proc/<pid>/numa_maps provides list of numa nodes from where pages are
allocated per VMA of the process. This is not useful if an user needs to
determine which numa node the mapped pages are allocated from for a
particular address range. It would have helped if the numa node information
presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
exact numa node from where the pages have been allocated.

The format of /proc/<pid>/numa_maps file content is dependent on
/proc/<pid>/maps file content as mentioned in the manpage. i.e one line
entry for every VMA corresponding to entries in /proc/<pids>/maps file.
Therefore changing the output of /proc/<pid>/numa_maps may not be possible.

Hence, this patch proposes adding file /proc/<pid>/numa_vamaps which will
provide proper break down of VA ranges by numa node id from where the mapped
pages are allocated. For Address ranges not having any pages mapped, a '-'
is printed instead of numa node id. In addition, this file will include most
of the other information currently presented in /proc/<pid>/numa_maps. The
additional information included is for convenience. If this is not
preferred, the patch could be modified to just provide VA range to numa node
information as the rest of the information is already available thru
/proc/<pid>/numa_maps file.

Since the VA range to numa node information does not include page's PFN,
reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).

Here is the snippet from the new file content showing the format.

00400000-00401000 N0=1 kernelpagesize_kB=4 mapped=1 file=/tmp/hmap2
00600000-00601000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/tmp/hmap2
00601000-00602000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/tmp/hmap2
7f0215600000-7f0215800000 N0=1 kernelpagesize_kB=2048 dirty=1 file=/mnt/f1
7f0215800000-7f0215c00000 -  file=/mnt/f1
7f0215c00000-7f0215e00000 N0=1 kernelpagesize_kB=2048 dirty=1 file=/mnt/f1
7f0215e00000-7f0216200000 -  file=/mnt/f1
..
7f0217ecb000-7f0217f20000 N0=85 kernelpagesize_kB=4 mapped=85 mapmax=51
   file=/usr/lib64/libc-2.17.so
7f0217f20000-7f0217f30000 -  file=/usr/lib64/libc-2.17.so
7f0217f30000-7f0217f90000 N0=96 kernelpagesize_kB=4 mapped=96 mapmax=51
   file=/usr/lib64/libc-2.17.so
7f0217f90000-7f0217fb0000 -  file=/usr/lib64/libc-2.17.so
..

The 'pmap' command can be enhanced to include an option to show numa node
information which it can read from this new proc file. This will be a
follow on proposal.

There have been couple of previous patch proposals to provide numa node
information based on pfn or physical address. They seem to have not made
progress. Also it would appear reading numa node information based on PFN
or physical address will require privileges(CAP_SYS_ADMIN) similar to
reading PFN info from /proc/<pid>/pagemap.

See
https://marc.info/?t=139630938200001&r=1&w=2

https://marc.info/?t=139718724400001&r=1&w=2

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 fs/proc/base.c     |   2 +
 fs/proc/internal.h |   3 +
 fs/proc/task_mmu.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 303 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1b2ede6..8fd7cc5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2960,6 +2960,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("maps",       S_IRUGO, proc_pid_maps_operations),
 #ifdef CONFIG_NUMA
 	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
+	REG("numa_vamaps",  S_IRUGO, proc_pid_numa_vamaps_operations),
 #endif
 	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
 	LNK("cwd",        proc_cwd_link),
@@ -3352,6 +3353,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_NUMA
 	REG("numa_maps", S_IRUGO, proc_tid_numa_maps_operations),
+	REG("numa_vamaps",  S_IRUGO, proc_tid_numa_vamaps_operations),
 #endif
 	REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
 	LNK("cwd",       proc_cwd_link),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 0f1692e..9a3ff80 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -273,6 +273,7 @@ struct proc_maps_private {
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
+	u64 vma_off;
 } __randomize_layout;
 
 struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode);
@@ -280,7 +281,9 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode);
 extern const struct file_operations proc_pid_maps_operations;
 extern const struct file_operations proc_tid_maps_operations;
 extern const struct file_operations proc_pid_numa_maps_operations;
+extern const struct file_operations proc_pid_numa_vamaps_operations;
 extern const struct file_operations proc_tid_numa_maps_operations;
+extern const struct file_operations proc_tid_numa_vamaps_operations;
 extern const struct file_operations proc_pid_smaps_operations;
 extern const struct file_operations proc_pid_smaps_rollup_operations;
 extern const struct file_operations proc_tid_smaps_operations;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c486ad4..e3c7d65 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -169,6 +169,13 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	hold_task_mempolicy(priv);
 	priv->tail_vma = get_gate_vma(mm);
 
+	if (priv->vma_off) {
+	       vma = find_vma(mm, priv->vma_off);
+	       if (vma)
+		       return vma;
+	}
+
+
 	if (last_addr) {
 		vma = find_vma(mm, last_addr - 1);
 		if (vma && vma->vm_start <= last_addr)
@@ -197,7 +204,18 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct proc_maps_private *priv = m->private;
-	struct vm_area_struct *next;
+	struct vm_area_struct *next, *vma = v;
+
+	if (priv->vma_off) {
+	       if (vma && vma->vm_start <= priv->vma_off &&
+		    priv->vma_off < vma->vm_end)
+		       next = vma;
+	       else
+		       next = find_vma(priv->mm, priv->vma_off);
+
+	       if (next)
+		       return next;
+	}
 
 	(*pos)++;
 	next = m_next_vma(priv, v);
@@ -1568,9 +1586,14 @@ struct numa_maps {
 	unsigned long mapcount_max;
 	unsigned long dirty;
 	unsigned long swapcache;
+	unsigned long nextaddr;
+		 long nid;
 	unsigned long node[MAX_NUMNODES];
 };
 
+#define	NUMA_VAMAPS_NID_NOPAGES 	(-1)
+#define	NUMA_VAMAPS_NID_NONE 	(-2)
+
 struct numa_maps_private {
 	struct proc_maps_private proc_maps;
 	struct numa_maps md;
@@ -1804,6 +1827,232 @@ static int show_numa_map(struct seq_file *m, void *v, int is_pid)
 	return 0;
 }
 
+/* match node id of page to previous node id, return 0 on match */
+static int vamap_match_nid(struct numa_maps *md, unsigned long addr,
+		struct page *page)
+{
+	if (page) {
+		if (md->nid == NUMA_VAMAPS_NID_NONE ||
+			 page_to_nid(page) == md->nid) {
+			if (md->nid == NUMA_VAMAPS_NID_NONE)
+				md->nid = page_to_nid(page);
+			return 0;
+		}
+	} else {
+		if (md->nid  == NUMA_VAMAPS_NID_NONE ||
+		     md->nid == NUMA_VAMAPS_NID_NOPAGES )  {
+			if (md->nid == NUMA_VAMAPS_NID_NONE)
+				md->nid = NUMA_VAMAPS_NID_NOPAGES;
+			return 0;
+		}
+	}
+	/* Did not match */
+	md->nextaddr = addr;
+	return 1;
+}
+
+static int gather_pte_stats_vamap(pmd_t *pmd, unsigned long addr,
+		unsigned long end, struct mm_walk *walk)
+{
+	struct numa_maps *md = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+	spinlock_t *ptl;
+	pte_t *orig_pte;
+	pte_t *pte;
+	int ret = 0;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		struct page *page;
+
+		page = can_gather_numa_stats_pmd(*pmd, vma, addr);
+		ret = vamap_match_nid(md, addr, page);
+		if (page && !ret)
+			gather_stats(page, md, pmd_dirty(*pmd),
+					     HPAGE_PMD_SIZE/PAGE_SIZE);
+		spin_unlock(ptl);
+		return ret;
+	}
+
+	if (pmd_trans_unstable(pmd))
+		return 0;
+#endif
+	orig_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	do {
+		struct page *page = can_gather_numa_stats(*pte, vma, addr);
+		ret = vamap_match_nid(md, addr, page);
+		if (ret)
+			break;
+		if (page)
+			gather_stats(page, md, pte_dirty(*pte), 1);
+
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap_unlock(orig_pte, ptl);
+	cond_resched();
+	return ret;
+}
+#ifdef CONFIG_HUGETLB_PAGE
+static int gather_hugetlb_stats_vamap(pte_t *pte, unsigned long hmask,
+		unsigned long addr, unsigned long end, struct mm_walk *walk)
+{
+	pte_t huge_pte = huge_ptep_get(pte);
+	struct numa_maps *md;
+	struct page *page;
+
+	md = walk->private;
+	if (!pte_present(huge_pte))
+		return (vamap_match_nid(md, addr, NULL));
+
+	page = pte_page(huge_pte);
+	if (!page)
+		return (vamap_match_nid(md, addr, page));
+
+	if (vamap_match_nid(md, addr, page))
+		return 1;
+	gather_stats(page, md, pte_dirty(huge_pte), 1);
+	return 0;
+}
+
+#else
+static int gather_hugetlb_stats_vamap(pte_t *pte, unsigned long hmask,
+		unsigned long addr, unsigned long end, struct mm_walk *walk)
+{
+	return 0;
+}
+#endif
+
+
+static int gather_hole_info_vamap(unsigned long start, unsigned long end,
+				struct mm_walk *walk)
+{
+	struct numa_maps *md = walk->private;
+	struct vm_area_struct *vma = walk->vma;
+
+	/*
+	 * check if we are still tracking a hole or end the walk.
+	 */
+	if ((md->nid != NUMA_VAMAPS_NID_NOPAGES &&
+	     md->nid != NUMA_VAMAPS_NID_NONE) ||
+	     vma != find_vma(walk->mm, start)) {
+		md->nextaddr = start;
+		return 1;
+	}
+
+	if (md->nid == NUMA_VAMAPS_NID_NONE)
+		md->nid = NUMA_VAMAPS_NID_NOPAGES;
+
+	return 0;
+}
+
+/*
+ * Display pages allocated per node via /proc.
+ */
+static int show_numa_vamap(struct seq_file *m, void *v, int is_pid)
+{
+	struct numa_maps_private *numa_priv = m->private;
+	struct proc_maps_private *proc_priv = &numa_priv->proc_maps;
+	struct vm_area_struct *vma = v;
+	struct numa_maps *md = &numa_priv->md;
+	struct file *file = vma->vm_file;
+	struct mm_struct *mm = vma->vm_mm;
+	struct mm_walk walk = {
+		.hugetlb_entry = gather_hugetlb_stats_vamap,
+		.pmd_entry = gather_pte_stats_vamap,
+		.pte_hole = gather_hole_info_vamap,
+		.private = md,
+		.mm = mm,
+	};
+	unsigned long start_va, next_va;
+
+	if (!mm)
+		return 0;
+
+	start_va = proc_priv->vma_off;
+	if (!start_va)
+		start_va = vma->vm_start;
+
+	if (start_va < vma->vm_end) {
+
+		/* Ensure we start with an empty numa_maps statistics */
+		memset(md, 0, sizeof(*md));
+		md->nid = NUMA_VAMAPS_NID_NONE; /* invalid nodeid at start */
+		md->nextaddr = 0;
+
+		/* mmap_sem is held by m_start() */
+		 if (walk_page_range(start_va, vma->vm_end, &walk) < 0)
+			goto out;
+
+		/*
+		 * If we reached the end of this vma.
+		 */
+		if (md->nextaddr == 0)
+			md->nextaddr = vma->vm_end;
+
+		next_va = md->nextaddr;
+		seq_printf(m, "%08lx-%08lx", start_va, next_va);
+		start_va = next_va;
+
+		if (md->nid != NUMA_VAMAPS_NID_NONE &&
+		    md->nid != NUMA_VAMAPS_NID_NOPAGES && md->node[md->nid]) {
+			seq_printf(m, " N%ld=%lu", md->nid, md->node[md->nid]);
+
+			seq_printf(m, " kernelpagesize_kB=%lu",
+					 vma_kernel_pagesize(vma) >> 10);
+		} else {
+			seq_printf(m, " - ");
+		}
+
+		if (md->anon)
+			seq_printf(m, " anon=%lu", md->anon);
+
+		if (md->dirty)
+			seq_printf(m, " dirty=%lu", md->dirty);
+
+		if (md->pages != md->anon && md->pages != md->dirty)
+			seq_printf(m, " mapped=%lu", md->pages);
+
+		if (md->mapcount_max > 1)
+			seq_printf(m, " mapmax=%lu", md->mapcount_max);
+
+		if (md->swapcache)
+			seq_printf(m, " swapcache=%lu", md->swapcache);
+
+		if (md->active < md->pages && !is_vm_hugetlb_page(vma))
+			seq_printf(m, " active=%lu", md->active);
+
+		if (md->writeback)
+			seq_printf(m, " writeback=%lu", md->writeback);
+
+		if (file) {
+			seq_puts(m, " file=");
+			seq_file_path(m, file, "\n\t= ");
+		} else if (vma->vm_start <= mm->brk &&
+				 vma->vm_end >= mm->start_brk) {
+			seq_puts(m, " heap");
+		} else if (is_stack(vma)) {
+			seq_puts(m, " stack");
+
+		}
+
+		seq_putc(m, '\n');
+	}
+
+	/*
+	 * If buffer has not overflowed update vma_off, otherwise preserve
+	 * previous offest as it will be retried.
+	 */
+	if (!seq_has_overflowed(m)) {
+	       if (md->nextaddr < vma->vm_end)
+		       proc_priv->vma_off = md->nextaddr;
+	       else
+		       proc_priv->vma_off = 0;
+	}
+out:
+	m_cache_vma(m, vma);
+	return 0;
+}
+
 static int show_pid_numa_map(struct seq_file *m, void *v)
 {
 	return show_numa_map(m, v, 1);
@@ -1814,6 +2063,16 @@ static int show_tid_numa_map(struct seq_file *m, void *v)
 	return show_numa_map(m, v, 0);
 }
 
+static int show_pid_numa_vamap(struct seq_file *m, void *v)
+{
+	return show_numa_vamap(m, v, 1);
+}
+
+static int show_tid_numa_vamap(struct seq_file *m, void *v)
+{
+	return show_numa_vamap(m, v, 0);
+}
+
 static const struct seq_operations proc_pid_numa_maps_op = {
 	.start  = m_start,
 	.next   = m_next,
@@ -1828,6 +2087,20 @@ static const struct seq_operations proc_tid_numa_maps_op = {
 	.show   = show_tid_numa_map,
 };
 
+static const struct seq_operations proc_pid_numa_vamaps_op = {
+	.start  = m_start,
+	.next   = m_next,
+	.stop   = m_stop,
+	.show   = show_pid_numa_vamap,
+};
+
+static const struct seq_operations proc_tid_numa_vamaps_op = {
+	.start  = m_start,
+	.next   = m_next,
+	.stop   = m_stop,
+	.show   = show_tid_numa_vamap,
+};
+
 static int numa_maps_open(struct inode *inode, struct file *file,
 			  const struct seq_operations *ops)
 {
@@ -1845,6 +2118,16 @@ static int tid_numa_maps_open(struct inode *inode, struct file *file)
 	return numa_maps_open(inode, file, &proc_tid_numa_maps_op);
 }
 
+static int pid_numa_vamaps_open(struct inode *inode, struct file *file)
+{
+	return numa_maps_open(inode, file, &proc_pid_numa_vamaps_op);
+}
+
+static int tid_numa_vamaps_open(struct inode *inode, struct file *file)
+{
+	return numa_maps_open(inode, file, &proc_tid_numa_vamaps_op);
+}
+
 const struct file_operations proc_pid_numa_maps_operations = {
 	.open		= pid_numa_maps_open,
 	.read		= seq_read,
@@ -1858,4 +2141,18 @@ const struct file_operations proc_tid_numa_maps_operations = {
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
+
+const struct file_operations proc_pid_numa_vamaps_operations = {
+	.open		= pid_numa_vamaps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= proc_map_release,
+};
+
+const struct file_operations proc_tid_numa_vamaps_operations = {
+	.open		= tid_numa_vamaps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= proc_map_release,
+};
 #endif /* CONFIG_NUMA */
-- 
2.7.4

