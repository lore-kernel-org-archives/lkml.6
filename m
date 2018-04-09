Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeDIPu1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:50:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:56720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751633AbeDIPu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:50:26 -0400
Date: Mon, 9 Apr 2018 17:50:25 +0200
From: Jan Kara <jack@suse.cz>
To: Mathieu Malaterre <malat@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>, Tejun Heo <tj@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backing: silence compiler warning using __printf
Message-ID: <20180409155025.ortsxj4fl3kxh36v@quack2.suse.cz>
References: <20180406201453.32683-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180406201453.32683-1-malat@debian.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-04-18 22:14:51, Mathieu Malaterre wrote:
> __printf marker was added in commit d2cc4dde9206 ("bdi_register: add
> __printf verification, fix arg mismatch") for function `bdi_register`
> since it is useful to verify format and arguments. Apply equivalent gcc
> attribute to `bdi_register_va`.
> 
> Remove warning triggered with W=1:
> 
>   mm/backing-dev.c:881:2: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  include/linux/backing-dev.h | 1 +
>  1 file changed, 1 insertion(+)

Yeah, the patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 3e4ce54d84ab..0e9c0f71f726 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -28,6 +28,7 @@ void bdi_put(struct backing_dev_info *bdi);
>  
>  __printf(2, 3)
>  int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...);
> +__printf(2, 0)
>  int bdi_register_va(struct backing_dev_info *bdi, const char *fmt,
>  		    va_list args);
>  int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner);
> -- 
> 2.11.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
