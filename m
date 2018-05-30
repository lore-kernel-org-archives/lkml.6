Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeE3VFs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:05:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32856 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeE3VFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:05:47 -0400
X-Google-Smtp-Source: ADUXVKL9/mh42aA2K7FMRIf3x/L52JwOtDm0q+sPOUBzK7R3pWxxg5lW9SLmrtAsyWO/NSb6xLZnCQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] h8300:let the checker know that size_t is ulong
Date: Wed, 30 May 2018 23:03:43 +0200
Message-Id: <20180530210343.22320-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All 64bit archs use unsigned long for size_t and most 32bit
archs use 'unsigned int'. By default, this is what is assumed
by sparse.

However, on h8300 (a 32bit arch) size_t is unsigned long which
can led sparse to emit wrong warnings.

Fix this by passing to sparse the flag -msize-long, telling it
that size_t is unsigned long.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/h8300/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index e1c02ca23..eaac6685f 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -22,6 +22,8 @@ KBUILD_CFLAGS += -DUTS_SYSNAME=\"uClinux\"
 KBUILD_AFLAGS += $(aflags-y)
 LDFLAGS += $(ldflags-y)
 
+CHECKFLAGS += -msize-long
+
 ifeq ($(CROSS_COMPILE),)
 CROSS_COMPILE := h8300-unknown-linux-
 endif
-- 
2.17.0
