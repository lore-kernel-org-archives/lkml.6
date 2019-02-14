Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EFCC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C29222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU/DzSfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405467AbfBNDed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:34:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36569 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfBNDed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:34:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so2292753pgr.3;
        Wed, 13 Feb 2019 19:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZoDIlVrlmxKr2Q6rld/S+7lQCfvoP90EskQtItqhgI=;
        b=oU/DzSfs9Jg/TNZrCGtPOnbGh0gSlnJYPErb6kDyrqAISpf3APCUIYQiElrkc2bR/o
         Rcvi2hKKMfjVsjgonKeie8P06ogq/cK2me5OFTOMq2nGw37HpEsJViYATMhTEFYcrUe+
         AfJ+Gy+UJ7KtAfMCL5UycTeU0cn3kj5lId1icNH+FGYnPVDRAcxz83Jycj6fiNnsxkaW
         vciQ6566IjDNsZ9lT93wr8WgRyJZElsGPtVsdglT/l2C+XEoKi1dPJ85ylJze46qQxqn
         /pj9/axR4IHxibLg6s9Mk4EMwuoJ0gV+YdnaGBMkVnFNKCfxZwbFdiY/YUzvTiV0O53L
         vB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZoDIlVrlmxKr2Q6rld/S+7lQCfvoP90EskQtItqhgI=;
        b=DIKVeC9IwA8UVN68xEb1Om7UhejwE9U9gfGptX9paaQ/07jfArgAWFMG5rrAiRNRO4
         gug91I0uQDdA8+6YkgxpvT458S2KHE7pgeWFI9vDxooMpMeDVPazpHwos8MhhQYhFZQb
         HRRN+gChxvrnNHrpnaVEkswYmRHmoJr8PmK/cn1tx1m6EA008fsVKQ1rFSCYYDlWaTKj
         impsdwhl1LAUN87h9ASxZhSjHYYU8lZl42BkZGHjQjFwYn1yuzcqqN3yFsS5Y/mu2/5Z
         fiDS0X4tAMCPNw621r4lSlgGHw8/gR5UEfQ1AWI0FxvGJ35+EDdobtxTiyKO/bdlAIaB
         x7Lw==
X-Gm-Message-State: AHQUAuYJsTA3O9jArkURDJtvyIPLzh/R+OZcJ5S5XtyRa9Zy94ge9G+E
        TJcfNVFBcQTWSGQ/vvIUN8o=
X-Google-Smtp-Source: AHgI3IZ2gNEhWDHfqt/+Y0W5vjUHV2MzhalsvsDEhTWXvUlLlu/buF8P0SXyhrhYGqFAdn7sGDooqA==
X-Received: by 2002:a63:fa06:: with SMTP id y6mr1650969pgh.177.1550115271811;
        Wed, 13 Feb 2019 19:34:31 -0800 (PST)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id d88sm1112145pfe.19.2019.02.13.19.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 19:34:31 -0800 (PST)
Date:   Thu, 14 Feb 2019 03:34:28 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] perf/core: Fix mmap failure caused by bad size check
Message-ID: <20190214033426.qbhlhjdv6qq75tf7@mail.google.com>
References: <20190212155221.32753-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212155221.32753-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Ingo and Arnaldo,
Could you help review this and have this fix merged in next RC? The perf
is totaly broken now! Thanks.

On Tue, Feb 12, 2019 at 11:52:21PM +0800, Changbin Du wrote:
> Perf tool now is broken by commit 9dff0aa95a32 ("perf/core: Don't WARN()
> for impossible ring-buffer sizes"). The get_order() should be used but not
> the order_base_2(). This mistake makes mmap() on perf fd always fail.
> 
> Fixes: 9dff0aa95a32 ("perf/core: Don't WARN() for impossible ring-buffer sizes")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> ---
>  kernel/events/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 309ef5a64af5..55faafca4a6e 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -734,7 +734,7 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>  	size = sizeof(struct ring_buffer);
>  	size += nr_pages * sizeof(void *);
>  
> -	if (order_base_2(size) >= MAX_ORDER)
> +	if (get_order(size) >= MAX_ORDER)
>  		goto fail;
>  
>  	rb = kzalloc(size, GFP_KERNEL);
> -- 
> 2.19.1
> 

-- 
Cheers,
Changbin Du
