Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754477AbeCGMsO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:48:14 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37700 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754449AbeCGMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:48:10 -0500
X-Google-Smtp-Source: AG47ELuVXW2qOsi4VMR6eAModBj9iaDjP4DpoAS/zlc/I7nOcmev32hPAzzhsNjfY9gtIL6uvZF8hhG8l9dUWNaVOAk=
MIME-Version: 1.0
In-Reply-To: <20180307234142.1c7d2710@canb.auug.org.au>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
 <20180307022127.GB802@jagdpanzerIV> <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
 <20180307104002.GA505@jagdpanzerIV> <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
 <20180307114845.GA894@jagdpanzerIV> <20180307234142.1c7d2710@canb.auug.org.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 13:48:09 +0100
X-Google-Sender-Auth: OPwGv8BmwYmkaUka-SDkNbtFIrM
Message-ID: <CAK8P3a2sA0BmR4cS4Af+d42MabzkZZEBvMaTpoWwOu-N7pP=dg@mail.gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 1:41 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Sergey,
>
> On Wed, 7 Mar 2018 20:48:56 +0900 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>
>> On (03/07/18 11:57), Arnd Bergmann wrote:
>> [..]
>> > >> Originally I planned to wait a few more releases, but the last maintainer
>> > >> has commented that he will now send a patch for immediate removal,
>> > >> so 4.17 is almost certain at this point.
>> > >
>> > > Would be great to get it removed as soon as possible then. Otherwise we
>> > > will get broken blackfin build errors from Stephen (or would need to hold
>> > > off Dave's patch).
>> >
>> > You could also add a patch to your tree that removes the blackfin
>> > dump_stack() function, or we could ask Stephen and the other
>> > people operating build bots to stop building blackfin right now
>> > (they will have to do that anyway once the arch gets removed).
>>
>> OK. Petr, Stephen, what would be your preference?
>
> I can easily stop building blackfin - and, if the intention is to
> remove it, there is not much point in wasting resources building it any
> anyway.

Right. At the moment, the plan is to remove metag, score, unicore32,
m32r, frv and blackfin. If you are building any more of those, you can
stop that as well.

The fate of tile and mn10300 is still open, but I suspect they won't
last long either.

      Arnd
