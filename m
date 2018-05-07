Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbeEGVJn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:09:43 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44905 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeEGVJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:09:42 -0400
X-Google-Smtp-Source: AB8JxZoEr/qB04VExoY2opxSoG3N2ahJMLkUJtbZE+TU4/S8XsIPp4iK128f4JA8vJ5B16sTrXo07ap956zAS05epNo=
MIME-Version: 1.0
In-Reply-To: <d099cce32d109caefd2fc39196ce5bca@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch> <d099cce32d109caefd2fc39196ce5bca@agner.ch>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 7 May 2018 17:09:41 -0400
X-Google-Sender-Auth: fLg170SQ8QbIubNc9vrEq36nHNM
Message-ID: <CAK8P3a3-0q-YrA0gdT-wJD3fp3a4pXQOCx9mVwp8qFWS3n7dMg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ARM: clang support
To: Stefan Agner <stefan@agner.ch>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Behan Webster <behanw@converseincode.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
        <Bernhard.Rosenkranzer@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 4:24 PM, Stefan Agner <stefan@agner.ch> wrote:
> On 25.03.2018 20:09, Stefan Agner wrote:
>> This patchset fixes some remaining issues when building the ARM
>> architecture using LLVM/clang.  The patchset requires the following
>> kbuild change:
>> https://lkml.org/lkml/2018/3/19/1756
>>
>> With that patch and this patchset applied and I can successfully
>> build (and boot) the multi_v7_defconfig with 4.16-rc5 using clang
>> 5.0.1 and 6.0.0.
>
> Russel, Arnd, any comment on this patch series? How can we get it
> merged?
>
> I was thinking patch 1 through armsoc since that is the way previous
> patches have been merged.

Please resend it to arm@kernel.org.

Lorenzo, Robin, Will, Suzuki: could one of you look at the patch and
provide an Ack
and maybe send a patch to add a MAINTAINERS file entry for the the
arm-cci driver to make it less ambiguous to who's responsible for it?

I know very little about the code and don't want to be the main person having
to decide if a patch can go in or not.

> Note sure about patch 2,

This should be up to Ard to pick up or comment on. I think I had
previously suggested a similar patch to him, but don't remember
what happened to that.

> Russel can you comment on Thierry's email?
>
> And patch 3 through 6 through Russel's tree?

Sounds good to me. Please submit those through
http://www.arm.linux.org.uk/developer/patches/ once they are
ready. I think patches 4, 5 and 6 are good to go in, while patch
3 has an unfinished discussion.

It might also be a good idea to pick up the CONFIG_FRAME_POINTER
problem and disable that option for clang based builds now, using
the new infrastructure we have for detecting compiler features at
Kconfig time.

       Arnd
