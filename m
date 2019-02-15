Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B20C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E606B222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191616;
	bh=sf6eyqs764o2p8sAsJKoLLz3/3gQIb+fthj9dkOwfXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dt4KOPhSwaF2+Elmp27LVpmbm2VN4ciig3wEswd+NP3Bi/DYCRZCV3PcERWyWwZSk
	 TMOvZ5VrXpApY2cEb0v8v1ckS+SE1tHc3i30X9jiLfPSlSw3tb2i9FY9aA1v9TW7w7
	 yd3j0Uq3pbx70+VjaAXEmUeOpms89YJ3zpn7emiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbfBOAqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388679AbfBOAqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:46:51 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E21C2229F;
        Fri, 15 Feb 2019 00:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191610;
        bh=sf6eyqs764o2p8sAsJKoLLz3/3gQIb+fthj9dkOwfXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnwRPrIJRyrMCdnZy6qx6Uzv/hyR3sS/3YFOzQlq9njiQVk3eEOuSdDTs/JFMMkYa
         yjjl8NfTKSfgQsvy5gh5JQmvKtYjEWr8fOd98fN6jT+X0iTbQNOCV7EJudmqu/qF1t
         As7FpKudEWqtBeCpMK0kBda1vmiv812AP+FaPHpE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 14/43] perf beauty ioctl cmd: The 'fd' arg is signed
Date:   Thu, 14 Feb 2019 21:45:10 -0300
Message-Id: <20190215004539.23571-15-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It is possible to pass a negative number as the fd and that has to be
handled, so stop using 'unsigned int fd' in the ioctl syscall 'cmd'
beautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-b7qwa0l19dswa09h3s41akfu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 620350d41209..52242fa4072b 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -175,7 +175,7 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size, boo
 size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg)
 {
 	unsigned long cmd = arg->val;
-	unsigned int fd = syscall_arg__val(arg, 0);
+	int fd = syscall_arg__val(arg, 0);
 	struct file *file = thread__files_entry(arg->thread, fd);
 
 	if (file != NULL) {
-- 
2.19.1

