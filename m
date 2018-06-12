Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ECC2AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE39208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE39208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeFLLtm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:49:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:44903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754019AbeFLLtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:49:41 -0400
Received: from juanniu018037.ss.mogujie.org ([122.225.81.134]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MId0S-1fQVwK39jM-002CVv; Tue, 12 Jun 2018 13:49:09 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2] x86: remove redundant check for kmem_cache_create()
Date:   Tue, 12 Jun 2018 19:48:52 +0800
Message-Id: <1528804132-154948-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:SRzQPuPqcxm7EN2BdxdWGb4Uhp7UFUVLDjTo++bX1e7FUwdUit1
 CKKk4rPDd+rfWmVgB6g0c8GR2haax96xh3PKiorQN1oAW0oeRIdbcs5hthaWLm6KD3RO/f9
 WF05839oTnbdgZVDYUnngPBROoNGT5rBIW5eDVQUWfRm4ZvMGp0vnUwPFkWNzlmyxSkl4gg
 s904BYj4DvPel0U2Ra2yQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3XYV9chKzRg=:Oh4mm8fqcUehXdR4/4WcH6
 EPtQuwnTOuFfBK2t59RUNq37i8e8hMxEY7/UOK0r1pD9ySrlJT474IWZO1YKQpAH15YSeDPKv
 HS8XyJvtHJO5VYVtB/ONuc3QTHQNdHWNwlpu+UxvSYKazK5wrluVeOq9pap/eno8EB6nUBWJH
 7OtKpYTr/wxp9fT0pdrzoqs/ar9imLNL+2J0mhoPKT4yiEsVFdRqT3E9ZXtfPjjBNypFm/9Ea
 jhaEkGnmTnYnxtYe7y+gT0h/Gh3UimvzpgSqxK7IZEb46e69Ojz9uapfRVDc//oEbI7qUWdIN
 Uw8zSjIy/2gEb72Vo/DMZYBhhTntR1klM+IpiZ1NJokNgVuUz2uuJGUWYT22pUqzZQXur78lX
 u6fWHUYPTpsMy+g1q7c8s2Yu0Sya0Us4BkhP2XUVrzhu5yR2nw2lxJ5+Jo+jk0HExAUkFz0l4
 98LBe6cCnRkiE/TgKhcNMNl3G4lzrUw09flD5NBQrI8wYy6GOGZcOw8r02TBYQnbQsOZlw1iP
 fGMvdi4QoSAm7U4vVMFakGJXvI1KtRr1OHRo4yFF2clDjTGwj26VDDIxUZnMH8jkEw31mvcd2
 qetI0jSHuQQCff2MIKfffAEMGMCBHw/nq4JmUBki3pnXp6462+hxwddMg6hQR8m8iQs4KhP4Z
 pkSRlepLkOL8oTcxdgThHzzwLFr1rGTt9L1mNUYWAtM/6LhYl7hhJ4ci2UZiOyOkooBv+4poH
 yVZFhM/10HIYsEu7HC7VAW+tW/MSJUE5KcKv2graIC5LZH2sdsLXVIKTbc0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag 'SLAB_PANIC' implies panic when encouter failure,
So there is no need to check NULL pointer for cache creation.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
v1->v2:
- Keep return type as int instead of changing to void.

 arch/x86/mm/pgtable.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 47b5951..406873d 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -329,9 +329,6 @@ static int __init pgd_cache_init(void)
 	 */
 	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_ALIGN,
 				      SLAB_PANIC, NULL);
-	if (!pgd_cache)
-		return -ENOMEM;
-
 	return 0;
 }
 core_initcall(pgd_cache_init);
-- 
1.8.3.1

