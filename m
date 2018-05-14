Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeENE2K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 00:28:10 -0400
Received: from gandharva.secretlabs.de ([5.9.72.18]:18542 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeENE2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 00:28:08 -0400
From: Holger Freyther <automatic+kernel@freyther.de>
To: linux-kernel@vger.kernel.org
Cc: Holger Hans Peter Freyther <holgar+kernel@google.com>
Subject: [RFC 1/6] perf probe: Do not exclude mangled C++ funcs
Date: Mon, 14 May 2018 12:19:35 +0800
Message-Id: <20180514041940.96126-2-automatic+kernel@freyther.de>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514041940.96126-1-automatic+kernel@freyther.de>
References: <20180514041940.96126-1-automatic+kernel@freyther.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holger Hans Peter Freyther <holgar+kernel@google.com>

Using --funcs --no-demangle on a C++ binary does not list any of the C++
functions. Change the default filter to not exclude the Common C++ ABI
symbols.

 $ ./perf probe -x ./cxx-example --funcs --no-demangle
 ...
 _ZN9__gnu_cxx13new_allocatorIiEC1Ev
 ...

Signed-off-by: Holger Hans Peter Freyther <holgar+kernel@google.com>
---
 tools/perf/builtin-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index c006592..d69f679 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -43,7 +43,7 @@
 #include "util/probe-file.h"
 
 #define DEFAULT_VAR_FILTER "!__k???tab_* & !__crc_*"
-#define DEFAULT_FUNC_FILTER "!_*"
+#define DEFAULT_FUNC_FILTER "!_* | _Z*"
 #define DEFAULT_LIST_FILTER "*"
 
 /* Session management structure */
-- 
2.7.4
