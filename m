Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C43218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170911;
	bh=EdEyZwH3Vh/HCl2uA+NYdhQRpsqmqGtGGjeB6WjKeZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UiXU7ZkMQlV8pyDh2Bf8pphccO1YNhFPZOdoe1GzO3STCwMFq1EsLvL7x4cvn0wk4
	 4LEA0j3oqx83vJ8hTYIqqG5kMNa5iTAx3RFiQkpJRM80AjC16W5w5zqKizE11e4kKT
	 +667mGoq/rdrXPdxTCYMftby2cjCf/J96FzxXUMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeLRWI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbeLRWI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:08:28 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE05217D9;
        Tue, 18 Dec 2018 22:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170907;
        bh=EdEyZwH3Vh/HCl2uA+NYdhQRpsqmqGtGGjeB6WjKeZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBcJqFW00Qv4m7/ptz5Zp9uwot9qVkg3HSIMm8G+2cSnC2nQfUB52+vRgExBhDFzS
         N/LvaCBfMANB8/cEkIV5vNtgPOJ29451uyh54WSTEcNqwgeoS9iXWWLrtjnusXPGat
         qgHDuxBsZUBnkjoNm9vGnQLJpaJueYQsozf9zexg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/63] perf tests: Use shebangs in the shell scripts
Date:   Tue, 18 Dec 2018 19:06:33 -0300
Message-Id: <20181218220733.15839-4-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

Since the first line was used as a test identification, it needs to be
skipped by shell_test__description() function now.

Further notes from Hendrik:

It might be worth to note that adding the shebang is necessary to spot
them as scripts.

Using /bin/sh looks fine to.  Just briefly checked whether the scripts
contains some bash-specifics, which is not the case.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
LPU-Reference: 2127419430.57657104.1542836358464.JavaMail.zimbra@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c                           | 3 +++
 tools/perf/tests/shell/probe_vfs_getname.sh               | 1 +
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh     | 1 +
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 1 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh         | 1 +
 5 files changed, 7 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 12c09e0ece71..9852b5d624a5 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -424,6 +424,9 @@ static const char *shell_test__description(char *description, size_t size,
 	if (!fp)
 		return NULL;
 
+	/* Skip shebang */
+	while (fgetc(fp) != '\n');
+
 	description = fgets(description, size, fp);
 	fclose(fp);
 
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 9b7635184dc2..46e076e3c537 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # Add vfs_getname probe to get syscall args filenames
 #
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index cab7b0aea6ea..61c9f8fc6fa1 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # probe libc's inet_pton & backtrace it with ping
 
 # Installs a probe on libc's inet_pton function, that will use uprobes,
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index ba29535b8580..9b073e7fa88c 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # Use vfs_getname probe to get syscall args filenames
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 4ce276efe6b4..50109f27ca07 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # Check open filename arg using perf trace + vfs_getname
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
-- 
2.19.2

