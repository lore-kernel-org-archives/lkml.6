Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeCVUUo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:20:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41963 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeCVUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:20:42 -0400
X-Google-Smtp-Source: AG47ELtuIukf4YhCRxgtXWCJqm7x+Pmkun3xxSjLhpvVkt+AxBh7/QWpcQhKjo8ZibyVuq2QTgP56A==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 02/19] powerpc/powermac: Mark variable x as unused
Date: Thu, 22 Mar 2018 21:19:48 +0100
Message-Id: <20180322202007.23088-3-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the value of x is never intended to be read, declare it with gcc
attribute as unused. Fix warning treated as error with W=1:

  arch/powerpc/platforms/powermac/udbg_scc.c:76:9: error: variable ‘x’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/powermac/udbg_scc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c b/arch/powerpc/platforms/powermac/udbg_scc.c
index d83135a9830e..c38ca406df1a 100644
--- a/arch/powerpc/platforms/powermac/udbg_scc.c
+++ b/arch/powerpc/platforms/powermac/udbg_scc.c
@@ -73,7 +73,7 @@ void udbg_scc_init(int force_scc)
 	struct device_node *stdout = NULL, *escc = NULL, *macio = NULL;
 	struct device_node *ch, *ch_def = NULL, *ch_a = NULL;
 	const char *path;
-	int i, x;
+	int i, x __maybe_unused;
 
 	escc = of_find_node_by_name(NULL, "escc");
 	if (escc == NULL)
-- 
2.11.0
