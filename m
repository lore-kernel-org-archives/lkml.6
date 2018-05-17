Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEQG7f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:59:35 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41624 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQG7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:59:34 -0400
X-Google-Smtp-Source: AB8JxZp4xbjdgFzWp8Ds96cnKplYjheT33oNSlX6QhGo47qy/OeSrGRR7/3QROHOX0yE9YfIhFFpjeDiv6vyjy/QZTg=
MIME-Version: 1.0
In-Reply-To: <1526373963-12417-1-git-send-email-vincentc@andestech.com>
References: <1526373963-12417-1-git-send-email-vincentc@andestech.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Thu, 17 May 2018 14:58:53 +0800
Message-ID: <CAEbi=3dN66nWLKF5bS30hmBWoLaMR07An5fjHtvc=SckeUYnFw@mail.gmail.com>
Subject: Re: [PATCH 0/3]nds32: Correct the cache operation for catch aliasing case
To: Vincent Chen <vincentc@andestech.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>, Arnd Bergmann <arnd@arndb.de>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-15 16:46 GMT+08:00 Vincent Chen <vincentc@andestech.com>:
> The following 3 issues are fixed in this patchset
>
> 1. In function flush_dacache_page and copy_user_highpage, the local irq is
> enabled when the cache of the page at address page_address(page) is written
> back to memory. It possibly causes data corruption. To fix this problem,
> the local irq is disabled before executing d-cache write-back and
> invalidate in this patchset.
>
> 2. According to Documentation/cachetlb.txt, the cache of the page at vmaddr
> shall be flushed in flush_anon_page instead of the cache of the page at
> page_address(page). We correct it and add the modification to this
> patchset.
>
> 3. Removing unneeded cache invalidation in copy_user_highpage function.
>
>
> Vincent Chen (3):
>   nds32: Correct flush_dcache_page function
>   nds32: Flush the cache of the page at vmaddr instead of kaddr in
>     flush_anon_page
>   nds32: Disable local irq before calling cpu_dcache_wb_page in
>     copy_user_highpage
>
>  arch/nds32/mm/cacheflush.c |   34 ++++++++++++++++++++--------------
>  1 files changed, 20 insertions(+), 14 deletions(-)
>

Thank you, Vincent.
Reviewed-by: Greentime Hu <greentime@andestech.com>
