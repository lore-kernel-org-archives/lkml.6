Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA8CECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550BD208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6fRnf9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550BD208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbeGLVp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:45:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44005 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732202AbeGLVp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:45:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id v13-v6so4281899pgr.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=INRYbdV7gCxAVtNjXKkl9vilZaEVf/iEphy06sCThzU=;
        b=B6fRnf9cfmX2V8cxVFsDwEs1eTI7sguuFEY6XODA2kgea3B2kihd1VkDgrUgxKVp2O
         prFX/gbIow9jYXqHiKkA3MoFzc4gqCcYKr5M+xp96Qz9nVHJAVEV7y49CJ6KOZaI1taa
         dtuqWgeUjVVPLt8eoFeflsmZEhYN1dtkgy/6YKc+Qc5RjtJ5Mgkc02jQBX1GADPze1vo
         tuZ9JsHBldkQ2ol9jJqiJu8WyIjAkiR7RQZmHjUAuyNMBOqiZSp/D/yIuU7KGoDPIxXe
         cEA+g4Vthk1fh/y0u8L/wUrpHu4wYarJA8LuXKnao98y5m+M8QoXvG1tXbYyyUH0rGfe
         1vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=INRYbdV7gCxAVtNjXKkl9vilZaEVf/iEphy06sCThzU=;
        b=DLe/LTAGD9UkVodWZIvlHDNMdef30MVNPNbE46u/hyTZt7F4H908Rw48f8NUSuqr7Z
         qGpOkORlzGrderOdvbI78r3iiVmpYL3jdGf10sIBpvSIpIKtQxjEkQT6INsOTojaGDRP
         PrOi9dCqgxtqp75cgyEluCO2qdZGca89asHg/a+jnoC4y5LEbRZ0R1ESlNdErY0aQ3dT
         /HdP/UfMCDkRFud3nywR5FRshxPst61ijMCbA/Sb2LgiY2UPb15ujpi3Okf00kC1tJzP
         Vq6gN6lCkAJXCM8Aa7p1kHctufdEx6t3mMmMrPrbRjvri7hZqp2P4MUm1Ww//1ZOeYp/
         9eSA==
X-Gm-Message-State: AOUpUlG0QFFEF9YtWPZO39HtveT7tx7DxRO+tT48ylFnhZfgJJbUcifp
        eok7AQf8Jr36nl8mrPSfnrygXw==
X-Google-Smtp-Source: AAOMgpdgfZKKFgxqujWdPWAJRLzsMB/OKWI0E7mjXYybgFdpYeoDl9CTufcY6WRf2Mte6A7V+aFKfw==
X-Received: by 2002:a62:5582:: with SMTP id j124-v6mr4141698pfb.20.1531431241295;
        Thu, 12 Jul 2018 14:34:01 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 1-v6sm43159007pfm.145.2018.07.12.14.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 14:34:00 -0700 (PDT)
Date:   Thu, 12 Jul 2018 14:34:00 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [patch -mm] mm, oom: remove oom_lock from exit_mmap
Message-ID: <alpine.DEB.2.21.1807121432370.170100@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oom_lock isn't needed for __oom_reap_task_mm().  If MMF_UNSTABLE is 
already set for the mm, we can simply back out immediately since oom 
reaping is already in progress (or done).

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/mmap.c     | 2 --
 mm/oom_kill.c | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index cd2431f46188..7f918eb725f6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3072,9 +3072,7 @@ void exit_mmap(struct mm_struct *mm)
 		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
 		 * __oom_reap_task_mm() will not block.
 		 */
-		mutex_lock(&oom_lock);
 		__oom_reap_task_mm(mm);
-		mutex_unlock(&oom_lock);
 
 		/*
 		 * Now, set MMF_UNSTABLE to avoid racing with the oom reaper.
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 0fe4087d5151..e6328cef090f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -488,9 +488,11 @@ void __oom_reap_task_mm(struct mm_struct *mm)
 	 * Tell all users of get_user/copy_from_user etc... that the content
 	 * is no longer stable. No barriers really needed because unmapping
 	 * should imply barriers already and the reader would hit a page fault
-	 * if it stumbled over a reaped memory.
+	 * if it stumbled over a reaped memory. If MMF_UNSTABLE is already set,
+	 * reaping as already occurred so nothing left to do.
 	 */
-	set_bit(MMF_UNSTABLE, &mm->flags);
+	if (test_and_set_bit(MMF_UNSTABLE, &mm->flags))
+		return;
 
 	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
 		if (!can_madv_dontneed_vma(vma))
