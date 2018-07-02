Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC3FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6190E25451
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6190E25451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933988AbeGBJaw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:30:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:56248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933423AbeGBJar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:30:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D60DAFD5;
        Mon,  2 Jul 2018 09:30:45 +0000 (UTC)
Date:   Mon, 2 Jul 2018 11:30:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Rodrigo Freire <rfreire@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: be more informative in OOM task list
Message-ID: <20180702093043.GB19043@dhcp22.suse.cz>
References: <7de14c6cac4a486c04149f37948e3a76028f3fa5.1530461087.git.rfreire@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de14c6cac4a486c04149f37948e3a76028f3fa5.1530461087.git.rfreire@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 01-07-18 13:09:40, Rodrigo Freire wrote:
> The default page memory unit of OOM task dump events might not be
> intuitive for the non-initiated when debugging OOM events. Add
> a small printk prior to the task dump informing that the memory
> units are actually memory _pages_.

Does this really help? I understand the the oom report might be not the
easiest thing to grasp but wouldn't it be much better to actually add
documentation with clarification of each part of it?

> Signed-off-by: Rodrigo Freire <rfreire@redhat.com>
> ---
>  mm/oom_kill.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 84081e7..b4d9557 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -392,6 +392,7 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
>  	struct task_struct *p;
>  	struct task_struct *task;
>  
> +	pr_info("Tasks state (memory values in pages):\n");
>  	pr_info("[ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
>  	rcu_read_lock();
>  	for_each_process(p) {
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
