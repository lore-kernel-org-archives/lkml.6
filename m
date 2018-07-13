Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A672ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34B32147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="OXTawfza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34B32147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbeGMAVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:21:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36253 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387819AbeGMAVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:21:50 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so11358256plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z15UaSzJRjo8tNMEdcU0lrFYH9loaE8GxwYN54R5itU=;
        b=OXTawfza7tZUQKWnWOBGLrlyvtI9Y+hFH6QBzVopvbKxoVKtdEDIvrHDuDftvcDR3Y
         8Ss5M8d8QLGHPc9Kdl4oS9FmyCfegf1mM0JEX4GPK9V1Mb0R24CasC9s5qEUbrTXrQ7U
         BM5lbNiqAXVw6frAd4NPI3xvQqP3OE32FkOLSfhADi/USsQ2YlJpw21lijL5M15PVQUC
         z6jMg9Ndy40m3A1J+78/yo54qUV6G5JMZ/96dVxqsWZ3Ub43tZZEfxil693wdnGcGghV
         C/NU74g1iNAj11UPTq42GZXrZoNfsikYy3H6gkUorzJKn2kTXstep/jA0CoTB6ssZeM7
         1sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z15UaSzJRjo8tNMEdcU0lrFYH9loaE8GxwYN54R5itU=;
        b=bxnRQjCPlHMrzRY/DmB2FJOIMjqYOU1ic8Ou4ryFNpLOekYSV4BqL3rNdciYlf+pid
         OxkUu3puu7F+EgiA6ecF6+yLrsPJxINdP9YoEAULXjIbMN6ue/sg0vyR+iLKEGvL7kxy
         p+zr/g7a7szfbuWCf35OY65BR8JaYJeT2Kpaf+PgZJUOiORyoSK7jk7KWy7hoJa8KA1M
         mSQQWFZagpnRAoqDJrX75/SEnx5DTNwsFuPeL1VVW5/hlwtFxbH46BRNMuC01IjhCNn9
         sGFrAMDwrE9L3H5oO/w19j8HxRMl0LDiCR3kPh8wYN6oy/Z5+GeWqqX73aVLYuyWijVO
         VSsw==
X-Gm-Message-State: AOUpUlGBa+hUslhE6N1+2De+C+/Q4qDzSK+wpLmL/RIX86JuJFl9oEjz
        jLZ2fq6MQMLuuwEKVta7zAZatpHYvSs=
X-Google-Smtp-Source: AAOMgpfcZPHhirctnO86EyKWh0Kywl+e2S4Ae1URppZPMQrDHjX6eK4uHA8NpuGeUgtX06XsEeJs0A==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1-v6mr4213791plp.20.1531440592324;
        Thu, 12 Jul 2018 17:09:52 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::5:74a0])
        by smtp.gmail.com with ESMTPSA id b86-v6sm4452067pfj.35.2018.07.12.17.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 17:09:51 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v2 6/7] proc/kcore: optimize multiple page reads
Date:   Thu, 12 Jul 2018 17:09:38 -0700
Message-Id: <296622acfe01efc2e93472b312afe9e374370abe.1531440458.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531440458.git.osandov@fb.com>
References: <cover.1531440458.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The current code does a full search of the segment list every time for
every page. This is wasteful, since it's almost certain that the next
page will be in the same segment. Instead, check if the previous segment
covers the current page before doing the list search.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index a7e730b40154..d1b875afc359 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -428,10 +428,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
 
+	m = NULL;
 	while (buflen) {
-		list_for_each_entry(m, &kclist_head, list) {
-			if (start >= m->addr && start < (m->addr+m->size))
-				break;
+		/*
+		 * If this is the first iteration or the address is not within
+		 * the previous entry, search for a matching entry.
+		 */
+		if (!m || start < m->addr || start >= m->addr + m->size) {
+			list_for_each_entry(m, &kclist_head, list) {
+				if (start >= m->addr &&
+				    start < m->addr + m->size)
+					break;
+			}
 		}
 
 		if (&m->list == &kclist_head) {
-- 
2.18.0

