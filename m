Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeCVUWe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:22:34 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46488 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeCVUVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:21:06 -0400
X-Google-Smtp-Source: AG47ELvJm5PQ1PFeQaA3piXJ5S1tPmrFQM1is4SiE1kAD4mvw5zbTUpaRkLbTrmLzPumK5KN097K2g==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 15/19] powerpc: Add missing prototype
Date: Thu, 22 Mar 2018 21:20:01 +0100
Message-Id: <20180322202007.23088-16-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one missing prototype for function rh_dump_blk. Fix warning treated as
error in W=1:

  arch/powerpc/lib/rheap.c:740:6: error: no previous prototype for ‘rh_dump_blk’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/rheap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/rheap.h b/arch/powerpc/include/asm/rheap.h
index 172381769cfc..e75d96de19a0 100644
--- a/arch/powerpc/include/asm/rheap.h
+++ b/arch/powerpc/include/asm/rheap.h
@@ -83,6 +83,9 @@ extern int rh_get_stats(rh_info_t * info, int what, int max_stats,
 /* Simple dump of remote heap info */
 extern void rh_dump(rh_info_t * info);
 
+/* Simple dump of remote info block */
+extern void rh_dump_blk(rh_info_t *info, rh_block_t *blk);
+
 /* Set owner of taken block */
 extern int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner);
 
-- 
2.11.0
