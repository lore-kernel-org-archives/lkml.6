Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeCIW6q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:58:46 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41256 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbeCIW6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:58:44 -0500
X-Google-Smtp-Source: AG47ELtaL3rGa2y28fZcMgwDarLN7iJcB876c2H7uF/Lvqj/ATkBfxh4kwpaFOHetcS/QbJSDWYLUg==
Subject: Re: WARNING in __proc_create
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com>
Cc: coreteam@netfilter.org, David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzkaller-bugs@googlegroups.com
References: <001a113f2be668a1e9056701e617@google.com>
 <CAM_iQpV+PnGUXEKcSrF7u19NOeLLp0PhDW-DOkEfS+8pLnTgYw@mail.gmail.com>
 <a559bbb6-0db4-2b71-b363-792d88d7eef7@gmail.com>
Message-ID: <c4b2dca8-f2b9-c187-9ee5-e7c4816848f5@gmail.com>
Date: Fri, 9 Mar 2018 14:58:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a559bbb6-0db4-2b71-b363-792d88d7eef7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2018 02:56 PM, Eric Dumazet wrote:

> 
> I sent a patch a while back, but Pablo/Florian wanted more than that 
> simple fix.
> 
> We also need to filter special characters like '/'
> 
> Or maybe I am mixing with something else.

Yes, Florian mentioned that we also had to reject "."  and ".."
