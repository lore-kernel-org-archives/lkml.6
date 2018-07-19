Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E800DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF8820858
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF8820858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbeGSO3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:29:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:57584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727441AbeGSO3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:29:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C9BFACFA;
        Thu, 19 Jul 2018 13:46:25 +0000 (UTC)
Date:   Thu, 19 Jul 2018 15:46:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 5/5] mm/page_alloc: Only call pgdat_set_deferred_range
 when the system boots
Message-ID: <20180719134622.GE7193@dhcp22.suse.cz>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-6-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719132740.32743-6-osalvador@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 15:27:40, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> We should only care about deferred initialization when booting.

Again why is this worth doing?
 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d77bc2a7ec2c..5911b64a88ab 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6419,7 +6419,8 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
>  				  zones_size, zholes_size);
>  
>  	alloc_node_mem_map(pgdat);
> -	pgdat_set_deferred_range(pgdat);
> +	if (system_state == SYSTEM_BOOTING)
> +		pgdat_set_deferred_range(pgdat);
>  
>  	free_area_init_core(pgdat);
>  }
> -- 
> 2.13.6
> 

-- 
Michal Hocko
SUSE Labs
