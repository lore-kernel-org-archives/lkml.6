Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932138AbeEORUO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:20:14 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35260 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbeEORUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:20:12 -0400
X-Google-Smtp-Source: AB8JxZqjDZOpqFtV0R9wWZ4lYrmom1UWvMYqM4gfRD3WGdA5CJr3GKr3N0xEervCLxclz5T2jyZEyL9QZ8UXyerTRPE=
MIME-Version: 1.0
In-Reply-To: <20180515064906.GA29231@gmail.com>
References: <CAPcyv4g5p72aiXYh8Tf03tvZq8HNYmTFU95PJGG1iQ4JHcr9PA@mail.gmail.com>
 <20180514072603.GA14099@gmail.com> <CAPcyv4j2HQH1wdsGGWUAiXEKXeoMUWN_HeUEMmkv8PG7RUTtfw@mail.gmail.com>
 <20180515064906.GA29231@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 May 2018 10:20:11 -0700
Message-ID: <CAPcyv4j6HfqeYhrXrnc-79BGBitWMovtv3-FykthChe7EFtSBQ@mail.gmail.com>
Subject: Re: use memcpy_mcsafe() for copy_to_iter() (was: Re: [PATCH v3 0/9]
 Series short description)
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:49 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
>> On Mon, May 14, 2018 at 12:26 AM, Ingo Molnar <mingo@kernel.org> wrote:
>> >
>> > * Dan Williams <dan.j.williams@intel.com> wrote:
>> >
>> >> Ingo, Thomas, Al, any concerns with this series?
>> >
>> > Yeah, so:
>> >
>> >    "[PATCH v3 0/9] Series short description"
>> >
>> > ... isn't the catchiest of titles to capture my [all too easily distracted]
>> > attention! ;-)
>>
>> My bad! After that mistake it became a toss-up between more spam and
>> hoping the distraction would not throw you off.
>>
>> > I have marked it now for -tip processing. Linus was happy with this and acked the
>> > approach, right?
>>
>> I think "happy" is a strong word when it comes to x86 machine check
>> handling. My interpretation is that he and Andy acquiesced that this
>> is about the best we can do with dax+mce as things stand today.
>
> So, how would you like to go about this series?
>
> To help move it forward I applied the first 5 commits to tip:x86/dax, on a
> vanilla v4.17-rc5 base, did some minor edits to the changelogs, tested it
> superficially (I don't have DAX so this essentially means build tests) and
> pushed out the result.

Thanks for that. Technically speaking, you do have dax, but setting up
our unit tests is currently not friction free, so I would not expect
you to go through that effort. Hopefully we can revive 0day running
our unit tests one of these days.

> Barring some later generic-x86 regression (unlikely) this looks good to me - feel
> free to cross-pull that branch into your DAX/nvdimm tree.
>
> Or we could apply the remaining changes to -tip too - your call.

The remainder patches have developed a conflict with another topic
branch in the nvdimm tree, in particular "dax: introduce a
->copy_to_iter dax operation". I think the best course is for me to
rebase the remaining 4 on top of tip/x86/dax and carry the merge
conflict through the nvdimm tree.

> Thanks,
>
>         Ingo

Thanks!
