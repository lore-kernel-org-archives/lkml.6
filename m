Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeCVUVI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:21:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34856 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbeCVUVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:21:04 -0400
X-Google-Smtp-Source: AG47ELtLgxmN++Mue0e7DzCfT6rIrLWcHzw8X9FlQoSDqK1ur52rKErHMhJB1bU7gUlI9Ivn2UMAJA==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 14/19] powerpc/altivec: Add missing prototypes for altivec
Date: Thu, 22 Mar 2018 21:20:00 +0100
Message-Id: <20180322202007.23088-15-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions prototypes were missing for the non-altivec code. Add the
missing prototypes directly in xor_vmx, fix warnings treated as errors with
W=1:

  arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype for ‘xor_altivec_2’ [-Werror=missing-prototypes]
  arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype for ‘xor_altivec_3’ [-Werror=missing-prototypes]
  arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype for ‘xor_altivec_4’ [-Werror=missing-prototypes]
  arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype for ‘xor_altivec_5’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/lib/xor_vmx.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/lib/xor_vmx.h b/arch/powerpc/lib/xor_vmx.h
index 5c2b0839b179..2173e3c84151 100644
--- a/arch/powerpc/lib/xor_vmx.h
+++ b/arch/powerpc/lib/xor_vmx.h
@@ -19,3 +19,17 @@ void __xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
 void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
 			     unsigned long *v2_in, unsigned long *v3_in,
 			     unsigned long *v4_in, unsigned long *v5_in);
+
+void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in);
+
+void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in, unsigned long *v3_in);
+
+void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in, unsigned long *v3_in,
+			     unsigned long *v4_in);
+
+void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
+			     unsigned long *v2_in, unsigned long *v3_in,
+			     unsigned long *v4_in, unsigned long *v5_in);
-- 
2.11.0
