Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E298BECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825DF2147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="LmEonp3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825DF2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbeGMAWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:22:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34561 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbeGMAVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:21:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so4382150pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mOok6eRTTKMGqaqxnoShfJFyRtKog3VsHFbGQRiYpqw=;
        b=LmEonp3cXMlUBjF7yIJy5KxFHSPctHQBN2BOkwHXf+w4q8O94MSR4UmAal58g9UjLt
         ZobsljlvsPPbYMuWBXigDidTfFScMS5Ridp063/Qs4WVYYN46EjZ7Ka2Fm7U0bHA6q4X
         hWCMUjT2badQOGlcx35IFt7H57J3R1QEO4YwYVdCmYmJ4lufqUd5DUSfy4eHNI7hajJg
         pOWbxGRMQZNUzvOSJXMOI5RzLAE6kHqZ4+5tDurFe1pbFjnjPyuU5Z2OcrZXifSA1b+n
         TyX7x/Z0gWVhZQpTdustB8dfOkQfo3QOofQ8fEileqZ/F0MxSiyh2mSx3FWSAmY6K7La
         aCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mOok6eRTTKMGqaqxnoShfJFyRtKog3VsHFbGQRiYpqw=;
        b=b9pRJZjc2nxqCFdjeZnCS4MBFku5JzklO9WUBRiibPdR57/9HJ4wDEUgMy66Z6e7Su
         6vsKsYFTetx365QiRMhGlUWDg4/hk/TUm37T2u5/4FicAx5rTnK1FW8cbYjN5sD7PUTV
         7IEzQ+QrTMtWl8SGrgoKm1emPjt0VQP9QZ/x4/bRsagh0/2yh7Rrz1AF8MRTirmmsde1
         JLgAqpZAlcpjxcOz9BLhx0hC7JApR33Ulkm1RtUnulg/6EdgKfFVH5PJsDZA6u5spcJt
         lS0+C6NASlO6t3Z4oEl1BYfqRF3YFMMym2/CBn3sXHBk62hqnJYcoBkBJ/PQZRI3na+y
         mqbg==
X-Gm-Message-State: AOUpUlFEwGd5k5eQxAW9QjRzVemfADRptMY882vZviKLAi+xqwuOg+Fy
        3I6Nk3q0L81A68xlCe9Baw0Ub3bbBuk=
X-Google-Smtp-Source: AAOMgpdab1kWuRdenNCsng//Ik0Two8N1wdCawD3Wn0Sx2VxJ1Knqv4UvXnr8HuecLo+8P+tKNrA/A==
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr4566482pfo.160.1531440587036;
        Thu, 12 Jul 2018 17:09:47 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::5:74a0])
        by smtp.gmail.com with ESMTPSA id b86-v6sm4452067pfj.35.2018.07.12.17.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 17:09:46 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v2 1/7] proc/kcore: don't grab lock for kclist_add()
Date:   Thu, 12 Jul 2018 17:09:33 -0700
Message-Id: <ddbe991f42b8d49e50645878ad8c1a8168db2e82.1531440458.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531440458.git.osandov@fb.com>
References: <cover.1531440458.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

kclist_add() is only called at init time, so there's no point in
grabbing any locks. We're also going to replace the rwlock with a rwsem,
which we don't want to try grabbing during early boot.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 66c373230e60..ddeeb3a5a015 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -62,6 +62,7 @@ static LIST_HEAD(kclist_head);
 static DEFINE_RWLOCK(kclist_lock);
 static int kcore_need_update = 1;
 
+/* This doesn't grab kclist_lock, so it should only be used at init time. */
 void
 kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 {
@@ -69,9 +70,7 @@ kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 	new->size = size;
 	new->type = type;
 
-	write_lock(&kclist_lock);
 	list_add_tail(&new->list, &kclist_head);
-	write_unlock(&kclist_lock);
 }
 
 static size_t get_kcore_size(int *nphdr, size_t *elf_buflen)
-- 
2.18.0

