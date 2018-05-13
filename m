Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeEMUdh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 16:33:37 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:45861 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeEMUdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 16:33:36 -0400
X-Google-Smtp-Source: AB8JxZq6qu83JAi0KHzk0O/eRG+E98Yul7GNAn2zhC8dnc3X9Da2ZS9Ci565BKAwRWQalxf3Z8XF2IzjJ30IAjIJmkI=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805132007200.1582@nanos.tec.linutronix.de>
References: <20180503102810.59657-1-andriy.shevchenko@linux.intel.com> <alpine.DEB.2.21.1805132007200.1582@nanos.tec.linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 23:33:35 +0300
Message-ID: <CAHp75Vc7uFDbHcf+mbaBxu2adiDD9CY7Z-fhn5E_3dZDZiTYoA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/io: Define readq()/writeq() to use 64-bit type
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 9:09 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 3 May 2018, Andy Shevchenko wrote:
>>  #ifdef CONFIG_X86_64
>>
>> -build_mmio_read(readq, "q", unsigned long, "=r", :"memory")
>> -build_mmio_read(__readq, "q", unsigned long, "=r", )
>> -build_mmio_write(writeq, "q", unsigned long, "r", :"memory")
>> -build_mmio_write(__writeq, "q", unsigned long, "r", )
>> +build_mmio_read(readq, "q", unsigned long long, "=r", :"memory")
>> +build_mmio_read(__readq, "q", unsigned long long, "=r", )
>> +build_mmio_write(writeq, "q", unsigned long long, "r", :"memory")
>> +build_mmio_write(__writeq, "q", unsigned long long, "r", )
>
> What's wrong with u64 which we use for expressing io access to a 64bit wide
> resource?

Same answer as per v1, i.e. I would like to be consistent with other
types in this file (unsigned int for readl() and similar for the
rest).
If we would need them, we might change at once for all accessors.

-- 
With Best Regards,
Andy Shevchenko
