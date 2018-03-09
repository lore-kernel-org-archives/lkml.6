Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeCIITx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:19:53 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:42625 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeCIITv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:19:51 -0500
X-Google-Smtp-Source: AG47ELtrsKF6MYHj0EY9xL+ApNbztpJJRdv+gCumMD8edHaLjCMI6hscaLlnR3JmQSL1u7Xo6QHr1ez9RZo6AG9goj4=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu86v9-Cj3bxEPWXCMRnE7S76kGdu7to3cOoLMgTTcH_xg@mail.gmail.com>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
 <20180308080020.22828-13-ard.biesheuvel@linaro.org> <20180309074719.y33xe4bjkjsjsaa3@gmail.com>
 <CAKv+Gu-JmM3F0=XCDZFAkK+6pRgmp=7HK2dhY9La9tKbNYFBEg@mail.gmail.com>
 <20180309080428.atur6wcbb6vtonhz@gmail.com> <CAKv+Gu86v9-Cj3bxEPWXCMRnE7S76kGdu7to3cOoLMgTTcH_xg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 9 Mar 2018 08:19:50 +0000
Message-ID: <CAKv+Gu-AuY=qPddZeKpidMY6thnP4z4R=bN7M63kDL32NQUMBA@mail.gmail.com>
Subject: Re: [PATCH 12/12] efi: make const array 'apple' static
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 March 2018 at 08:07, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 9 March 2018 at 08:04, Ingo Molnar <mingo@kernel.org> wrote:
>>
>> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>>> > Also, would it make sense to rename it to something more descriptive like
>>> > "apple_unicode_str[]" or so?
>>> >
>>> > Plus an unicode string literal initializer would be pretty descriptive as well,
>>> > instead of the weird looking character array, i.e. something like:
>>> >
>>> >   static efi_char16_t const apple_unicode_str[] = u"Apple";
>>> >
>>> > ... or so?
>>> >
>>>
>>> is u"xxx" the same as L"xxx"?
>>
>> So "L" literals map to wchar_t, which wide character type is implementation
>> specific IIRC, could be 16-bit or 32-bit wide.
>>
>> u"" literals OTOH are specified by the C11 spec to be char16_t, i.e. 16-bit wide
>> characters - which I assume is the EFI type as well?
>>
>>> In any case, this is for historical reasons: at some point (and I
>>> don't remember the exact details) we had a conflict at link time with
>>> objects using 4 byte wchar_t, so we started using this notation to be
>>> independent of the size of wchar_t. That issue no longer exists so we
>>> should be able to get rid of this.
>>
>> Yes, my guess is that those problems were due to L"xyz" mapping to wchar_t and
>> having a different type in the kernel build and the host build side - but u"xyz"
>> should solve that.
>>
>
> Excellent!
>
> Do you mind taking this patch as is? I will follow up with a patch
> that updates all occurrences of this pattern (we have a few of them),
> i.e., use u"" notation and move them to file scope.

OK, I misremembered: the other occurrences have already been moved to
file scope a while ago.

I will follow up with a patch that switches to u"" notation, please
let me know if I should respin this or not
