Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF491C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8388420835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZwu2xVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8388420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeJKQia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:38:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37905 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeJKQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:38:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id a13-v6so8795826wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7iXPeVDvhpBB9apt324pVk0j82sbHF2s/zEIXe+3lq0=;
        b=AZwu2xVAKjys1Ri0DIp8BWNVdu27WG1WPB/V0rEWvb26vxrook84XyqOqE0F79YX7J
         iohxj06MSl1LbSDbuMXPvomMf5/6V3j+HCsRLC1RjFAC1zED3o1hBzJP3TdWUCNB4uwY
         Z32Xbj+e8vVRhOkw4t8AUZEayvkHdPd93pI0eXGVeQ2IpoXp8kNcp9TbCxYgRoGSKDis
         uJr5nQxBGm+ekFGFu98g/LKTzc71YO1WzV30//cBqjF6C3swjmK8NuQWNsZ9br5HOvSN
         GMMVteZ+LqoJgN0ghKJRtdVY9Mzof4RJB5qTFm0U1yHrhVIX5RKt9HkVPRFyZEzoYrRL
         TF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7iXPeVDvhpBB9apt324pVk0j82sbHF2s/zEIXe+3lq0=;
        b=B7NCKKNNOmwAXnE86jQSZyIcCpc4mHj4flda76oETV5/yO9bax1K3zFMzLJ0pcJAwk
         iBtvtnABAcRUb5mNTZNRExoQmi2ECTVd/PfBA0zV3kMIO4ZjSWmOoD+84/srCc8pHLhu
         ljqZwg9oekzZioa/6Y+dJrmHjko2QdPJCg81utDXnmnjCMAp/DmmH6DAo0Sx7yg0aiyQ
         OTM4lCT7eHiytBYKyO0HE/e11aI3C04IGlkSrPGCwObeWlRajo/MhAyQY7GxfA3LnNR5
         BPGuBh909e/kNkFNhzRKKft+AOOP4vCc0ViJJbuz4MSBWBaqecz8DKnnWhuVYOcEUljx
         tJLg==
X-Gm-Message-State: ABuFfoixiS3o+/FU8gJCCvLvsYLxf2N3XqHZInWP4Zy9VKNTDMIvaE0H
        pmiGA8s76Gu687LxWSdvv6NAHqwY
X-Google-Smtp-Source: ACcGV613kvfNjCzEFEaesyFTt6vmp2LDp75hWxoaxy7TB3lD+E4AC4gS51B8XltTNCfkHZW83M7MbQ==
X-Received: by 2002:adf:df88:: with SMTP id z8-v6mr722908wrl.113.1539249125257;
        Thu, 11 Oct 2018 02:12:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b81-v6sm17580062wmh.47.2018.10.11.02.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 02:12:04 -0700 (PDT)
Date:   Thu, 11 Oct 2018 11:12:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20181011091202.GA78343@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: c1883f10cfe05c707cce46d6999411c50a2413ca Merge tag 'perf-urgent-for-mingo-4.19-20181005' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Misc perf tooling fixes.

 Thanks,

	Ingo

------------------>
Adrian Hunter (2):
      perf script python: Fix export-to-postgresql.py occasional failure
      perf script python: Fix export-to-sqlite.py sample columns

Arnaldo Carvalho de Melo (1):
      perf python: Use -Wno-redundant-decls to build with PYTHON=python3

Milian Wolff (2):
      perf report: Don't try to map ip to invalid map
      perf record: Use unmapped IP for inline callchain cursors


 tools/perf/scripts/python/export-to-postgresql.py | 9 +++++++++
 tools/perf/scripts/python/export-to-sqlite.py     | 6 +++++-
 tools/perf/util/machine.c                         | 8 +++++---
 tools/perf/util/setup.py                          | 2 +-
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index efcaf6cac2eb..e46f51b17513 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -204,14 +204,23 @@ from ctypes import *
 libpq = CDLL("libpq.so.5")
 PQconnectdb = libpq.PQconnectdb
 PQconnectdb.restype = c_void_p
+PQconnectdb.argtypes = [ c_char_p ]
 PQfinish = libpq.PQfinish
+PQfinish.argtypes = [ c_void_p ]
 PQstatus = libpq.PQstatus
+PQstatus.restype = c_int
+PQstatus.argtypes = [ c_void_p ]
 PQexec = libpq.PQexec
 PQexec.restype = c_void_p
+PQexec.argtypes = [ c_void_p, c_char_p ]
 PQresultStatus = libpq.PQresultStatus
+PQresultStatus.restype = c_int
+PQresultStatus.argtypes = [ c_void_p ]
 PQputCopyData = libpq.PQputCopyData
+PQputCopyData.restype = c_int
 PQputCopyData.argtypes = [ c_void_p, c_void_p, c_int ]
 PQputCopyEnd = libpq.PQputCopyEnd
+PQputCopyEnd.restype = c_int
 PQputCopyEnd.argtypes = [ c_void_p, c_void_p ]
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index f827bf77e9d2..e4bb82c8aba9 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -440,7 +440,11 @@ def branch_type_table(*x):
 
 def sample_table(*x):
 	if branches:
-		bind_exec(sample_query, 18, x)
+		for xx in x[0:15]:
+			sample_query.addBindValue(str(xx))
+		for xx in x[19:22]:
+			sample_query.addBindValue(str(xx))
+		do_query_(sample_query)
 	else:
 		bind_exec(sample_query, 22, x)
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c4acd2001db0..111ae858cbcb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2286,7 +2286,8 @@ static int append_inlines(struct callchain_cursor *cursor,
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
 
-	addr = map__rip_2objdump(map, ip);
+	addr = map__map_ip(map, ip);
+	addr = map__rip_2objdump(map, addr);
 
 	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
 	if (!inline_node) {
@@ -2312,7 +2313,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	struct callchain_cursor *cursor = arg;
 	const char *srcline = NULL;
-	u64 addr;
+	u64 addr = entry->ip;
 
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
@@ -2324,7 +2325,8 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
 	 */
-	addr = map__map_ip(entry->map, entry->ip);
+	if (entry->map)
+		addr = map__map_ip(entry->map, entry->ip);
 
 	srcline = callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 97efbcad076e..1942f6dd24f6 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -35,7 +35,7 @@ class install_lib(_install_lib):
 
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
-cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter' ]
+cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
 if cc != "clang":
     cflags += ['-Wno-cast-function-type' ]
 

----- End forwarded message -----
