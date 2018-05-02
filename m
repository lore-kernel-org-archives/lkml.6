Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeEBUa2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:30:28 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41775 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeEBUaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:30:22 -0400
X-Google-Smtp-Source: AB8JxZry1m4AdB8UBpsOYDKlXaMwV1/Hpj7EwK4KNCo7cbpm/Zc0S4Y+yrjVJgbmg2gM5IfYA59yIQ+tU1Qelp9rHO8=
MIME-Version: 1.0
In-Reply-To: <1525179614-14571-5-git-send-email-changbin.du@intel.com>
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com> <1525179614-14571-5-git-send-email-changbin.du@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 2 May 2018 16:30:21 -0400
X-Google-Sender-Auth: wLUmBW10zixqRt189pu0PAt3QLY
Message-ID: <CAK8P3a0c++Ti_39WPXwwjjmRx+EUozzCVY5Y2qicyEeLop6_6w@mail.gmail.com>
Subject: Re: [PATCH 4/5] kernel hacking: new config DEBUG_EXPERIENCE to apply
 GCC -Og optimization
To: changbin.du@intel.com
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:00 AM,  <changbin.du@intel.com> wrote:
> From: Changbin Du <changbin.du@intel.com>
> +config DEBUG_EXPERIENCE
> +       bool "Optimize for better debugging experience (-Og)"
> +       default n
> +       select NO_AUTO_INLINE
> +       depends on !CC_OPTIMIZE_FOR_SIZE
> +       help

How about having this as another option alongside CC_OPTIMIZE_FOR_SIZE
and CC_OPTIMIZE_FOR_PERFORMANCE in the same choice statement?

We could also add another option for -Os (for faster compiles)  or possibly
for -O3 (if anyone cares) in there.

      Arnd
