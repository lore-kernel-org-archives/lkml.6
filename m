Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935704AbeE2Pvh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:51:37 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41792 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965258AbeE2Pvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:51:31 -0400
X-Google-Smtp-Source: ADUXVKLD+3Xz5LpgqPHwd6wYUCOZ1cT1VtBcmEJYuG94uv2vYxhfe/WaRXHYiZN+g0O+gWXFRgayZNeUr8Hgy7jT4Wg=
MIME-Version: 1.0
In-Reply-To: <20180529150823.GD17159@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com> <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com> <CAMuHMdXgiMeD4uF+j8W+CpNwYYK2W_8xqk_=vGBiW=bUvKeq7w@mail.gmail.com>
 <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com> <20180529150823.GD17159@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 May 2018 17:51:29 +0200
X-Google-Sender-Auth: bpGeGlaf0ka_A3mTeGasxkK18yQ
Message-ID: <CAMuHMdU0yET6+-FfS8e9HJdKB7h0gDn7kzWGpJZV=UiWn5fLkA@mail.gmail.com>
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
To: Will Deacon <will.deacon@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>, austinwc@codeaurora.org,
        tnowicki@caviumnetworks.com, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Morten.Rasmussen@arm.com,
        vkilari@codeaurora.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        jhugo@codeaurora.org, Al Stone <ahs3@redhat.com>,
        Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>,
        wangxiongfeng2@huawei.com, Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, May 29, 2018 at 5:08 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, May 29, 2018 at 02:18:40PM +0100, Sudeep Holla wrote:
>> On 29/05/18 12:56, Geert Uytterhoeven wrote:
>> > On Tue, May 29, 2018 at 1:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> >> On 29/05/18 11:48, Geert Uytterhoeven wrote:
>> >>> System supend still works fine on systems with big cores only:
>> >>>
>> >>>     R-Car H3 ES1.0 (4xCA57 (4xCA53 disabled in firmware))
>> >>>     R-Car M3-N (2xCA57)
>> >>>
>> >>> Reverting this commit fixes the issue for me.
>> >>
>> >> I can't find anything that relates to system suspend in these patches
>> >> unless they are messing with something during CPU hot plug-in back
>> >> during resume.
>> >
>> > It's only the last patch that introduces the breakage.
>> >
>>
>> As specified in the commit log, it won't change any behavior for DT
>> systems if it's non-NUMA or single node system. So I am still wondering
>> what could trigger this regression.
>
> I wonder if we're somehow giving an uninitialised/invalid NUMA configuration
> to the scheduler, although I can't see how this would happen.
>
> Geert -- if you enable CONFIG_DEBUG_PER_CPU_MAPS=y and apply the diff below
> do you see anything shouting in dmesg?

Thanks, but unfortunately it doesn't help.
I added some debug code to print cpumask, but so far I don't see anything
suspicious.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
