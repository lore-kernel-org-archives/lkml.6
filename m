Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6FFC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C9420833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4GNMn6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C9420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeKDJFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 04:05:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53839 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKDJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 04:05:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id v24-v6so4944501wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 16:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Yv9sHn+v08m8SuM0/F+aI+6ZTUsbLjXBnOwxDHQoCfU=;
        b=a4GNMn6IP1wiXCbFNIcnmmfSvDy7mFsiq4bCH8c44OxV6uGjumzzDTFRRbKnz2C4IR
         5cZ9pdopefIqokj9VjnrW2Wk0Sq/WrmiLrAv82UE7TAt5QnoyEqdWDaNXhgEmWHPdYtf
         HKZAP/wVPPsITztcNOXE0kimkQwJM7OxKh/DVJ8Z4yjME+NG0M0fToKP19FnpY3LQCtE
         dXuEiOSY2wBOqVYrPHsj1udItcknt5MA3QNp/2vldbg4Erf430+RiiAThtidW+nrnWSB
         BQh2+ZCH/G4ue2gzFaKqtoar8bESJH75cJn3MGsJkdXorDsauGKKxT2CHYX3xpjrLZgw
         q61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Yv9sHn+v08m8SuM0/F+aI+6ZTUsbLjXBnOwxDHQoCfU=;
        b=JTG8B9DE3Sazrmvhs2n5LddXbnDeS5hRhbtiIe2AgLy6JQiAfax+R+opUA8ch5XzST
         pk5qtyt/mgtST8Q4FFPnlodcsUCw6BzetOOcmmZhJzS4SvhiEIityWeaO6HhcLmdhlyB
         W+nItymDkWhyIbakg0YJTlWQ5yHf+t2Nicz3W1Ow2nRh8OgIP2mDrUrK61dBKqSjRgtE
         QXOX0a5F+ZWnPezelwiLBKZteEwYQat1ZEKICDA8SVQbql7YVq3dBvvrPPko8knw7Cx3
         uxloUNusZGCUQR/vmlFbyFTPOSM1oiAwCQKRNioK2dAAAv+na8SyADI31EZK77i3M0R5
         49UA==
X-Gm-Message-State: AGRZ1gJ4LNi1Nda9R5iBFVIJXlHZhCdVgNrkUv8INWkIt3sTAfg/wbQv
        7q5d9Z3gENsw98nD2NiRHGg=
X-Google-Smtp-Source: AJdET5fZSeFV5ez7otpoE6/er5nxE9XoJPOms4BwJicu0LJdrfTczLkhiZVh1Hqg3GcOLC3HGu4hPw==
X-Received: by 2002:a1c:6555:: with SMTP id z82-v6mr2022153wmb.66.1541289139729;
        Sat, 03 Nov 2018 16:52:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l6-v6sm16205406wrs.85.2018.11.03.16.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 16:52:18 -0700 (PDT)
Date:   Sun, 4 Nov 2018 00:52:16 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20181103235216.GA46027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 993f0b0510dad98b4e6e39506834dab0d13fd539 sched/topology: Fix off by one bug

A memory (under-)allocation fix and a comment fix.

 Thanks,

	Ingo

------------------>
Muchun Song (1):
      sched/rt: Update comment in pick_next_task_rt()

Peter Zijlstra (1):
      sched/topology: Fix off by one bug


 kernel/sched/rt.c       | 2 +-
 kernel/sched/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..a21ea6021929 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1561,7 +1561,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/*
 	 * We may dequeue prev's rt_rq in put_prev_task().
-	 * So, we update time before rt_nr_running check.
+	 * So, we update time before rt_queued check.
 	 */
 	if (prev->sched_class == &rt_sched_class)
 		update_curr_rt(rq);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9d74371e4aad..8d7f15ba5916 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1337,7 +1337,7 @@ void sched_init_numa(void)
 	int level = 0;
 	int i, j, k;
 
-	sched_domains_numa_distance = kzalloc(sizeof(int) * nr_node_ids, GFP_KERNEL);
+	sched_domains_numa_distance = kzalloc(sizeof(int) * (nr_node_ids + 1), GFP_KERNEL);
 	if (!sched_domains_numa_distance)
 		return;
 
