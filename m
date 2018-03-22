Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeCVUUm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:20:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38084 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeCVUUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:20:40 -0400
X-Google-Smtp-Source: AG47ELulvtBC5Vv3jWONzRRgldvopDLW0ng410OWG3IDeWzDPJehZK7NndV0OSxXxzbCo/Sx7OMoAw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 01/19] powerpc/powermac: Mark variable x as unused
Date: Thu, 22 Mar 2018 21:19:47 +0100
Message-Id: <20180322202007.23088-2-malat@debian.org>
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

  arch/powerpc/platforms/powermac/bootx_init.c:471:21: error: variable ‘x’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/powermac/bootx_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index c3c9bbb3573a..d3ce55dae78f 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -468,7 +468,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
 	boot_infos_t *bi = (boot_infos_t *) r4;
 	unsigned long hdr;
 	unsigned long space;
-	unsigned long ptr, x;
+	unsigned long ptr, x __maybe_unused;
 	char *model;
 	unsigned long offset = reloc_offset();
 
-- 
2.11.0
