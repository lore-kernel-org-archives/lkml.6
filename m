Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeCNDDC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:03:02 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43792 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeCNDC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:02:59 -0400
X-Google-Smtp-Source: AG47ELsg9hJL/KGwLva+B37NtVbMO4cK26HJvy91x1W7+2qztkTXFIqlgeMKuZeaGBzeheBHKOsZj/Wz6rPlQtDUPlU=
MIME-Version: 1.0
In-Reply-To: <20180313.202552.1990425972566331246.davem@davemloft.net>
References: <20180313205856.3309750-1-arnd@arndb.de> <20180313.202552.1990425972566331246.davem@davemloft.net>
From: Wang Jian <jianjian.wang1@gmail.com>
Date: Wed, 14 Mar 2018 11:02:57 +0800
Message-ID: <CAP4sYWURRroc0H7vDcMdmi2cyuKxHfcj12X0zqWjw1vcoru06A@mail.gmail.com>
Subject: Re: [PATCH] pktgen: use dynamic allocation for debug print buffer
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, gustavo@embeddedor.com, dima@arista.com,
        johannes.berg@intel.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +  kfree(buf);
free tb? buf is an array.

On Wed, Mar 14, 2018 at 8:25 AM, David Miller <davem@davemloft.net> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 13 Mar 2018 21:58:39 +0100
>
>> After the removal of the VLA, we get a harmless warning about a large
>> stack frame:
>>
>> net/core/pktgen.c: In function 'pktgen_if_write':
>> net/core/pktgen.c:1710:1: error: the frame size of 1076 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>>
>> The function was previously shown to be safe despite hitting
>> the 1024 bye warning level. To get rid of the annoyging warning,
>> while keeping it readable, this changes it to use strndup_user().
>>
>> Obviously this is not a fast path, so the kmalloc() overhead
>> can be disregarded.
>>
>> Fixes: 35951393bbff ("pktgen: Remove VLA usage")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Applied, thanks.
