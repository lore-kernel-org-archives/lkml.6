Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934026AbeE2MO6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:14:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35095 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933677AbeE2MOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:14:48 -0400
X-Google-Smtp-Source: ADUXVKJUBfqFz9wiUueXgc+zvYqvim5DF7EDqeaOUCGj97wrwyJVWfK7z1s1WZCg2qO0l0Q7dwpZAeOZ4likYqqgUbc=
MIME-Version: 1.0
In-Reply-To: <CA+7wUswm60dZAfnTYJ-2p3o1H1ubwn1_OH7GSu9Y_PRKKCHJog@mail.gmail.com>
References: <20180529210257.26da8de7@canb.auug.org.au> <CA+7wUsw4Us749j8yO5zpqfMcYWPMujwkNq0CRSSWWVFDJXLS0w@mail.gmail.com>
 <CA+7wUswm60dZAfnTYJ-2p3o1H1ubwn1_OH7GSu9Y_PRKKCHJog@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 29 May 2018 14:14:27 +0200
X-Google-Sender-Auth: VsOd2lER5jYtr1Syk_m2cL0WJG4
Message-ID: <CA+7wUsy8=hbyN4NQ3x-Sp-YT1uPFRcYLNpJncuoMMy==Qd7PeQ@mail.gmail.com>
Subject: Re: linux-next: boot messages from today's linux-next
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,


On Tue, May 29, 2018 at 2:00 PM, Mathieu Malaterre <malat@debian.org> wrote:
> On Tue, May 29, 2018 at 1:56 PM, Mathieu Malaterre <malat@debian.org> wrote:
>> On Tue, May 29, 2018 at 1:02 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> Hi all,
>>>
>>> My qemu boots of today's powerpc linux-next kernel produced the following
>>> boot message differences:
>>>
>>> -Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
>>> +Max number of cores passed to firmware: u (NR_CPUS = 2048)
>>>
>>> Seemingly caused by commit
>>>
>>>   eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")
>>
>> My bad. Patch is pending (thanks Michael!):
>>
>> https://patchwork.ozlabs.org/patch/921948/
>
> Nope, nevermind this is unrelated.

Could you update your patch "powerpc/prom: Fix %llx usage since
prom_printf() change" to also do "powerpc/prom: Fix %u usage since
prom_printf() change"

I did not pay attention that "%u" was also not supported in prom_printf.

I may be able to provide a patch tonight, if this is not acceptable,
please revert my faulty patch. Sorry for the mess.


>>> --
>>> Cheers,
>>> Stephen Rothwell
