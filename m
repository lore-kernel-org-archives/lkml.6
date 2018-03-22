Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeCVCLD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:11:03 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:50772 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeCVCLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:11:00 -0400
From: Adam Borowski <kilobyte@angband.pl>
To: Nick Terrell <terrelln@fb.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel-team@fb.com,
        Chris Mason <clm@fb.com>, Rene Rebe <rene@exactcode.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Andi Kleen <ak@linux.intel.com>
Cc: Adam Borowski <kilobyte@angband.pl>
Date: Thu, 22 Mar 2018 03:10:43 +0100
Message-Id: <20180322021043.29889-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180322012943.4145794-2-terrelln@fb.com>
References: <20180322012943.4145794-2-terrelln@fb.com>
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH] [NOT FOR MERGING] lib: Be noisy about used decompression method.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's too easy to build the initrd with wrong options during testing, after
which it may silently work anyway.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 lib/decompress.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index ab3fc90ffc64..556b9d916e10 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -78,7 +78,9 @@ decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
 			break;
 
 	}
-	if (name)
+	if (name) {
 		*name = cf->name;
+		printk("Decompressing using %s.\n", *name);
+	}
 	return cf->decompressor;
 }
-- 
2.16.2
