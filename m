Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeCVW0d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:26:33 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33951 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeCVW0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:26:31 -0400
X-Google-Smtp-Source: AG47ELvQZlFDY51SP71gZpNL7nnoYehjzLmRbCdu10Hzq6TfSPe7DvXpkyRTiekzTNlAFGQtA7N12sQhyfDUMsgVxws=
MIME-Version: 1.0
References: <20180322212705.141175-1-mka@chromium.org>
In-Reply-To: <20180322212705.141175-1-mka@chromium.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 22 Mar 2018 22:26:18 +0000
Message-ID: <CAKwvOdk4Tos1Q8dyQvic4PUX3cjy3q1hn3FkK=xiVSChht+gEg@mail.gmail.com>
Subject: Re: [PATCH] arm/arm64: smccc: Use xN for arm64 register constraints
 with clang
To: Matthias Kaehlcke <mka@chromium.org>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>, Dave.Martin@arm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that a patch in this form has previously been implemented by:

Andrey Konovalov <andreyknvl@google.com>:
https://gist.github.com/xairy/ee11682ea86044a45c0291c528cd936f

and another by:

Greg Hackmann <ghackmann@google.com>:
https://android-review.googlesource.com/c/kernel/common/+/645181

If you used either as a reference, you may want to credit them with a
`Suggested-by:` in the commit message.

On Thu, Mar 22, 2018 at 2:28 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> +#ifndef __clang__
> +#define __reg__ "r"
> +#else
> +#define __reg__ "x"
> +#endif

Can this be flipped to #ifdef __clang__ ?  having an if...else where the
conditional negated is kind of funny.

--
Thanks,
~Nick Desaulniers
