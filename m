Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD76DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F972086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkdm5skY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F972086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeKQJ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:57:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36760 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQJ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:57:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id s11so169292wmh.1;
        Fri, 16 Nov 2018 15:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NvqT/01OOAqA5rJCBzjcbMJKeTqiYCSeqQEQv+tJTRg=;
        b=Lkdm5skYJ3OFwZzL8pyT1xpLqNb5x2IlwfmqE5WjknfNfA0uj74NJ+o1JXFo3XvVaO
         IXDcpnp2UjKH+BtgmwtvF4pOF0mQvNgbfXLCJuoEVhGUCP27uycnT5sKQ+ahhabD9hwN
         pQmaLaHV2zjJZX/pNxw9+nnvw/aSG0S3gnl2GVQja5v4k9wjZOjj8bEsYIPZhnuT7Bfa
         XWz/JFzfvs33PH6QAIUqUvbg0SdMsrWFdL8AuyQzGkIEIrcWhWHAmBJ9vhNNvewCIwPz
         /MdMK79tIm/HMMsjexOH/ex1gpbmXT/+fJsLuwfnJQyGyUPJYP4T6f+M2cPdaL9zyBX6
         6AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NvqT/01OOAqA5rJCBzjcbMJKeTqiYCSeqQEQv+tJTRg=;
        b=HlVzA/zhEe/mQOqpN/zhVNKffYBTaNY+6VgJEUDV65IpibuoWjWp2XUN/mX3yChflc
         5ol8TMcTsFDcgv4sKeiiJrroXkA3ARJsfobx0xSt/LRGBpvwXmAZPaH9w6kIoPUj+n1t
         uby+lfNzrdwcybNt5obbV1tyRAJVyg7mBw8q488RyP4Ss+5/XAdV6QvBrGJ1yfCcqU4+
         eEbu3cLi5hRzNwbUQ9ZnUQGTEhpb7f99VvdJul0LMbUfim7XEgNYrar3lXb6vMEdKNjq
         nhsvyTLUtSUGrDUzaXfC0s7H7vL+lfVPK/rKoUC9I6lxPH9SO5sIs0BqQtcCfJeTQXXX
         jObg==
X-Gm-Message-State: AGRZ1gIDjaIrXtU64ap3LcwhulWCjOy9N5if8+Byq0+utOe4gUPEy694
        ebXOiJX1a7DgfVw+gdbGxUY=
X-Google-Smtp-Source: AFSGD/Vs+CMxl+Yw6vtiU/LDlikKEjzHFpWMvdG0baseivU7Wa+oOIZ7WsgcyWDYsLverWIJWF2WNw==
X-Received: by 2002:a1c:568b:: with SMTP id k133-v6mr182898wmb.4.1542411753842;
        Fri, 16 Nov 2018 15:42:33 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id 73-v6sm8485330wmj.4.2018.11.16.15.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 15:42:33 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] media: videobuf2-core: fix use after free in vb2_mmap
Date:   Fri, 16 Nov 2018 23:42:27 +0000
Message-Id: <20181116234227.27255-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we are using __find_plane_by_offset() to find the matching plane
number and the buffer, the queue is not locked. So, after we have
calculated the buffer number and assigned the pointer to vb, it can get
freed. And if that happens then we get a use-after-free when we try to
use this for the mmap and get the following calltrace:

[   30.623259] Call Trace:
[   30.623531]  dump_stack+0x244/0x39d
[   30.623914]  ? dump_stack_print_info.cold.1+0x20/0x20
[   30.624439]  ? printk+0xa7/0xcf
[   30.624777]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[   30.625265]  print_address_description.cold.7+0x9/0x1ff
[   30.625809]  kasan_report.cold.8+0x242/0x309
[   30.626263]  ? vb2_mmap+0x712/0x790
[   30.626637]  __asan_report_load8_noabort+0x14/0x20
[   30.627201]  vb2_mmap+0x712/0x790
[   30.627642]  ? vb2_poll+0x1d0/0x1d0
[   30.628060]  vb2_fop_mmap+0x4b/0x70
[   30.628458]  v4l2_mmap+0x153/0x200
[   30.628929]  mmap_region+0xe85/0x1cd0

Lock the queue before we start finding the matching plane and buffer so
that there is no chance of the memory being freed while we are about
to use it.

Reported-by: syzbot+be93025dd45dccd8923c@syzkaller.appspotmail.com
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 975ff5669f72..a81320566e02 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -2125,9 +2125,12 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 	/*
 	 * Find the plane corresponding to the offset passed by userspace.
 	 */
+	mutex_lock(&q->mmap_lock);
 	ret = __find_plane_by_offset(q, off, &buffer, &plane);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&q->mmap_lock);
 		return ret;
+	}
 
 	vb = q->bufs[buffer];
 
@@ -2138,12 +2141,12 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 	 */
 	length = PAGE_ALIGN(vb->planes[plane].length);
 	if (length < (vma->vm_end - vma->vm_start)) {
+		mutex_unlock(&q->mmap_lock);
 		dprintk(1,
 			"MMAP invalid, as it would overflow buffer length\n");
 		return -EINVAL;
 	}
 
-	mutex_lock(&q->mmap_lock);
 	ret = call_memop(vb, mmap, vb->planes[plane].mem_priv, vma);
 	mutex_unlock(&q->mmap_lock);
 	if (ret)
-- 
2.11.0

