Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC486ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1C92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="gKKSfyFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1C92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeGRXjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:39:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40207 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbeGRXjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:39:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id s17-v6so2684726plp.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lnhh2st4VX6fehK5+kTz/Y62FrZVJOTwdJg1BYsX/0s=;
        b=gKKSfyFh/FCLHtCMA0kiqlE5CiijuIkzB+rU0uXmOJkm8MWdAonRtkDeAeTojl5eKV
         G5jChoGSvQhFrIFPthuvPZLAt944+xJ9e/0NOa6KLae4Bkb/Nu8R9xfXXJUlLadxMQUD
         kRXwJIF2vkxhoRn7Kv09R4V5N4bdAgZYKqKPW2Zw6Y1f4+C7krfhzg3OG9+IS/AAjA+j
         DLPCEJerGHgLBYC6UX0Kj8tj8F+uptRsub6+S5cLJQ73Nk7e+N2nFQdHadEABdSV/sJX
         m531CksYuv6BXdup7P81hbz6eGU+pgiksyJz74Q0qiFMRQ8OLkeA2pNCsF2fiJoXEx97
         Ej5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lnhh2st4VX6fehK5+kTz/Y62FrZVJOTwdJg1BYsX/0s=;
        b=TkF8GlORz46/4pdE7E/vVt9OrN1hicAThOqTjUceu5UBvpt3SnCdXnQ8JNFhe+mDor
         bDCyXWqLo0vDnDOnDcrX63R9IQrREedJ1VzkdBpBBC88LHDgdFiePMCUwlm5v3ZJbPp9
         WEmn5uL/TNuv2JfUgO/5Gly0UVIZlnWhAjWPJjWJ+UtVTcWbKk3Yh2XRQUQd2sawWQOB
         o8CbYMNz2FywVrro19QVJjWm9BcvIR2eVACyyNAVQObuL6UaDp+rfOjlAqeQ33XgjnAy
         i7wGduQdumEV5ib6XLJhebSeS+IL7b2X2b+4cPJ/nVb3QyNTcTLKpIadcJtifySaOpDL
         2V9w==
X-Gm-Message-State: AOUpUlHP1FoM5ULvXA+Naqp1nlXCZObRtVCEGXSNNycmIQvgVm3pjJuV
        euvP2XWzL+kE3R0/JAi/2RTEkkp2BuY=
X-Google-Smtp-Source: AAOMgpc8447Ag1hXtUydGpCL49hHJ4EVktEXb0qgfGD60nGKEio6lV+p/SKdrQrehrzV/AAq27fOVQ==
X-Received: by 2002:a17:902:599b:: with SMTP id p27-v6mr7562887pli.191.1531954755568;
        Wed, 18 Jul 2018 15:59:15 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8800:a9a9:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s16-v6sm6377946pfm.114.2018.07.18.15.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:59:15 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v3 2/8] proc/kcore: don't grab lock for memory hotplug notifier
Date:   Wed, 18 Jul 2018 15:58:42 -0700
Message-Id: <0a4bc89f4dbde8b5b2ea309f7b4fb6a85fe29df2.1531953780.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531953780.git.osandov@fb.com>
References: <cover.1531953780.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The memory hotplug notifier kcore_callback() only needs kclist_lock to
prevent races with __kcore_update_ram(), but we can easily eliminate
that race by using an atomic xchg() in __kcore_update_ram(). This is
preparation for converting kclist_lock to an rwsem.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index b0b9a76f28d6..e83f15a4f66d 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -118,7 +118,7 @@ static void __kcore_update_ram(struct list_head *list)
 	LIST_HEAD(garbage);
 
 	write_lock(&kclist_lock);
-	if (kcore_need_update) {
+	if (xchg(&kcore_need_update, 0)) {
 		list_for_each_entry_safe(pos, tmp, &kclist_head, list) {
 			if (pos->type == KCORE_RAM
 				|| pos->type == KCORE_VMEMMAP)
@@ -127,7 +127,6 @@ static void __kcore_update_ram(struct list_head *list)
 		list_splice_tail(list, &kclist_head);
 	} else
 		list_splice(list, &garbage);
-	kcore_need_update = 0;
 	proc_root_kcore->size = get_kcore_size(&nphdr, &size);
 	write_unlock(&kclist_lock);
 
@@ -593,9 +592,8 @@ static int __meminit kcore_callback(struct notifier_block *self,
 	switch (action) {
 	case MEM_ONLINE:
 	case MEM_OFFLINE:
-		write_lock(&kclist_lock);
 		kcore_need_update = 1;
-		write_unlock(&kclist_lock);
+		break;
 	}
 	return NOTIFY_OK;
 }
-- 
2.18.0

