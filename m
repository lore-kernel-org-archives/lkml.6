Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DFBC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0792320811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="wB9WSyAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0792320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeLMCrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:47:00 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44412 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeLMCrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:47:00 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so409306iod.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 18:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRnJZLQFs70FIewWJV7XazGm0g0dZRdV0CZhPT5PP4k=;
        b=wB9WSyApOWc2MfDvhlXno52/wtweMfqgvEGIlKSkmVF7LxYnDw+0Zquk503UYxZrfg
         iYOBDe7OD0owQjz4tQeZ39ODWVGRxCTVFMpSmBW0berCsARBTH3+atSz+nDTEpwxJVOH
         ZxUk4uq8FQo2CXUNpwUCqnNoWvzt3ONdyKJo95vvFboa35wUZOxlDWGeTZ1/nT3EGTVz
         8cVlEZqDM905I4NhvXAegubE8o2JQmjZYJd/NaROfQti/O+PGKP0AMwC0uHkvQItGrl8
         +6K3Y6DbVINrAd3SCw5rdc0UM5thB4zHYaT5N84jcHaNwR+s+M/sfCXP5DDrxLallU7I
         scmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRnJZLQFs70FIewWJV7XazGm0g0dZRdV0CZhPT5PP4k=;
        b=ObqK2JE0kR7Mt1pr9J1ynRc09iVgQnC/qhn2DNo8iBBW9FPG7B9KvOBNAYmFHrZwU8
         Rb39gz4L1oS6NjLxAgz5NHC9Ggf3pofKUFzEq9IfVCqPLmoLkeUir15zZymFI8VcG2J7
         4nUtjgk09l9KVC5xlRWO64nyxOQtjEqiHVea5qusGwboOyDkEtMN1LKatUFAaV8MUvmT
         v7CyrwzlRXS6Ni8yAQa58M04L1xbnV1PUp6CXVbw5r1bvR5z+Us7NOg2d+xIkUeAzVYs
         TqRHVczIEbrMP91+FlKhJrKGmcV27WFojOZulLM+oDfE1phKiYIhrAmETpHpWUGbI1jq
         71KQ==
X-Gm-Message-State: AA+aEWaUlRWrboVnHxfgcK1JOMTvb3xAjZKzwBykDc0jhfhx9Z3HNkPd
        QqLEkCO17c6HgQ2gIZM79UweuA==
X-Google-Smtp-Source: AFSGD/VG6LvxCSRrFEAfzMpql58gC2+zQhCi39qqKIcPgs3K4DH0Y4fhcoB4nEVhyy3vDXnzgXnMCQ==
X-Received: by 2002:a6b:f218:: with SMTP id q24mr18576695ioh.48.1544669219628;
        Wed, 12 Dec 2018 18:46:59 -0800 (PST)
Received: from cisco.lan (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id v16sm269979iom.26.2018.12.12.18.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 18:46:58 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] seccomp: fix poor type promotion
Date:   Wed, 12 Dec 2018 19:46:54 -0700
Message-Id: <20181213024654.7004-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains,

kernel/seccomp.c:1172:13: warning: incorrect type in assignment (different base types)
kernel/seccomp.c:1172:13:    expected restricted __poll_t [usertype] ret
kernel/seccomp.c:1172:13:    got int
kernel/seccomp.c:1173:13: warning: restricted __poll_t degrades to integer

Instead of assigning this to ret, since we don't use this anywhere, let's
just test it against 0 directly.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Reported-by: 0day robot <lkp@intel.com>
---
 kernel/seccomp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 15b6be97fc09..d7f538847b84 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1169,8 +1169,7 @@ static __poll_t seccomp_notify_poll(struct file *file,
 
 	poll_wait(file, &filter->notif->wqh, poll_tab);
 
-	ret = mutex_lock_interruptible(&filter->notify_lock);
-	if (ret < 0)
+	if (mutex_lock_interruptible(&filter->notify_lock) < 0)
 		return EPOLLERR;
 
 	list_for_each_entry(cur, &filter->notif->notifications, list) {
-- 
2.19.1

