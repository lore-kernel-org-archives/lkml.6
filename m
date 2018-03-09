Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeCIIup (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:50:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeCIIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:50:42 -0500
Date: Fri, 9 Mar 2018 00:50:35 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-13f89dbafe73e56fd317c078bb1d3a45fd94ab7b@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, acme@redhat.com, jolsa@redhat.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: jolsa@redhat.com, adrian.hunter@intel.com, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1520431349-30689-9-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-9-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Remove a check for sampling mode
Git-Commit-ID: 13f89dbafe73e56fd317c078bb1d3a45fd94ab7b
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

Commit-ID:  13f89dbafe73e56fd317c078bb1d3a45fd94ab7b
Gitweb:     https://git.kernel.org/tip/13f89dbafe73e56fd317c078bb1d3a45fd94ab7b
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 7 Mar 2018 16:02:28 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:58 -0300

perf intel-pt: Remove a check for sampling mode

Intel PT code already has some preparation for AUX area sampling mode.

However the implementation has changed from the first proposal and one
of the side-effects is that it will not be impossible to support snapshot
mode and sampling mode at the same time.

Although there are no plans to support it, let validation (not yet
implemented) control whether it is allowed rather than low-level
functions.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/1520431349-30689-9-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9a4f9cdb752f..5c5c155fba78 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2061,9 +2061,6 @@ static int intel_pt_process_auxtrace_event(struct perf_session *session,
 	struct intel_pt *pt = container_of(session->auxtrace, struct intel_pt,
 					   auxtrace);
 
-	if (pt->sampling_mode)
-		return 0;
-
 	if (!pt->data_queued) {
 		struct auxtrace_buffer *buffer;
 		off_t data_offset;
