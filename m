Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754182AbeBNFwa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 00:52:30 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36895 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeBNFw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 00:52:28 -0500
X-Google-Smtp-Source: AH8x226g6JXyTv1ZY0xLN/LFZ4JF7ZVHnSPHs5CwuBT7wuR5NSqx5hed3XmM7fL5tv5PSHJDH4A5lQ==
Date: Wed, 14 Feb 2018 14:52:23 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCHv2 1/2] zsmalloc: introduce zs_huge_object() function
Message-ID: <20180214055223.GA508@jagdpanzerIV>
References: <20180207092919.19696-2-sergey.senozhatsky@gmail.com>
 <20180210082321.17798-1-sergey.senozhatsky@gmail.com>
 <20180211070539.GA13931@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211070539.GA13931@rapoport-lnx>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/11/18 09:05), Mike Rapoport wrote:
[..]
> > +/**
> > + * zs_huge_object() - Test if a compressed object's size is too big for normal
> > + *                    zspool classes and it shall be stored in a huge class.
> 
> I think "is should be stored" is more appropriate
> 
> > + * @sz: Size of the compressed object (in bytes).
> > + *
> > + * The function checks if the object's size falls into huge_class
> > + * area. We must take handle size into account and test the actual
> > + * size we are going to use, because zs_malloc() unconditionally
> > + * adds %ZS_HANDLE_SIZE before it performs %size_class lookup.
> 
>                                             ^ &size_class ;-)

I'm sorry, Mike. Lost in branches/versions and sent out a half baked
version.

	-ss
