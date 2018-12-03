Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FEDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CAD21473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CAD21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbeLCJJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:09:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:57430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbeLCJJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:09:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F993AE3A;
        Mon,  3 Dec 2018 09:09:40 +0000 (UTC)
Date:   Mon, 3 Dec 2018 10:09:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yueyi Li <liyueyi@live.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memblock: Anonotate memblock_is_reserved() with
 __init_memblock.
Message-ID: <20181203090939.GI31738@dhcp22.suse.cz>
References: <BLUPR13MB02893411BF12EACB61888E80DFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLUPR13MB02893411BF12EACB61888E80DFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 04:00:08, Yueyi Li wrote:
> Found warning:
> 
> WARNING: EXPORT symbol "gsi_write_channel_scratch" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: vmlinux.o(.text+0x1e0a0): Section mismatch in reference from the function valid_phys_addr_range() to the function .init.text:memblock_is_reserved()
> The function valid_phys_addr_range() references
> the function __init memblock_is_reserved().
> This is often because valid_phys_addr_range lacks a __init
> annotation or the annotation of memblock_is_reserved is wrong.
> 
> Use __init_memblock instead of __init.

Yes, it really doesn't make much sense to stand this out of all other
helpers.

> Signed-off-by: liyueyi <liyueyi@live.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
>  Changes v2: correct typo in 'warning'.
> 
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 9a2d5ae..81ae63c 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1727,7 +1727,7 @@ static int __init_memblock memblock_search(struct memblock_type *type, phys_addr
>  	return -1;
>  }
>  
> -bool __init memblock_is_reserved(phys_addr_t addr)
> +bool __init_memblock memblock_is_reserved(phys_addr_t addr)
>  {
>  	return memblock_search(&memblock.reserved, addr) != -1;
>  }
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
