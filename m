Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbeCPCT4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:19:56 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:44540 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbeCPCTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:19:12 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w2G2IoBN003525
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] kbuild: remove wrong 'touch' in adjust_autoksyms.sh
Date: Fri, 16 Mar 2018 11:18:39 +0900
Message-Id: <1521166725-24157-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment mentions it creates autoksyms.h in case it is missing,
but the actual code touches it when it does exists.

The build system creates it anyway because <linux/export.h> and
<asm-generic/export.h> need it.

The code would not have worked as intended, and people have not
noticed it.  This is a proof that we can simply remove it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Remove the code instead of fixing it

 scripts/adjust_autoksyms.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index a162258..e0dd0d5 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -48,9 +48,6 @@ case "${KCONFIG_CONFIG}" in
 	. "./${KCONFIG_CONFIG}"
 esac
 
-# In case it doesn't exist yet...
-if [ -e "$cur_ksyms_file" ]; then touch "$cur_ksyms_file"; fi
-
 # Generate a new ksym list file with symbols needed by the current
 # set of modules.
 cat > "$new_ksyms_file" << EOT
-- 
2.7.4
