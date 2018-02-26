Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeBZHq7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 02:46:59 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:54599 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeBZHq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 02:46:58 -0500
X-Google-Smtp-Source: AH8x227QQ/StTJ76FZYEKXH7ZQOTtj1YZpjsz8j/aPA9LJ0Wyum/NvZCm3JBSEV92Ji5O3nPDm5KoQ==
Date: Mon, 26 Feb 2018 16:46:52 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv3 1/2] zsmalloc: introduce zs_huge_object() function
Message-ID: <20180226074652.GB168047@rodete-desktop-imager.corp.google.com>
References: <20180210082321.17798-1-sergey.senozhatsky@gmail.com>
 <20180214055747.8420-1-sergey.senozhatsky@gmail.com>
 <20180220012429.GA186771@rodete-desktop-imager.corp.google.com>
 <20180226054927.GA12539@jagdpanzerIV>
 <20180226055804.GD112402@rodete-desktop-imager.corp.google.com>
 <20180226065035.GD12539@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226065035.GD12539@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 03:50:35PM +0900, Sergey Senozhatsky wrote:
> On (02/26/18 14:58), Minchan Kim wrote:
> [..]
> > > Right. The changes are pretty trivial, that's why I kept then in
> > > 2 simple patches. Besides, I didn't want to mix zsmalloc and zram
> > > changes.
> > 
> > As I said earlier, it's not thing we usually do, at least, MM.
> > Anyway, I don't want to insist on it because it depends each
> > person's point of view what's the better for review, git-bisect.
> 
> Thanks :)
> 
> > > > 	size_t huge_size = _zs_huge_object(pool);
> > > > 	..
> > > > 	..
> > > > 	if (comp_size >= huge_size)
> > > > 		memcpy(dst, src, 4K);
> > > 
> > > Yes, can do. My plan was to keep it completely internally to zsmalloc.
> > > Who knows, it might become smart enough one day to do something more
> > > than just size comparison. Any reason you used that leading underscore
> > 
> > Let's do that in future if someone want it. :)
> 
> OK.
> 
> > > in _zs_huge_object()?
> > 
> > 
> > Nope. It's just typo. Let's think better name.
> > How about using zs_huge_size()?
> 
> hm, I think `huge_size' on it's own is a bit general and cryptic.
> zs_huge_object_size() or zs_huge_class_size()?

I wanted to use more general word to hide zsmalloc internal but
I realized it's really impossible to hide them all.
If so, let's use zs_huge_class_size and then let's add big fat
comment what the API represents in there.

Thanks, Sergey!
