Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9269EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C8A20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0dpYw8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C8A20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbeLMErv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:47:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42848 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeLMEru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:47:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so427741plp.9;
        Wed, 12 Dec 2018 20:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eLJRTbAqRgsRGMY4O7tUsKbGxT0XHDoZgsWFMI/bheM=;
        b=a0dpYw8uzAHmrVEinebNliFkQ61tQhlAftQWfLQewsUN70m+wBaD+NmjZ2L5y+MkAC
         r2IAt+fcQujxDJXqZeV8/DJq79bmO37qkKa/Ths+5Nbu+M21cm1prMrmIxwwjdkp6T/h
         7PSJH58iKhC5cjpADYDV0NoIA8CFJTDDa9Eo0ny91WLTt4d+W37BieCiPnFjA3Cwv3ye
         bGNYYl7Gfp2q7XCnFzYPtM8jYMoC98Y04tre+T/Di4tiTLqu5Qm2emNyerCn6DzA/hTv
         7dop98hUFOPH7kyB9u28bPcjGAHzRAMAoSHYS1bh17WS+P/svOcKpCxS5kaXbqqhlkHH
         jDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eLJRTbAqRgsRGMY4O7tUsKbGxT0XHDoZgsWFMI/bheM=;
        b=tfg49opRBIeRcPAcgVEdO9IsRZ8yElNiTqrlHoCXQR57Thljfu6sDyTCR7yAQVSi1L
         NMQ27xmWuJnhAJzEV6j6nYPaWF6llKn09dQS3NSfOzLvrR3UJAXNp28xEQAOJebuTmEq
         ORqKaz3p7A7rij43U1T6FtudE8J1QH55I+9l0i1+KvS3moq462bZM1q1Wiy3XQyCN81D
         yj0xVuH8y9NkWtvEkrVKQhIqtK05E7mCWE04uBxwAAIOhLVjJfSlh691NGsCUoLmJTOZ
         4Muh2EXxVTZzHGG5/L+UpLshyQ0T48kX1XhnaVUkIBZfldJz0Qn0ZcTTUJWqXXw7gI2L
         +y3g==
X-Gm-Message-State: AA+aEWa+xJkLpqMJYYd0WdGvLzfCPm765loJDJul3iPIzRJtqizfSVw3
        CVxx1BABT+TVuyy+DYuvsq0=
X-Google-Smtp-Source: AFSGD/Xv8ROIx4aZA+CEDpph7LQDV/btrympqrOF62OMjGN7vbFMpILAzI+pIRPnqCxRGnLEm/52+g==
X-Received: by 2002:a17:902:887:: with SMTP id 7mr22177157pll.164.1544676469483;
        Wed, 12 Dec 2018 20:47:49 -0800 (PST)
Received: from VM_15_152_centos.localdomain ([193.112.178.48])
        by smtp.gmail.com with ESMTPSA id x186sm786073pfb.59.2018.12.12.20.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 20:47:48 -0800 (PST)
From:   gchen.guomin@gmail.com
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, <guominchen@tencent.com>
Cc:     guomin chen <gchen.guomin@gmail.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH]  Export mm_update_next_owner function for vhost-net
Date:   Thu, 13 Dec 2018 12:47:25 +0800
Message-Id: <1544676445-14897-1-git-send-email-gchen.guomin@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guomin chen <gchen.guomin@gmail.com>

 Under normal circumstances,When do_exit exits, mm->owner will
 be updated on exit_mm(). but when the kernel process calls
 unuse_mm() and then exits,mm->owner cannot be updated. And it
 will point to a task that has been released.

 Below is my issue on vhost_net:
    A, B are two kernel processes(such as vhost_worker),
    C is a user space process(such as qemu), and all
    three use the mm of the user process C.
    Now, because user process C exits abnormally, the owner of this
    mm becomes A. When A calls unuse_mm and exits, this mm->ower
    still points to the A that has been released.
    When B accesses this mm->owner again, A has been released.

 Process A             Process B
 vhost_worker()        vhost_worker()
  ---------             ---------
  use_mm()              use_mm()
   ...
  unuse_mm()
     tsk->mm=NULL
   do_exit()            page fault
    exit_mm()           access mm->owner
   can't update owner   kernel Oops

                        unuse_mm()

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: guomin chen <gchen.guomin@gmail.com>
---
 drivers/vhost/vhost.c | 1 +
 kernel/exit.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6b98d8e..7c09087 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -368,6 +368,7 @@ static int vhost_worker(void *data)
 		}
 	}
 	unuse_mm(dev->mm);
+	mm_update_next_owner(dev->mm);
 	set_fs(oldfs);
 	return 0;
 }
diff --git a/kernel/exit.c b/kernel/exit.c
index 0e21e6d..9e046dd 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -486,6 +486,7 @@ void mm_update_next_owner(struct mm_struct *mm)
 	task_unlock(c);
 	put_task_struct(c);
 }
+EXPORT_SYMBOL(mm_update_next_owner);
 #endif /* CONFIG_MEMCG */
 
 /*
-- 
1.8.3.1

