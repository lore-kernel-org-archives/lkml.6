Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F6CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C6D217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297801;
	bh=VM8VmnhOGahDE9+80xpGj8GDOfEKcVOGVd1nn4qRQJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jdeQVLI8q6xE9ohqHb/rOKngWl56OujkWNUReuSbf3Tn7g6W4sRU9Fgv/T0r77Goc
	 uyqRIHK2kFEfpRAZpVK518EvbkjWmbpArxc8QseAVWY2jvRWDIO6URh1jT2QV+r6YA
	 ruJKDz5LkHhxsNB76YSheJn44ofgmRNH0l3ucI3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbeLTJXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731499AbeLTJXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:23:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9A120656;
        Thu, 20 Dec 2018 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297796;
        bh=VM8VmnhOGahDE9+80xpGj8GDOfEKcVOGVd1nn4qRQJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uf39BjWfA5D15qSb/JOmz0n5tWOZplwK6KHmpmobFvbA12V4UondNEvkQ5wlaTKQV
         SJGZQmv1mbK1KRWqcNMdcsUxzeD5XoWbkCD5jiLx+NozAgSWF7mfs5UxFugbxu+ub5
         K9gkWOCNGbuOaRVpePbuP2A+DiKDZ8MdpF2tuaqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 07/61] timer/debug: Change /proc/timer_list from 0444 to 0400
Date:   Thu, 20 Dec 2018 10:18:07 +0100
Message-Id: <20181220085844.024304430@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8e7df2b5b7f245c9bd11064712db5cb69044a362 ]

While it uses %pK, there's still few reasons to read this file
as non-root.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timer_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index ef4f16e81283..1407ed20ea93 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -399,7 +399,7 @@ static int __init init_timer_list_procfs(void)
 {
 	struct proc_dir_entry *pe;
 
-	pe = proc_create("timer_list", 0444, NULL, &timer_list_fops);
+	pe = proc_create("timer_list", 0400, NULL, &timer_list_fops);
 	if (!pe)
 		return -ENOMEM;
 	return 0;
-- 
2.19.1



