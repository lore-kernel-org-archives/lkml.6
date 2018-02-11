Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeBKKV0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:21:26 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45405 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeBKKVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:21:25 -0500
X-Google-Smtp-Source: AH8x2267lIemoEcc+bG56Um7M/Fm4TBvN4ebo+gPlD/OnmMKwnmKb83+cA5jpdMyGD4OvnlhSbtsv40sF1OoD/gxtMo=
MIME-Version: 1.0
In-Reply-To: <1518340546-6690-1-git-send-email-jcmvbkbc@gmail.com>
References: <1518340546-6690-1-git-send-email-jcmvbkbc@gmail.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Sun, 11 Feb 2018 11:21:24 +0100
Message-ID: <CAAeHK+w+nxJoOfivzvY4TB5xmgYCADbd_+K03U44xrwcTtXzcg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: fix build with KASAN
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:15 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> The commit 917538e212a2 ("kasan: clean up KASAN_SHADOW_SCALE_SHIFT
> usage") removed KASAN_SHADOW_SCALE_SHIFT definition from
> include/linux/kasan.h and added it to architecture-specific headers,
> except for xtensa. This broke the xtensa build with KASAN enabled.
> Define KASAN_SHADOW_SCALE_SHIFT in arch/xtensa/include/asm/kasan.h
>
> Reported by: kbuild test robot <fengguang.wu@intel.com>
> Fixes: 917538e212a2 ("kasan: clean up KASAN_SHADOW_SCALE_SHIFT usage")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/include/asm/kasan.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/xtensa/include/asm/kasan.h b/arch/xtensa/include/asm/kasan.h
> index 54be80876e57..216b6f32c375 100644
> --- a/arch/xtensa/include/asm/kasan.h
> +++ b/arch/xtensa/include/asm/kasan.h
> @@ -10,6 +10,8 @@
>  #include <linux/sizes.h>
>  #include <asm/kmem_layout.h>
>
> +#define KASAN_SHADOW_SCALE_SHIFT 3
> +
>  /* Start of area covered by KASAN */
>  #define KASAN_START_VADDR __XTENSA_UL_CONST(0x90000000)
>  /* Start of the shadow map */
> --
> 2.1.4
>

Thanks!

Acked-by: Andrey Konovalov <andreyknvl@google.com>
