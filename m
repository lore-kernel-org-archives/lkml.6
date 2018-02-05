Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeBEBni (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:43:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:62675 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752648AbeBEBm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:42:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,462,1511856000";
   d="scan'208";a="15834004"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michal Hocko" <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: bisected bd4c82c22c367e is the first bad commit (was [Bug 198617] New: zswap causing random applications to crash)
References: <20180130114841.aa2d3bd99526c03c6a5b5810@linux-foundation.org>
        <20180203013455.GA739@jagdpanzerIV>
        <CAC=cRTPyh-JTY=uOQf2dgmyPDyY-4+ryxkedp-iZMcFQZtnaqw@mail.gmail.com>
        <20180205013758.GA648@jagdpanzerIV>
Date: Mon, 05 Feb 2018 09:42:23 +0800
In-Reply-To: <20180205013758.GA648@jagdpanzerIV> (Sergey Senozhatsky's message
        of "Mon, 5 Feb 2018 10:37:58 +0900")
Message-ID: <87shag43gg.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> writes:

> Hi,
>
> On (02/04/18 22:21), huang ying wrote:
> [..]
>> >> After disabling zswap no crashes at all.
>> >>
>> >> /etc/systemd/swap.conf
>> >> zswap_enabled=1
>> >> zswap_compressor=lz4      # lzo lz4
>> >> zswap_max_pool_percent=25 # 1-99
>> >> zswap_zpool=zbud          # zbud z3fold
>> >
> [..]
>> Can you give me some detailed steps to reproduce this?  Like the
>> kernel configuration file, swap configuration, etc.  Any kernel
>> WARNING during testing?  Can you reproduce this with a real swap
>> device instead of zswap?
>
> No warnings (at least no warnings with my .config). Tested it only with
> zram based swap (I'm running swap-less x86 systems, so zram is the easiest
> way). It seems it's THP + frontswap that makes things unstable, rather
> than THP + swap.
>
> Kernel zswap boot params:
> zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=10 zswap.zpool=zbud
>
> Then I add a 4G zram swap and run a silly memory hogger. I don't think
> you'll have any problems reproducing it, but just in case I attached my
> .config

Thanks for your information!  I will try to reproduce it today!

Best Regards,
Huang, Ying

> 	-ss
