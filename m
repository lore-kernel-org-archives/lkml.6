Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELuqiUkV8qQzN9h2PeIXo1UsJpm4Z79/NMXCGpkQY7WzRMJ48ey9noI9MEzCT8yZ+KRs7fm+
ARC-Seal: i=1; a=rsa-sha256; t=1520295987; cv=none;
        d=google.com; s=arc-20160816;
        b=CiR8humWX8ZrR5VSBs/ybTTkeMc5vVjjJ0BqcQ5quxAYvMGdUo5yJmJzwaHKrh0QIF
         VbvLjCVVU64qxCf3wtnlJla7Hl4XGVGeNAMrIH2dKqN4One8ULP3MTk5AMWb3Vyker9+
         UGiwq0dNgeL6vIm0AAWhL67Qm/i2pwUn0qGpCkIHTyXXkf8LtlFmbe6QN3faLIPeUHvI
         CHUIXAo0tSK55gO3gp6u6/oTqV0x8i95XtZN0OYa2rZwP3WTmpjENw7UVDjeXXHrgFVZ
         n5CDnbrhtJdEciUNDDZuMSyEN0jkeV3UBXrxA/u7Ud+5HTNaKrRZEfqTO5fYCW+OLW6V
         Anyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=CoahtpSACNL1iQzZIsxk+OijmxP6/iYmC9GGbrKDcG4=;
        b=qoP3FNcLrhWG1w5g63ZzqtUQu2s9UWF2iZZMnOLN1QmQcYYFOo3DhYn66KA7MV3H3G
         3ORQ7ub/Xwx1qnhcjMyb0k5d5+dhHXwe9nREiUrQSYTpg0QPDLUZsoEY2l0zPOE+teiC
         6wfK9TR2GylB27O2ZaMW909AGIoGMpQ71K+gfCBuUVRzvqsQ6vyM3OT9TfLcRlc3UkH/
         eEs+yaz1joqSTfIP6VrB62o2gPkUy/WkVCRtjTuZLD3YZ33Fv27qFT7g6rqGaHEnqT9Z
         CHcG23HNl0VxEjzQS/SU0V5hBiClbXNwQfvZSQ1VJ1Z2B5vAclmNvC0FvB1CoxHkCAfr
         lzYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gc/YXOYL;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gc/YXOYL;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 30/65] kaiser: fix build and FIXME in alloc_ldt_struct()
Date: Mon,  5 Mar 2018 19:25:03 -0500
Message-Id: <20180306002538.1761-31-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=762
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145885124288153?=
X-GMAIL-MSGID: =?utf-8?q?1594145885124288153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Include linux/kaiser.h instead of asm/kaiser.h to build ldt.c without
CONFIG_KAISER.  kaiser_add_mapping() does already return an error code,
so fix the FIXME.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 9b94cf97f42ca30fe9b5010900fa6e1d6855a9f6)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/ldt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 9c6ebaf0a83b..c388247e0353 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -48,7 +48,7 @@ static struct ldt_struct *alloc_ldt_struct(int size)
 {
 	struct ldt_struct *new_ldt;
 	int alloc_size;
-	int ret = 0;
+	int ret;
 
 	if (size > LDT_ENTRIES)
 		return NULL;
@@ -76,10 +76,8 @@ static struct ldt_struct *alloc_ldt_struct(int size)
 		return NULL;
 	}
 
-	// FIXME: make kaiser_add_mapping() return an error code
-	// when it fails
-	kaiser_add_mapping((unsigned long)new_ldt->entries, alloc_size,
-			   __PAGE_KERNEL);
+	ret = kaiser_add_mapping((unsigned long)new_ldt->entries, alloc_size,
+				 __PAGE_KERNEL);
 	if (ret) {
 		__free_ldt_struct(new_ldt);
 		return NULL;
-- 
2.16.2
