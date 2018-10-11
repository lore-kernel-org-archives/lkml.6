Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7841E2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7841E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJKTI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:08:58 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:38298 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbeJKTI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:08:58 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E63093A1C7D578758265;
        Thu, 11 Oct 2018 19:42:04 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9BBfv13004149;
        Thu, 11 Oct 2018 19:41:57 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018101119422988-3878431 ;
          Thu, 11 Oct 2018 19:42:29 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  selftests: fix warning: "_GNU_SOURCE" redefined
Date:   Fri, 12 Oct 2018 03:53:50 +0800
Message-Id: <1539287630-92982-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-11 19:42:29,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-11 19:41:45,
        Serialize complete at 2018-10-11 19:41:45
X-MAIL: mse01.zte.com.cn w9BBfv13004149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makefile contains -D_GNU_SOURCE. remove define "_GNU_SOURCE"
in c files.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 tools/testing/selftests/proc/fd-001-lookup.c  | 2 +-
 tools/testing/selftests/proc/fd-003-kthread.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/proc/fd-001-lookup.c b/tools/testing/selftests/proc/fd-001-lookup.c
index a2010df..60d7948 100644
--- a/tools/testing/selftests/proc/fd-001-lookup.c
+++ b/tools/testing/selftests/proc/fd-001-lookup.c
@@ -14,7 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 // Test /proc/*/fd lookup.
-#define _GNU_SOURCE
+
 #undef NDEBUG
 #include <assert.h>
 #include <dirent.h>
diff --git a/tools/testing/selftests/proc/fd-003-kthread.c b/tools/testing/selftests/proc/fd-003-kthread.c
index 1d659d5..dc591f9 100644
--- a/tools/testing/selftests/proc/fd-003-kthread.c
+++ b/tools/testing/selftests/proc/fd-003-kthread.c
@@ -14,7 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 // Test that /proc/$KERNEL_THREAD/fd/ is empty.
-#define _GNU_SOURCE
+
 #undef NDEBUG
 #include <sys/syscall.h>
 #include <assert.h>
-- 
1.8.3.1

