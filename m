Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76DFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CD720663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfANI6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:58:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:49996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfANI6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:58:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40B2AAD73;
        Mon, 14 Jan 2019 08:58:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E6C8F1E157A; Mon, 14 Jan 2019 09:58:39 +0100 (CET)
Date:   Mon, 14 Jan 2019 09:58:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, zwisler@kernel.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] fs/dax: Convert to use vmf_error()
Message-ID: <20190114085839.GA13316@quack2.suse.cz>
References: <20190104192410.GA11084@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104192410.GA11084@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 05-01-19 00:54:11, Souptick Joarder wrote:
> This code is converted to use vmf_error().
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Dan, you are merging DAX patches these days. So probably you should add
yourself to 'FILESYSTEM DIRECT ACCESS (DAX)' in MAINTAINERs. Or I can start
picking patches for fsdax to my tree if you are too busy but I think your
tree is easier as there are less chances for conflicts etc.

In either case this patch looks OK to me so feel free to add

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dax.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 48132ec..ed39161 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1220,9 +1220,7 @@ static vm_fault_t dax_fault_return(int error)
>  {
>  	if (error == 0)
>  		return VM_FAULT_NOPAGE;
> -	if (error == -ENOMEM)
> -		return VM_FAULT_OOM;
> -	return VM_FAULT_SIGBUS;
> +	return vmf_error(error);
>  }
>  
>  /*
> -- 
> 1.9.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
