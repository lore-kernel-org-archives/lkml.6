Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932384AbeDWTgv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:36:51 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43510 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932262AbeDWTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:36:50 -0400
X-Google-Smtp-Source: AB8JxZoS/LaItBcaS4YqGsYDRu8ycayPqYhPj98SH4FtLiUY5JXfFI73VepxRMnCguAh0679o9bJew==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/mm/radix: use do/while(0) trick for single statement block
Date: Mon, 23 Apr 2018 21:36:38 +0200
Message-Id: <20180423193638.10535-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180408194424.8719-1-malat@debian.org>
References: <20180408194424.8719-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7a22d6321c3d ("powerpc/mm/radix: Update command line parsing for
disable_radix") an `if` statement was added for a possible empty body
(prom_debug).

Fix the following warning, treated as error with W=1:

  arch/powerpc/kernel/prom_init.c:656:46: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: update macro directly

 arch/powerpc/kernel/prom_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 5ae153b97d0a..7edf3aa5bc6d 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -103,7 +103,7 @@ int of_workarounds;
 #ifdef DEBUG_PROM
 #define prom_debug(x...)	prom_printf(x)
 #else
-#define prom_debug(x...)
+#define prom_debug(x...)	do { } while (0)
 #endif
 
 
-- 
2.11.0
