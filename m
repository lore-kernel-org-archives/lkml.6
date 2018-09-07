Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B71C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AA42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AA42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeIGSDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:03:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:59594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbeIGSDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:03:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E48ADB019;
        Fri,  7 Sep 2018 13:22:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
Subject: [PATCH -resend] xtensa: use generic vga.h
Date:   Fri,  7 Sep 2018 15:22:19 +0200
Message-Id: <20180907132219.12979-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What xtensa has in asm/vga.h is the same as what can be found in
asm-generic/vga.h. So use the latter header.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/include/asm/Kbuild |  1 +
 arch/xtensa/include/asm/vga.h  | 19 -------------------
 2 files changed, 1 insertion(+), 19 deletions(-)
 delete mode 100644 arch/xtensa/include/asm/vga.h

diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 82c756431b49..3310adecafb0 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -26,5 +26,6 @@ generic-y += rwsem.h
 generic-y += sections.h
 generic-y += topology.h
 generic-y += trace_clock.h
+generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/xtensa/include/asm/vga.h b/arch/xtensa/include/asm/vga.h
deleted file mode 100644
index 1fd8cab3a297..000000000000
--- a/arch/xtensa/include/asm/vga.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * include/asm-xtensa/vga.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-
-#ifndef _XTENSA_VGA_H
-#define _XTENSA_VGA_H
-
-#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
-
-#define vga_readb(x)	(*(x))
-#define vga_writeb(x,y)	(*(y) = (x))
-
-#endif
-- 
2.18.0

