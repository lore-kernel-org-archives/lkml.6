Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14A1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF32218D4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ck5br19Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfBFQOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:14:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40735 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBFQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:14:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id q21so3401023wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZMdTIJiFZs6WXlsN77wJLrnWDIrhgBDpB1unHtC2Zf4=;
        b=ck5br19QXXWqPqJHm1nL7N3+Iu9ivZnhh1nnL2Pq7gpeMfMiTc0IacB0d5c/eNM+Ux
         wec7MBg4Tm8saX1yjET6RZi7O4kPo60snxP2W6eDrutGebIrRN+2PzvqhLSmtncA66//
         Q5EGBmCEDvn+BLFLlHKV2zYI4PTPqA2dznWZycvbSYrx1tOvsJTi2jebYxwjyv+e7rMF
         R8Ad596/7vKH2Ypa18+6Kraj5/pJdEoJemlxJ9bSl10BBx5lNmIn7cQptMKt/aHrbnLg
         VC3R5W3cYh41c2wa8vM2CDjoLOCaUtZKAIhwsD8S82AcdeExZOgkfpZsIXCweBOs+eMq
         9u/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZMdTIJiFZs6WXlsN77wJLrnWDIrhgBDpB1unHtC2Zf4=;
        b=DyXn0nZRjpqQNjyLKjFFLqbN8VV3REUyY8JUoKgmf0Ib2kPU2IuyOmvQSoqjGdyIn5
         ksHkEaq8SC8JtR4qnfuEayLYTPZIQT3B6sdU4Jh4xkAdiBJ+n98LS1+Tqd7Te9L+9L97
         TMi6Dce7HjttrvGZu7KsUnev+oE5DTKSYFkVEuQmIn76kyjxAubdoCqjQLd6HSdLfIpl
         OvH84Nw++vQ+q8YLuO5LJtSVIlEeWY0nC/v/r1chVDfLrF267eNP1aEaFqwjG0oCf57V
         S85uZSSSEMriK6ojtEFfqsTjASHT7o+oW2E5fsaAhlvuMbcLyX2eH/eRnw3BzBkwuur2
         jB+w==
X-Gm-Message-State: AHQUAuaiLE8lXuQeJrlvpXIt1S/6DPX+38dyXjWNqAaXH+qKWFpNlW6o
        FijbYzWjf5BcKt7Zh93bFOfeQpt4tiI=
X-Google-Smtp-Source: AHgI3IbO+BhtXYGgLf1hGx57EQpK0fx88VZG9FLw/fEW75auj9hg/m6FKiXn8Xi1R20j/OjYQz7w2Q==
X-Received: by 2002:a05:600c:2147:: with SMTP id v7mr3311932wml.41.1549469668563;
        Wed, 06 Feb 2019 08:14:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e4a1:3fb3:af18:c98a])
        by smtp.gmail.com with ESMTPSA id y20sm27492328wra.51.2019.02.06.08.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 08:14:27 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     tj@kernel.org, sargun@sargun.me, xiexiuqi@huawei.com,
        xiezhipeng1@huawei.com, torvalds@linux-foundation.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2] sched/fair: Fix O(nr_cgroups) in load balance path
Date:   Wed,  6 Feb 2019 17:14:20 +0100
Message-Id: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds missing pieces in the management of leaf_cfs_rq_list 
to ensure that cfs_rqs are always correctly ordered before
re-enabling ("sched/fair: Fix O(nr_cgroups) in load balance path")

Vincent Guittot (2):
  sched/fair: optimization of update_blocked_averages()
  sched/fair: Fix O(nr_cgroups) in load balance path

 kernel/sched/fair.c | 67 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 14 deletions(-)

-- 
2.7.4

