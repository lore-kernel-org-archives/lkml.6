Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756268AbeDZNsA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:48:00 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:42307 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755172AbeDZNr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:47:56 -0400
X-Google-Smtp-Source: AB8JxZqPlsi1Y2CZ8BBrECN6FBkDzvX1jdy7zOa2f6kcH0mmk9G811ekuOol+5a1REFnW0SfJWBsRg==
Subject: Re: [PATCH v2 net-next 1/2] tcp: add TCP_ZEROCOPY_RECEIVE support for
 zerocopy receive
To: Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Soheil Hassas Yeganeh <soheil@google.com>
References: <20180425214307.159264-1-edumazet@google.com>
 <20180425214307.159264-2-edumazet@google.com>
 <d3ad6970-4139-76a9-2417-3df077753aa9@oracle.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <0ab0c947-0c51-10b9-054c-7cbc5a1726bd@gmail.com>
Date: Thu, 26 Apr 2018 06:47:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d3ad6970-4139-76a9-2417-3df077753aa9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/26/2018 06:40 AM, Ka-Cheong Poon wrote:

> A quick question.  Is it a normal practice to return a result
> in setsockopt() given that the optval parameter is supposed to
> be a const void *?

Very good question.

Andy suggested an ioctl() or setsockopt(), and I chose setsockopt() but it looks
like a better choice would have been getsockopt() indeed.

This might even allow future changes in "struct tcp_zerocopy_receive"

Willem suggested to add code in tcp_recvmsg() but I prefer to not bloat this already too complex function.

I will send a v3 using getsockopt() then, thanks !
