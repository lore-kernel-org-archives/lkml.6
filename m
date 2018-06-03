Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbeFCM2S (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeFCM2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:28:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 18/29] tools include: Drop ARRAY_SIZE() definition from linux/hashtable.h
Date: Sun,  3 Jun 2018 14:26:41 +0200
Message-Id: <20180603122652.17453-19-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 68289cbd83eaa20faef7cc818121bc8e769065de upstream.

As tools/include/linux/kernel.h has it now, with the goodies present in
the kernel.h counterpart, i.e. checking that the parameter is an array
at build time.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-v0b41ivu6z6dyugbq9ffa9ez@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/include/linux/hashtable.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/linux/hashtable.h b/tools/include/linux/hashtable.h
index c65cc0aa2659..251eabf2a05e 100644
--- a/tools/include/linux/hashtable.h
+++ b/tools/include/linux/hashtable.h
@@ -13,10 +13,6 @@
 #include <linux/hash.h>
 #include <linux/log2.h>
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
 #define DEFINE_HASHTABLE(name, bits)						\
 	struct hlist_head name[1 << (bits)] =					\
 			{ [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
-- 
2.17.1
