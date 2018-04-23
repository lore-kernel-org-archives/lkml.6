Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932426AbeDWTpm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:45:42 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38510 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932330AbeDWTph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:45:37 -0400
X-Google-Smtp-Source: AB8JxZoTlGdBwTgv4qSQeJqabRRtRa/r+ULLyf/xd15fBdEeWrBJU3OmZ24ZT8pZcW3CZq5Bzc6m7w==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/wii: Make hlwd_pic_init function static
Date: Mon, 23 Apr 2018 21:45:32 +0200
Message-Id: <20180423194533.23487-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function hlwd_pic_init can be made static, so do it. Fix the following
warning treated as error (W=1):

../arch/powerpc/platforms/embedded6xx/hlwd-pic.c:158:20: error: no previous prototype for ‘hlwd_pic_init’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 89c54de88b7a..e3e3af73e9d8 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -155,7 +155,7 @@ static void __hlwd_quiesce(void __iomem *io_base)
 	out_be32(io_base + HW_BROADWAY_ICR, 0xffffffff);
 }
 
-struct irq_domain *hlwd_pic_init(struct device_node *np)
+static struct irq_domain *hlwd_pic_init(struct device_node *np)
 {
 	struct irq_domain *irq_domain;
 	struct resource res;
-- 
2.11.0
