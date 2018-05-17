Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeEQG00 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:26:26 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33878 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeEQG0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:26:22 -0400
X-Google-Smtp-Source: AB8JxZqqF+nbtA7J9WUmiol96gI2WJ5CdpndYYPOrBcsLags1g/0ZLG/a6P+JVLTddP7zzmcQv8NJjpUwKN86tkjDDI=
MIME-Version: 1.0
In-Reply-To: <1526537830-22606-24-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com> <1526537830-22606-24-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 May 2018 23:26:20 -0700
X-Google-Sender-Auth: yXat5Wo56-K_obUVuN9MM1SWtzs
Message-ID: <CAGXu5jKhZWMfKWvj2QhU8LaXD4CqO9oVZ==Ux919jN7fKG8okg@mail.gmail.com>
Subject: Re: [PATCH v4 23/31] stack-protector: test compiler capability in
 Kconfig and drop AUTO mode
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:17 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Move the test for -fstack-protector(-strong) option to Kconfig.
>
> If the compiler does not support the option, the corresponding menu
> is automatically hidden.  If STRONG is not supported, it will fall
> back to REGULAR.  If REGULAR is not supported, it will be disabled.
> This means, AUTO is implicitly handled by the dependency solver of
> Kconfig, hence removed.
>
> I also turned the 'choice' into only two boolean symbols.  The use of
> 'choice' is not a good idea here, because all of all{yes,mod,no}config
> would choose the first visible value, while we want allnoconfig to
> disable as many features as possible.
>
> X86 has additional shell scripts in case the compiler supports those
> options, but generates broken code.  I added CC_HAS_SANE_STACKPROTECTOR
> to test this.  I had to add -m32 to gcc-x86_32-has-stack-protector.sh
> to make it work correctly.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
