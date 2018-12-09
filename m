Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075C1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5E120837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="UGVIzrSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5E120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLISY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:24:27 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38340 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLISY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:24:26 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so7060609ioj.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 10:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkYVZ7daY1cwdpZ1lpCsOliAPs5GrROQtKSvKXGy2GM=;
        b=UGVIzrSH9ntgbDzileq8k8GI7tP80Tb9h322c3V+dJncoUxyfyWG4g5vXy5rgwcJN+
         +89ZwVsoNb280bq0wJ2uJEWQxjXsiR4UfiWolVxAruSUfyYtukBW0Iusp5v3ZLCdgKw/
         jnyuD71JdP6wlHc/SlZYKLK3/s5VEj5VErCSjXRIdAyQehHF0m6JJnBBRg4tPRAywl8H
         MXx1hAybMtv91gQp+mlvhomFcbCsxiQyzdY0Kg/vWgK+r3w1e41IdBotud2oBKH3Y/Qs
         mbeFBVPPLUCDPxOnOEeMHnMTOmZPvHnzOlxZlpIzY2xvFf688JrFllc9Hh97q/Jj690M
         iEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkYVZ7daY1cwdpZ1lpCsOliAPs5GrROQtKSvKXGy2GM=;
        b=C3QonVEx0fpB8NDD6fv0QT79Wik8FOhsRNAMkrBZ2sKJVkfu0hqhA16eTvAgB94oW8
         /glK8RCxqEfYP5oRaETVy0/eI4yKZuTu07YW34NE/TwaFkAVDvcDVyXdxDB4yeWXr/5e
         NDuDC+I8PgR9XDR6CMS8DejqNdQywDeByoKqO/eKjxayk6J98cZZOkTZGo2UZijTD0+C
         lxoV92phkYL8g7pWzPLu6gCiWrysgyveM94CvyLzr77EBgo8l0tuKN0L7CMRE9SUbwC/
         bElKUmrCWDpA0I9oOFKadJLRIV0uYHS3L/g0WRRY2NZhmY9BaNCLFfRc4xL7kUwmmWAz
         z3JQ==
X-Gm-Message-State: AA+aEWa+vQYVMaxKoXzQlxoEBdbymw24LbKUlvJcwxgUWd6AmGM6g/dv
        Zm9WPRK2CW0MiSrFOVSYJPfNaA==
X-Google-Smtp-Source: AFSGD/VISciBwKOt8TOR9D4+9S/r54n5wSnNi1L3W5AjHQIuxX+mCoeJVkz7Sj9Ma6RP8fJ1HOafiQ==
X-Received: by 2002:a6b:bc83:: with SMTP id m125mr6690201iof.83.1544379865420;
        Sun, 09 Dec 2018 10:24:25 -0800 (PST)
Received: from cisco.lan (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id l25sm3270631ioj.68.2018.12.09.10.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:24:24 -0800 (PST)
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
Subject: [PATCH v10 1/4] seccomp: hoist struct seccomp_data recalculation higher
Date:   Sun,  9 Dec 2018 11:24:11 -0700
Message-Id: <20181209182414.30862-2-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209182414.30862-1-tycho@tycho.ws>
References: <20181209182414.30862-1-tycho@tycho.ws>
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
Acked-by: Serge Hallyn <serge@hallyn.com>
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

