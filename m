Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeFAEBH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:01:07 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42537 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFAEBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:01:04 -0400
X-Google-Smtp-Source: ADUXVKLlbBGmNrdmSTQ/Jj5xWYG3ZXS6yk+79hMaf0KFhkI+BnmaHMzPxVCb3qLx3guelrxayY5nU8/stxC0KGA/rF8=
MIME-Version: 1.0
In-Reply-To: <CAK7LNASYTVNque5kgq7FnyOSjX4byBsWhfB-0Jy9Fp0ZmpuqYA@mail.gmail.com>
References: <20180531084037.2f8b4c1e@canb.auug.org.au> <CAK7LNAQjVCPwfJ-opUkW3+XTM0uk9PSo3XiyGwCAMKkK05WnxA@mail.gmail.com>
 <CAGXu5jK8OSJXT5eGK=J0msL9kc+fjOxFUyv=5NYbOH8savc5Xw@mail.gmail.com>
 <CAGXu5jKb9f7Or9z3eBzAUci2teE6ULVjkuqv00O_j3VuowwbJw@mail.gmail.com> <CAK7LNASYTVNque5kgq7FnyOSjX4byBsWhfB-0Jy9Fp0ZmpuqYA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 31 May 2018 21:01:01 -0700
X-Google-Sender-Auth: lfKIg0RioMXD7Ksz1cSPDvYL5V4
Message-ID: <CAGXu5jK8F_R-CAt8h92ZG51s5eSnV+6FASLmYCWWgRX_2_m8zA@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the kbuild tree
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 6:56 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-05-31 12:53 GMT+09:00 Kees Cook <keescook@chromium.org>:
>> On Wed, May 30, 2018 at 6:26 PM, Kees Cook <keescook@chromium.org> wrote:
>>> On Wed, May 30, 2018 at 6:12 PM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> Hi.
>>>> (+CC Kees)
>>>>
>>>> 2018-05-31 7:40 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
>>>>> Hi Masahiro,
>>>>>
>>>>> After merging the kbuild tree, today's linux-next build (x86_64
>>>>> allmodconfig) produced these warnings:
>>>>>
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_workarounds_nphy_rev7':
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16563:1: warning: the frame size of 3136 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>>>>  }
>>>>>  ^
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_workarounds_nphy_rev3':
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16905:1: warning: the frame size of 2872 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>>>>  }
>>>>>  ^
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_cal_txiqlo_nphy':
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:26033:1: warning: the frame size of 2432 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>>>>  }
>>>>>  ^
>>>>>
>>>>> I have no idea what caused these warnings to appear ... nothing in those
>>>>> functions looks too bad.
>>>>
>>>>
>>>> This has been triggered by the following commit:
>>>>
>>>>
>>>> commit 0e461945f3504e09b8ecf947b6398adce1287a28
>>>> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> Date:   Mon May 28 18:22:07 2018 +0900
>>>>
>>>>     gcc-plugins: allow to enable GCC_PLUGINS for COMPILE_TEST
>>>>
>>>>
>>>>
>>>> CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL was previously disabled
>>>> for COMPILE_TEST, which is now enabled.

For the moment, can you add "depends on !COMPILE_TEST" to
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL in your tree and I'll continue
to figure out what's happening?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
