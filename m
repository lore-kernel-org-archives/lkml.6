Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeFDKGs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:06:48 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43581 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeFDKGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:06:47 -0400
X-Google-Smtp-Source: ADUXVKIMw7nN/FihhdOj6AHxC0uyFlHlcjdrGkHKX/MK7Bx7+22Fo1jcpdx54M4IYEirUTS4kXTg9Adjx7YGHr7OW74=
MIME-Version: 1.0
In-Reply-To: <6fefc785-b6b7-e24f-2559-76ce70544717@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VeM8+pWEx=XNOGAb=Fdh+rh3WOn2i4m7ObhcVdcXKVa3A@mail.gmail.com> <6fefc785-b6b7-e24f-2559-76ce70544717@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Jun 2018 13:06:45 +0300
Message-ID: <CAHp75Vc-BDtz62zS2_Chi=UgZJw7vvUzJ34CEHd-RCjqnOjBew@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] sparc64: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 4:06 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> Hi Andy,
>
> On 2018/6/1 19:34, Andy Shevchenko wrote:
>> On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>>> match_string() returns the index of an array for a matching string,
>>> which can be used instead of open coded variant.
>>
>>> @@ -512,10 +512,9 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
>>>                                 break;
>>>                         }
>>>                 }
>>
>> It seems previous loop also can be replaced.
>
> No, because the there is an NULL in the middle of the array hwcaps:
>  static const char *hwcaps[] = {
>           "flush", "stbar", "swap", "muldiv", "v9",
>           "ultra3", "blkinit", "n2",
>
>           /* These strings are as they appear in the machine description
>            * 'hwcap-list' property for cpu nodes.
>            */
>           "mul32", "div32", "fsmuld", "v8plus", "popc", "vis", "vis2",
>           "ASIBlkInit", "fmaf", "vis3", "hpc", "random", "trans", "fjfmau",
>           "ima", "cspare", "pause", "cbcond", NULL /*reserved for crypto */,
>           "adp",
>   };

Actually you can.
What you need is to add string literal instead of NULL and make an
additional condition after match_string() in all users (not to many),
something like

i = match_string();
if (i < 0)
 ...
if (BIT(i) == HWCAP_SPARC_CRYPTO) // or !=
 ...

-- 
With Best Regards,
Andy Shevchenko
