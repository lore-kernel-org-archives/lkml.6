Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B077ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23C920834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23C920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJZQMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:12:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35699 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:12:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7ajvt137698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:36:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7ai5x137694;
        Fri, 26 Oct 2018 00:36:44 -0700
Date:   Fri, 26 Oct 2018 00:36:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1d865c06f5715df94528f76d6bb7f6f98975e04e@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, jolsa@redhat.com,
        hpa@zytor.com, mingo@kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, mingo@kernel.org, adrian.hunter@intel.com,
          jolsa@redhat.com, acme@redhat.com
In-Reply-To: <20181001062853.28285-3-adrian.hunter@intel.com>
References: <20181001062853.28285-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: call-graph-from-sql.py:
 Provide better default column sizes
Git-Commit-ID: 1d865c06f5715df94528f76d6bb7f6f98975e04e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1d865c06f5715df94528f76d6bb7f6f98975e04e
Gitweb:     https://git.kernel.org/tip/1d865c06f5715df94528f76d6bb7f6f98975e04e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 1 Oct 2018 09:28:36 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Oct 2018 14:15:30 -0300

perf scripts python: call-graph-from-sql.py: Provide better default column sizes

Set initial column sizes to improve initial display.

Committer testing:

Extended instructions on testing this, using the sqlite variant:

Make sure you have the SQLite glue for python+Qt installed, on fedora 27
I used:

  # dnf install python-pyside

Collect some PT samples, say 5-secs worth, system wide:

  # perf record -r 10 -e intel_pt//u -a sleep 5
  [ perf record: Woken up 49 times to write data ]
  [ perf record: Captured and wrote 96.131 MB perf.data ]

This results in this perf.data file:

  # ls -larth perf.data
  -rw-------. 1 root root 97M Oct 23 10:11 perf.data

With the following attributes:

  # perf evlist -v
  intel_pt//u: type: 8, size: 112, config: 0x300e601, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, sample_id_all: 1
  dummy:u: type: 1, size: 112, config: 0x9, { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, context_switch: 1
  #

Then generate the "pt_example" tables using:

  # perf script -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py pt_example branches calls
  2018-10-23 10:56:59.177711 Creating database...
  2018-10-23 10:56:59.195842 Writing records...
   instruction trace error type 1 cpu 2 pid 1644 tid 1644 ip 0x263984516750 code 5: Failed to get instruction
   instruction trace error type 1 cpu 2 pid 1644 tid 1644 ip 0x7f26e116fd20 code 6: Trace doesn't match instruction
   instruction trace error type 1 cpu 2 pid 1644 tid 1644 ip 0x7f26e162c9ee code 6: Trace doesn't match instruction
   instruction trace error type 1 cpu 2 pid 1644 tid 1644 ip 0x7f26e9ce831a code 6: Trace doesn't match instruction
  <SNIP>
   instruction trace error type 1 cpu 0 pid 1644 tid 1644 ip 0x7f26e13d07b4 code 6: Trace doesn't match instruction
  Warning:
  132 instruction trace errors
  2018-10-23 11:25:25.015717 Adding indexes
  2018-10-23 11:25:28.788061 Done
  #

In my example, that perf.data file generated this db:

  # file pt_example
  pt_example: SQLite 3.x database, last written using SQLite version 3020001
  [root@seventh perf]# ls -lah pt_example
  -rw-r--r--. 1 root root 6.6G Oct 23 11:25 pt_example
  #

Then use this python script to use that db and provide a GUI:

  $ python tools/perf/scripts/python/call-graph-from-sql.py pt_example branches calls

I compared the column widths before this patch and after applying it,
the visual results match the patch intent.

The following patches will refer to this set of instructions in the "Committer
Testing" section.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index ce1b91fcd6b8..e1014f2628a7 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -280,6 +280,9 @@ class MainWindow(QMainWindow):
 		self.view = QTreeView()
 		self.view.setModel(self.model)
 
+		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
+			self.view.setColumnWidth(c, w)
+
 		self.setCentralWidget(self.view)
 
 if __name__ == '__main__':
