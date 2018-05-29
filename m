Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937019AbeE2PyQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:54:16 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40674 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936523AbeE2PyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:54:05 -0400
X-Google-Smtp-Source: ADUXVKKsdRSgxuL9V+7vHU2NufQbmd4U+CnPUMG7Sv4lmt+lbAGfOtF8PYjjSJfvGuv+ROzKmO7+NQ==
Subject: Re: [PATCH bpf-next] bpf: hide the unused 'off' variable
To: Arnd Bergmann <arnd@arndb.de>, YueHaibing <yuehaibing@huawei.com>
Cc: David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180529024018.12740-1-yuehaibing@huawei.com>
 <CAK8P3a0jnU69RQ8jLF82GofE=fgENMVoWkObYvro82f+q=p_XA@mail.gmail.com>
From: John Fastabend <john.fastabend@gmail.com>
Message-ID: <4a060ed5-f147-6778-caa2-7866b1f04479@gmail.com>
Date: Tue, 29 May 2018 08:53:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0jnU69RQ8jLF82GofE=fgENMVoWkObYvro82f+q=p_XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 03:35 AM, Arnd Bergmann wrote:
> On Tue, May 29, 2018 at 4:40 AM, YueHaibing <yuehaibing@huawei.com> wrote:
>> The local variable is only used while CONFIG_IPV6 enabled
>>
>> net/core/filter.c: In function ‘sk_msg_convert_ctx_access’:
>> net/core/filter.c:6489:6: warning: unused variable ‘off’ [-Wunused-variable]
>>   int off;
>>       ^
>> This puts it into #ifdef.
>>
>> Fixes: 303def35f64e ("bpf: allow sk_msg programs to read sock fields")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> I was about to send the same patch and found you had already sent one.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 

Thanks! I'm curious why kbuild bot didn't catch this. Will
try to dig into that in a bit.

Acked-by: John Fastabend <john.fastabend@gmail.com>
