Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD33ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677EC2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1iwhRh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677EC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeKIDZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:25:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44663 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKIDZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:25:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so9856037plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sn9YD/aRXB7ZOxgLD7MkEPfRLE73zuHoCyAc48NEeaM=;
        b=S1iwhRh3GA2OJBeh8ULgOYmY3ziu0fZbT+IvyAG+n/Og6XkyJFiuxAYwOcS7iztOHi
         VX2UpesY0Po+gdIEnpfDnYbCm58QSZfaZhckq8EoKKAYpWG7YsSbivMmRPJit6MX4yio
         C2IxvCVIcT7MoyXwYWsRPSctoklK4ApC2LUWk0lQP1/4DXvh29iPDjH/pgqXm7HNFJO4
         OURgU8BMt7PhDT0pKAFp7jUD+RgBsc4VVLjBsCrZG53nX2bQ+pu7EKc77jyznjqM31eD
         CM1Z2QT4Za6tPDnpSDuoJljRi1mTGxcmijaSJENgypBQ0s/5ewL0FzOBDE8vNQjwk01+
         tllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sn9YD/aRXB7ZOxgLD7MkEPfRLE73zuHoCyAc48NEeaM=;
        b=o1rpmIA7wOprAZM1Anh3TGxUfHBmeWa71lTE9a08SY8fSfgGIkxzBCriRL9XisRy4N
         o9xuAea4cKaLjMYNgWGEIuxfXReVf5sjM7gVXeX8EqTD3/+MYNtj/o7cQryAf5sjwB+I
         vTKNPHGy6qkoUk7KofWCuHOTCRgkkX5ygnJKFQ8m3AXx0hWx0iJLK2IvWOyv/6xMHK52
         B1HLxRNRoweUjRDGjyebUg++aEgilT5ovbWCvLtUQ3RI1e2THiOMu5l+eXtuMLEV/bpA
         aq+hQBBzPZ6R1OqdAbJOeIdbkrUOhUahpOJ/CKvG/KnayW6Ok/pWEPFLvUDWg7EpBiK5
         Mwxw==
X-Gm-Message-State: AGRZ1gKc///kKGgI2yfKAANDFy8A01u6nDQ5Mvmj0eiwjpUJJ2Nndp81
        KWoP1Li6Dj1udXr5vT4gCKU=
X-Google-Smtp-Source: AJdET5dJmlK+GjpqS8KMHmM0rBjA6Qv6qck1aOqI1Y2F0g5TNX4NAikIiroDnZ6BMWR94Dl21SkEfA==
X-Received: by 2002:a17:902:6185:: with SMTP id u5-v6mr5378942plj.41.1541699343081;
        Thu, 08 Nov 2018 09:49:03 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x63-v6sm5387946pfk.14.2018.11.08.09.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 09:49:02 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        dan.j.williams@intel.com, linux@dominikbrodowski.net,
        dave.hansen@linux.intel.com, dwmw@amazon.co.uk, mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] mm: mmap: remove verify_mm_writelocked()
Date:   Thu,  8 Nov 2018 12:48:56 -0500
Message-Id: <20181108174856.10811-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get rid of this function. It no longer serves its purpose.This
is a historical artifact from 2005 where do_brk was called outside of
the core mm.We do have a proper abstraction in vm_brk_flags and that one
does the locking properly.So there is no need to use this function.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 mm/mmap.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f7cd9cb966c0..1cee506494d2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2910,16 +2910,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	return ret;
 }
 
-static inline void verify_mm_writelocked(struct mm_struct *mm)
-{
-#ifdef CONFIG_DEBUG_VM
-	if (unlikely(down_read_trylock(&mm->mmap_sem))) {
-		WARN_ON(1);
-		up_read(&mm->mmap_sem);
-	}
-#endif
-}
-
 /*
  *  this is really a simplified "do_mmap".  it only handles
  *  anonymous maps.  eventually we may be able to do some
@@ -2946,12 +2936,6 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	if (error)
 		return error;
 
-	/*
-	 * mm->mmap_sem is required to protect against another thread
-	 * changing the mappings in case we sleep.
-	 */
-	verify_mm_writelocked(mm);
-
 	/*
 	 * Clear old maps.  this also does some error checking for us
 	 */
-- 
2.17.0

