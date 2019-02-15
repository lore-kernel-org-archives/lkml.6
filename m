Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33961C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5E521929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc2cBYM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437168AbfBONnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:43:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45793 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfBONnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:43:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so8358201ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 05:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaHGUNKg8i0vYLBgUYfl3StVBo6VlAX0vE1pzfTEDe0=;
        b=Sc2cBYM5RpQ+l1FKZj9xkF0htsfP8nTPHMCKT8LH5jFi4F+Jsq/+bZ+v9aqEyawk4Q
         Mgm6yxdxYscb+zju6y/p/CoZ0Kf6ajFqqXjkLWl8PTk5mhLdNJaa1yHtKJOQlWkWdH6L
         JyTG0itpP2A7K2uvWUJdL5e+wWngvzQas7B3FnRSgtOa81hfSb+ZHQqvbCUmwgVajvUe
         wjFBPwfwkbu+VDWZT+IC+S/bZxmaPWIToGz8gSZtYb+thYHV9GQttrNmJiFCol5DuWxP
         h3KIzngxZyYuky9kOHD/XplbyqRBi1EJsrryG/9yo3RPmDTUY5JeK5YuQ5CNgedJSgwe
         0UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaHGUNKg8i0vYLBgUYfl3StVBo6VlAX0vE1pzfTEDe0=;
        b=KLCUJzEhAr2XYoLY2pRcjJxNKQEga//VompCLgbwV/hzFPx4bXq0pcTLSX5fBRlrQS
         Ah/hkwfPCJ2HY9/4tGkmsK6JmwgZcyZkk6m26vcCPnv5d1SE/HRxyVz5968+aKbv/ejk
         PbTMMoxzgE1gjuI0PjSAEXEW5Xp5Hg5lU7dgeLgtbqpieClPj8iznEzu/ztbNp0MYu5Y
         L8+ZWc4jeUZsrn2GhtnFrwLXxJB0Akly/j6o3hCj0tG1DrkN3Ffbd1Xm2Njf+s21omZo
         HKPqG+1DApu8q9PdmQ7nJgqgIlT2qMxnFSnNKU6MXdnwcveAkfjMIiv3aoxpuNk5ICHH
         E2RQ==
X-Gm-Message-State: AHQUAuYibTJ5r8+yhoKDjpiYjyv1lc+F17j1R5nHlYhoaLYEQJwrCdk1
        Wo/aWgaXK7qiuoTSGblfDiNhk6+rh6w=
X-Google-Smtp-Source: AHgI3IZbRhfIq19ld03/G3UwfqsM+bpaJ6cbO6vic7lgU0Qp6Lnk2GbqNnBMTdiCn8HZmHDchKlxIg==
X-Received: by 2002:a2e:81a:: with SMTP id 26-v6mr5746253lji.14.1550238210349;
        Fri, 15 Feb 2019 05:43:30 -0800 (PST)
Received: from localhost.localdomain (mobile-access-b0481f-5.dhcp.inet.fi. [176.72.31.5])
        by smtp.gmail.com with ESMTPSA id k3-v6sm1255020lja.8.2019.02.15.05.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 05:43:29 -0800 (PST)
From:   Tommi Rantala <tt.rantala@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH] perf tests shell: Skip trace+probe_vfs_getname.sh if built without trace support
Date:   Fri, 15 Feb 2019 15:42:46 +0200
Message-Id: <20190215134253.11454-1-tt.rantala@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

If perf was built without trace support, trace+probe_vfs_getname.sh
fails:

  # perf trace -h
  perf: 'trace' is not a perf-command. See 'perf --help'

  # perf test 64
  64: Check open filename arg using perf trace + vfs_getname: FAILED!

Check trace support, so that we'll skip the test:

  # perf test 64
  64: Check open filename arg using perf trace + vfs_getname: Skip

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/tests/shell/lib/probe.sh               | 5 +++++
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/lib/probe.sh b/tools/perf/tests/shell/lib/probe.sh
index 6293cc660947..e37787be672b 100644
--- a/tools/perf/tests/shell/lib/probe.sh
+++ b/tools/perf/tests/shell/lib/probe.sh
@@ -4,3 +4,8 @@ skip_if_no_perf_probe() {
 	perf probe 2>&1 | grep -q 'is not a perf-command' && return 2
 	return 0
 }
+
+skip_if_no_perf_trace() {
+	perf trace -h 2>&1 | grep -q -e 'is not a perf-command' -e 'trace command not available' && return 2
+	return 0
+}
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 50109f27ca07..147efeb6b195 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -12,6 +12,7 @@
 . $(dirname $0)/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
+skip_if_no_perf_trace || exit 2
 
 . $(dirname $0)/lib/probe_vfs_getname.sh
 
-- 
2.20.1

