Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B27CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDBD20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDBD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeGZH0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:26:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbeGZH0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:26:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80CCAADBB;
        Thu, 26 Jul 2018 06:11:16 +0000 (UTC)
Date:   Thu, 26 Jul 2018 08:11:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiang Biao <jiang.biao2@zte.com.cn>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        hillf.zj@alibaba-inc.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn
Subject: Re: [PATCH] mm/vmscan: fix page_freeze_refs in comment.
Message-ID: <20180726061115.GR28386@dhcp22.suse.cz>
References: <1532561657-98783-1-git-send-email-jiang.biao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532561657-98783-1-git-send-email-jiang.biao2@zte.com.cn>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-07-18 07:34:17, Jiang Biao wrote:
> page_freeze_refs has already been relplaced by page_ref_freeze, but
> it is not modified in the comment.

Hmm
$ git grep page_refs_freeze origin/master
$

The same is the case in the linux-next tree. Which tree are you looking at?

> 
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 03822f8..d29e207 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -744,7 +744,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>  		refcount = 2;
>  	if (!page_ref_freeze(page, refcount))
>  		goto cannot_free;
> -	/* note: atomic_cmpxchg in page_freeze_refs provides the smp_rmb */
> +	/* note: atomic_cmpxchg in page_refs_freeze provides the smp_rmb */
>  	if (unlikely(PageDirty(page))) {
>  		page_ref_unfreeze(page, refcount);
>  		goto cannot_free;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
