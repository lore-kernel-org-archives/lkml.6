Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755558AbeEaPzH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:55:07 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33568 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755456AbeEaPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:55:05 -0400
X-Google-Smtp-Source: ADUXVKKDYipoLQOwHigtQQNTjFzqxFJZ+EBVxGC7+r84yu9h0AMZGUx1smj1eOqC6sFEsDlaaKw3nc622vlQqZT1PbI=
MIME-Version: 1.0
In-Reply-To: <000001d3f8b2$07fc2ab0$17f48010$@toshiba.co.jp>
References: <20180528100202.045206534@linuxfoundation.org> <20180528100203.357731085@linuxfoundation.org>
 <005601d3f888$37f266f0$a7d734d0$@toshiba.co.jp> <20180531063408.GA7744@kroah.com>
 <000001d3f8b2$07fc2ab0$17f48010$@toshiba.co.jp>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 May 2018 21:25:03 +0530
Message-ID: <CA+G9fYte-o6ALhcyd_uBs+B=Q5biogk6wFZUH8pjkCoS+zWWhA@mail.gmail.com>
Subject: Re: [PATCH 4.4 011/268] Revert "ipc/shm: Fix shmat mmap nil-page protection"
To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 May 2018 at 13:06, Daniel Sangorrin
<daniel.sangorrin@toshiba.co.jp> wrote:
>> -----Original Message-----
>> From: 'Greg Kroah-Hartman' [mailto:gregkh@linuxfoundation.org]
> ..
>> Thanks for letting us know, but this was reported already.  See the
>> emails on lkml with the subject:
>>       Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
>> from Davidlohr Bueso
>>       Message-ID: <20180528213039.yy2madue67njkmw5@linux-n805>
>>
>> where he discusses that the LTP test is incorrect and that the kernel
>> change is correct and that LTP is going to be fixed because of this.

My two cents,
If you are referring to cve-2017-5669.c
LTP test case is been fixed few hours ago by Rafael Tinoco,

- shm_addr = shmat(shm_id, ((void *)1), SHM_RND);
+ shm_addr = shmat(shm_id, ((void *)1), SHM_RND | SHM_REMAP);

LTP patch pull request and it is been merged.
https://github.com/linux-test-project/ltp/pull/324

>
> OK, thank you for the information!
>

- Naresh

> Regards,
> Daniel
>
>
