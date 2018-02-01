Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932193AbeBABH6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:07:58 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.95]:38157 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755927AbeBABHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:07:53 -0500
Date: Wed, 31 Jan 2018 19:07:49 -0600
Message-ID: <20180131190749.Horde.bsc7GhewsZwdnkmDtMlSwWO@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Wong Hoi Sing, Edison" <hswong3i@gmail.com>,
        "Hung Hing Lun, Mike" <hlhung3i@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp_lp: use 64-bit arithmetic instead of 32-bit
References: <20180201002407.GA1608@embeddedgus>
 <20180201003236.06143fd0@alans-desktop>
In-Reply-To: <20180201003236.06143fd0@alans-desktop>
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
X-Exim-ID: 1eh3Lx-001cqO-7p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:41994
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

Quoting Alan Cox <gnomes@lxorguk.ukuu.org.uk>:

> On Wed, 31 Jan 2018 18:24:07 -0600
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>
>> Cast to s64 some variables and a macro in order to give the
>> compiler complete information about the proper arithmetic to
>> use. Notice that these elements are used in contexts that
>> expect expressions of type s64 (64 bits, signed).
>>
>> Currently such expression are being evaluated using 32-bit
>> arithmetic.
>
> The question you need to ask is 'can it overflow 32bit maths', otherwise
> you are potentially making the system do extra work for no reason.
>

Yeah, I get your point and it seems that in this particular case there  
is no risk of a 32bit overflow, but in general and IMHO as the code  
evolves, the use of incorrect arithmetic may have security  
implications in the future, so I advocate for code correctness in this  
case.

Thanks
--
Gustavo
