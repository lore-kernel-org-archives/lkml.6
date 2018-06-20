Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8BEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABAB20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABAB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754576AbeFTIdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:33:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:57407 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754289AbeFTIdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:33:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 937E4ADE9;
        Wed, 20 Jun 2018 08:21:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3A0AA1E0A21; Wed, 20 Jun 2018 10:21:18 +0200 (CEST)
Date:   Wed, 20 Jun 2018 10:21:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        y2038@lists.linaro.org, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] reiserfs: remove unused j_timestamp
Message-ID: <20180620082118.gnqgk2w2snxntpzo@quack2.suse.cz>
References: <20180619154343.3640484-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619154343.3640484-1-arnd@arndb.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-06-18 17:43:13, Arnd Bergmann wrote:
> This uses the deprecated time_t type but is write-only, so we
> can just remove it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/journal.c  | 1 -
>  fs/reiserfs/reiserfs.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 52eb5d293a34..1e7f733b2a12 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -4110,7 +4110,6 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
>  
>  	atomic_set(&jl->j_older_commits_done, 0);
>  	jl->j_trans_id = journal->j_trans_id;
> -	jl->j_timestamp = journal->j_trans_start_time;
>  	jl->j_commit_bh = c_bh;
>  	jl->j_start = journal->j_start;
>  	jl->j_len = journal->j_len;
> diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
> index ae4811fecc1f..1536ebbaf6ab 100644
> --- a/fs/reiserfs/reiserfs.h
> +++ b/fs/reiserfs/reiserfs.h
> @@ -271,7 +271,6 @@ struct reiserfs_journal_list {
>  
>  	struct mutex j_commit_mutex;
>  	unsigned int j_trans_id;
> -	time_t j_timestamp;
>  	struct reiserfs_list_bitmap *j_list_bitmap;
>  	struct buffer_head *j_commit_bh;	/* commit buffer head */
>  	struct reiserfs_journal_cnode *j_realblock;
> -- 
> 2.9.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
