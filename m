Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755252AbeBBCjD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 21:39:03 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.113]:11103 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754124AbeBBCiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 21:38:52 -0500
Date: Thu, 01 Feb 2018 20:38:51 -0600
Message-ID: <20180201203851.Horde.ldq0eUL3uh14qcIIJ75epb2@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: David Miller <davem@davemloft.net>
Cc: gustavo@embeddedor.com, hswong3i@gmail.com, hlhung3i@gmail.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp_lp: use 64-bit arithmetic instead of 32-bit
References: <20180201002407.GA1608@embeddedgus>
 <20180201.094531.310132736141169083.davem@davemloft.net>
In-Reply-To: <20180201.094531.310132736141169083.davem@davemloft.net>
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
X-Exim-ID: 1ehRFb-000ym8-8A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:57693
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Quoting David Miller <davem@davemloft.net>:

> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Date: Wed, 31 Jan 2018 18:24:07 -0600
>
>> Cast to s64 some variables and a macro in order to give the
>> compiler complete information about the proper arithmetic to
>> use. Notice that these elements are used in contexts that
>> expect expressions of type s64 (64 bits, signed).
>>
>> Currently such expression are being evaluated using 32-bit
>> arithmetic.
>>
>> Addresses-Coverity-ID: 200687
>> Addresses-Coverity-ID: 200688
>> Addresses-Coverity-ID: 200689
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Sorry, I'm not applying this, the domain of the input values
> means that the calculation cannot overflow.

Yep, that's fine.

Thanks for the feedback.
--
Gustavo
