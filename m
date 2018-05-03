Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeECHnc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:43:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:58877 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751043AbeECHn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:43:29 -0400
Date: Thu, 3 May 2018 09:43:27 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Huaisheng Ye <yehs1@lenovo.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz,
        mgorman@techsingularity.net, alexander.levin@verizon.com,
        colyli@suse.de, chengnt@lenovo.com
Subject: Re: [PATCH] include/linux/gfp.h: use unsigned int in gfp_zone
Message-ID: <20180503074327.GA4535@dhcp22.suse.cz>
References: <1525319098-91429-1-git-send-email-yehs1@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525319098-91429-1-git-send-email-yehs1@lenovo.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-05-18 11:44:58, Huaisheng Ye wrote:
> Suggest using unsigned int instead of int for bit within gfp_zone.
> 
> The value of bit comes from flags, which's type is gfp_t. And it
> indicates the number of bits in the right shift for GFP_ZONE_TABLE.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

The patch looks OK but it misses the most important piece of
information. Why this is worth changing. Does it lead to a better code?
Silence a warning or...

> ---
>  include/linux/gfp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 1a4582b..21551fc 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -401,7 +401,7 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>  static inline enum zone_type gfp_zone(gfp_t flags)
>  {
>  	enum zone_type z;
> -	int bit = (__force int) (flags & GFP_ZONEMASK);
> +	unsigned int bit = (__force unsigned int) (flags & GFP_ZONEMASK);
>  
>  	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
>  					 ((1 << GFP_ZONES_SHIFT) - 1);
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
