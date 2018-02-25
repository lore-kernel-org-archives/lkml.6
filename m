Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeBYR0m (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:26:42 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34556 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeBYRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:01 -0500
X-Google-Smtp-Source: AH8x224kv2L7LirU0TGVqT300AAAoh/9xP6/ueVKsQMh/BY3ATNvvVHbIJLeyBFZMiGkyRMe8LYI1w==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 07/21] powerpc: Make functions flipper_pic_init & ug_udbg_putc static
Date: Sun, 25 Feb 2018 18:22:22 +0100
Message-Id: <20180225172236.29650-8-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change signature of two functions, adding static keyword to prevent the
following two warnings (treated as errors on W=1):

  CC      kernel/sys.o
arch/powerpc/platforms/embedded6xx/flipper-pic.c:135:28: error: no previous prototype for ‘flipper_pic_init’ [-Werror=missing-prototypes]
 struct irq_domain * __init flipper_pic_init(struct device_node *np)
                            ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

and

  CC      arch/powerpc/platforms/embedded6xx/usbgecko_udbg.o
arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c:172:6: error: no previous prototype for ‘ug_udbg_putc’ [-Werror=missing-prototypes]
 void ug_udbg_putc(char ch)
      ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   | 2 +-
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index ade83829d5e8..7206f3f573d4 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -132,7 +132,7 @@ static void __flipper_quiesce(void __iomem *io_base)
 	out_be32(io_base + FLIPPER_ICR, 0xffffffff);
 }
 
-struct irq_domain * __init flipper_pic_init(struct device_node *np)
+static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 {
 	struct device_node *pi;
 	struct irq_domain *irq_domain = NULL;
diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
index 7feb325b636b..5c7e7ce6dbab 100644
--- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
+++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
@@ -169,7 +169,7 @@ static int ug_getc(void)
 /*
  * Transmits a character.
  */
-void ug_udbg_putc(char ch)
+static void ug_udbg_putc(char ch)
 {
 	ug_putc(ch);
 }
-- 
2.11.0
