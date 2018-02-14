Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030541AbeBNNz7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:55:59 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35440 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030500AbeBNNzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:55:55 -0500
X-Google-Smtp-Source: AH8x224QliZNjCs+vpuZuqwfqC6y/yxMU2yPHHP6w2MFPuMhg3qvvCpyoktP21bqPi+BI20zjjfrKrjULcMBpwym7bg=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802141306360.1292@nanos.tec.linutronix.de>
References: <CABbc0=RMYWGN0L=z_Y=FuZJUDzD5NVa2XBTVnmpZxX5tnk3-5g@mail.gmail.com>
 <alpine.DEB.2.21.1802141306360.1292@nanos.tec.linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2018 15:55:54 +0200
Message-ID: <CAHp75VdwOAMnzSnhRCjNALn=n7BDiePoGBCsNojcz4QMzT3+UA@mail.gmail.com>
Subject: Re: linux acpi (thunderbolt? bug)
To: Thomas Gleixner <tglx@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yuriy Vostrikov <delamonpansie@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Mika -- the Thunderbolt guy.

On Wed, Feb 14, 2018 at 2:09 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 14 Feb 2018, Yuriy Vostrikov wrote:
>> after boot
>> name:   VECTOR
>>  size:   0
>>  mapped: 64
>>  flags:  0x00000041
>> Online bitmaps:        2
>> Global available:    368
>> Global reserved:      26
>> Total allocated:      38
>> System: 41: 0-19,32,50,128,238-255
>>  | CPU | avl | man | act | vectors
>>      0   184     1    19  33-49,51-52
>>      1   184     1    19  33-49,51-52
>>
>> after unplug
>> name:   VECTOR
>>  size:   0
>>  mapped: 55
>>  flags:  0x00000041
>> Online bitmaps:        2
>> Global available:    377
>> Global reserved:      26
>> Total allocated:      29
>> System: 41: 0-19,32,50,128,238-255
>>  | CPU | avl | man | act | vectors
>>      0   188     1    15  33-46,48
>>      1   189     1    14  33-46
>>
>> after sleep 1 time
>> name:   VECTOR
>>  size:   0
>>  mapped: 35
>>  flags:  0x00000041
>> Online bitmaps:        2
>> Global available:    385
>> Global reserved:      12
>> Total allocated:      32
>> System: 41: 0-19,32,50,128,238-255
>>  | CPU | avl | man | act | vectors
>>      0   185     1    18  33-43,46-49,51-53
>>      1   200     1     3  33-37
>
> The accounting is already screwed. CPU1 claims to have 3 allocated vectors,
> but the allocation bitmap has 5 bits set !?!
>
> I have no idea yet how that can happen. Lemme stare into the code some more
> and I came back to you.
>
> Thanks,
>
>         tglx



-- 
With Best Regards,
Andy Shevchenko
