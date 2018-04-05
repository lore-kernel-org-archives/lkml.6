Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDELSu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:18:50 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37018 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeDELSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:18:49 -0400
X-Google-Smtp-Source: AIpwx4/2FNxP83MniYVTJDv1K6F12cyu+ZAb5fHNhMAeGvHPwwnLkUKx4VwpzBJgrWv7lbCHO5RpacZUmNuXN4ABqUM=
MIME-Version: 1.0
In-Reply-To: <20180404223843.GL16141@n2100.armlinux.org.uk>
References: <20180404123117.3575773-1-arnd@arndb.de> <CAGXu5jK1abgzQCJ+9ysTZHvxPo4vG6dfwPFs_CuXdP=0_Qib_g@mail.gmail.com>
 <20180404223843.GL16141@n2100.armlinux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 13:18:48 +0200
X-Google-Sender-Auth: y7xYrK8t3Qw-pjCgOwMSgkZoeYw
Message-ID: <CAK8P3a3PcP4rpmw2gAO7GhxwaeHeZPTrtONuqUjFvu1rfKjgpw@mail.gmail.com>
Subject: Re: [PATCH] arm: decompressor: mark error() as __noreturn
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>, Jinbum Park <jinb.park7@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 12:38 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Apr 04, 2018 at 03:34:06PM -0700, Kees Cook wrote:
>> On Wed, Apr 4, 2018 at 5:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > gcc complains about fortify_panic() possibly returning:
>> >
>> > arch/arm/boot/compressed/misc.c: In function 'fortify_panic':
>> > arch/arm/boot/compressed/misc.c:167:1: error: 'noreturn' function does return [-Werror]
>> >
>> > This annotates the error() function as __noreturn, which lets gcc
>> > see in all configurations that it fortify_panic() cannot return either.
>> >
>> > Fixes: ee333554fed5 ("ARM: 8749/1: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE")
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>
> I'd actually prefer a more robust solution to this - error() is used
> in different files, each with their own separate prototype, which is
> error-prone.  The same goes for a few other variables.  The following
> is IMHO a more complete (and thus larger) patch:

Right, much better.

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume you'll just fold it into the original patch if you can, or apply it
on top yourself.
