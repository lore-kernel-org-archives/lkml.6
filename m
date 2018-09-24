Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B983EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC0721480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC0721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbeIXU2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:28:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729045AbeIXU2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:28:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B583ACCC;
        Mon, 24 Sep 2018 14:26:10 +0000 (UTC)
Date:   Mon, 24 Sep 2018 16:26:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     zhe.he@windriver.com
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        pasha.tatashin@oracle.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, osalvador@suse.de, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/page_alloc: Add KBUILD_MODNAME
Message-ID: <20180924142609.GD18685@dhcp22.suse.cz>
References: <1537628013-243902-1-git-send-email-zhe.he@windriver.com>
 <1537628013-243902-2-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537628013-243902-2-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 22-09-18 22:53:33, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> Add KBUILD_MODNAME to make prints more clear.

Please be more explicit. Examples of before and after would be really
helpful.

> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Cc: akpm@linux-foundation.org
> Cc: mhocko@suse.com
> Cc: vbabka@suse.cz
> Cc: pasha.tatashin@oracle.com
> Cc: mgorman@techsingularity.net
> Cc: aaron.lu@intel.com
> Cc: osalvador@suse.de
> Cc: iamjoonsoo.kim@lge.com
> ---
> v2:
> Split the addition of KBUILD_MODNAME out
> 
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f34cae1..ead9556 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -14,6 +14,8 @@
>   *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/stddef.h>
>  #include <linux/mm.h>
>  #include <linux/swap.h>
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
