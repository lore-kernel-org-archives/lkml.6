Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeDSHRY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 03:17:24 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34714 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeDSHRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 03:17:23 -0400
X-Google-Smtp-Source: AIpwx4+HZ801qk4YsZmZ6PNPHwgmocUM80TI9TcbvieNlQ84m1cQmvUyb8+KHY4/1uyydTJ0MDYg9w==
From: ufo19890607 <ufo19890607@gmail.com>
To: guro@fb.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        penguin-kernel@i-love.sakura.ne.jp, rientjes@google.com,
        akpm@linux-foundation.org, tj@kernel.org
Cc: kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yuzhoujian <yuzhoujian@didichuxing.com>
Subject: Some questions about cgroup aware OOM killer.
Date: Thu, 19 Apr 2018 08:17:04 +0100
Message-Id: <1524122224-26670-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

Hi Roman
I've read your patchset about cgroup aware OOM killer, and try
to merge your patchset to the upstream kernel(v4.17-rc1). But
I found some functions which in your patch([PATCH v13 3/7] 
mm, oom: cgroup-aware OOM killer) does not exist in the upstream
kernel. Which version of the kernel do you patch on? And, do you
have the latest patchset?

The faults in PATCH v13 3/7:
1. mm/oom_kill.o: In function `out_of_memory':
   /linux/mm/oom_kill.c:1125: undefined reference to `alloc_pages_before_oomkill'
2. mm/oom_kill.c: In function ‘out_of_memory’:
   mm/oom_kill.c:1125:5: error: ‘struct oom_control’ has no member named ‘page’
   oc->page = alloc_pages_before_oomkill(oc);
     ^

Best wishes
