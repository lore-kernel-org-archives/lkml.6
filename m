Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeEOFqo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:46:44 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:40217 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeEOFqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:46:42 -0400
X-Google-Smtp-Source: AB8JxZpOkq1rDX1eEPmJeTi0VnmPMdJ1hbpx8JEAlHzmN3xJcaHfSgbkV8qe+RqIE9M9CmSlpuZqdg==
Subject: Re: [PATCH v3 4/6] ALSA: xen-front: Implement handling of shared
 buffers
To: Takashi Iwai <tiwai@suse.de>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20180514062742.25879-1-andr2000@gmail.com>
 <20180514062742.25879-5-andr2000@gmail.com> <s5ho9hi56ds.wl-tiwai@suse.de>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <e37b5170-4fab-0c06-8902-730e57118ceb@gmail.com>
Date: Tue, 15 May 2018 08:46:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5ho9hi56ds.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/2018 11:28 PM, Takashi Iwai wrote:
> On Mon, 14 May 2018 08:27:40 +0200,
> Oleksandr Andrushchenko wrote:
>> --- /dev/null
>> +++ b/sound/xen/xen_snd_front_shbuf.c
>> @@ -0,0 +1,193 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +
>> +/*
>> + * Xen para-virtual sound device
>> + *
>> + * Copyright (C) 2016-2018 EPAM Systems Inc.
>> + *
>> + * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> + */
>> +
>> +#include <xen/xen.h>
>> +#include <xen/xenbus.h>
>> +
>> +#include "xen_snd_front_shbuf.h"
> Hm, with the local build test, I get the following error:
>
>    CC [M]  sound/xen/xen_snd_front_shbuf.o
>    In file included from sound/xen/xen_snd_front_shbuf.c:11:0:
>    ./include/xen/xen.h:18:8: error: unknown type name ‘bool’
>     extern bool xen_pvh;
>             ^~~~
>     In file included from ./include/xen/interface/xen.h:30:0,
>                      from ./include/xen/xen.h:29,
>                      from sound/xen/xen_snd_front_shbuf.c:11:
>    ./arch/x86/include/asm/xen/interface.h:92:21: error: unknown type name ‘uint64_t’
>     DEFINE_GUEST_HANDLE(uint64_t);
>                         ^
> 			
> Adding #include <linux/kernel.h> fixed the issue.
>
> Did you really test your patches with the latest Linus tree?
My bad, it does build for ARM (which is my target), but also does
need "#include <linux/kernel.h>" for x86 which I didn't build this time.
Sorry about that.

Do you want me to resend this single patch or you can make the change
while applying?
>
>
> thanks,
>
> Takashi
Thank you,
Oleksandr
