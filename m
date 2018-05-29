Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966525AbeE2TvD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:51:03 -0400
Received: from www62.your-server.de ([213.133.104.62]:41881 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966455AbeE2Tu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:50:58 -0400
Subject: Re: [PATCH bpf-next] bpf: hide the unused 'off' variable
To: Song Liu <liu.song.a23@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, YueHaibing <yuehaibing@huawei.com>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180529024018.12740-1-yuehaibing@huawei.com>
 <CAK8P3a0jnU69RQ8jLF82GofE=fgENMVoWkObYvro82f+q=p_XA@mail.gmail.com>
 <4a060ed5-f147-6778-caa2-7866b1f04479@gmail.com>
 <CAPhsuW7tkQVY0rVRt2=cAHf_fif7W_73Ns7_mnt3CriMbGEhrg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2b40c9d1-d8c7-ae0a-7339-aac2a20ba1b2@iogearbox.net>
Date: Tue, 29 May 2018 21:50:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7tkQVY0rVRt2=cAHf_fif7W_73Ns7_mnt3CriMbGEhrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 08:18 PM, Song Liu wrote:
> On Tue, May 29, 2018 at 8:53 AM, John Fastabend
> <john.fastabend@gmail.com> wrote:
>> On 05/29/2018 03:35 AM, Arnd Bergmann wrote:
>>> On Tue, May 29, 2018 at 4:40 AM, YueHaibing <yuehaibing@huawei.com> wrote:
>>>> The local variable is only used while CONFIG_IPV6 enabled
>>>>
>>>> net/core/filter.c: In function ‘sk_msg_convert_ctx_access’:
>>>> net/core/filter.c:6489:6: warning: unused variable ‘off’ [-Wunused-variable]
>>>>   int off;
>>>>       ^
>>>> This puts it into #ifdef.
>>>>
>>>> Fixes: 303def35f64e ("bpf: allow sk_msg programs to read sock fields")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>
>>> I was about to send the same patch and found you had already sent one.
>>>
>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Thanks! I'm curious why kbuild bot didn't catch this. Will
>> try to dig into that in a bit.
>>
>> Acked-by: John Fastabend <john.fastabend@gmail.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>

Applied to bpf-next, thanks Yue!
