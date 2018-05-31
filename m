Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754514AbeEaKdz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754584AbeEaKcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:32:51 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/7] perf data: Update documentation section on cpu topology
Date: Thu, 31 May 2018 07:32:18 -0300
Message-Id: <20180531103220.24684-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180531103220.24684-1-acme@kernel.org>
References: <20180531103220.24684-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Add an explanation of each cpu's core and socket identifier to the
perf.data file format documentation.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180528074433.16652-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index d00f0d51cab8..c57904a526ce 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -153,10 +153,18 @@ struct {
 	HEADER_CPU_TOPOLOGY = 13,
 
 String lists defining the core and CPU threads topology.
+The string lists are followed by a variable length array
+which contains core_id and socket_id of each cpu.
+The number of entries can be determined by the size of the
+section minus the sizes of both string lists.
 
 struct {
        struct perf_header_string_list cores; /* Variable length */
        struct perf_header_string_list threads; /* Variable length */
+       struct {
+	      uint32_t core_id;
+	      uint32_t socket_id;
+       } cpus[nr]; /* Variable length records */
 };
 
 Example:
-- 
2.14.3
