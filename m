Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBZGun (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 01:50:43 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:42058 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbeBZGul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 01:50:41 -0500
X-Google-Smtp-Source: AH8x224UnFQQw2StVz5pM8buP2/vhwJEWdCYle5Aj6HkkxyxybllpMyPiS+2oTCfE4O9CJ9vcy4fsw==
Date: Mon, 26 Feb 2018 15:50:35 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv3 1/2] zsmalloc: introduce zs_huge_object() function
Message-ID: <20180226065035.GD12539@jagdpanzerIV>
References: <20180210082321.17798-1-sergey.senozhatsky@gmail.com>
 <20180214055747.8420-1-sergey.senozhatsky@gmail.com>
 <20180220012429.GA186771@rodete-desktop-imager.corp.google.com>
 <20180226054927.GA12539@jagdpanzerIV>
 <20180226055804.GD112402@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226055804.GD112402@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/26/18 14:58), Minchan Kim wrote:
[..]
> > Right. The changes are pretty trivial, that's why I kept then in
> > 2 simple patches. Besides, I didn't want to mix zsmalloc and zram
> > changes.
> 
> As I said earlier, it's not thing we usually do, at least, MM.
> Anyway, I don't want to insist on it because it depends each
> person's point of view what's the better for review, git-bisect.

Thanks :)

> > > 	size_t huge_size = _zs_huge_object(pool);
> > > 	..
> > > 	..
> > > 	if (comp_size >= huge_size)
> > > 		memcpy(dst, src, 4K);
> > 
> > Yes, can do. My plan was to keep it completely internally to zsmalloc.
> > Who knows, it might become smart enough one day to do something more
> > than just size comparison. Any reason you used that leading underscore
> 
> Let's do that in future if someone want it. :)

OK.

> > in _zs_huge_object()?
> 
> 
> Nope. It's just typo. Let's think better name.
> How about using zs_huge_size()?

hm, I think `huge_size' on it's own is a bit general and cryptic.
zs_huge_object_size() or zs_huge_class_size()?

	-ss
