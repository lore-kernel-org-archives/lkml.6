Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELt7PsKa+Vuktk281RXcaya6QhCyXaBSjmqmpDjcbmfAQ0XQ1XPcVu9hlf8qwKEjmA0qAVaj
ARC-Seal: i=1; a=rsa-sha256; t=1520945698; cv=none;
        d=google.com; s=arc-20160816;
        b=Bz0edl56Y3A9Ajbfw8stxiJ69049iUleo1h5YnUdRHmc5eLvrIjsssx8HcABcTPGPE
         YTBsqUvojNroLYHdka71kD4/gpTetsscluhJbayIJ4FrTklG9NevK1+XogLnRPNfPnK2
         pixe++umRGQy6JpSe3VO0NBs2CLTV9LQt7gLENv9jdnN7OFqD60RdyUU0+oBME2Ib3PN
         VjuPgCVw6QUL5G3IBOLMXkIqDny4Qa3CwJukk0rvnCjV7WHPPXzQbkcGDrIUzgHfu6eB
         I4Qb4zjbu2XG9bV/qjR+rolyvM1OagWtS+TXVPk/xUczNdOg728ruCPjtHG/ta9jzcmt
         JWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=66IjrC6hGSUn0trVrP0mrsD+611byHy9lVZOH/S1wTs=;
        b=XtjYWT82lHYKEh8pboZiyFgRToeNx4qirRLVq9IJ43TVzozb/K89NWKHn1GCa3NP2u
         m0P0/0IIJHMwKDA76isGnbx7hV11ee4BdRevlP8yRMdWpHwTAOsA7+E6q54u0F3zea8F
         bLoHJlxnH3uSLgzfxGEmHqymK5jd3LVqiXTCR3cWN2VfGnGb4o6TdFkFKJRaRUQayYdQ
         ooFFokUV5GVnNOdpG0bdXBeymkmXruFhlRy9+N7PUcrzHmtlvoO8MJdCWOZ4Jkqhar1n
         8/5hI5au4bEtDOdi1pykYfgJXb6OyFELBt+oybmh9fHTDKywDkPj5KFA8dvaDXWqWQWL
         Qx3w==
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
Subject: [PATCH 4/8] Uprobe: Export uprobe_map_info along with uprobe_{build/free}_map_info()
Date: Tue, 13 Mar 2018 18:25:59 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031312-0016-0000-0000-00000530FAD7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031312-0017-0000-0000-0000286E2CB6
Message-Id: <20180313125603.19819-5-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130154
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827156987945249?=
X-GMAIL-MSGID: =?utf-8?q?1594827156987945249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These exported data structure and functions will be used by other
files in later patches.

No functionality changes.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 include/linux/uprobes.h |  9 +++++++++
 kernel/events/uprobes.c | 14 +++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e9..7bd2760 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -109,12 +109,19 @@ enum rp_check {
 	RP_CHECK_RET,
 };
 
+struct address_space;
 struct xol_area;
 
 struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
+struct uprobe_map_info {
+	struct uprobe_map_info *next;
+	struct mm_struct *mm;
+	unsigned long vaddr;
+};
+
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
@@ -149,6 +156,8 @@ struct uprobes_state {
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
+extern struct uprobe_map_info *uprobe_free_map_info(struct uprobe_map_info *info);
+extern struct uprobe_map_info *uprobe_build_map_info(struct address_space *mapping, loff_t offset, bool is_register);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 081b88c1..e7830b8 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -695,23 +695,15 @@ static void delete_uprobe(struct uprobe *uprobe)
 	put_uprobe(uprobe);
 }
 
-struct uprobe_map_info {
-	struct uprobe_map_info *next;
-	struct mm_struct *mm;
-	unsigned long vaddr;
-};
-
-static inline struct uprobe_map_info *
-uprobe_free_map_info(struct uprobe_map_info *info)
+struct uprobe_map_info *uprobe_free_map_info(struct uprobe_map_info *info)
 {
 	struct uprobe_map_info *next = info->next;
 	kfree(info);
 	return next;
 }
 
-static struct uprobe_map_info *
-uprobe_build_map_info(struct address_space *mapping, loff_t offset,
-		      bool is_register)
+struct uprobe_map_info *uprobe_build_map_info(struct address_space *mapping,
+					      loff_t offset, bool is_register)
 {
 	unsigned long pgoff = offset >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
-- 
1.8.3.1
