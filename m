Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeEQHwK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:52:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41816 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbeEQHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:52:08 -0400
X-Google-Smtp-Source: AB8JxZrlUbiUmJeXYYjianfoqsC+7Heq1dVoPqU4WHfhTbJfvjIYtjoFyMU0mpcSMaBg2UAesNAbQw==
Date: Thu, 17 May 2018 17:51:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, Emese Revfy <re.emese@gmail.com>,
        x86@kernel.org
Subject: Re: [PATCH v4 00/31] kconfig: move compiler capability tests to
 Kconfig
Message-ID: <20180517175156.4c4246f6@roar.ozlabs.ibm.com>
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 15:16:39 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> [Introduction]
> 
> The motivation of this work is to move the compiler option tests to
> Kconfig from Makefile.  A number of kernel features require the
> compiler support.  Enabling such features blindly in Kconfig ends up
> with a lot of nasty build-time testing in Makefiles.  If a chosen
> feature turns out unsupported by the compiler, what the build system
> can do is either to disable it (silently!) or to forcibly break the
> build, despite Kconfig has let the user to enable it.  By moving the
> compiler capability tests to Kconfig, Kconfig entries will be visible
> only when they are available.
> 
> [Major Changes in V4]

Do you have a git tree for v4? I can test it with the powerpc patches.

The new scripting capability in kconfig has allowed us to already
improve the config process on powerpc:

https://marc.info/?l=linuxppc-embedded&m=152648110727868&w=2

I'm sure there's more clever things we can do with it but I haven't
had time to think about it yet. One thing that comes to mind is that
It might be nice to show the option as disabled, then the user could
upgrade their compiler to get the options they want.

Anyway v3 worked fine for me, the documentation is really nice, I
could implement the above patch without any problem despite being a
kbuild dummy. Thanks for the series, ack from me.

Thanks,
Nick
