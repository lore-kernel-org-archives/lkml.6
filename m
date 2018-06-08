Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +KO1A3N7Gls/AgAAmS7hNA
	; Fri, 08 Jun 2018 12:50:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1B5D7608B8; Fri,  8 Jun 2018 12:50:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqQp4Gtv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 90CCD606FA;
	Fri,  8 Jun 2018 12:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90CCD606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeFHMt4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:49:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44880 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751846AbeFHMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:49:54 -0400
Received: by mail-pg0-f68.google.com with SMTP id p21-v6so6352457pgd.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QbCpKA5auRQCtpvi2En1bDrPZ5zG/N+QDTapvB0H/bQ=;
        b=sqQp4Gtv/LpRKBq+h0Gyc+Dq0/9ByREOvuuk2B5ngay8HWd6zXic4JiKMfw8WWSFyn
         VmMcSzIzBYy0kHPWj6vbOfJw+Ogofs4a/onB/6FMUFtfmWPPXNMCYopiccoBGc2MLVZk
         p1te6Vlq7+7ccitM5wqe+rsYJ7pmwj45x0fPRFFTacjMX4rmHMQJrHGLbitopZvIB/Kw
         XsUSyxTmPyBaOfyQYq1wr9XGRGSZmW9P4CeSeCNOcZgCfwx9/0SjvY+vdjXKC9LFXpoK
         1jKKsTyD+16fELRNSxyjxSqk/xQxgqG7UG+UzvIdDmZc/LQ7wMTetSdG025WnwkrDfOO
         giDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QbCpKA5auRQCtpvi2En1bDrPZ5zG/N+QDTapvB0H/bQ=;
        b=TgPukkryvR9M75k/GFdkDWffoWdk5jHBWufrJkO0xxMedEj31AcIdjDBeZt3kVrSDs
         dUBILhSJSnOVfKy/LMkqBBVeZjkpje9u5wOIrXxhh1mwFPiTz6r1FHPoFPg8HGb+n4RE
         qHXE2JnZKBwS4m1gAmtP9bX5nKV6B9UFaoDW9jrwcLbqGZXnNcGx+0YWwE4hOqQuR6WC
         t6ki+R9RuCZ1pzBbvyRUjgE988erpDP+mAjMqilX+hHjUzcCN3OacoCy06EwgWIm1j1L
         oDN8U9lLfpSwpIaR27ekzf5MCcehe3FC2lEJ4F2Ci1TZurBbJ5lXwz2+vDo25peU3Dmp
         Fb+w==
X-Gm-Message-State: APt69E0mgWw1KpWi6BLiiGVhjoIrksCYO9EcsMRsuGeMsijMIMBpxJ/3
        /DzU/egTOOAUiqnLjWUHvMI=
X-Google-Smtp-Source: ADUXVKKKgxdbBpqCygb6IfZ+yelFJJgUbJnGOMQLQoYGMDLUPcv17eQq6EXBGhrQOsGGHz1wIIowLQ==
X-Received: by 2002:a65:418b:: with SMTP id a11-v6mr5199323pgq.118.1528462194351;
        Fri, 08 Jun 2018 05:49:54 -0700 (PDT)
Received: from dest.didichuxing.com ([13.94.31.177])
        by smtp.gmail.com with ESMTPSA id h8-v6sm72530396pgq.56.2018.06.08.05.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 05:49:53 -0700 (PDT)
From: ufo19890607@gmail.com
To: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, yuzhoujian@didichuxing.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ufo19890607 <ufo19890607@gmail.com>
Subject: [PATCH v8 0/1] Refactor part of the oom report in dump_header
Date: Fri,  8 Jun 2018 20:49:37 +0800
Message-Id: <1528462178-29250-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ufo19890607 <ufo19890607@gmail.com>

Some users complains that system-wide oom report does not print memcg's
name which contains the task killed by the oom-killer. The current system
wide oom report prints the task's command, gfp_mask, order ,oom_score_adj 
and shows the memory info, but misses some important information, etc. the 
memcg that has reached its limit and the memcg to which the killed process 
is attached.

I follow the advices of David Rientjes and Michal Hocko, and refactor
part of the oom report. After this patch, users can get the memcg's 
path from the oom report and check the certain container more quickly.

Below is the part of the oom report in the dmesg
...
[  142.158316] panic cpuset=/ mems_allowed=0-1
[  142.158983] CPU: 15 PID: 8682 Comm: panic Not tainted 4.17.0-rc6+ #13
[  142.159659] Hardware name: Inspur SA5212M4/YZMB-00370-107, BIOS 4.1.10 11/14/2016
[  142.160342] Call Trace:
[  142.161037]  dump_stack+0x78/0xb3
[  142.161734]  dump_header+0x7d/0x334
[  142.162433]  oom_kill_process+0x228/0x490
[  142.163126]  ? oom_badness+0x2a/0x130
[  142.163821]  out_of_memory+0xf0/0x280
[  142.164532]  __alloc_pages_slowpath+0x711/0xa07
[  142.165241]  __alloc_pages_nodemask+0x23f/0x260
[  142.165947]  alloc_pages_vma+0x73/0x180
[  142.166665]  do_anonymous_page+0xed/0x4e0
[  142.167388]  __handle_mm_fault+0xbd2/0xe00
[  142.168114]  handle_mm_fault+0x116/0x250
[  142.168841]  __do_page_fault+0x233/0x4d0
[  142.169567]  do_page_fault+0x32/0x130
[  142.170303]  ? page_fault+0x8/0x30
[  142.171036]  page_fault+0x1e/0x30
[  142.171764] RIP: 0033:0x7f403000a860
[  142.172517] RSP: 002b:00007ffc9f745c28 EFLAGS: 00010206
[  142.173268] RAX: 00007f3f6fd7d000 RBX: 0000000000000000 RCX: 00007f3f7f5cd000
[  142.174040] RDX: 00007f3fafd7d000 RSI: 0000000000000000 RDI: 00007f3f6fd7d000
[  142.174806] RBP: 00007ffc9f745c50 R08: ffffffffffffffff R09: 0000000000000000
[  142.175623] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000400490
[  142.176542] R13: 00007ffc9f745d30 R14: 0000000000000000 R15: 0000000000000000
[  142.177709] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),origin_memcg=(null),kill_memcg=/test/test1/test2,task=panic,pid= 8622,uid=    0
...

ufo19890607 (1):
  Refactor part of the oom report in dump_header

 include/linux/memcontrol.h | 29 ++++++++++++++++++++++++++---
 mm/memcontrol.c            | 43 ++++++++++++++++++++++++++++++++-----------
 mm/oom_kill.c              | 26 +++++++++++---------------
 3 files changed, 69 insertions(+), 29 deletions(-)

-- 
2.14.1
