Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B47C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F4225131
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F4225131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934297AbeFZJYy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:24:54 -0400
Received: from osg.samsung.com ([64.30.133.232]:43310 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933868AbeFZJYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:24:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 37AB030B40;
        Tue, 26 Jun 2018 02:24:47 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C-32Gz-CQSbt; Tue, 26 Jun 2018 02:24:46 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.130.70.dynamic.adsl.gvt.net.br [177.41.130.70])
        by osg.samsung.com (Postfix) with ESMTPSA id CA1C330B28;
        Tue, 26 Jun 2018 02:24:44 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fXkDK-0000Xc-1B; Tue, 26 Jun 2018 06:24:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Subject: [PATCH 2/4] alsa: multisound.sh: fix script to make it build with modern tools
Date:   Tue, 26 Jun 2018 06:24:38 -0300
Message-Id: <23ff79af9b3a8bf1f1a5a19508b735fc620c0a13.1530004939.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1530004939.git.mchehab+samsung@kernel.org>
References: <cover.1530004939.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1530004939.git.mchehab+samsung@kernel.org>
References: <cover.1530004939.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The script is old and produce some warnings and errors, because
it lacks including stdlib.h and io.h is at sys/io.h.

Fix it to run with the tools found on modern Linux distros.

Tested building it on Fedora 28.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sound/cards/multisound.sh | 30 +++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/sound/cards/multisound.sh b/Documentation/sound/cards/multisound.sh
index 7a7a88256dfd..0e0cb029421b 100755
--- a/Documentation/sound/cards/multisound.sh
+++ b/Documentation/sound/cards/multisound.sh
@@ -381,11 +381,11 @@
 # This shar contains:
 # length mode       name
 # ------ ---------- ------------------------------------------
-#   2046 -rw-rw-r-- MultiSound.d/setdigital.c
-#  10235 -rw-rw-r-- MultiSound.d/pinnaclecfg.c
+#   2064 -rw-rw-r-- MultiSound.d/setdigital.c
+#  10224 -rw-rw-r-- MultiSound.d/pinnaclecfg.c
 #    106 -rw-rw-r-- MultiSound.d/Makefile
-#    141 -rw-rw-r-- MultiSound.d/conv.l
-#   1472 -rw-rw-r-- MultiSound.d/msndreset.c
+#    146 -rw-rw-r-- MultiSound.d/conv.l
+#   1491 -rw-rw-r-- MultiSound.d/msndreset.c
 #
 save_IFS="${IFS}"
 IFS="${IFS}:"
@@ -471,6 +471,7 @@ X *
 X ********************************************************************/
 X
 #include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/types.h>
@@ -538,8 +539,8 @@ e87217fc3e71288102ba41fd81f71ec4  MultiSound.d/setdigital.c
 SHAR_EOF
   else
     shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'MultiSound.d/setdigital.c'`"
-    test 2046 -eq "$shar_count" ||
-    $echo 'MultiSound.d/setdigital.c:' 'original size' '2046,' 'current size' "$shar_count!"
+    test 2064 -eq "$shar_count" ||
+    $echo 'MultiSound.d/setdigital.c:' 'original size' '2064,' 'current size' "$shar_count!"
   fi
 fi
 # ============= MultiSound.d/pinnaclecfg.c ==============
@@ -581,8 +582,8 @@ X
 #include <string.h>
 #include <errno.h>
 #include <unistd.h>
-#include <asm/io.h>
 #include <asm/types.h>
+#include <sys/io.h>
 X
 #define IREG_LOGDEVICE		0x07
 #define IREG_ACTIVATE		0x30
@@ -992,8 +993,8 @@ SHAR_EOF
 SHAR_EOF
   else
     shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'MultiSound.d/pinnaclecfg.c'`"
-    test 10235 -eq "$shar_count" ||
-    $echo 'MultiSound.d/pinnaclecfg.c:' 'original size' '10235,' 'current size' "$shar_count!"
+    test 10224 -eq "$shar_count" ||
+    $echo 'MultiSound.d/pinnaclecfg.c:' 'original size' '10224,' 'current size' "$shar_count!"
   fi
 fi
 # ============= MultiSound.d/Makefile ==============
@@ -1039,7 +1040,7 @@ DB
 [0-9A-Fa-f]+H	{ int n; sscanf(yytext, "%xH", &n); printf("%c", n); }
 %%
 int yywrap() { return 1; }
-main() { yylex(); }
+void main() { yylex(); }
 SHAR_EOF
   $shar_touch -am 0828231798 'MultiSound.d/conv.l' &&
   chmod 0664 'MultiSound.d/conv.l' ||
@@ -1052,8 +1053,8 @@ d2411fc32cd71a00dcdc1f009e858dd2  MultiSound.d/conv.l
 SHAR_EOF
   else
     shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'MultiSound.d/conv.l'`"
-    test 141 -eq "$shar_count" ||
-    $echo 'MultiSound.d/conv.l:' 'original size' '141,' 'current size' "$shar_count!"
+    test 146 -eq "$shar_count" ||
+    $echo 'MultiSound.d/conv.l:' 'original size' '146,' 'current size' "$shar_count!"
   fi
 fi
 # ============= MultiSound.d/msndreset.c ==============
@@ -1085,6 +1086,7 @@ X *
 X ********************************************************************/
 X
 #include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/types.h>
@@ -1129,8 +1131,8 @@ c52f876521084e8eb25e12e01dcccb8a  MultiSound.d/msndreset.c
 SHAR_EOF
   else
     shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'MultiSound.d/msndreset.c'`"
-    test 1472 -eq "$shar_count" ||
-    $echo 'MultiSound.d/msndreset.c:' 'original size' '1472,' 'current size' "$shar_count!"
+    test 1491 -eq "$shar_count" ||
+    $echo 'MultiSound.d/msndreset.c:' 'original size' '1491,' 'current size' "$shar_count!"
   fi
 fi
 rm -fr _sh01426
-- 
2.17.1

