Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8FCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35AB204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="UcCnOtMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35AB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbeI1WLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:11:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46392 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbeI1WLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:11:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id d8-v6so4574536pfo.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CTlt9tT/JqYRyTbWztXKvohMtR5jImpfi8VGfxIvZW8=;
        b=UcCnOtMRqvssVMt0J1bg/r1YuZKhuHoHeazQCj78rDNt82wdQAA1f29t89QUliBlHp
         LGxU7vzJAsqHxtamt5OsTvkcqo3LK8z4KSdoCXwnqc4QzxDqFi3fg/85qV2N/J0yOF5Y
         f/HGwuVLF0UgwuZoqnO5mL8TwrBoZjgtMrQpVT9uU16s/1V2jQLc2gh72ekU9XMvTgzS
         rcQ51etM7V4SlpdVS/8q1vZjv2562v6LJJ83231bhP2kvDh733KHfGCwO9adfmI3aZN6
         hGHwoYX+VRaZnMf7YiBskTUbBDHM0pSfj3rclVZu2G3R1FEvtljlnJFIrh3KJryatiNz
         yaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CTlt9tT/JqYRyTbWztXKvohMtR5jImpfi8VGfxIvZW8=;
        b=F10dmKH2mQeeZkN/aREfr2VbqXRjM1ZZm/mlYxO2GtuRXYUDhVIhe6yu6RRcdmBJuL
         gTjqcBWBrz9VIee63D2PRJFKMZ/J4NABTNjaxCeE9rOu82pBYF0rp32bDCd/K2qkNyV2
         eqmk6KAbvJqh1JHVijQ8MsHQhL1hc/4umBn6SDFNu+UngynLi5YhORF1UjE1JzdHYaiN
         1cG9tRWlFWFB4O+s7F4SHSRm47Hyt++UyU50e+I2dPn9c8NS2d3+kTra+GPQDfcTqhIP
         Mej43UhRlvFJLrX+r+BgYaddDjUPIIusv+pLpcE9jMehhLcmzA/lxTkQTwudE2AglbSV
         QILw==
X-Gm-Message-State: ABuFfohb4ePipp+XVgFLqK7//ZixSJv1YMXz+uvUn2NjE3F/sc2BeXwe
        rZnsxkiq7egtJjHvm66AXmzSTA==
X-Google-Smtp-Source: ACcGV63ccX2hAgsXZVIyUvqe1G+C/MtfZ0/eUcq7HctgqcH7kctGIfS5oPPveUq/n/w8AkeaEWAeGg==
X-Received: by 2002:a63:ec4b:: with SMTP id r11-v6mr15748200pgj.295.1538149646181;
        Fri, 28 Sep 2018 08:47:26 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.180])
        by smtp.gmail.com with ESMTPSA id c69-v6sm321532pfg.2.2018.09.28.08.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 08:47:25 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 3/3] seccomp: introduce read protection for struct seccomp
Date:   Fri, 28 Sep 2018 09:46:48 -0600
Message-Id: <20180928154648.6320-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180928154648.6320-1-tycho@tycho.ws>
References: <20180928154648.6320-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Jann pointed out, there is a race between SECCOMP_FILTER_FLAG_TSYNC and
the ptrace code that can inspect a filter of another process. Let's
introduce read locking into the two ptrace accesses so that we don't race.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Reported-by: Jann Horn <jannh@google.com>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
---
 include/linux/seccomp.h |  4 ++--
 kernel/seccomp.c        | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 8429bdda947a..30b27e898162 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -22,8 +22,8 @@ struct seccomp_filter;
  * @filter: must always point to a valid seccomp-filter or NULL as it is
  *          accessed without locking during system call entry.
  *
- *          @filter must only be accessed from the context of current as there
- *          is no read locking.
+ *          @filter is read-protected by task->signal->cred_guard_mutex when
+ *          outside of current context.
  */
 struct seccomp {
 	int mode;
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index ef80dd19f268..f65d47650ac1 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1042,7 +1042,12 @@ int seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
 		return -EACCES;
 	}
 
+	ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
+	if (ret < 0)
+		return ret;
+
 	filter = get_nth_filter(task, filter_off);
+	mutex_unlock(&task->signal->cred_guard_mutex);
 	if (IS_ERR(filter))
 		return PTR_ERR(filter);
 
@@ -1088,7 +1093,12 @@ int seccomp_get_metadata(struct task_struct *task,
 	if (copy_from_user(&kmd.filter_off, data, sizeof(kmd.filter_off)))
 		return -EFAULT;
 
+	ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
+	if (ret < 0)
+		return ret;
+
 	filter = get_nth_filter(task, kmd.filter_off);
+	mutex_unlock(&task->signal->cred_guard_mutex);
 	if (IS_ERR(filter))
 		return PTR_ERR(filter);
 
-- 
2.17.1

