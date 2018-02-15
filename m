Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167307AbeBOVIH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:08:07 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52940 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163660AbeBOVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:08:04 -0500
X-Google-Smtp-Source: AH8x2265/qQQ82qJe/VpAHBMDJPvn5ROlaQROtFw2FDHWt5Osuapc/iS5ctCr35+R1erpSpAiMflBw==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-sparse@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] disable sparse warnings about unknown attributes
Date: Thu, 15 Feb 2018 22:07:50 +0100
Message-Id: <20180215210750.28813-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.16.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, sparse issues warnings on code using an attribute
it doesn't know about.

One of the problem with this is that these warnings have no
value for the developer, it's just noise for him. At best these
warnings tell something about some deficiencies of sparse itself
but not about a potential problem with code analyzed.

A second problem with this is that sparse release are, alas,
less frequent than new attributes are added to GCC.

So, avoid the noise by asking sparse to not warn about
attributes it doesn't know about.

Reference: https://marc.info/?l=linux-sparse&m=151871600016790
Reference: https://marc.info/?l=linux-sparse&m=151871725417322
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 79ad2bfa2..8d9a7374c 100644
--- a/Makefile
+++ b/Makefile
@@ -388,7 +388,7 @@ PYTHON		= python
 CHECK		= sparse
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
-		  -Wbitwise -Wno-return-void $(CF)
+		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
 NOSTDINC_FLAGS  =
 CFLAGS_MODULE   =
 AFLAGS_MODULE   =
-- 
2.16.0
