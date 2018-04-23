Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeDWQJn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:09:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36216 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbeDWQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:09:37 -0400
X-Google-Smtp-Source: AIpwx4+lSeWKt+/fJvePPKayAMmloOzo2iuvaSva7wwdkj6VpI/iVwIJPvKw+l69PJ/EqBQl3uiG8g==
Subject: Re: [PATCH net-next] net: init sk_cookie for inet socket
To: David Miller <davem@davemloft.net>, laoar.shao@gmail.com
Cc: eric.dumazet@gmail.com, alexei.starovoitov@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1524405004-10960-1-git-send-email-laoar.shao@gmail.com>
 <20180423.115821.640630949143585629.davem@davemloft.net>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <788ce3f1-6534-5c2e-1870-5ebd8ea4ae7f@gmail.com>
Date: Mon, 23 Apr 2018 09:09:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180423.115821.640630949143585629.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/23/2018 08:58 AM, David Miller wrote:
> From: Yafang Shao <laoar.shao@gmail.com>
> Date: Sun, 22 Apr 2018 21:50:04 +0800
> 
>> With sk_cookie we can identify a socket, that is very helpful for
>> traceing and statistic, i.e. tcp tracepiont and ebpf.
>> So we'd better init it by default for inet socket.
>> When using it, we just need call atomic64_read(&sk->sk_cookie).
>>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> 
> Applied, thank you.
> 

This is adding yet another atomic_inc on a global cache line.

Most applications do not need the cookie being ever set.

The existing mechanism was fine. Set it on demand.
