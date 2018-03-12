Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeCLQqP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:46:15 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35182 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeCLQqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:46:14 -0400
X-Google-Smtp-Source: AG47ELsu52VbDHF7NA+j5mJkdZYuV0ZlaBxRfy1aWpKmgiqqGHYFd5MGa/imoOPBWXVISXU3FSeQOuD1+8vqIVbp6UY=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a06_zke6Zy77TCX6aUS1C0aK2btvnLA7APxRykkxS6S_w@mail.gmail.com>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-2-arnd@arndb.de>
 <nycvar.YSQ.7.76.1803112233070.28583@knanqh.ubzr> <CAK8P3a06_zke6Zy77TCX6aUS1C0aK2btvnLA7APxRykkxS6S_w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 12 Mar 2018 17:46:12 +0100
X-Google-Sender-Auth: NXmNsOaZ8iph4ZD4GJ6Q0Wsd4tQ
Message-ID: <CAK8P3a128iw+HB5Fp6ZOBCyuK0LypqSXqnkNPQs8sWR1pc8x3g@mail.gmail.com>
Subject: Re: [PATCH 1/7] ARM: disallow combining XIP and LTO
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 2:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Mar 12, 2018 at 3:40 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> On Tue, 20 Feb 2018, Arnd Bergmann wrote:
>
>>> Obviously we want to make the combination work, no idea why it doesn't.
>>
>> Well, it does work regardless of the noise. Here the nm output is piped
>> into sed, and the later exits early when it finds what it is looking
>> for, causing nm to complain about the broken pipe.
>>
>> Here's a patch silencing this bogus error message and fixing other minor
>> issues.
>>
>> ----- >8
>> Subject: [PATCH] ARM: deflate_xip_data.sh: minor fixes
>>
>> Send nm complaints about broken pipe (when sed exits early) to /dev/null.
>> All errors should be printed to stderr.
>> Don't trap on normal exit so the trap can return an error code.
>>
>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>
> Ah, that explains it, thanks!
>
> Tested-by: Arnd Bergmann <arnd@arndb.de>


Nevermind, I confused it with a different problem that I'm running into
with randconfig builds:

arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux':
No such file

I applied your patch, and it did not happen for a couple of randconfigs,
but that is now back. So I did not test the bug you are fixing, and the
thing that I thought you fixed is still there.

        Arnd
