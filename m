Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755236AbeBBCeG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 21:34:06 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.216]:48721 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754125AbeBBCd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 21:33:56 -0500
Date: Thu, 01 Feb 2018 20:33:52 -0600
Message-ID: <20180201203352.Horde.xv5XUdiSqNDHlFujzwjX6S0@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: David Laight <David.Laight@aculab.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Wong Hoi Sing, Edison" <hswong3i@gmail.com>,
        "Hung Hing Lun, Mike" <hlhung3i@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp_lp: use 64-bit arithmetic instead of 32-bit
References: <20180201002407.GA1608@embeddedgus>
 <20180201003236.06143fd0@alans-desktop>
 <20180131190749.Horde.bsc7GhewsZwdnkmDtMlSwWO@gator4166.hostgator.com>
 <ef625a4f15144822a037ddabc33a4134@AcuMS.aculab.com>
In-Reply-To: <ef625a4f15144822a037ddabc33a4134@AcuMS.aculab.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 108.167.133.22
X-Source-L: Yes
X-Exim-ID: 1ehRAn-000vkd-LE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:50091
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Quoting David Laight <David.Laight@aculab.com>:

>> > The question you need to ask is 'can it overflow 32bit maths', otherwise
>> > you are potentially making the system do extra work for no reason.
>> >
>>
>> Yeah, I get your point and it seems that in this particular case there
>> is no risk of a 32bit overflow, but in general and IMHO as the code
>> evolves, the use of incorrect arithmetic may have security
>> implications in the future, so I advocate for code correctness in this
>> case.
>
> Even if the variable are 64bit you still need to worry (maybe less)
> about arithmetic overflow.
> The only real way to avoid overflow is to understand the domain
> of the values being used.
>

Yep, that's correct.

Thanks for the feedback.
--
Gustavo
