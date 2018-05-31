Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755918AbeEaSPt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:15:49 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45539 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755824AbeEaSPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:15:44 -0400
X-Google-Smtp-Source: ADUXVKK47KiJJ5xPRK70L4ZtnQKw5IgfNaPNSdpdyXm8gkVytYn+ni3oeTcTfuFLAVpuCg36mnWEcUWaBa7g6PXZgrM=
MIME-Version: 1.0
In-Reply-To: <ea92b4fb-a1c9-a961-b67e-7834e351d6e1@infradead.org>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
 <CAHp75VdFZcNMMt6aRWicCozMJ+wfAyJ4ajegHCgNg2X-x_KN_A@mail.gmail.com> <ea92b4fb-a1c9-a961-b67e-7834e351d6e1@infradead.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 21:15:43 +0300
Message-ID: <CAHp75VfcyyFeBnEdDbARk2VdxRT55qWdBJu_XWK5gGRHm5LTGg@mail.gmail.com>
Subject: Re: [RFC 1/2] printk: Enable platform to provide a early boot clock
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alek.du@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 8:22 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 05/31/2018 12:18 AM, Andy Shevchenko wrote:
>> On Wed, May 30, 2018 at 12:20 PM, Feng Tang <feng.tang@intel.com> wrote:

>>> +static u64 printk_clock(void)
>>> +{
>>> +       /* If platform provides early boot printk clock, then use it */
>>> +       if (unlikely(system_state == SYSTEM_BOOTING && boot_printk_clock_fn))
>>> +               return boot_printk_clock_fn();
>>> +       else
>>> +               return local_clock();
>>
>> 'else' is redundant.
>
> So it is.  Is this a style comment?
> This shouldn't matter to a smart compiler, should it?

In this particular case it doesn't matter, in more complex cases this
will increase an indentation level which becomes a hardly readable
code.

>>> +}

-- 
With Best Regards,
Andy Shevchenko
