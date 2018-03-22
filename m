Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeCVUW5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:22:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53867 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeCVUVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:21:01 -0400
X-Google-Smtp-Source: AG47ELt3TBw87iE7M/1R4fpQace9Bw7+ormhhyMMDg5v0+T5ZtyY5jqvFsDr4dbhaEAeygDPKi/kNQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 12/19] powerpc/powermac: Add missing prototype for note_bootable_part()
Date: Thu, 22 Mar 2018 21:19:58 +0100
Message-Id: <20180322202007.23088-13-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing prototype for function `note_bootable_part` to silence a
warning treated as error with W=1:

  arch/powerpc/platforms/powermac/setup.c:361:12: error: no previous prototype for ‘note_bootable_part’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/powermac/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index ab668cb72263..e3d00f8af441 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -352,6 +352,7 @@ static int pmac_late_init(void)
 }
 machine_late_initcall(powermac, pmac_late_init);
 
+extern void note_bootable_part(dev_t dev, int part, int goodness);
 /*
  * This is __ref because we check for "initializing" before
  * touching any of the __init sensitive things and "initializing"
-- 
2.11.0
