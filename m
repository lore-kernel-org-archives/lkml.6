Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeCVUUx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:20:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39123 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbeCVUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:20:49 -0400
X-Google-Smtp-Source: AG47ELve4FoiE+U2O4gWMqEeUCxqOFTs0ryEhGFzlzYbWibFJQqhCiWTinKO9BI5MvehRZQzvJq2Lg==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 06/19] powerpc: Make function btext_initialize static
Date: Thu, 22 Mar 2018 21:19:52 +0100
Message-Id: <20180322202007.23088-7-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function can be static, make it so, this fix a warning treated as
error with W=1:

  arch/powerpc/kernel/btext.c:173:5: error: no previous prototype for ‘btext_initialize’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/btext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 6537cba1a758..38ae3ffe44f6 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -170,7 +170,7 @@ void btext_map(void)
 	boot_text_mapped = 1;
 }
 
-int btext_initialize(struct device_node *np)
+static int btext_initialize(struct device_node *np)
 {
 	unsigned int width, height, depth, pitch;
 	unsigned long address = 0;
-- 
2.11.0
