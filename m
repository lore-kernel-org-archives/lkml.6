Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D18CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C7420849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544625246;
	bh=qEX6KLdOlIIvRUexA4oaQvKIRWZ3hTLPZw4+heg7hL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LTFfDuQxNHK1wKUMzYACykQPPYxKzfm/7ENIGYl8c2g+8RyU/cnctmJY2ARJJp3fC
	 rfMrG9Zz2gg8+rWnA+ZbQi3uVncYkj3VdaAYy61bNLdXovwgAmsGFf9PZNh+GxPnn0
	 gy0KTcZ2SH+YtUihlsLfvDzItT0QG7yB5lHfrN4Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C7420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeLLOeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:34:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:56732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbeLLOeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:34:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3F06AA7C;
        Wed, 12 Dec 2018 14:34:02 +0000 (UTC)
Date:   Wed, 12 Dec 2018 15:34:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] mm: lower the printk loglevel for __dump_page
 messages
Message-ID: <20181212143402.GB7378@dhcp22.suse.cz>
References: <20181107101830.17405-1-mhocko@kernel.org>
 <20181107101830.17405-3-mhocko@kernel.org>
 <20181212142540.GA7378@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212142540.GA7378@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-12-18 15:25:40, Michal Hocko wrote:
> It seems one follow up fix got lost on my side. Andrew, could you fold
> this in please?
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 68e9a9f2df16..4c916e1abedc 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -88,7 +88,7 @@ void __dump_page(struct page *page, const char *reason)
>  	pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>  
>  hex_only:
> -	print_hex_dump(KERN_ALERT, "raw: ", DUMP_PREFIX_NONE, 32,
> +	print_hex_dump(KERN_WARN, "raw: ", DUMP_PREFIX_NONE, 32,
>  			sizeof(unsigned long), page,
>  			sizeof(struct page), false);

s@KERN_WARN@KERN_WARNING@ of course. Sigh. Sorry
-- 
Michal Hocko
SUSE Labs
