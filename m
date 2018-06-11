Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0wIHHJRAHluGawAAmS7hNA
	; Mon, 11 Jun 2018 09:28:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 80052607A4; Mon, 11 Jun 2018 09:28:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1BF63600D0;
	Mon, 11 Jun 2018 09:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BF63600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932709AbeFKJ2c (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:28:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932590AbeFKJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:28:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5B9OA6R069129
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 05:28:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jhp7prp42-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 05:28:29 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 11 Jun 2018 10:28:26 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 10:28:24 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5B9SNiE32243852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 09:28:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF6614203F;
        Mon, 11 Jun 2018 10:18:36 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98D924204B;
        Mon, 11 Jun 2018 10:18:36 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jun 2018 10:18:36 +0100 (BST)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: efault@gmx.de, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] Revert "debugfs: inode: debugfs_create_dir uses mode permission from parent"
Date: Mon, 11 Jun 2018 11:28:10 +0200
X-Mailer: git-send-email 2.16.3
X-TM-AS-GCONF: 00
x-cbid: 18061109-4275-0000-0000-0000028C5DA0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061109-4276-0000-0000-000037937BE0
Message-Id: <20180611092810.21886-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 95cde3c59966f6371b6bcd9e4e2da2ba64ee9775.
It breaks the ioctl(KVM_CREATE_VM) interface.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 fs/debugfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index a913b12fc7f8..13b01351dd1c 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -512,9 +512,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
-	if (!parent)
-		parent = debugfs_mount->mnt_root;
-	inode->i_mode = S_IFDIR | ((d_inode(parent)->i_mode & 0770));
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 
-- 
2.14.3
