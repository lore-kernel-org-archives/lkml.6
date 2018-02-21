Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeBUBer (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 20:34:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeBUBep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 20:34:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8862177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/5] perf s390: Fix reading cpuid model information
Date: Tue, 20 Feb 2018 22:34:27 -0300
Message-Id: <20180221013431.11738-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221013431.11738-1-acme@kernel.org>
References: <20180221013431.11738-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Commit eca0fa28cd0d (perf record: Provide detailed information on s390
CPU") fixed a  build error on Ubuntu. However the fix uses the wrong
size to print the model information.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
Link: http://lkml.kernel.org/r/20180219102444.96900-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 231294b80dc4..a4c30f1c70be 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -81,7 +81,7 @@ int get_cpuid(char *buffer, size_t sz)
 			line2 = line + strlen(SYSINFO_MODEL);
 
 			while ((cp = strtok_r(line2, "\n ", &line2))) {
-				mdsize += scnprintf(model + mdsize, sizeof(type) - mdsize,
+				mdsize += scnprintf(model + mdsize, sizeof(model) - mdsize,
 						    "%s%s", model[0] ? "," : "", cp);
 			}
 			break;
-- 
2.14.3
