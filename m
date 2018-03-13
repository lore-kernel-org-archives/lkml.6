Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeCMS3G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:29:06 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43163 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbeCMS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:29:02 -0400
X-Google-Smtp-Source: AG47ELs4rv9wGrRYoSZXoWra9sGO5jsAfq4q/R6yLU9riJVJHxm+AJTbgBVVLNLr/SXySald5T47RuCk+ADAX5alTao=
MIME-Version: 1.0
In-Reply-To: <a6a2afaa-566e-8376-7999-410c886211c6@nokia.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com> <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
 <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com> <CAKv+Gu-Z58VseyCQBe_3KqgKn4s9dNBxR8wGyZ7JFrLB=EX8jw@mail.gmail.com>
 <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com> <CAKv+Gu9G9UNf_jif4ySw9iM9mYW_LNzKXyVv7mEAQP_Laaq3UA@mail.gmail.com>
 <ec84d8ee-8b90-5365-5be4-4b08d274c6e5@nokia.com> <CAKv+Gu8WeV+7U4omoMvECPa0LhF4Nrusvy+V0mirWVfejCebNg@mail.gmail.com>
 <a6a2afaa-566e-8376-7999-410c886211c6@nokia.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 13 Mar 2018 18:29:01 +0000
Message-ID: <CAKv+Gu_9xWhOyCwrYVaXkzNqmNMFo12rSL1opHO_fsmQcXDNmQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2018 at 18:24, Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:
> Hi!
>
> On 13/03/18 18:51, Ard Biesheuvel wrote:
>>>> if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
>>>>     module_plt_alloc_fixed();
>>> Do you consider this a legal C code if without module-plts.o the function would not exist at all?
>>> That's too much relying on optimizer I think...
>>>
>> Yes, we rely on that in many different places in the kernel.
>
> https://www.kernel.org/doc/Documentation/process/coding-style.rst:
> "However, this approach still allows the C compiler to see the code
> inside the block, and check it for correctness (syntax, types, symbol
> references, etc).  Thus, you still have to use an #ifdef if the code inside the
> block references symbols that will not exist if the condition is not met."
>

"will not exist" is ambiguous here. It is rather common to declare
symbols, but only define them conditionally, and use IS_ENABLED() to
refer to them. As the documentation says, this gets rid of #ifdefs,
making the code always visible to the compiler which is a good thing.
