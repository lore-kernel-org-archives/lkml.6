Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELvfbo21WM18HzA4fVAda4aMaSz+VjnquQ3/W3ocn0t81TQGh5hPeVUz6LObgTbCRIylLmZk
ARC-Seal: i=1; a=rsa-sha256; t=1520945689; cv=none;
        d=google.com; s=arc-20160816;
        b=zkqXnl3ppBREm+s27eMau7OtbqkpZ3HfZ/wECaez9v8dXIRjX/akHAtG3FAr+MKdv3
         SkOv1UuXNqQtVCK/ruOjbzYiZL7hOOSjte/n2mcDm8d3cxMhNHse20/nIrNnwxY8z/oC
         1AY8NSs/CWui5O7RfrhEJ5dvYjX7xSUWqu5CRpRDJ82mMQVVkd200sqTIkIapHc+WUCD
         XEcFVRBN/e7jvsMWpmhb81gI49sS32+v8ywlU79jh+cyh2DW+LzwwwuanWyFgIHGYbLH
         jVRzIYIElPnViG9JXgUMaJLnXWQiKq2oWKfYmJMTnpZBW9IEDMuY/weRMwMo00oqeyLi
         9qYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=KUFsgeDhP6bohsS82X89m8W3lm8lKKrQc7ypVc4wVww=;
        b=RoFl1NMXT5OiPLzvmzk0wiRyJ7bFTHZhqCeaaqfS6OnzcRdGPLxtuiV0AIyVCkVYTy
         NLRhRHHuc1XFT4k2buCMQ3oRawyfGQNDmI9BwpxaRNx4SmvP6yQrJ34vYSwP7fYNsvX7
         +NzgENjsZoZlMZx0ZfVF49Wg43G9PVp/HNRDZxQcXL046LGraChnUak+4ZuvNlAHy9LW
         CqRKv+fLbFz10RsMXuH6bROpmdn+aVxsspERmobf9oy3kGNRQSgbVWFbDGZXvCwQAjVP
         nqNUwbjk6ikgq1YOT/uCCry+zSfkbZNLCHRRdOGNVnkfsmbQIK4PDh8MFnal665eBQIX
         3zeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
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
Subject: [PATCH 3/8] Uprobe: Rename map_info to uprobe_map_info
Date: Tue, 13 Mar 2018 18:25:58 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031312-0012-0000-0000-000005BD6631
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031312-0013-0000-0000-000019396961
Message-Id: <20180313125603.19819-4-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130154
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827147158689995?=
X-GMAIL-MSGID: =?utf-8?q?1594827147158689995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

map_info is very generic name, rename it to uprobe_map_info.
Renaming will help to export this structure outside of the
file.

Also rename free_map_info() to uprobe_free_map_info() and
build_map_info() to uprobe_build_map_info().

No functionality changes.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 kernel/events/uprobes.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 535fd39..081b88c1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -695,27 +695,29 @@ static void delete_uprobe(struct uprobe *uprobe)
 	put_uprobe(uprobe);
 }
 
-struct map_info {
-	struct map_info *next;
+struct uprobe_map_info {
+	struct uprobe_map_info *next;
 	struct mm_struct *mm;
 	unsigned long vaddr;
 };
 
-static inline struct map_info *free_map_info(struct map_info *info)
+static inline struct uprobe_map_info *
+uprobe_free_map_info(struct uprobe_map_info *info)
 {
-	struct map_info *next = info->next;
+	struct uprobe_map_info *next = info->next;
 	kfree(info);
 	return next;
 }
 
-static struct map_info *
-build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
+static struct uprobe_map_info *
+uprobe_build_map_info(struct address_space *mapping, loff_t offset,
+		      bool is_register)
 {
 	unsigned long pgoff = offset >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
-	struct map_info *curr = NULL;
-	struct map_info *prev = NULL;
-	struct map_info *info;
+	struct uprobe_map_info *curr = NULL;
+	struct uprobe_map_info *prev = NULL;
+	struct uprobe_map_info *info;
 	int more = 0;
 
  again:
@@ -729,7 +731,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 			 * Needs GFP_NOWAIT to avoid i_mmap_rwsem recursion through
 			 * reclaim. This is optimistic, no harm done if it fails.
 			 */
-			prev = kmalloc(sizeof(struct map_info),
+			prev = kmalloc(sizeof(struct uprobe_map_info),
 					GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			if (prev)
 				prev->next = NULL;
@@ -762,7 +764,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 	}
 
 	do {
-		info = kmalloc(sizeof(struct map_info), GFP_KERNEL);
+		info = kmalloc(sizeof(struct uprobe_map_info), GFP_KERNEL);
 		if (!info) {
 			curr = ERR_PTR(-ENOMEM);
 			goto out;
@@ -774,7 +776,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 	goto again;
  out:
 	while (prev)
-		prev = free_map_info(prev);
+		prev = uprobe_free_map_info(prev);
 	return curr;
 }
 
@@ -782,11 +784,11 @@ static inline struct map_info *free_map_info(struct map_info *info)
 register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 {
 	bool is_register = !!new;
-	struct map_info *info;
+	struct uprobe_map_info *info;
 	int err = 0;
 
 	percpu_down_write(&dup_mmap_sem);
-	info = build_map_info(uprobe->inode->i_mapping,
+	info = uprobe_build_map_info(uprobe->inode->i_mapping,
 					uprobe->offset, is_register);
 	if (IS_ERR(info)) {
 		err = PTR_ERR(info);
@@ -825,7 +827,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 		up_write(&mm->mmap_sem);
  free:
 		mmput(mm);
-		info = free_map_info(info);
+		info = uprobe_free_map_info(info);
 	}
  out:
 	percpu_up_write(&dup_mmap_sem);
-- 
1.8.3.1
