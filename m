Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754662AbeEaKpj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:45:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36053 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754471AbeEaKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:45:35 -0400
Date: Thu, 31 May 2018 03:45:04 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-0c711138fa61188aa379210e9e08ac76838dea03@git.kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, brueckner@linux.vnet.ibm.com,
        tglx@linutronix.de, tmricht@linux.ibm.com, heiko.carstens@de.ibm.com,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tmricht@linux.ibm.com, tglx@linutronix.de, heiko.carstens@de.ibm.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
        hpa@zytor.com, brueckner@linux.vnet.ibm.com, acme@redhat.com
In-Reply-To: <20180528074433.16652-1-tmricht@linux.ibm.com>
References: <20180528074433.16652-1-tmricht@linux.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf data: Update documentation section on cpu
 topology
Git-Commit-ID: 0c711138fa61188aa379210e9e08ac76838dea03
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0c711138fa61188aa379210e9e08ac76838dea03
Gitweb:     https://git.kernel.org/tip/0c711138fa61188aa379210e9e08ac76838dea03
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Mon, 28 May 2018 09:44:33 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 30 May 2018 15:39:13 -0300

perf data: Update documentation section on cpu topology

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
