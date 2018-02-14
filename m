Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031331AbeBNVPf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:15:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53103 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeBNVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:15:33 -0500
X-Google-Smtp-Source: AH8x227uJWwj8C4JW8MzToeeYKBCdZKo8V20FB7SH6d3UZjKsyv/ZjvTBcSxNichOZFnHAKmLxyAmw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/via-pmu: Fix section mismatch warning
Date: Wed, 14 Feb 2018 22:15:18 +0100
Message-Id: <20180214211519.15683-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180207194439.32680-1-malat@debian.org>
References: <20180207194439.32680-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the struct via_pmu_driver const to avoid following warning:

WARNING: vmlinux.o(.data+0x4739c): Section mismatch in reference from the variable via_pmu_driver to the function .init.text:pmu_init()
The variable via_pmu_driver references
the function __init pmu_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Suggested-by: Laurent Vivier <lvivier@redhat.com>
---
v2: pmu_init() is really an init function, leave __init marker

 drivers/macintosh/via-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 94c0f3f7df69..fc56c7067732 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -198,7 +198,7 @@ static const struct file_operations pmu_battery_proc_fops;
 static const struct file_operations pmu_options_proc_fops;
 
 #ifdef CONFIG_ADB
-struct adb_driver via_pmu_driver = {
+const struct adb_driver via_pmu_driver = {
 	"PMU",
 	pmu_probe,
 	pmu_init,
-- 
2.11.0
