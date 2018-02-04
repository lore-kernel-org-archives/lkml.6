Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeBDDU7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 22:20:59 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38427 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBDDUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 22:20:49 -0500
X-Google-Smtp-Source: AH8x227OlzzSCLd4EDisZnhT6/EXzENsW1VWuOM/qtx3xPodkKzv+DcKQ3HSN2WQt92DsnmMfaEtiw==
From: sztsian@gmail.com
To: rostedt@goodmis.org
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com, sztsian@gmail.com
Subject: [PATCH 2/2] trace-cmd: Change the way of getting python ldflags.
Date: Sun,  4 Feb 2018 11:20:14 +0800
Message-Id: <20180204032014.6962-3-sztsian@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180204032014.6962-1-sztsian@gmail.com>
References: <20180204032014.6962-1-sztsian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zamir SUN <sztsian@gmail.com>

Prior than this patch, Makefile detects python ldflags using a hardcoded
python command. It will cause problems if we are building against
python3 in the future when ldflags for python2 and python3 are
different. With this patch, python ldflags are detected by
corresponding python{,3}-config which will detect the right config for
python plugins.

Signed-off-by: Zamir SUN (Red Hat) <sztsian@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7c0d1a6..f41e399 100644
--- a/Makefile
+++ b/Makefile
@@ -636,7 +636,7 @@ report_noswig: force
 
 PYTHON_INCLUDES = `pkg-config --cflags $(PYTHON_VERS)`
 PYTHON_LDFLAGS = `pkg-config --libs $(PYTHON_VERS)` \
-		$(shell python2 -c "import distutils.sysconfig; print distutils.sysconfig.get_config_var('LINKFORSHARED')")
+		$(shell $(PYTHON_VERS)-config --ldflags)
 PYGTK_CFLAGS = `pkg-config --cflags pygtk-2.0`
 
 ctracecmd.so: $(TCMD_LIB_OBJS) ctracecmd.i
-- 
2.14.3
