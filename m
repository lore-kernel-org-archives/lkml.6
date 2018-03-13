Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932733AbeCMKYo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:24:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34987 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932639AbeCMKYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:24:43 -0400
X-Google-Smtp-Source: AG47ELtKcGl58J80il/XJBF6dTYTiyoFVEyp/lB9AftoXkei+sHzGli9dm+rYHoMQnzI6RrXQu3eWQ==
Date: Tue, 13 Mar 2018 19:24:37 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 2/2] zram: drop max_zpage_size and use
 zs_huge_class_size()
Message-ID: <20180313102437.GA5114@jagdpanzerIV>
References: <20180306070639.7389-1-sergey.senozhatsky@gmail.com>
 <20180306070639.7389-3-sergey.senozhatsky@gmail.com>
 <20180313090249.GA240650@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313090249.GA240650@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Minchan,

On (03/13/18 18:02), Minchan Kim wrote:
> Sorry for being late.
> I love this patchset! Just a minor below.

:)

[..]
> > +	if (!huge_class_size)
> > +		huge_class_size = zs_huge_class_size();
> 
> If it is static, we can do this in zram_init? I believe it's more readable in that
> it's never changed betweens zram instances.

We need to have at least one pool, because pool decides where the
watermark is. At zram_init() stage we don't have a pool yet. We
zs_create_pool() in zram_meta_alloc() so that's why I put
zs_huge_class_size() there. I'm not in love with it, but that's
the only place where we can have it.

	-ss
