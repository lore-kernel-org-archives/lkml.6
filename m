Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E1EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD32C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD32C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeGRHtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:49:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbeGRHtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:49:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6I78eEL073478
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:12:41 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ka0hxh0vv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:12:41 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 18 Jul 2018 08:12:38 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 08:12:34 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6I7CXLj27590852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 07:12:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE18842045;
        Wed, 18 Jul 2018 10:12:51 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 253884204D;
        Wed, 18 Jul 2018 10:12:51 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.216])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 18 Jul 2018 10:12:51 +0100 (BST)
Date:   Wed, 18 Jul 2018 10:12:31 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        syzbot <syzbot+121be635a7a35ddb7dcb@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: kernel BUG at fs/userfaultfd.c:LINE! (2)
References: <000000000000dcb1a1057112c66a@google.com>
 <20180717192806.GI75957@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717192806.GI75957@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18071807-0008-0000-0000-000002547029
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071807-0009-0000-0000-000021BAC50C
Message-Id: <20180718071230.GA4302@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=869 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:28:06PM -0700, Eric Biggers wrote:
> [+Cc userfaultfd developers and linux-mm]
> 
> The reproducer hits the BUG_ON() in userfaultfd_release():
> 
> 	BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
> 	       !!(vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));

Thanks for the CC.

The fix is below.

--
Sincerely yours,
Mike.

From 3711b6a72abe3796b2b97fdba8eadd995b29f195 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Wed, 18 Jul 2018 09:45:54 +0300
Subject: [PATCH] userfaultfd: remove uffd flags from vma->vm_flags if
 UFFD_EVENT_FORK fails

The fix in commit 0cbb4b4f4c44 ("userfaultfd: clear the
vma->vm_userfaultfd_ctx if UFFD_EVENT_FORK fails") cleared the
vma->vm_userfaultfd_ctx but kept userfaultfd flags in vma->vm_flags that
were copied from the parent process VMA.

As the result, there is an inconsistency between the values of
vma->vm_userfaultfd_ctx.ctx and vma->vm_flags which triggers BUG_ON in
userfaultfd_release().

Clearing the uffd flags from vma->vm_flags in case of UFFD_EVENT_FORK
failure resolves the issue.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reported-by: syzbot+121be635a7a35ddb7dcb@syzkaller.appspotmail.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Eric Biggers <ebiggers3@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/userfaultfd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 594d192b2331..bad9cea37f12 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -633,8 +633,10 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		down_write(&mm->mmap_sem);
 		for (vma = mm->mmap; vma; vma = vma->vm_next)
-			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx)
+			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+				vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
+			}
 		up_write(&mm->mmap_sem);
 
 		userfaultfd_ctx_put(release_new_ctx);
-- 
2.7.4

 

