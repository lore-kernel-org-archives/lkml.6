Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeDYVK6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:10:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49958 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751750AbeDYVKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:10:53 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] mips: xilfpga: actually include FDT in fitImage
Date: Wed, 25 Apr 2018 23:10:36 +0200
Message-Id: <20180425211036.28509-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425211036.28509-1-alexandre.belloni@bootlin.com>
References: <20180425211036.28509-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b35565bb16a5 ("MIPS: generic: Add support for MIPSfpga") added and
its.S file for xilfpga but forgot to add it to arch/mips/generic/Platform
so it is never used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/generic/Platform | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
index b51432dd10b6..0dd0d5d460a5 100644
--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -16,3 +16,4 @@ all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz.itb
 its-y					:= vmlinux.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= board-boston.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= board-ni169445.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= board-xilfpga.its.S
-- 
2.17.0
