Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965317AbeBMRS3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:18:29 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:44425 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965064AbeBMRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:18:10 -0500
X-Google-Smtp-Source: AH8x226CGpn0NkPjEII4iaVhkpAmIFBIu/JlJo1ulEl6u67vahvAAYF7PS/ej7mwHQgeXUVYWoLXvEHWvnz2cBFtS7s=
MIME-Version: 1.0
In-Reply-To: <20180213171112.GA28598@avx2>
References: <20180210211110.GA24324@avx2> <CAHp75VcQf-8RUP+bjej5dGJ+s2-hW9=51NVkvhYE6mUO3dY1Cg@mail.gmail.com>
 <20180213171112.GA28598@avx2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 19:18:08 +0200
Message-ID: <CAHp75VffzNNws=zb+oBRuaJ=rQUwMgtxgN32Qv85X-Gfr0dR8Q@mail.gmail.com>
Subject: Re: [PATCH] kstrtox: make kstrtobool_from_user() very strict
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 7:11 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Tue, Feb 13, 2018 at 06:02:27PM +0200, Andy Shevchenko wrote:
>> On Sat, Feb 10, 2018 at 11:11 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>> > Once upon a time module parameter parsing code accepted
>> > 0, 1, y, n, Y and N for boolean values. Gratituous but contained
>> > to module code and thus tolerable.
>> >
>> > Commit ef951599074ba4fad2d0efa0a977129b41e6d203
>> > ("lib: move strtobool() to kstrtobool()") promoted that ugly wart
>> > to kstrtobool() and, more importantly, kstrtobool_from_user().
>> >
>> > Later set of accepted values was expanded to "on" and "of".
>> > Now there are 6+8=14(!) valid strings for a boolean.
>> >
>> > This patch reduces set of accepted values to "0" and "1"
>> > (with optional newline) in spirit with other kstrto*() functions.
>> >
>> > I'm starting with kstrtobool_from_user() as it is explicitly designed
>> > to be used for interacting with userspace. Currently there are 9 users
>> > all debug code, so there is hope.
>> >
>> > Please send before 4.16 so no real users start to depend on verbose behaviour.

>> NACK.
>> You basically are breaking ABI here. I don't see a zillion patches
>> which adds a tons of duplicate code to the corresponding users.
>
> Please do "find . -type f -name '*.[ch]' | xargs grep kstrtobool_from_user -w'
> before talking about zillion of patches.

If you wonder, I did it of course. The stylistic device I used here is
called "hyperbole".

Even for that dozen or so users I don't see how you handled the change.

-- 
With Best Regards,
Andy Shevchenko
