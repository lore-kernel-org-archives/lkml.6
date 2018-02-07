Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932210AbeBGToy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:44:54 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35006 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754429AbeBGTow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:44:52 -0500
X-Google-Smtp-Source: AH8x2262MtrAupnY/oP7wpp/Eq8U+ZRJ+tW5EUpSZjbi4R2gF0YH4us2bTPJVNGsZdOZ+Tix8IOrJg==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/via-pmu: Fix section mismatch warning
Date: Wed,  7 Feb 2018 20:44:38 +0100
Message-Id: <20180207194439.32680-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the __init annotation from pmu_init() to avoid the
following warning.

WARNING: vmlinux.o(.data+0x4739c): Section mismatch in reference from the variable via_pmu_driver to the function .init.text:pmu_init()
The variable via_pmu_driver references
the function __init pmu_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/macintosh/via-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 08849e33c567..5f378272d5b2 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -378,7 +378,7 @@ static int pmu_probe(void)
 	return vias == NULL? -ENODEV: 0;
 }
 
-static int __init pmu_init(void)
+static int pmu_init(void)
 {
 	if (vias == NULL)
 		return -ENODEV;
-- 
2.11.0
