Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeECQpm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:45:42 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:41959 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeECQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:45:38 -0400
X-Google-Smtp-Source: AB8JxZqfVgGr+bZzpJWgZxWD7v3228QlnkqDEe24I9Ul5++7zgr7YUc2qAnR+edZ2Bv/kGFehr3FqP4gDKUSi5PC2Ng=
MIME-Version: 1.0
In-Reply-To: <fc4f2832-4e8f-3e70-6ab0-9f077790eca0@linux.com>
References: <20180502203326.9491-1-labbott@redhat.com> <20180502203326.9491-3-labbott@redhat.com>
 <CAGXu5jK1_--omGSqz03sfB8twQVzy9ZQR9Xzi-uxseekp+r1jQ@mail.gmail.com>
 <4b7e94c1-79c9-0380-25c6-762762ed595f@redhat.com> <fc4f2832-4e8f-3e70-6ab0-9f077790eca0@linux.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 3 May 2018 09:45:36 -0700
X-Google-Sender-Auth: 3jOW1CDSBlxiKlq0wiEGRFggOJk
Message-ID: <CAGXu5jJ7ER58PvF4V=-BiNpmhxU2=_C8tkcNSPR5ANp2B7Seeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: Clear the stack
To: Alexander Popov <alex.popov@linux.com>
Cc: Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 9:05 AM, Alexander Popov <alex.popov@linux.com> wrote:
> Hello Laura and Kees,
>
> On 03.05.2018 02:07, Laura Abbott wrote:
>> On 05/02/2018 02:31 PM, Kees Cook wrote:
>>> On Wed, May 2, 2018 at 1:33 PM, Laura Abbott <labbott@redhat.com> wrote:
>>>>
>>>> Implementation of stackleak based heavily on the x86 version
>>>
>>> Awesome! Notes below for both you and Alexander, since I think we can
>>> create a common code base instead of having near-duplicates in the
>>> arch/ trees...
>
> Yes, sure.
>
> I will extract the common part and send v12 for x86. Then Laura will be able to
> add arm64 support in a separate patch series. Is it fine?

Sure, though if you could fold the plugin fix from her, that would be
ideal. I'll likely carry both patch sets together once the arm64 one
stabilizes.

>> This was based on the earlier version of x86. I'll confess to
>> not seeing how the current x86 version ended up with get_stack_info
>> but I suspect it's either related to ORC unwinding or it's best
>> practice.
>
> I've changed that in v4. Quote from the changelog:
>   - Fixed the surplus and erroneous code for calculating stack_left in
>      check_alloca() on x86_64. That code repeats the work which is already
>      done in get_stack_info() and it misses the fact that different
>      exception stacks on x86_64 have different size.
>
> http://www.openwall.com/lists/kernel-hardening/2017/10/04/68
>
> We can see that in arch/x86/kernel/dumpstack_64.c.
>
> Is it fine if check_alloca() would be arch-specific?

I'm fine if check_alloca() remains arch-specific.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
