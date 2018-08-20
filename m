Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19745C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D8F2170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI5++Vl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D8F2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeHTTc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:32:55 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D962172D;
        Mon, 20 Aug 2018 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781799;
        bh=gC9stGaWchaV21K6Vqm2+DJZadWHArszzDmKiluRO4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hI5++Vl/Kkg2Az7CVEjBS217SmlhbHzbRRzWUxKB9NbSnyz5bG8FXlx9Hjfty80Xv
         5+ATmP+u/9Ino2cPKk63KK0DP9qD3jjYTAJbi+toOvNwzsQNBLtx9d+P4NCFSuzjLq
         go7fKAkkEQyXGsVy5jkk7tdr/Y7UZ1/o88Dp314Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/21] perf tools: Make decompress_to_file() function static
Date:   Mon, 20 Aug 2018 13:15:49 -0300
Message-Id: <20180820161602.6830-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no outside user of it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 +-
 tools/perf/util/dso.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 8ee1faa5726f..9f4b72d8f50f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -239,7 +239,7 @@ bool is_kernel_module(const char *pathname, int cpumode)
 	return m.kmod;
 }
 
-bool decompress_to_file(const char *ext, const char *filename, int output_fd)
+static bool decompress_to_file(const char *ext, const char *filename, int output_fd)
 {
 	unsigned i;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ef69de2e69ea..e1adadd1fe1e 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -252,7 +252,6 @@ int dso__read_binary_type_filename(const struct dso *dso, enum dso_binary_type t
 				   char *root_dir, char *filename, size_t size);
 bool is_supported_compression(const char *ext);
 bool is_kernel_module(const char *pathname, int cpumode);
-bool decompress_to_file(const char *ext, const char *filename, int output_fd);
 bool dso__needs_decompress(struct dso *dso);
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
 int dso__decompress_kmodule_path(struct dso *dso, const char *name,
-- 
2.14.4

