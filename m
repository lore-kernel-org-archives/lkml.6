Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeDDULt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:11:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53601 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeDDULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:11:48 -0400
X-Google-Smtp-Source: AIpwx4+DwFkyv6g+1acy6kcM8BQl6796XZKh668Bno81QhZY2myErHfs9FBOEwjwfrtGSG0R0avxOw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/19] powerpc: Add missing prototype
Date: Wed,  4 Apr 2018 22:11:42 +0200
Message-Id: <20180404201142.27691-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-16-malat@debian.org>
References: <20180322202007.23088-16-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one missing prototype for function rh_dump_blk. Fix warning treated as
error in W=1:

  arch/powerpc/lib/rheap.c:740:6: error: no previous prototype for ‘rh_dump_blk’ [-Werror=missing-prototypes]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: remove extern keyword
v2: no change
 arch/powerpc/include/asm/rheap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/rheap.h b/arch/powerpc/include/asm/rheap.h
index 172381769cfc..8e83703d6736 100644
--- a/arch/powerpc/include/asm/rheap.h
+++ b/arch/powerpc/include/asm/rheap.h
@@ -83,6 +83,9 @@ extern int rh_get_stats(rh_info_t * info, int what, int max_stats,
 /* Simple dump of remote heap info */
 extern void rh_dump(rh_info_t * info);
 
+/* Simple dump of remote info block */
+void rh_dump_blk(rh_info_t *info, rh_block_t *blk);
+
 /* Set owner of taken block */
 extern int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner);
 
-- 
2.11.0
