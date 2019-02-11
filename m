Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5DCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08632229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="j6UoFsN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbfBKTIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:08:25 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46005 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfBKTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:08:24 -0500
Received: by mail-yb1-f196.google.com with SMTP id e131so4598505ybh.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=udO/CAGWaZzJg7wtfE9Irj4YqoOL3OpYf/G/zEavsIE=;
        b=j6UoFsN7aS17EQdpvoIwl3GmHKJPT9x0KBUHG/lcN55cD57f7aGYEPbpO4lglC8BpM
         Eln0inWNeahjKWHTKbGF/ZJUgoYQFxyZ2HJ6xB4wL3Y1FXeO/t+hlRFAb0ChHAki5ZxB
         t7+BidMid3Pq/EanAvvb7J5zWr156RypfhJNbEEfIhRN5z/trpBjWQDMWRCYkLUOlg46
         ECrTCBk4FPnLdfvNqB0Eu7wAa32ZXHQWNByHdDNSyDqhQmxavEUarPHUvuccNn8ZU5wE
         rAHz1aPyQ6XNyK0puQDt1u8NTPqVFDz/T3i/D3JDsokEUQOnYvt2t2MjDxMdQ0U/YT9G
         a+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=udO/CAGWaZzJg7wtfE9Irj4YqoOL3OpYf/G/zEavsIE=;
        b=r31SUVztPw5/eeY/8r+c6k2g5EvjqR9Ge6ZZpPmhX/LjSpHxIy/4ZePkZxQmE9gWJS
         4pujkYivq6cdYNooFwaNzV40Fq37st+glvYocWKA96QKg0+qDyfoUhwGyWDbWsdmwLFN
         xgG4sHgysSuy9ra4O8R4EPTOTjjyelsoBRgh8jZvrjLXSSxJ/BP7HJZEmkyEYF4/V086
         ZzCGIjPgWhD7tKNbGa27dZAWEgD6S45zX9NAMaCivgjgHoU8peaOId584f5NGjhI5tfd
         eVvt8828Mljk01LmrrE73Y2u3BQ2sh73vG7gW8ntDz3TQijavPYg8z2tVZNkY+9yxmR/
         OK0Q==
X-Gm-Message-State: AHQUAuZVhgKjwneRu5t2EKyjBeBVGfntdh0BKYxVLS9ZCeD+/4UlAT6J
        88tcOibChYx3J7klGGv6ggpeqw==
X-Google-Smtp-Source: AHgI3IbJVWvvHfQxjFYRfbjQtGMyT/wbgVp6ZciqD9On+75HOuIbku0rWi0uxMnuB+3SaB8uOGQinA==
X-Received: by 2002:a5b:947:: with SMTP id x7mr12939985ybq.116.1549912103883;
        Mon, 11 Feb 2019 11:08:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:6e5])
        by smtp.gmail.com with ESMTPSA id 127sm4136207ywl.1.2019.02.11.11.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 11:08:23 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:08:22 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] vmalloc enhancements
Message-ID: <20190211190822.GA14443@cmpxchg.org>
References: <20181219173751.28056-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219173751.28056-1-guro@fb.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These slipped through the cracks. +CC Andrew directly.
Andrew, if it's not too late yet, could you consider them for 5.1?

On Wed, Dec 19, 2018 at 09:37:48AM -0800, Roman Gushchin wrote:
> The patchset contains few changes to the vmalloc code, which are
> leading to some performance gains and code simplification.
> 
> Also, it exports a number of pages, used by vmalloc(),
> in /proc/meminfo.
> 
> Patch (1) removes some redundancy on __vunmap().
> Patch (2) separates memory allocation and data initialization
>   in alloc_vmap_area()
> Patch (3) adds vmalloc counter to /proc/meminfo.
> 
> RFC->v1:
>   - removed bogus empty lines (suggested by Matthew Wilcox)
>   - made nr_vmalloc_pages static (suggested by Matthew Wilcox)
>   - dropped patch 3 from RFC patchset, will post later with
>   some other changes
>   - dropped RFC
> 
> Roman Gushchin (3):
>   mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
>   mm: separate memory allocation and actual work in alloc_vmap_area()
>   mm: show number of vmalloc pages in /proc/meminfo
> 
>  fs/proc/meminfo.c       |   2 +-
>  include/linux/vmalloc.h |   2 +
>  mm/vmalloc.c            | 107 ++++++++++++++++++++++++++--------------
>  3 files changed, 73 insertions(+), 38 deletions(-)
> 
> -- 
> 2.19.2
> 
