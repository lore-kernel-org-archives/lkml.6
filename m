Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57FBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8064920645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8064920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeIJVoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:44:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:51342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbeIJVoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:44:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 740BBAF31;
        Mon, 10 Sep 2018 16:49:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1400DAD81; Mon, 10 Sep 2018 18:48:43 +0200 (CEST)
Date:   Mon, 10 Sep 2018 18:48:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, kbuild-all@01.org,
        David Sterba <dsterba@suse.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Josef Bacik <jbacik@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH linux-next] btrfs: btrfs_run_delayed_refs_for_head()
 can be static
Message-ID: <20180910164843.GS24025@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        kbuild test robot <fengguang.wu@intel.com>,
        Nikolay Borisov <nborisov@suse.com>, kbuild-all@01.org,
        David Sterba <dsterba@suse.com>,
        Chris Mason <chris.mason@fusionio.com>, Josef Bacik <jbacik@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201809102215.95hxOLVe%fengguang.wu@intel.com>
 <20180910150029.GA11874@lkp-wsm-ep1.lkp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910150029.GA11874@lkp-wsm-ep1.lkp.intel.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:00:29PM +0800, kbuild test robot wrote:
> 
> Fixes: ac75a14eb672 ("btrfs: Factor out loop processing all refs of a head")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> ---
>  extent-tree.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index b0882b6..719f1bb 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2537,9 +2537,9 @@ struct btrfs_delayed_ref_head *btrfs_obtain_ref_head(
>  }
>  
>  STATIC
> -int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
> -				    struct btrfs_delayed_ref_head *locked_ref,
> -				    unsigned long *run_refs)
> +static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
> +					   struct btrfs_delayed_ref_head *locked_ref,
> +					   unsigned long *run_refs)

I have a cleanup series to get rid of the STATIC macro, will result in
normal 'static' of the function. The patch will need to be updated, you
can ignore the warning for now.

>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_delayed_ref_root *delayed_refs;
