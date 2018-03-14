Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeCNQpt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:45:49 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38069 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeCNQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:44:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2EGiSdR001049
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] kbuild: touch autoksyms.h when it is really missing
Date: Thu, 15 Mar 2018 01:44:16 +0900
Message-Id: <1521045861-22418-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From the comment, I expect this code creates autoksyms.h in case it
is missing, but it actually touches it when it does exists.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I do not know when this code is useful...

If autoksyms.h were missing, build should have already failed because
include/{linux,asm-generic}/export.h need it.

Maybe for standalone test?
Or, in order to make this script self-contained?


 scripts/adjust_autoksyms.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 513da1a..a52210b 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -49,7 +49,7 @@ case "${KCONFIG_CONFIG}" in
 esac
 
 # In case it doesn't exist yet...
-if [ -e "$cur_ksyms_file" ]; then touch "$cur_ksyms_file"; fi
+if [ ! -e "$cur_ksyms_file" ]; then touch "$cur_ksyms_file"; fi
 
 # Generate a new ksym list file with symbols needed by the current
 # set of modules.
-- 
2.7.4
