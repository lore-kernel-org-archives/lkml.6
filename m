Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753750AbeBKTTo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 14:19:44 -0500
Received: from omr-a019e.mx.aol.com ([204.29.186.67]:40167 "EHLO
        omr-a019e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753726AbeBKTTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 14:19:43 -0500
From: Martin Vuille <jpmv27@aim.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf annotate: Don't prepend symfs path to build_id_filename
Date: Sun, 11 Feb 2018 14:19:37 -0500
Message-Id: <20180211191937.9703-1-jpmv27@aim.com>
X-Mailer: git-send-email 2.13.6
x-aol-global-disposition: G
x-aol-sid: 3039ac1afd4d5a80974d2b78
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

build_id_filename already contains symfs path if applicable, so
don't prepend it a second time.

Signed-off-by: Martin Vuille <jpmv27@aim.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 28b233c3dcbe..425b7f0760ec 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1381,7 +1381,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
 	if (build_id_filename) {
-		__symbol__join_symfs(filename, filename_size, build_id_filename);
+		scnprintf(filename, filename_size, "%s", build_id_filename);
 		free(build_id_filename);
 	} else {
 		if (dso->has_build_id)
-- 
2.13.6
