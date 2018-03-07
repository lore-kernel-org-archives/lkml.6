Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbeCGOJb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:09:31 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33764 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754418AbeCGOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:09:29 -0500
X-Google-Smtp-Source: AG47ELs1NmIF5gswE6ABP49ESizZWBpwtsJJSgcWAPkjr7nt/usVaimXXFms66iuK9cdqIbkYiPp3EZzYnaKg0hh/fU=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 15:09:27 +0100
X-Google-Sender-Auth: o5qU1Ak8-DMWtHl_QFYyGVtOITk
Message-ID: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
Subject: CRIS port status, was: [PATCH] dump_stack: convert generic dump_stack
 into a weak symbol
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <jesper@jni.nu>, Mikael Starvik <starvik@axis.com>,
        linux-cris-kernel@axis.com, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 2:40 PM, Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
> On (03/07/18 13:48), Arnd Bergmann wrote:
> [..]
>> >
>> > I can easily stop building blackfin - and, if the intention is to
>> > remove it, there is not much point in wasting resources building it any
>> > anyway.
>>
>> Right. At the moment, the plan is to remove metag, score, unicore32,
>> m32r, frv and blackfin. If you are building any more of those, you can
>> stop that as well.
>>
>> The fate of tile and mn10300 is still open, but I suspect they won't
>> last long either.
>
> That's a huge list.
>
> I heard that CRIS is having some problems as well:
> https://lkml.org/lkml/2018/1/11/403

Interesting. I thought I looked at cris when I made the list and found that
it was still (semi-)regularly updated, so I assumed it was still needed.

(adding CRIS and microblaze maintainers)

Jesper/Mikael: If you are considering to drop the port, I think it
would make sense to do it at the same time as the others, so feel
free to send me a removal pull request for 4.17 that I'll merge with
the other removal patches, or I can offer to remove it myself.

Obviously if your plans have changed in the meantime and you
prefer to keep it for a while longer, just let me know and I'll document
the state in the tag description for the arch removal for future reference.

If we remove cris, it's probably also appropriate to ask the question
about microblaze: Michal, I know your work on microblaze linux has
been winding down over the years as the user base shrinks (just
like for all others above). Should we keep it for a few more years for
the remaining users, or is it time to let go? I would guess we still
have active users on modern kernels, but that's what I thought
about cris as well ;-)

      Arnd
