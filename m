Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 45636C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC57820693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/RtcTZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC57820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeFLEYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:24:01 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39517 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752534AbeFLEYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:24:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id f1-v6so13609651plt.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 21:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=75SXqYADAVAJbgMS9+7iXQBYcJeOijQdTSqG+3LO9+Q=;
        b=O/RtcTZ7Mvv8Jn+llCu4iOz/bd30wSPtectJoHJGZnrL1v7w+FJ/KEXBL8nHUWUN7q
         IPZlBzqVvlB3fQDfL6grmE0dPJTW6FZ+xByid0Rdci6z9iCf/UPNS/Z2alSUcRszDl2p
         HmwjWOBwaCYPPETrJ35l2STYndshToagVyZL+D4B81SPTteLw2CesBRn6mU2UFbLNBoS
         yMmFyssMZ1H8OHGP/0KVOmdMIQQ3RtMol0AyeAgVbvNa6K65+7r/+o7X0FO/Ds7KPyj6
         jJ9or36n4Wml8PFvbifqgMXakIbV61emmrABj2h3/4ZAIeW3tJQdAutyHhVUgpJn7eZs
         IbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=75SXqYADAVAJbgMS9+7iXQBYcJeOijQdTSqG+3LO9+Q=;
        b=mSZ/hL/6AmZBJaKrO2qJS4ZwRR/NdwnKseXpLavfR4gMMtV/RqauztT9Q7ZBAMmEyx
         gdKHi/bJymjWFhOie6Q+14BFYFA3XrZ/iEujX1FmSyKx4xBJfT6lWEvl9DvBJi7WIOHA
         EG/4Sv/Xfo5Z8tQ2UeJQ0YxryPUt70QKB7ZzIcWUw6DOfNvMExoLN3QIBNQspS4kR//6
         M+ZHjtZjl/aUG9xvkL3b9xo3Qw2tgRyb1IHshoUzq9OOA9Re7EGiFRMNW5uwmQnJBNIh
         4GQ5gtmMzIoe/JlDJDlJFXLIwyamU7l8P+OHsa94Aq7t1zDDuCiJyLzEXXcxDfnYfNOs
         lN0g==
X-Gm-Message-State: APt69E2slMoL9sZUimP9LwhMQvOZuOaxCoCaADhQcR5kVSsjD3NBOsUU
        CUBkuqtZZWnEBpFdboCzTuY=
X-Google-Smtp-Source: ADUXVKL/H8m7WXgV1p3tZcKyDp9YYh1ec6d5UtaVlkkobpjClpsPtKBrunQDfYZjKz91zXadRjARww==
X-Received: by 2002:a17:902:600a:: with SMTP id r10-v6mr2267064plj.70.1528777440037;
        Mon, 11 Jun 2018 21:24:00 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id z26-v6sm3502945pfd.60.2018.06.11.21.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:23:59 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] proc: add error handling for kmem_cache_create
Date:   Tue, 12 Jun 2018 12:23:52 +0800
Message-Id: <1528777434-40324-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmem_cache_create fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling kmem_cache_create.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 fs/proc/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 2cf3b74..5d8b2d1 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -104,6 +104,9 @@ void __init proc_init_kmemcache(void)
 	pde_opener_cache =
 		kmem_cache_create("pde_opener", sizeof(struct pde_opener), 0,
 				  SLAB_ACCOUNT|SLAB_PANIC, NULL);
+	if (!proc_inode_cachep || !pde_opener_cache)
+		return -ENOMEM;
+
 	proc_dir_entry_cache = kmem_cache_create_usercopy(
 		"proc_dir_entry", sizeof(struct proc_dir_entry), 0, SLAB_PANIC,
 		offsetof(struct proc_dir_entry, inline_name),
-- 
2.7.4

