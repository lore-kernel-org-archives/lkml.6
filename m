Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5706A2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547121297;
	bh=TuhlOxYENEjN1XpZi9oQsi5ebnGUHDROSmDIj+CDb5U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qTqXHoBgP1hXaMW7MheVI+2g6Ppv8bVyRabjbmalNFQ7GkjqUS/K8293RhhHyOxZq
	 U+3ZT3uz1TtZb4w3vdDA25OR7eqM39a8APKB6CDjx9gUL4DGalJP8VhmSh0zpR82T1
	 Cidhz7TdVdWUi4wQfPx/yr5QBjlRqxHxtUEUy5RE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfAJLy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbfAJLy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:54:56 -0500
Received: from localhost.localdomain (unknown [115.199.179.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93024214DA;
        Thu, 10 Jan 2019 11:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547121295;
        bh=TuhlOxYENEjN1XpZi9oQsi5ebnGUHDROSmDIj+CDb5U=;
        h=From:To:Cc:Subject:Date:From;
        b=1iblWmYewgA4+/RByqe3CgUWko9wCinV0Vdqg/ewCFv9hC3/V2MPWc4itrEOkSdJC
         7exA/jExe6UdxTfR+ZhsJlDnw7eGCBKrq+mGwozgbygtxVncAx+L/KqaIeisNJqqTC
         4E1gnbQKXu5XL94neBuB6rb8MJbi12AbRhzynXtU=
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: fixup compile error with CPU 810.
Date:   Thu, 10 Jan 2019 19:54:47 +0800
Message-Id: <1547121287-12824-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

This bug is from commit f553aa1c13cb:
  "csky: fixup relocation error with 807 & 860".

I forgot to compile with 810 for that patch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
index 0b028ee..b5ad7d9 100644
--- a/arch/csky/kernel/module.c
+++ b/arch/csky/kernel/module.c
@@ -28,7 +28,7 @@
 
 static void jsri_2_lrw_jsr(uint32_t *location)
 {
-	uint16_t location_tmp = (uint16_t *)location;
+	uint16_t *location_tmp = (uint16_t *)location;
 
 	if (IS_BSR32(*location_tmp, *(location_tmp + 1)))
 		return;
-- 
2.7.4

