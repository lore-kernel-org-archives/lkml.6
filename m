Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeDFHQG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:16:06 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38649 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeDFHQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:16:04 -0400
X-Google-Smtp-Source: AIpwx4+OfVxMgjBmdNRTy8/9HFLHRi/u7Vhy/kRqDrxHgDG0GejvB+HDKNjDiELZ9nc2eVvOkLHYFyLAK9sWNwjb1Co=
MIME-Version: 1.0
In-Reply-To: <CAJWu+ooTV+VYib6aDXc9V2As6Nzz5DddBttaxYxyMJd0ZrcwDA@mail.gmail.com>
References: <20180404115310.6c69e7b9@gandalf.local.home> <20180404120002.6561a5bc@gandalf.local.home>
 <CAJWu+orC-1JDYHDTQU+DFckGq5ZnXBCCq9wLG-gNK0Nc4-vo7w@mail.gmail.com>
 <20180404121326.6eca4fa3@gandalf.local.home> <CAJWu+op5-sr=2xWDYcd7FDBeMtrM9Zm96BgGzb4Q31UGBiU3ew@mail.gmail.com>
 <CAJWu+opM6RjK-Z1dr35XvQ5cLKaV=cLG5uMu-rLkoO=X03c+FA@mail.gmail.com>
 <20180405094346.104cf288@gandalf.local.home> <CAJWu+oqT0oPrEL4mPnWvF3Zt-psg2DWGj9Nrr+fda2JYFzRmqg@mail.gmail.com>
 <CAJWu+ooTV+VYib6aDXc9V2As6Nzz5DddBttaxYxyMJd0ZrcwDA@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 6 Apr 2018 15:16:03 +0800
Message-ID: <CAGWkznGDGPmOZpNgNCZrQrwn9+5=_dKz+_tPyC9i-aYq0xwf2g@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Add set/clear_current_oom_origin() during allocations
To: Joel Fernandes <joelaf@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 7:36 AM, Joel Fernandes <joelaf@google.com> wrote:
> Hi Steve,
>
> On Thu, Apr 5, 2018 at 12:57 PM, Joel Fernandes <joelaf@google.com> wrote:
>> On Thu, Apr 5, 2018 at 6:43 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>>> On Wed, 4 Apr 2018 16:59:18 -0700
>>> Joel Fernandes <joelaf@google.com> wrote:
>>>
>>>> Happy to try anything else, BTW when the si_mem_available check
>>>> enabled, this doesn't happen and the buffer_size_kb write fails
>>>> normally without hurting anything else.
>>>
>>> Can you remove the RETRY_MAYFAIL and see if you can try again? It may
>>> be that we just remove that, and if si_mem_available() is wrong, it
>>> will kill the process :-/ My original code would only add MAYFAIL if it
>>> was a kernel thread (which is why I created the mflags variable).
>>
>> Tried this. Dropping RETRY_MAYFAIL and the si_mem_available check
>> destabilized the system and brought it down (along with OOM killing
>> the victim).
>>
>> System hung for several seconds and then both the memory hog and bash
>> got killed.
>
> I think its still Ok to keep the OOM patch as a safe guard even though
> its hard to test, and the si_mem_available on its own seem sufficient.
> What do you think?
>
> thanks,
>
>
> - Joel
I also test the patch on my system, which works fine for the previous script.

PS: The script I mentioned is the cts test case POC 16_12 on android8.1
