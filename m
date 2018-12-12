Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1707C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965CC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbbAB/tJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965CC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLLBy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:54:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38830 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLBy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:54:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so7543623pgc.5;
        Tue, 11 Dec 2018 17:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wMiU8m4FxK5Mmyx9m3CouY8SU7XPJqd6xuSRWNHMlC0=;
        b=RbbAB/tJGzIvFWL6BzgPv49EKviGxgOa5dyIiHKU0Ff/aqpFBFQEL3VKNvpF+wQUvZ
         09yNTwnO21L0j2dTe6/xS87TsS5USWWxr82FFSyQYN6UwPgD0FIxz+MvYIecL0S6mwFn
         yTo5oHWouy0mjkhOFktBMtzYo7pInKuqdMw1jCvYQ3GunaUqtEYhCm4AiiNTDkVGXmas
         5OlNMPOzR5Yrx05BX6gganBGscMUAdBqgnCUyOEnEeWmj6wPxxDYRwj6iIu3YnsV3gqJ
         GURMWmtGvFSbN3651UDuQ/wrwIRaIuX1IMOFk2dFLvApH4lj2W0bCT+nOGRFfdlXVb3z
         4NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wMiU8m4FxK5Mmyx9m3CouY8SU7XPJqd6xuSRWNHMlC0=;
        b=GAiWVKz/o0TPW2rX20M3RAV2neXBZVTdCyqM+VlRQY9tEKXgtcRR/tiExRcmyfxeXl
         0U5ycYG1NK0YrH+DhVHC8JwQ0iqYSvzxPzcOoOjqMIn7oHGg1VodioaTpuiFwgdn4BzB
         8YOnSltd52WwtmvD7HZTgYKA2KK4ngfDqFaQhkfKZrf4kNh0BiWZrTVpqIXI1bh7iicX
         I+dY7rmwd7hLYKrHcRPehectI9priiTZvxSTcCby/9Si3VqPsE7ShUjrNY36EXwG8276
         iy9Ja3orEttDIaPT497Um8vaBKKve8dqJe6K2idnhfYjaaLk9lHfo9podnscBjPfVKh4
         P+7A==
X-Gm-Message-State: AA+aEWaEPmu4wLbVGFXfJG3rhCCYAqfyx/i84N//+DkC5bA9tHUqim9+
        M2cV/fdC0joFfJ6y2E8RbZM=
X-Google-Smtp-Source: AFSGD/WkkVhDjGPIxDxaxnO+6+qESCBRXgjdab7i8B6Uu1lWvSVNFS4nqSooGwbXU0YRW5rbOGHEqw==
X-Received: by 2002:a62:3948:: with SMTP id g69mr18795627pfa.114.1544579666117;
        Tue, 11 Dec 2018 17:54:26 -0800 (PST)
Received: from VM_15_152_centos.localdomain ([193.112.178.48])
        by smtp.gmail.com with ESMTPSA id r130sm30478813pfr.48.2018.12.11.17.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 17:54:25 -0800 (PST)
From:   gchen.guomin@gmail.com
To:     <guominchen@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     guomin chen <gchen.guomin@gmail.com>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Fix mm->owner point to a task that does not exists.
Date:   Wed, 12 Dec 2018 09:54:02 +0800
Message-Id: <1544579642-29626-1-git-send-email-gchen.guomin@gmail.com>
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
Cc: <kvm@vger.kernel.org>
Cc: <virtualization@lists.linux-foundation.org>
Cc: <netdev@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: guomin chen <gchen.guomin@gmail.com>
---
 drivers/vhost/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6b98d8e..7f8586a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -368,6 +368,10 @@ static int vhost_worker(void *data)
 		}
 	}
 	unuse_mm(dev->mm);
+	/* current->mm needs to be processed by the later exit_mm() */
+	task_lock(current);
+	current->mm = dev->mm;
+	task_unlock(current);
 	set_fs(oldfs);
 	return 0;
 }
-- 
1.8.3.1

