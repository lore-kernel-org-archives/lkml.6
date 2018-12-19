Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3C3C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E24217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeLSJZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:25:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeLSJZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:25:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D8807F3E8;
        Wed, 19 Dec 2018 09:25:09 +0000 (UTC)
Received: from bsingh.kernel.org.com (unknown [10.76.1.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E845D67164;
        Wed, 19 Dec 2018 09:25:06 +0000 (UTC)
From:   Buland Singh <bsingh@redhat.com>
To:     clemens@ladisch.de
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        prarit@redhat.com, bsingh@redhat.com
Subject: [PATCH] hpet: Fix missing '=' character in the __setup() code of hpet_mmap_enable.
Date:   Wed, 19 Dec 2018 14:55:02 +0530
Message-Id: <20181219092502.3079-1-bsingh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 19 Dec 2018 09:25:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel command parameter 'hpet_mmap' never takes effect due to missing
'=' character in the __setup() code of hpet_mmap_enable and the memory map
of the HPET registers never get expose to userspace.

Signed-off-by: Buland Singh <bsingh@redhat.com>
---
 drivers/char/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 4a22b4b41aef..9bffcd37cc7b 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -377,7 +377,7 @@ static __init int hpet_mmap_enable(char *str)
 	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
 	return 1;
 }
-__setup("hpet_mmap", hpet_mmap_enable);
+__setup("hpet_mmap=", hpet_mmap_enable);
 
 static int hpet_mmap(struct file *file, struct vm_area_struct *vma)
 {
-- 
2.19.1

