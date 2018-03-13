Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELs++f6Oh+dfqASfUMtJrZagEZ9P0Ls6P2b9xIaRs9bv8g8eA4Udx1purcpKFWYccu2jv7s4
ARC-Seal: i=1; a=rsa-sha256; t=1520945709; cv=none;
        d=google.com; s=arc-20160816;
        b=FcQT3qjmDZ8L1UN0cCEhT0GdENJlm7lXoJ8x1Mb4MubhVHCev8hQmr59q+abarD/4n
         HPyfIMs0BhaTbvfLfkoD/6f0fBnG72lusKnY4a8RN6HR2DRcaQWPqQqglaraDnVM3NY4
         nQH9cjaqYmJ0LRYlRuQ/OFv8M2xf3GGouZBedBB+I23KQsu2/koNZ5XpF4N67yMuIQSm
         Kz7Ny3piA8aIY5tUOGtaDpQog0yhJMPK6A2QGVeXfjvU//1X+yA3xTlDLfNMIIJF8D8T
         gX7VAa/ji6LWXc9NeXYl2VrqfVtyQC2amYlmk0dH0sWQNEQ6JTnQbjhCxHkifoUBtRZL
         WjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XmFyYaNCgKjTzxY/rkhTPkuYAYswHJQtj+vWWYSq1Nc=;
        b=nIeP1mk01HhKaIUXMeM8vmVJIIv2GiTrBFAaeeIUgfy/aed0dGoXBDh5NWLzyRTtTt
         R52WCu4N6dMjfoyLFqNAs0YwQ2UUipfeFqdmlbG5FZh8OBEkHsrxA+SJ7hl0BDF1tulZ
         AgSHYNTqqWDXPPrMZvBDDumeHOOxv1HO97rhoAJd6AVdanVE4qB2BR4P/TQNQgeuxHmh
         u89EwXXvQ15eEBhCkZ1tiv9fWBiOf1qxaVpgOycA+ZOnSaYqfuR83XasPqR79DqC0+g9
         SNYu3eUqTBplBiAhkCvxJ0XL9XLw1ss/npi+e4/HGFHg2FiRNJkq4rTEAV+49xLBIAb2
         dSuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com
Cc: acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        huawei.libin@huawei.com, hughd@google.com, jack@suse.cz,
        jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
        kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
        rostedt@goodmis.org, tglx@linutronix.de, tmricht@linux.vnet.ibm.com,
        willy@infradead.org, yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 2/8] mm: Prefix vma_ to vaddr_to_offset() and offset_to_vaddr()
Date: Tue, 13 Mar 2018 18:25:57 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031312-0040-0000-0000-0000043EFB37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031312-0041-0000-0000-000020E22D7E
Message-Id: <20180313125603.19819-3-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130154
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827168615885864?=
X-GMAIL-MSGID: =?utf-8?q?1594827168615885864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No functionality changes.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 include/linux/mm.h      |  4 ++--
 kernel/events/uprobes.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 95909f2..d7ee526 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2275,13 +2275,13 @@ struct vm_unmapped_area_info {
 }
 
 static inline unsigned long
-offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
+vma_offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
 {
 	return vma->vm_start + offset - ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 }
 
 static inline loff_t
-vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
+vma_vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
 {
 	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
 }
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bd6f230..535fd39 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -748,7 +748,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 		curr = info;
 
 		info->mm = vma->vm_mm;
-		info->vaddr = offset_to_vaddr(vma, offset);
+		info->vaddr = vma_offset_to_vaddr(vma, offset);
 	}
 	i_mmap_unlock_read(mapping);
 
@@ -807,7 +807,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 			goto unlock;
 
 		if (vma->vm_start > info->vaddr ||
-		    vaddr_to_offset(vma, info->vaddr) != uprobe->offset)
+		    vma_vaddr_to_offset(vma, info->vaddr) != uprobe->offset)
 			goto unlock;
 
 		if (is_register) {
@@ -977,7 +977,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 		    uprobe->offset >= offset + vma->vm_end - vma->vm_start)
 			continue;
 
-		vaddr = offset_to_vaddr(vma, uprobe->offset);
+		vaddr = vma_offset_to_vaddr(vma, uprobe->offset);
 		err |= remove_breakpoint(uprobe, mm, vaddr);
 	}
 	up_read(&mm->mmap_sem);
@@ -1023,7 +1023,7 @@ static void build_probe_list(struct inode *inode,
 	struct uprobe *u;
 
 	INIT_LIST_HEAD(head);
-	min = vaddr_to_offset(vma, start);
+	min = vma_vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
 	spin_lock(&uprobes_treelock);
@@ -1076,7 +1076,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	list_for_each_entry_safe(uprobe, u, &tmp_list, pending_list) {
 		if (!fatal_signal_pending(current) &&
 		    filter_chain(uprobe, UPROBE_FILTER_MMAP, vma->vm_mm)) {
-			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
+			unsigned long vaddr = vma_offset_to_vaddr(vma, uprobe->offset);
 			install_breakpoint(uprobe, vma->vm_mm, vma, vaddr);
 		}
 		put_uprobe(uprobe);
@@ -1095,7 +1095,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 
 	inode = file_inode(vma->vm_file);
 
-	min = vaddr_to_offset(vma, start);
+	min = vma_vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
 	spin_lock(&uprobes_treelock);
@@ -1730,7 +1730,7 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
 	if (vma && vma->vm_start <= bp_vaddr) {
 		if (valid_vma(vma, false)) {
 			struct inode *inode = file_inode(vma->vm_file);
-			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
+			loff_t offset = vma_vaddr_to_offset(vma, bp_vaddr);
 
 			uprobe = find_uprobe(inode, offset);
 		}
-- 
1.8.3.1
