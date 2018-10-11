Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A622BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5745220841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkiJs7bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5745220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJKQ3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:29:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43298 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeJKQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:29:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so8742934wrt.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2A8LBGz3OUcq7yhYq2rTFDcFxaOQSvaZ/o9zFVkIACM=;
        b=fkiJs7biW7tMsD43MNfUj5UFgT4VjCjIHgLirBBSGD4trktzGXV7O5sXCjL/LeFwL8
         HaK1i/v5s9NCJTa09eKV8Dyt6j3Zyo3XiCTzNe1L2cck/sbu1MXkQ4SISj/o1G8nHyvM
         4eXGXs/k96xG2yNexUVk+fTH5MVEzU9ClOO3rcmIRfC/AbmNE7M15/oytD3onY0Aq7BX
         MplYCdacmhZ1wE6zgVjk+bjnN48nEcTVIU8DlWWWMEQD+oWNVHHcGIks1/p/PzobVt29
         dSg9w3RkekQsMf1m9lNm8X/iFngpDNvVZu1kmTeNF6sNMSyvvruVk/My/0HTJ6GbofXJ
         nk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=2A8LBGz3OUcq7yhYq2rTFDcFxaOQSvaZ/o9zFVkIACM=;
        b=CrpLwdHIje/zcOWou8O1I0oqIBhkF8a1ZC9b7Chj36tCaO/mxKsmLgMzeNTMJjZORD
         5kWNQybEFwCtn55+PmX5S/+H2agAct83aeL75ITQcroRBvt3MiwDDM5eufdlxxkmxF0/
         JQA82y+i/KjMjxbHok8MpSCiRZhwSNCz6JtnODg1lq1kP8nXe7y9WTUNafTUWIogUJuw
         x3Fpwq13LHlbgdrpU4hCJcMQbdVW/aC9vC3JJQ50iuQawqdHHmlnr4e+Mn+wmaSBRy5s
         IilqvQfcUr5Ggo6K8+VdkSXA5dToEJnzE4zACsVlQC251DSw5mwaCbZ6Dl/yTTYwbR5W
         wICA==
X-Gm-Message-State: ABuFfogQ2mBNbUM1Mg48M8qZzuAYzEt7dTadkj66FEQIpA5dN2sGTW9h
        nISv4fOEAVkUMbJma8J8fvg=
X-Google-Smtp-Source: ACcGV60+tMa2lgCPZrn3trJ4IT1EuSFz+HISEvkGnsSWeRag8tEdm1lmI0cFg2cbyf053wIVt4K/Qw==
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr722429wra.95.1539248557631;
        Thu, 11 Oct 2018 02:02:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y19-v6sm17917832wra.60.2018.10.11.02.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 02:02:37 -0700 (PDT)
Date:   Thu, 11 Oct 2018 11:02:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <20181011090234.GA49395@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: e054637597ba36d3729ba6a3a3dd7aad8e2a3003 mm, sched/numa: Remove remaining traces of NUMA rate-limiting

Cleanup of dead code left over from the recent sched/numa fixes.

 Thanks,

	Ingo

------------------>
Srikar Dronamraju (1):
      mm, sched/numa: Remove remaining traces of NUMA rate-limiting


 include/linux/mmzone.h |  4 ----
 mm/page_alloc.c        | 10 ----------
 2 files changed, 14 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3f4c0b167333..d4b0c79d2924 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -667,10 +667,6 @@ typedef struct pglist_data {
 	enum zone_type kcompactd_classzone_idx;
 	wait_queue_head_t kcompactd_wait;
 	struct task_struct *kcompactd;
-#endif
-#ifdef CONFIG_NUMA_BALANCING
-	/* Lock serializing the migrate rate limiting window */
-	spinlock_t numabalancing_migrate_lock;
 #endif
 	/*
 	 * This is a per-node reserve of pages that are not available
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 706a738c0aee..e2ef1c17942f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6193,15 +6193,6 @@ static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
 	return PAGE_ALIGN(pages * sizeof(struct page)) >> PAGE_SHIFT;
 }
 
-#ifdef CONFIG_NUMA_BALANCING
-static void pgdat_init_numabalancing(struct pglist_data *pgdat)
-{
-	spin_lock_init(&pgdat->numabalancing_migrate_lock);
-}
-#else
-static void pgdat_init_numabalancing(struct pglist_data *pgdat) {}
-#endif
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void pgdat_init_split_queue(struct pglist_data *pgdat)
 {
@@ -6226,7 +6217,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 {
 	pgdat_resize_init(pgdat);
 
-	pgdat_init_numabalancing(pgdat);
 	pgdat_init_split_queue(pgdat);
 	pgdat_init_kcompactd(pgdat);
 
