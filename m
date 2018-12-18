Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60019218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeLRQey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:34:54 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:38986 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbeLRQex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:34:53 -0500
Received: by suse.de (Postfix, from userid 1000)
        id E1C8E3C69; Tue, 18 Dec 2018 17:34:51 +0100 (CET)
Date:   Tue, 18 Dec 2018 17:34:51 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] memory_hotplug: add missing newlines to debugging output
Message-ID: <20181218163446.ua6svkohowov35to@d104.suse.de>
References: <20181218162307.10518-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218162307.10518-1-mhocko@kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:23:07PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>

> Fixes: b77eab7079d9 ("mm/memory_hotplug: optimize probe routine")
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  drivers/base/memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 0e5985682642..b5ff45ab7967 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -207,15 +207,15 @@ static bool pages_correctly_probed(unsigned long start_pfn)
>  			return false;
>  
>  		if (!present_section_nr(section_nr)) {
> -			pr_warn("section %ld pfn[%lx, %lx) not present",
> +			pr_warn("section %ld pfn[%lx, %lx) not present\n",
>  				section_nr, pfn, pfn + PAGES_PER_SECTION);
>  			return false;
>  		} else if (!valid_section_nr(section_nr)) {
> -			pr_warn("section %ld pfn[%lx, %lx) no valid memmap",
> +			pr_warn("section %ld pfn[%lx, %lx) no valid memmap\n",
>  				section_nr, pfn, pfn + PAGES_PER_SECTION);
>  			return false;
>  		} else if (online_section_nr(section_nr)) {
> -			pr_warn("section %ld pfn[%lx, %lx) is already online",
> +			pr_warn("section %ld pfn[%lx, %lx) is already online\n",
>  				section_nr, pfn, pfn + PAGES_PER_SECTION);
>  			return false;
>  		}
> -- 
> 2.19.2
> 

-- 
Oscar Salvador
SUSE L3
