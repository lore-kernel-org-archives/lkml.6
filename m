Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756050AbeDYQfQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:35:16 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:46863 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755296AbeDYQfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:35:13 -0400
X-Google-Smtp-Source: AIpwx49LveF4uqy34mDRFPGVn7ncHBgAn6e7tB+vkDwVOU1tXBrq4Ib29HdgLrzCbgRgTYiHVy51kg==
Subject: Re: [PATCH net-next 1/2] tcp: add TCP_ZEROCOPY_RECEIVE support for
 zerocopy receive
To: Andy Lutomirski <luto@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Soheil Hassas Yeganeh <soheil@google.com>
References: <20180425052722.73022-1-edumazet@google.com>
 <20180425052722.73022-2-edumazet@google.com>
 <20180425062859.GA23914@infradead.org>
 <5cd31eba-63b5-9160-0a2e-f441340df0d3@gmail.com>
 <20180425160413.GC8546@bombadil.infradead.org>
 <CALCETrWaekirEe+rKiPB-Zim6ZHKL-n7nfk9wrsHra_FtrS=DA@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <155a86d5-a910-c366-f521-216a0582bad8@gmail.com>
Date: Wed, 25 Apr 2018 09:35:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWaekirEe+rKiPB-Zim6ZHKL-n7nfk9wrsHra_FtrS=DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 09:22 AM, Andy Lutomirski wrote:

> In general, I suspect that the zerocopy receive mechanism will only
> really be a win in single-threaded applications that consume large
> amounts of receive bandwidth on a single TCP socket using lots of
> memory and don't do all that much else.

This was dully noted in the original patch submission.

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=309c446cb45f6663932c8e6d0754f4ac81d1b5cd

Our intent at Google is to use it for some specific 1MB+ receives, not as a generic and universal mechanism.

The major benefit is really the 4KB+ MTU, allowing to pack exactly 4096 bytes of payload per page.
