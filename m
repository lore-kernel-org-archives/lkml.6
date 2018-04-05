Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeDESwe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 14:52:34 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36801 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbeDESwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 14:52:32 -0400
X-Google-Smtp-Source: AIpwx4/KVvmFmTs9xDt0c5EBKR3loZHt324ZzszbMRvF5AQjqPZbyDIpVb6R66RDszS6rr4MisUGm83gAOLEtLE5V9M=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL8oLV2xvjBVYv_SNXr74LdgpXEmU7K+cLYpD7jh2chgw@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5jLwyot++C2EXs+032Lz5WdG65GsEJ-Q55rfhSbkG1Nh+A@mail.gmail.com>
 <3265889.eu5sbW8aRz@natalenko.name> <CAGXu5jL++CEmLzFtGMVMhGWBzHpsRNJPTsEoc7Pw1dP--=azCA@mail.gmail.com>
 <7fc01f67a561ce1fad676fc34c2249e7@natalenko.name> <CAGXu5jKhiE512yQXp90M+Wie=8RkpMZT-Yi_9BgjfKwibP433g@mail.gmail.com>
 <dee9721a530576e667881d86bbec351b@natalenko.name> <08e06234c81fac30ccff5a2695d02f2a@natalenko.name>
 <CAGXu5jL8oLV2xvjBVYv_SNXr74LdgpXEmU7K+cLYpD7jh2chgw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Apr 2018 11:52:31 -0700
X-Google-Sender-Auth: Fht20ijcbvXhXmSRgG_rwMBzqBE
Message-ID: <CAGXu5j+mVc6O_=GOF3YQmS4QZxeFgVPQtMxNH8sjBAhpJLjm9w@mail.gmail.com>
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[forcing non-HTML and resending...]

On Thu, Apr 5, 2018 at 7:33 AM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> 05.04.2018 16:32, Oleksandr Natalenko wrote:
>>
>> "-hda sda.img -hdb sda.img"
>
>
> "-hda sda.img -hdb sdb.img", of course, I don't pass the same disk twice

Okay. My qemu gets mad about that and wants the format=raw argument,
so I'm using:

-drive file=sda.img,format=raw \
-drive file=sdb.img,format=raw \

How are you running your smartctl? I'm doing this now:

[1]   Running                 while :; do
    ( smartctl -a /dev/sda; smartctl -a /dev/sdb ) > /dev/null;
done &

I assume I'm missing something from your .config, but since I don't
boot with an initramfs, I had to tweak it a bit. I'll try again...

-Kees

-- 
Kees Cook
Pixel Security
