Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DC6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FBD2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="c5TOYzRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FBD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeLCD2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:28:46 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35574 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeLCD2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:28:46 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so6567525itp.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 19:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QRC+2J09QEmUyVLJbctrVLGJbdHDDiVfDdZtEc0W9w=;
        b=c5TOYzRCp4/mWzloe0sZTzdbd0mVIVBLhEymzh1giVrso8alVmiPOdJdEiLFbLDU8Q
         YWQGUT9jJUXNl3rbTK+y52hmvOdUyhTyP2MsnwgtNFPviBAAH3Jh8GeTy+7PzWrQ+hrA
         3qgAJ5PmRVnPte2NNMiRquSZvG+067NBoob3oKCBTx4ChP/giaeTqLEBKlcwiUJjWapE
         BBVYf8b6mZPLbi+YEQrhkyDTQP/CFAMpVTQxirBEoa8Ero+4fa+k7Ap+70Wpu1IM7cKW
         mQKuY8IxAHthcaBymynSob8qKL9cwvyMurTpUka5ywe5uxvpsKNEgKYlEoA+KTvYL5ZH
         /4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QRC+2J09QEmUyVLJbctrVLGJbdHDDiVfDdZtEc0W9w=;
        b=cETYKPzub55nni5sXEHIekDunZI1B5WdG5SYjmb1yOW5OpqZFdc5yFGKoduv/ESuwy
         RcMEIw7uN/iGP+V5GPjceqll3fQ1lvPichh5HrQAuzXgDQluQ4S4onsPBgyYpYeBE8fR
         CRUxFZfslf2I1mjR9K9Zu/HPO6xrHG24kF5Ne/4+azGSFuJdPOvo+F2w+4q4CNgFlDLO
         v6UhXAFI4mDNXvJCBMaD4/KAYD05CshH809mnmRDVi3vMyQPE3r6+oFTUHGyVGE5q7ZP
         DvGBqLmbIoFE/ygWerX1Ir/uWsv6vo5AfGzxFSHbC/2l2co0LGxjugEd+3DvSAIIrX3q
         egWg==
X-Gm-Message-State: AA+aEWZgS7TEE6r5L1n2rS8mvnXUMeIVMFzxK1L+LBKSmTKTXeWWrZ02
        EWpebIgzg9z85hB3pavA7kJ78g==
X-Google-Smtp-Source: AFSGD/UqcVAmCnZCoPx2MK6xTnvrmfsYPeTTCgUkPqaXvxQkbJLQ9ug8tWZhGoFZCzf8VBRmAxM7TA==
X-Received: by 2002:a24:bd48:: with SMTP id x69mr6262187ite.81.1543807722663;
        Sun, 02 Dec 2018 19:28:42 -0800 (PST)
Received: from cisco.lan (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id n136sm3243529itb.35.2018.12.02.19.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 19:28:42 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v9 1/4] seccomp: hoist struct seccomp_data recalculation higher
Date:   Sun,  2 Dec 2018 20:28:24 -0700
Message-Id: <20181203032827.27978-2-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203032827.27978-1-tycho@tycho.ws>
References: <20181203032827.27978-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next patch, we're going to use the sd pointer passed to
__seccomp_filter() as the data to pass to userspace. Except that in some
cases (__seccomp_filter(SECCOMP_RET_TRACE), emulate_vsyscall(), every time
seccomp is inovked on power, etc.) the sd pointer will be NULL in order to
force seccomp to recompute the register data. Previously this recomputation
happened one level lower, in seccomp_run_filters(); this patch just moves
it up a level higher to __seccomp_filter().

Thanks Oleg for spotting this.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Christian Brauner <christian@brauner.io>
CC: Tyler Hicks <tyhicks@canonical.com>
CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
---
 kernel/seccomp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index f2ae2324c232..96afc32e041d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -188,7 +188,6 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 static u32 seccomp_run_filters(const struct seccomp_data *sd,
 			       struct seccomp_filter **match)
 {
-	struct seccomp_data sd_local;
 	u32 ret = SECCOMP_RET_ALLOW;
 	/* Make sure cross-thread synced filter points somewhere sane. */
 	struct seccomp_filter *f =
@@ -198,11 +197,6 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 	if (WARN_ON(f == NULL))
 		return SECCOMP_RET_KILL_PROCESS;
 
-	if (!sd) {
-		populate_seccomp_data(&sd_local);
-		sd = &sd_local;
-	}
-
 	/*
 	 * All filters in the list are evaluated and the lowest BPF return
 	 * value always takes priority (ignoring the DATA).
@@ -658,6 +652,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 	u32 filter_ret, action;
 	struct seccomp_filter *match = NULL;
 	int data;
+	struct seccomp_data sd_local;
 
 	/*
 	 * Make sure that any changes to mode from another thread have
@@ -665,6 +660,11 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 	 */
 	rmb();
 
+	if (!sd) {
+		populate_seccomp_data(&sd_local);
+		sd = &sd_local;
+	}
+
 	filter_ret = seccomp_run_filters(sd, &match);
 	data = filter_ret & SECCOMP_RET_DATA;
 	action = filter_ret & SECCOMP_RET_ACTION_FULL;
-- 
2.19.1

