Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeDXPvW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:51:22 -0400
Received: from david.siemens.de ([192.35.17.14]:47455 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeDXPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:51:19 -0400
To: Catalin Marinas <catalin.marinas@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] kmemleak: Report if we need to tune KMEMLEAK_EARLY_LOG_SIZE
Openpgp: preference=signencrypt
Message-ID: <288b0afc-bcc3-a2aa-2791-707e625d1da7@siemens.com>
Date: Tue, 24 Apr 2018 17:51:15 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...rather than just mysteriously disabling it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 mm/kmemleak.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 9a085d525bbc..156c0c69cc5c 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -863,6 +863,7 @@ static void __init log_early(int op_type, const void *ptr, size_t size,
 
 	if (crt_early_log >= ARRAY_SIZE(early_log)) {
 		crt_early_log++;
+		pr_warn("Too many early logs\n");
 		kmemleak_disable();
 		return;
 	}
-- 
2.13.6
