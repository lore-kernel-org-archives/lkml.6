Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeEQIii (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:38:38 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:51916 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:38:35 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w4H8cKHT016871
X-Nifty-SrcIP: [209.85.213.47]
X-Google-Smtp-Source: AB8JxZoluVe4qxnXVa8jfg88ZPhXnDuE+fZscrFml/HB1F3kK+rxvz1qDiSZry0tJ7Sj2u6u03qJ5jzU+wZnsR6OBSI=
MIME-Version: 1.0
In-Reply-To: <fb123c1f-7680-9e75-125a-e4e66f0f9c93@redhat.com>
References: <20180329180112.11055-1-labbott@redhat.com> <CAK7LNATTfjpkG0PLR5_anZOW5zfSZxKgFO6sHXuMf50OEtx0PQ@mail.gmail.com>
 <fb123c1f-7680-9e75-125a-e4e66f0f9c93@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 17 May 2018 17:37:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR=YQswK2cgq2XUYpK-LrODGd-nSxg20b5fbsitNjD_PQ@mail.gmail.com>
Message-ID: <CAK7LNAR=YQswK2cgq2XUYpK-LrODGd-nSxg20b5fbsitNjD_PQ@mail.gmail.com>
Subject: Re: [RFCv2 PATCH 0/3] Salted build ids via linker sections
To: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-15 6:02 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> On 05/06/2018 11:28 PM, Masahiro Yamada wrote:
>>
>> 2018-03-30 3:01 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>>>
>>> Hi,
>>>
>>> This is v2 of my proposal to allow unique build-ids in the kernel. from
>>> last time:
>>>
>>> ""
>>> In Fedora, the debug information is packaged separately (foo-debuginfo)
>>> and
>>> can be installed separately. There's been a long standing issue where
>>> only one
>>> version of a debuginfo info package can be installed at a time. Mark
>>> Wielaard
>>> made an effort for Fedora 27 to allow parallel installation of debuginfo
>>> (see
>>> https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
>>> more details)
>>>
>>> Part of the requirement to allow this to work is that build ids are
>>> unique between builds. The existing upstream rpm implementation ensures
>>> this by re-calculating the build-id using the version and release as a
>>> seed. This doesn't work 100% for the kernel because of the vDSO which is
>>> its own binary and doesn't get updated. After poking holes in a few of my
>>> ideas, there was a discussion with some people from the binutils team
>>> about
>>> adding --build-id-salt to let ld do the calculation debugedit is doing.
>>> There
>>> was a counter proposal made about adding some extra information via a
>>> .comment
>>> which will affect the build id calculation but just get stripped out.
>>> ""
>>
>>
>>
>> I think you already know '--build-id=uuid' linker option.
>>
>> Doesn't this solve your problem?
>>
>> The disadvantage of this option is,
>> we will lose reproducible building because  --build-id=uuid
>> adds every time random salt.
>>
>> The advantage is, the implementation is even simpler,
>> and easier to migrate to --build-id-salt once it is supported
>> in the future.
>>
>>
>
> It could, theoretically. The reproducibility is nice though and
> I'd like to keep the kernel close to matching what other packages
> do though.

Okay.
I left some comments in v2
about improvement, and cause of
the sporadic build failures.

Will wait for v3.

-- 
Best Regards
Masahiro Yamada
