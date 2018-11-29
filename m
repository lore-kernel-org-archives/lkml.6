Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A786F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO5Y1Z+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A786F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeK2WtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:49:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32946 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeK2WtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:49:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so831417pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 03:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qzn765aUDqzzJ2gdZD9+8/pJfQHoGGe3O3x6M3DeWjI=;
        b=dO5Y1Z+HaDnbkNRHicAUnWF1WU8KOQEHGMTo6+1eVGGKDh6uRjq5WbEF7QyYHhn8sQ
         lsLQP2UO21xNAW6IRrAl+69Pgz4Z0nfWAPN9IG64kYhmJXHhSPd/D/gzm2XKs4EuZGJm
         wdG5gQqECc+aCWNwUE4R7z2bbgW56W4Eb2WXp+cL8w/3UkgxZv0HG4wn3MTDPe/c5OxQ
         RUTfMTk5DUlcg+QTyrTAbYgpGWIy3cudNZyeZOIQpzjI6D+0bjrzlDAqicQXdlPFoqpw
         fx4tAr3kDKADM/8HjhchX7Z/JMp5BjAJkRiIhPmmgIPVFuRAuk2N78uYYVJR7Mnunqyq
         WrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qzn765aUDqzzJ2gdZD9+8/pJfQHoGGe3O3x6M3DeWjI=;
        b=rm5tKDWBiqneELmGijn0igcKc6AeOnb3P+kpcq/K0lKJKcERrLi2cFVL0mPCx9iKOQ
         H9U4WsGjBTRTRYhqXcHJzh4S6RMfmF94onKPsimKP/XYmSQo0fdm43VWN+m0YcNiA9oh
         XkM26He2b4Y44wUp6qdFZyMSQsdtQF3+JUxcpl5VJ0d3H5wns+MbVr6pufTymLppLun0
         xMWnsi8nVzu1THylOhaqEFi9qk4Y1YbKy7MYaUxxpqvNBQYwH/O1uz7DpCAOYVdVsHbH
         XOllAtnCbmhRERd6jlbwa9iYdK3QG8os2+iPZ4yEtZzj5iV5+Kh5Kb2I7piPWk6Mmd4j
         +2og==
X-Gm-Message-State: AA+aEWZrJUpdVngDRzH3z9lBF5+Yalnj7Ial8TlmVQpjF9rl7iXMFOp6
        3xxnLW1/8/tKe736yH72rLDLbDgm/Jo=
X-Google-Smtp-Source: AFSGD/XhP+Ouxm5cTpqRlnSdomAYQE9VQ1sxxQdSf3TkisyysHc95wn9MqL5NiMXkg6pBiZiGoI5Og==
X-Received: by 2002:a62:3ac1:: with SMTP id v62mr1022372pfj.87.1543491860432;
        Thu, 29 Nov 2018 03:44:20 -0800 (PST)
Received: from VM_67_44_centos.localdomain ([150.109.46.178])
        by smtp.gmail.com with ESMTPSA id c67sm3041141pfg.170.2018.11.29.03.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 03:44:20 -0800 (PST)
From:   Yongkai Wu <nic.wuyk@gmail.com>
X-Google-Original-From: Yongkai Wu <nic_w@163.com>
To:     mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, nic_w@163.com
Subject: [PATCH] hugetlbfs: Call VM_BUG_ON_PAGE earlier in free_huge_page
Date:   Thu, 29 Nov 2018 19:44:03 +0800
Message-Id: <1543491843-23438-1-git-send-email-nic_w@163.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A stack trace was triggered by VM_BUG_ON_PAGE(page_mapcount(page),
page) in free_huge_page().  Unfortunately, the page->mapping field
was set to NULL before this test.  This made it more difficult to
determine the root cause of the problem.

Move the VM_BUG_ON_PAGE tests earlier in the function so that if
they do trigger more information is present in the page struct.

Signed-off-by: Yongkai Wu <nic_w@163.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7f2a28a..14ef274 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1248,10 +1248,11 @@ void free_huge_page(struct page *page)
 		(struct hugepage_subpool *)page_private(page);
 	bool restore_reserve;
 
-	set_page_private(page, 0);
-	page->mapping = NULL;
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
+
+	set_page_private(page, 0);
+	page->mapping = NULL;
 	restore_reserve = PagePrivate(page);
 	ClearPagePrivate(page);
 
-- 
1.8.3.1

