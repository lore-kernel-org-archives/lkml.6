Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBYRYk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:24:40 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38560 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeBYRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:09 -0500
X-Google-Smtp-Source: AG47ELtPpcxSW8hN8+vwMzmqAOO80/Oo/8aaK/3D0iLwmjg+e8uZO54Zle/Rd4dFRtBdcWNYIzuGOQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 15/21] powerpc: Add missing prototype for MMU_setup
Date: Sun, 25 Feb 2018 18:22:30 +0100
Message-Id: <20180225172236.29650-16-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function declaration for MMU_setup at the beginning of the file to
fix a warning (treated as error in W=1):

  CC      kernel/sys.o
arch/powerpc/mm/init_32.c:102:13: error: no previous prototype for ‘MMU_setup’ [-Werror=missing-prototypes]
 void __init MMU_setup(void)
             ^~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/mm/init_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 6419b33ca309..e88bcad9a63b 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -79,6 +79,7 @@ EXPORT_SYMBOL(agp_special_page);
 #endif
 
 void MMU_init(void);
+void __init MMU_setup(void);
 
 /*
  * this tells the system to map all of ram with the segregs
-- 
2.11.0
