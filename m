Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeBEKPo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:15:44 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34207 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBEKPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:15:37 -0500
X-Google-Smtp-Source: AH8x224c762UTJLZU4dmfPv0ufmbFC+cZRktmWZ1UanNHDrJfyd8fWbZe/bGeqSpeHHBb4CXv5GIL/jKWPEDfnPYA1g=
MIME-Version: 1.0
In-Reply-To: <d77f9a8a-0bb2-50a3-68e3-b4f4173645bc@virtuozzo.com>
References: <20180202154813.1625742-1-arnd@arndb.de> <d77f9a8a-0bb2-50a3-68e3-b4f4173645bc@virtuozzo.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Feb 2018 11:15:35 +0100
X-Google-Sender-Auth: cCqIeLS05BkurBU7f5QnFi46_GU
Message-ID: <CAK8P3a124Jdza9YbgOHECC2owpx_HmOuDMWtotxuC2-F9L9Cgg@mail.gmail.com>
Subject: Re: [PATCH] ubsan: don't mark __ubsan_handle_builtin_unreachable as noreturn
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 10:02 AM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
>
>
> On 02/02/2018 06:47 PM, Arnd Bergmann wrote:
>> gcc-8 complains about the prototype for this function:
>>
>> lib/ubsan.c:432:1: error: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Werror=attributes]
>>
>
> That's actually a bug in GCC. In GCC __ubsan_handle_builtin_unreachable declared
> with 'noreturn' and 'const' attributes:
>
> DEF_SANITIZER_BUILTIN(BUILT_IN_UBSAN_HANDLE_BUILTIN_UNREACHABLE,
>                       "__ubsan_handle_builtin_unreachable",
>                       BT_FN_VOID_PTR,
>                       ATTR_COLD_CONST_NORETURN_NOTHROW_LEAF_LIST)
>
>
> But const attribute doesn't make any sense for function that returns void or doesn't return at all.
> Given that gcc-8 has not released yet, it would be better to fix this bug there.

Ok. Should I open a gcc bug, or will you take care of it?

       Arnd
