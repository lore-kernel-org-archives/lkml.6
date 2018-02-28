Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeB1Kvt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:51:49 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39831 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752566AbeB1Kvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:51:46 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37332018"
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC: <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>, <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v9 5/5] document: add document for kaslr_boot_mem
Date: Wed, 28 Feb 2018 18:51:05 +0800
Message-ID: <20180228105105.11487-6-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: DD81648AE766.AADFB
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b37c1c30c16f..23232c9ffa39 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2389,6 +2389,16 @@
 			allocations which rules out almost all kernel
 			allocations. Use with caution!
 
+	kaslr_boot_mem=nn[KMG][@ss[KMG]]
+			[KNL] Force usage of a specific region of memory
+			for KASLR during kernel decompression stage.
+			Region of usable memory is from ss to ss+nn. If ss is
+			omitted, it is equivalent to kaslr_boot_mem=nn[KMG]@0.
+			Multiple regions can be specified, comma delimited.
+			Notice: only support 4 regions at most now.
+			Example:
+			kaslr_boot_mem=1G,500M@2G,1G@4G
+
 	MTD_Partition=	[MTD]
 			Format: <name>,<region-number>,<size>,<offset>
 
-- 
2.14.3
