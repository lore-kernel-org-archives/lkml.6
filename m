Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeDPWhn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 18:37:43 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:34967 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPWhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 18:37:41 -0400
Date: Mon, 16 Apr 2018 15:37:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, gwendal@chromium.org
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
Message-ID: <20180416223707.GA26180@roeck-us.net>
References: <20180412215501.GA16406@roeck-us.net>
 <CAMJBoFMq8DoWdcrajB_xyMrGXsUsbMjos_U60mOvf01MpK_9Kw@mail.gmail.com>
 <20180413173555.GA30587@roeck-us.net>
 <CAMJBoFPXObpXyQWz-zPJ7JnC-Z5FqqrLfr5BFWKdh+szZrPZ7A@mail.gmail.com>
 <20180413175615.GA30242@roeck-us.net>
 <b241e25a-50a3-fefb-0443-ad6c0a200898@gmail.com>
 <20180416155832.GB12015@roeck-us.net>
 <b5158eef-2fbd-ce8c-1c8c-6c38ec837f1d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5158eef-2fbd-ce8c-1c8c-6c38ec837f1d@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 12:14:37AM +0200, Vitaly Wool wrote:
[ ... ]
> Ugh. Could you please keep that patch and apply this on top:
> 
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index c0bca6153b95..e8a80d044d9e 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -840,6 +840,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>  			kref_get(&zhdr->refcount);
>  			list_del_init(&zhdr->buddy);
>  			zhdr->cpu = -1;
> +			break;
>  		}
>  		list_del_init(&page->lru);
> 
Much better, in a way. The system now takes much longer to crash,
and the crash reason is a bit different. The log is too long to attach,
so I copied it to [1].

crashdump.0002			Latest log
000[12]-Fix-attempt-[12].patch	Patches applied on top of v4.17.0-rc1.

Hope it helps,
Guenter


[1] http://server.roeck-us.net/qemu/z3pool/
