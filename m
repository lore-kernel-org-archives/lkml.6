Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeC1Tai (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:30:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53187 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbeC1Tag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:30:36 -0400
X-Google-Smtp-Source: AIpwx4++2maxj7BlrBGQ/I+1EyT444F/CgDvo1KnbXFvA3l1+XlNLMRE3Ak9daEM7W5JrnBjiKqd6Q==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/19] powerpc/powermac: Mark variable x as unused
Date: Wed, 28 Mar 2018 21:30:28 +0200
Message-Id: <20180328193028.823-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-3-malat@debian.org>
References: <20180322202007.23088-3-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the value of x is never intended to be read, remove it. Fix warning
treated as error with W=1:

  arch/powerpc/platforms/powermac/udbg_scc.c:76:9: error: variable ‘x’ set but not used [-Werror=unused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: remove x completely

 arch/powerpc/platforms/powermac/udbg_scc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c b/arch/powerpc/platforms/powermac/udbg_scc.c
index d83135a9830e..8901973ed683 100644
--- a/arch/powerpc/platforms/powermac/udbg_scc.c
+++ b/arch/powerpc/platforms/powermac/udbg_scc.c
@@ -73,7 +73,7 @@ void udbg_scc_init(int force_scc)
 	struct device_node *stdout = NULL, *escc = NULL, *macio = NULL;
 	struct device_node *ch, *ch_def = NULL, *ch_a = NULL;
 	const char *path;
-	int i, x;
+	int i;
 
 	escc = of_find_node_by_name(NULL, "escc");
 	if (escc == NULL)
@@ -120,7 +120,7 @@ void udbg_scc_init(int force_scc)
 	mb();
 
 	for (i = 20000; i != 0; --i)
-		x = in_8(sccc);
+		in_8(sccc);
 	out_8(sccc, 0x09);		/* reset A or B side */
 	out_8(sccc, 0xc0);
 
-- 
2.11.0
