Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2262C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE4426A32
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE4426A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964853AbeFZMG1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:06:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934341AbeFZMG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:06:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 85338AF4C;
        Tue, 26 Jun 2018 12:06:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E874D1E3515; Tue, 26 Jun 2018 14:06:24 +0200 (CEST)
Date:   Tue, 26 Jun 2018 14:06:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Greg Thelen <gthelen@google.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: update stale account_page_redirty() comment
Message-ID: <20180626120624.duicgmjjmzhpqao4@quack2.suse.cz>
References: <20180625171526.173483-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625171526.173483-1-gthelen@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-06-18 10:15:26, Greg Thelen wrote:
> commit 93f78d882865 ("writeback: move backing_dev_info->bdi_stat[] into
> bdi_writeback") replaced BDI_DIRTIED with WB_DIRTIED in
> account_page_redirty().  Update comment to track that change.
>   BDI_DIRTIED => WB_DIRTIED
>   BDI_WRITTEN => WB_WRITTEN
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 337c6afb3345..6551d3b0dc30 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2490,8 +2490,8 @@ EXPORT_SYMBOL(__set_page_dirty_nobuffers);
>  
>  /*
>   * Call this whenever redirtying a page, to de-account the dirty counters
> - * (NR_DIRTIED, BDI_DIRTIED, tsk->nr_dirtied), so that they match the written
> - * counters (NR_WRITTEN, BDI_WRITTEN) in long term. The mismatches will lead to
> + * (NR_DIRTIED, WB_DIRTIED, tsk->nr_dirtied), so that they match the written
> + * counters (NR_WRITTEN, WB_WRITTEN) in long term. The mismatches will lead to
>   * systematic errors in balanced_dirty_ratelimit and the dirty pages position
>   * control.
>   */
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
