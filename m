Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbeEaAGu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:06:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59790 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbeEaAGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:06:46 -0400
Subject: Re: [PATCH] kbuild: add machine size to CHEKCFLAGS
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Rob Landley <rob@landley.net>
References: <20180530204838.22079-1-luc.vanoostenryck@gmail.com>
 <d47b72cc-9209-a190-38b3-969870e1bf26@suse.de>
 <CAMHZB6GXVPvr1uwbemuxqPPtNzYT7jeVokR6q9tz2mS_=TG6vA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <01db7e93-89f3-361a-29c6-5146cda1d745@infradead.org>
Date: Wed, 30 May 2018 17:06:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMHZB6GXVPvr1uwbemuxqPPtNzYT7jeVokR6q9tz2mS_=TG6vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 04:06 PM, Luc Van Oostenryck wrote:
> On Thu, May 31, 2018 at 12:00 AM, Andreas Färber <afaerber@suse.de> wrote:
>> Hi Luc,
>>
>> The typo in the subject made me curious...
>>
>> Am 30.05.2018 um 22:48 schrieb Luc Van Oostenryck:
>>> By default, sparse assumes a 64bit machine when compiled on x86-64
>>> and 32bit when compiled on anything else.
>>>
>>> This can of course create all sort of problems for the other archs, like
>>> issuing false warnings ('shift too big (32) for type unsigned long'), or
>>> worse, failing to emit legitimate warnings.
>>>
>>> Fix this by adding the -m32/-m64 flag, depending on CONFIG_64BIT,
>>> to CHECKFLAGS in the main Makefile (and so for all archs).
>>> Also, remove the now unneeded -m32/-m64 in arch specific Makefiles.
>>>
>>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>> ---
>>>  Makefile             | 3 +++
>>>  arch/alpha/Makefile  | 2 +-
>>>  arch/arm/Makefile    | 2 +-
>>>  arch/arm64/Makefile  | 2 +-
>>>  arch/ia64/Makefile   | 2 +-
>>>  arch/mips/Makefile   | 3 ---
>>>  arch/parisc/Makefile | 2 +-
>>>  arch/sparc/Makefile  | 2 +-
>>>  arch/x86/Makefile    | 2 +-
>>>  9 files changed, 10 insertions(+), 10 deletions(-)
>>
>> What about the architectures not touched by your patch that previously
>> had no -m32/-m64? (arc, c6x, h8300, hexagon, m68k, microblaze, nds32,
>> nios2, openrisc, powerpc, riscv, s390, sh, unicore32, xtensa)
> 
> As explained in the patch, by default sparse uses -m64 if compiled on x86-64
> and 32bit on everything else (well, more recent versions use -m64 if
> compiled on any 64 bit machine). I think that most ppc devs use a ppc
> machine and so ppc was most probably fine (at least ppc64) but I suspect
> that most of these others archs either had never sparse used on them
> or had a lot of wrong warnings. IOW, it was maybe OK but most probably
> incorrect for them and now it is OK.
> 
>> You forgot to CC them on this patch.
> 
> I didn't thought/knew  it was needed and the CC list is already
> quite long but, if needed, no problem for me.

Ideally, adding linux-arch@vger.kernel.org would be sufficient, but
sadly I have doubts about that.

>> Have you really checked that all their toolchains support the -m32/-m64
>> flags you newly introduce for them? Apart from non-biarch architectures,
>> I'm thinking of 31-bit s390 as a corner case where !64 != 32.
> 
> Hmm, there is no change to anything I call 'toolchain related', like
> compiler and linker. The only change is sparse (or any other checker)
> receiving now a correct and explicit -m32 or -m64.
> 
> For s390, as far as I know:
> 1) it has CONFIG_64BIT unconditionally definee (because the old 31bit
>    is no more supported, now everything is s390x only).
> 2) even if the *address space* was only 31 bit, I'm very sure
>    that sizeof(long) and sizeof(void*) was 4 on these machine
>    hence -m32 would have been correct.


-- 
~Randy
