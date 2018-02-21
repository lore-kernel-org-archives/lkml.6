Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933626AbeBULso (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:48:44 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:45450 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932556AbeBULsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:48:43 -0500
X-Google-Smtp-Source: AH8x2276A5OTG4eYoZJvWDGMz0ZWzoThn3RLb0QlBnIVhCiM68wEW1CoCO37syAnI5/s5dUigEGzJCNv73Vw+mk7Exs=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1802202202220.31644@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-3-arnd@arndb.de>
 <nycvar.YSQ.7.76.1802202202220.31644@knanqh.ubzr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 12:48:42 +0100
X-Google-Sender-Auth: kbpJ-3PdJlOmhOZSgfFZ8UBWqCg
Message-ID: <CAK8P3a0VR1bkwdQ+Th6mPVVV_t5YoyqGPOAiWmtg8kVnjUha-g@mail.gmail.com>
Subject: Re: [PATCH 2/7] ARM: LTO: avoid THUMB2_KERNEL+LTO
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 4:12 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 20 Feb 2018, Arnd Bergmann wrote:
>
>> Trying to build an LTO-Enabled kernel with Thumb2 instructions failed
>> horribly for me, with an endless output of things like
>>
>> ccVnNycO.s:2665: Error: thumb conditional instruction should be in IT block -- `bxne lr'
>> ccVnNycO.s:7128: Error: thumb conditional instruction should be in IT block -- `strexeq r5,r2,[r3]'
>> ccVnNycO.s:7258: Error: thumb conditional instruction should be in IT block -- `strexeq lr,r0,[r3]'
>> ccVnNycO.s:17380: Error: thumb conditional instruction should be in IT block -- `strexeq r1,r2,[r6]'
>> ccVnNycO.s:19163: Error: thumb conditional instruction should be in IT block -- `strexeq r8,r6,[r3]'
>> ccVnNycO.s:22722: Error: thumb conditional instruction should be in IT block -- `strexeq r7,r1,[r0]'
>> ccVnNycO.s:24105: conditional infixes are deprecated in unified syntax
>> ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `sbcccs r1,r1,r3'
>> ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'
>> ccVnNycO.s:24210: conditional infixes are deprecated in unified syntax
>> ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `sbcccs r2,r2,r3'
>> ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'
>>
>> I did not investigate this too much, disabling Thumb2 support when LTO is
>> set lets me build randconfig kernels.
>>
>> Since ARM_SINGLE_ARMV7M is Thumb2-only, I have to disallow LTO for V7-M
>> targets.
>
> Here's the workaround I sent you on January 2rd:

Hmm, I thought I had applied that correctly but looking again now I
must have overwritten
the assembler when I reinstalled the toolchain from source to get a
fixed version of the
compiler.

       Arnd
