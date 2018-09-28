Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6AFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172A5204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="EZXvK8mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172A5204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbeI1WLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:11:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35850 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeI1WLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:11:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id b7-v6so4606604pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2OMkUL8hej/cfOevTefn01o1Yd1V9tYl0gYMwS/h2SI=;
        b=EZXvK8moBl3ysKTrMMFgppFzW6MzbhGqudWRIxkbOFiyO00eEXgfXHP54EnDl3VyYz
         tTrWoThhPeZUYt4dP7CHHXF54tBH2f1uAsic1e/D8BPFvUtpXfi6TlwFqbhjuqqH0BTm
         6Ud7hfdGByAws9lFJgpBnrJsWbjauPNvQoTRhFjn7RN29TD8cV0rwfMJ6Asvt5ZYClo3
         2VVvaMFRWynVkOqATD0ZhQeAydxmweIqxcltiX/I500Sg2ibWAVGDdfpYKo+8Y7G1izz
         pZU8W/1np8/7+CYv5UqVjOHQaMoBmquQWGsTvUvK4Pk6LAbd8CQNIpTcD/Jyi5ZItKl4
         y3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2OMkUL8hej/cfOevTefn01o1Yd1V9tYl0gYMwS/h2SI=;
        b=nT3skqhLDowt4WyDa2CuhJNeoLZm6FIqVHhn9UU4JbV11KmhdGbgA1B+regzOMwwan
         bLdP8zIUUWfVVoqObJVtjr2LRlan0BGxcx7qu2HQTD/S0CvfAum2jyGeyMT1TvBp4gHI
         S05Pq1b7nMzyXy+6aF1FTwvoSAXv/+VAcBswr6KMen+byK2DNsa+i8cN15HaJRY7vZql
         kGB8KY0E9R68Lj+Ogndmy407CEzggysGTBYWGtuFC/r2z7k6raAhcEQftsaw9nlz5Llg
         N1l/dpkCtNMWxNdNHyOPTeScOyZ0qgPpuhcetXsN+V50+FlsJR1/ehzA6jVP52IXA0Cz
         1TNA==
X-Gm-Message-State: ABuFfoiYdsJMlDMw8JWYmHfNg/KUKVb58HjjT9MJWunkht5QsUIhQRfI
        h2X/oPWy5SbBDRt3PWqNQKIsity0h44=
X-Google-Smtp-Source: ACcGV612j0BI2WyojFaAC8CqsLMB6Fau34P18CbmmOAK5HQUP5D4wpQuNnWQw9f6jXPVfhiQyy65hA==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33-v6mr16999551pll.65.1538149642920;
        Fri, 28 Sep 2018 08:47:22 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.180])
        by smtp.gmail.com with ESMTPSA id c69-v6sm321532pfg.2.2018.09.28.08.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 08:47:21 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 1/3] seccomp: change return type of seccomp_get_metadata to int
Date:   Fri, 28 Sep 2018 09:46:46 -0600
Message-Id: <20180928154648.6320-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Jann pointed out in another thread, ptrace_requiest() returns an int, so
it makes sense for seccomp_get_metdata() to return an int as well. The
return type of seccomp_get_metadata() is bounded by sizeof(kmd), so this
conversion is safe.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Reported-by: Jann Horn <jannh@google.com>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
---
 include/linux/seccomp.h | 10 +++++-----
 kernel/seccomp.c        |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index e5320f6c8654..af972549a7b4 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -96,17 +96,17 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
 #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
 extern long seccomp_get_filter(struct task_struct *task,
 			       unsigned long filter_off, void __user *data);
-extern long seccomp_get_metadata(struct task_struct *task,
-				 unsigned long filter_off, void __user *data);
+extern int seccomp_get_metadata(struct task_struct *task,
+				unsigned long filter_off, void __user *data);
 #else
 static inline long seccomp_get_filter(struct task_struct *task,
 				      unsigned long n, void __user *data)
 {
 	return -EINVAL;
 }
-static inline long seccomp_get_metadata(struct task_struct *task,
-					unsigned long filter_off,
-					void __user *data)
+static inline int seccomp_get_metadata(struct task_struct *task,
+				       unsigned long filter_off,
+				       void __user *data)
 {
 	return -EINVAL;
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index fd023ac24e10..9f3721849747 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1068,10 +1068,10 @@ long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
 	return ret;
 }
 
-long seccomp_get_metadata(struct task_struct *task,
-			  unsigned long size, void __user *data)
+int seccomp_get_metadata(struct task_struct *task,
+			 unsigned long size, void __user *data)
 {
-	long ret;
+	int ret;
 	struct seccomp_filter *filter;
 	struct seccomp_metadata kmd = {};
 
-- 
2.17.1

