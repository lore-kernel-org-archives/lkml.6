Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3419AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24FB20893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="KDAn5Xks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24FB20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeH1S3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:29:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38700 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbeH1S3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:29:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id e2-v6so842878pgv.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4N5JhkRgF226RrUGxow0Fgcw8yOtLmkY4sHBc8BRVtk=;
        b=KDAn5XksiUjY/Bd6pfD3cRsJ9saITrnTT7dKlN/2Dxk8XX8n404xGB6Dt8TQGCZOsM
         /A6W4JN8ycDKz4lxj6e8cBoTL33Tx4qIlpv4oasZXN9Awpw/Psgqpsx8M+NNfCcbjz4j
         7wKqKA8eyeOAl7HWgnB32T9uZbGU4IlR3UVDDBCRyHk3nH1yDsLN64jXIzN9F7vW4AdI
         1nMMmPnAN4hkaJad0bxn+2XEUK7WFJdtUG3sn3TGm02V8za3mPmytD46OWUrK+lxoKWE
         swYnRqKOmRMdceBiQPYuShXFYgGoBqS3jV58N9ZEAM5ty+3eyMOfUeZT8Qxo32CCwZ0o
         kiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4N5JhkRgF226RrUGxow0Fgcw8yOtLmkY4sHBc8BRVtk=;
        b=mMRKCOGIQQUysIi2Jx0Kzdxhx0m8xA3wwR/8KZDO1Kh8CJ9tkDPjHIdOHjWPsMCw0j
         Qe+oN4XXDLkI+NMUmscdE+5H2eH8zNQkSHkvKaY+3G0Tt1M7I3aw187CtB/hK5Y9XViL
         yx2i2wEzq9Fobc7B+NsWfx2G/50XWhO2ikDkB0cA+xkMi52LJBvqmsZmo7DPCsMuZSMx
         mIkYg/EgbF76GzAljqfq5u8M05hEWl6Dsd4+PsAupnqMy2g5DK3sMvtBxSMzKqmhGRDl
         W8W0eoxGLnxri3dBoNOkrQT4Mzu2YrvHnqAyRTAuXRSqikodMjV2Lie5Jv/9vzq29Aba
         PwYA==
X-Gm-Message-State: APzg51BAAS0K8T97EZ+b2+Rg14lcMrO3vlmvwGlWoF0oFxNmhz+h4Lf3
        R+/kKJb++iKL5KL9/wn0mX3RLQ==
X-Google-Smtp-Source: ANB0Vdb6X3duRIqxT/kVYVz7hkIKNzbQhYck4W4KH1B8kINm7WHYauS/15Sn48BcdoOSW0D8jX9CNQ==
X-Received: by 2002:a63:4606:: with SMTP id t6-v6mr1820876pga.271.1535467029160;
        Tue, 28 Aug 2018 07:37:09 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.165])
        by smtp.gmail.com with ESMTPSA id s16-v6sm1973550pfm.114.2018.08.28.07.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 07:37:08 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v5 2/5] seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
Date:   Tue, 28 Aug 2018 08:36:00 -0600
Message-Id: <20180828143603.8127-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828143603.8127-1-tycho@tycho.ws>
References: <20180828143603.8127-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next commit we'll use this same mnemonic to get a listener for the
nth filter, so we need it available outside of CHECKPOINT_RESTORE in the
USER_NOTIFICATION case as well.

v2: new in v2
v3: no changes
v4: no changes
v5: switch to CHECKPOINT_RESTORE || USER_NOTIFICATION to avoid warning when
    only CONFIG_SECCOMP_FILTER is enabled.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Tyler Hicks <tyhicks@canonical.com>
CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
---
 kernel/seccomp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index a09eb5c05f68..ed786655186d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1188,7 +1188,8 @@ long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
 	return do_seccomp(op, 0, uargs);
 }
 
-#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
+#if defined(CONFIG_CHECKPOINT_RESTORE) || \
+	defined(CONFIG_SECCOMP_USER_NOTIFICATION)
 static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 					     unsigned long filter_off)
 {
@@ -1235,6 +1236,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 	return filter;
 }
 
+#if defined(CONFIG_CHECKPOINT_RESTORE)
 long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
 			void __user *data)
 {
@@ -1307,7 +1309,8 @@ long seccomp_get_metadata(struct task_struct *task,
 	__put_seccomp_filter(filter);
 	return ret;
 }
-#endif
+#endif /* CONFIG_CHECKPOINT_RESTORE */
+#endif /* CONFIG_SECCOMP_FILTER */
 
 #ifdef CONFIG_SYSCTL
 
-- 
2.17.1

