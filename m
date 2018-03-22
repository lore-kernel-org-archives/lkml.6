Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeCVUYa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:24:30 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41968 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeCVUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:20:45 -0400
X-Google-Smtp-Source: AG47ELspeKjd7/zfXtbd+8DVbt8l598O7/HTFnc6OLInM3UpRFPMRs7AkZfuEWwqwjwDzp3t8KmABw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 04/19] powerpc/kvm: Mark variable tmp unused
Date: Thu, 22 Mar 2018 21:19:50 +0100
Message-Id: <20180322202007.23088-5-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcc attribute unused to variable tmp. Fix warning treated as error with
W=1:

  arch/powerpc/kernel/kvm.c:675:6: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 9ad37f827a97..cd3c088283f9 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -672,7 +672,7 @@ static void kvm_use_magic_page(void)
 {
 	u32 *p;
 	u32 *start, *end;
-	u32 tmp;
+	u32 tmp __maybe_unused;
 	u32 features;
 
 	/* Tell the host to map the magic page to -4096 on all CPUs */
-- 
2.11.0
