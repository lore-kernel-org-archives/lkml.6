Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeERIyl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:54:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42136 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeERIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:52:39 -0400
X-Google-Smtp-Source: AB8JxZqOJb6/XqiMEKzk6I9EleBwBIhsmzM/ZuI7oWD3QI2rIZtBkVmbftFhHyu0LB8FRaWnzP7PgmoG5CFFXZq7K78=
MIME-Version: 1.0
In-Reply-To: <20180514200335.GA2050@avx2>
References: <20180226212145.GB742@avx2> <CA+G9fYt0ymKKtk7mOgHyHiQHONMWK00Lo14FoRtd8tQM57ymsw@mail.gmail.com>
 <20180514200335.GA2050@avx2>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 18 May 2018 14:22:37 +0530
Message-ID: <CA+G9fYv3rqfZBMK=Sbr1b3QxkW51917wU1esGuXtPN-irNq01w@mail.gmail.com>
Subject: Re: [PATCH 2/2] proc: test /proc/self/syscall
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2018 at 01:33, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Tue, May 15, 2018 at 12:34:18AM +0530, Naresh Kamboju wrote:
>> Hi Alexey,
>>
>> On 27 February 2018 at 02:51, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>> > Read from /proc/self/syscall should yield read system call and correct
>> > args in the output as current is reading /proc/self/syscall.
>>
>> Is this test expected to work on arm32 bit architecture ?
>> I have tested on arm32 devices and it returns 1 and reported as FAIL.
>>
>> Strace output:
>> <snip>
>> munmap(0xb6f4a000, 13514)               = 0
>> open("/proc/self/syscall", O_RDONLY)    = 3
>> read(3, "3 0x3 0xbeacfbe0 0x40 0x3 0xbeac"..., 64) = 64
>
> Yes! Obviously, it was tested on x86_64 only.
>
> arch/arm/tools/syscall.tbl shows read is #3
> and pointer looks 32-bit, so what's wrong?

Please ignore the strace output because test return 0 for strace process.

Here is the modified test case with more prints, which shows test case failed
due to third condition is true.
strncmp() return 3.
Is strncmp() implementation different on 32 and 64 bit architecture in glibc ?

Test case and output:
https://pastebin.com/grL2TUzs

- Naresh
