Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5547C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7FF21479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550477517;
	bh=F9y7lSaqxWYTV9o8SAQ8gMQ0TIi7C/kjNQfrjGg8j6g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qveHnHrj6p+Qh30CZqh0Tfsr4+8D7EDFm8V3PvjR1K3oZXMLmuCs7WETJhUnI0TTW
	 UmZjTWZOj9GNc4aMXYh4RRzDKhvYmPyp1Pmxy5VwEDAVyuyVjwI/xTkq87dB2fOc6D
	 yi8c6kDuj3hxqSOKm4J987D/FBm5osa0pBgCuouQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfBRILz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:11:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46783 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:11:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so8048506pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcZRnl9lE4QIkCI9psKc6XHAkAhb2o/LPyacWFNhV/U=;
        b=oJLd1xUKXzNOyX9QvChe8wA7ahme5SG2YsDQ63pkv1TwtGcoNlOwc79LjVAY1VrSKI
         iYQzyy++6a5pHcyiZeyjwfzqRP45NIE9oO2ZqZrz+KruyL52iWh0AudMyy4uwj/3ETXZ
         l6AYOgRj9PCKutOMjxEa/v64MRv1rIth8Vd+kIpdJIwyMmDTVCvW8YhhedRYJHaCmBVV
         nUcqweLjkRXR/78oRqt/sKLUXblTPF8sTPmrWsaPi7PzZckRllbro/FVH4pSBwPaPd9+
         vv4QlDC9A3RCs8/KQfD1PTld5PNF0EEJY8IlgihsEADtSop4AYS8M/7BVNex6m9NLdt5
         wsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZcZRnl9lE4QIkCI9psKc6XHAkAhb2o/LPyacWFNhV/U=;
        b=oTM/6CzICkaO37qJkDdjIWoxoegvJPk6jih70ysX5kx8kO88vO9v4NXSTQZrkw65TR
         70i+RmSqnw9Ow4uQosWENnu9SAb/QzYkLkAekLwAa4wH5vn8ocDFAz5vu9W26uJn1Oob
         ETsdHqMaCWTCRliMjjqx6DPCrfm+IjoPAjOohAKUF9mDH8483R75f/hPh9NZa+LQaVp2
         Ca8hXOkYwJnVzHbeuZJ+HujYPmtHqWJXYzTHPYZ9L8NSvbL4Wpp/PyelK0qKxVOmmAjl
         RbPzbTnv+j6gh4YiOceYXbNawLeZ/3pBhT7/1qzLJyO8hgIbYVsjOwblK/azJ2WfMB8b
         stBg==
X-Gm-Message-State: AHQUAubuq2ha8Q26vNdkz+YRL6JQWDe2aAQnOFrCEDohKfaj4ZgKc2/C
        5ws+jZiEUVqHmOPemGnfO90=
X-Google-Smtp-Source: AHgI3IaX38tq461oE/F9v/3NRbYaDAsj9yeudPC/GKwX9bpSoJRbiqKsOW3XAXBofp2H5i/LnfJxpg==
X-Received: by 2002:a63:d342:: with SMTP id u2mr17722234pgi.41.1550477513947;
        Mon, 18 Feb 2019 00:11:53 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id l87sm31865694pfj.35.2019.02.18.00.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 00:11:52 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>, Todd Kjos <tkjos@google.com>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH] binder: reduce mmap_sem write-side lock
Date:   Mon, 18 Feb 2019 17:11:45 +0900
Message-Id: <20190218081145.86633-1-minchan@kernel.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binder has used write-side mmap_sem semaphore to release memory
mapped at address space of the process. However, right lock to
release pages is down_read, not down_write because page table lock
already protects the race for parallel freeing.

Please do not use mmap_sem write-side lock which is well known
contented lock.

Cc: Todd Kjos <tkjos@google.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/android/binder_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 022cd80e80cc3..2a62553b20fcc 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -964,7 +964,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		if (!mmget_not_zero(alloc->vma_vm_mm))
 			goto err_mmget;
 		mm = alloc->vma_vm_mm;
-		if (!down_write_trylock(&mm->mmap_sem))
+		if (!down_read_trylock(&mm->mmap_sem))
 			goto err_down_write_mmap_sem_failed;
 	}
 
@@ -980,7 +980,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 		trace_binder_unmap_user_end(alloc, index);
 
-		up_write(&mm->mmap_sem);
+		up_read(&mm->mmap_sem);
 		mmput(mm);
 	}
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

