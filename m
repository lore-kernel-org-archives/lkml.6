Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBZFte (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 00:49:34 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36478 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBZFtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 00:49:32 -0500
X-Google-Smtp-Source: AH8x225APEhbe3RO5sIsZlmu5aeoQtetJkI6g1RhzSQZzmoVXqu+h0Ef1PyllQ7s7S9fQGsfunCW3Q==
Date: Mon, 26 Feb 2018 14:49:27 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv3 1/2] zsmalloc: introduce zs_huge_object() function
Message-ID: <20180226054927.GA12539@jagdpanzerIV>
References: <20180210082321.17798-1-sergey.senozhatsky@gmail.com>
 <20180214055747.8420-1-sergey.senozhatsky@gmail.com>
 <20180220012429.GA186771@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220012429.GA186771@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/20/18 10:24), Minchan Kim wrote:
> Hi Sergey,

[..]

> Sorry for the long delay. I was horribly busy for a few weeks. ;-(

My turn to say "Sorry for the delay" :)

[..]
> I think it's simple enough. :)

Right. The changes are pretty trivial, that's why I kept then in
2 simple patches. Besides, I didn't want to mix zsmalloc and zram
changes.

> Can't zram ask to zsmalloc about what size is for hugeobject from?
> With that, zram can save the wartermark in itself and use it.
> What I mean is as follows,
> 
> zram:
> 	size_t huge_size = _zs_huge_object(pool);
> 	..
> 	..
> 	if (comp_size >= huge_size)
> 		memcpy(dst, src, 4K);

Yes, can do. My plan was to keep it completely internally to zsmalloc.
Who knows, it might become smart enough one day to do something more
than just size comparison. Any reason you used that leading underscore
in _zs_huge_object()?

	-ss
