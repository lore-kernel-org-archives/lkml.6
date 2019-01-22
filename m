Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D129BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5F82084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfAVKXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:23:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42595 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfAVKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:23:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MANJ732907904
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:23:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MANJfD2907901;
        Tue, 22 Jan 2019 02:23:19 -0800
Date:   Tue, 22 Jan 2019 02:23:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-6934058d9fb6c058fb5e5b11cdcb19834e205c91@git.kernel.org>
Cc:     songliubraving@fb.com, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, daniel@iogearbox.net,
        peterz@infradead.org, mingo@kernel.org, ast@kernel.org
Reply-To: daniel@iogearbox.net, hpa@zytor.com, mingo@kernel.org,
          ast@kernel.org, peterz@infradead.org, songliubraving@fb.com,
          tglx@linutronix.de, acme@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190117161521.1341602-10-songliubraving@fb.com>
References: <20190117161521.1341602-10-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] bpf: Add module name [bpf] to ksymbols for bpf
 programs
Git-Commit-ID: 6934058d9fb6c058fb5e5b11cdcb19834e205c91
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

Commit-ID:  6934058d9fb6c058fb5e5b11cdcb19834e205c91
Gitweb:     https://git.kernel.org/tip/6934058d9fb6c058fb5e5b11cdcb19834e205c91
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Thu, 17 Jan 2019 08:15:21 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 17:38:56 -0300

bpf: Add module name [bpf] to ksymbols for bpf programs

With this patch, /proc/kallsyms will show BPF programs as

  <addr> t bpf_prog_<tag>_<name> [bpf]

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: http://lkml.kernel.org/r/20190117161521.1341602-10-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index f3a04994e063..14934afa9e68 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -494,7 +494,7 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 
 static int get_ksymbol_bpf(struct kallsym_iter *iter)
 {
-	iter->module_name[0] = '\0';
+	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
 	return bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			       &iter->value, &iter->type,
