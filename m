Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932712AbeEaB0T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 21:26:19 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42623 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932683AbeEaB0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 21:26:10 -0400
X-Google-Smtp-Source: ADUXVKLNIPFCURX3ORXUNuj5KGqSxnRdGGHFlb7xBjIWlzygHVDVMCSfCKJS8nnvAUb2mJ+xWdIZb5p924B1S9yKpUQ=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQjVCPwfJ-opUkW3+XTM0uk9PSo3XiyGwCAMKkK05WnxA@mail.gmail.com>
References: <20180531084037.2f8b4c1e@canb.auug.org.au> <CAK7LNAQjVCPwfJ-opUkW3+XTM0uk9PSo3XiyGwCAMKkK05WnxA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 30 May 2018 18:26:08 -0700
X-Google-Sender-Auth: BcOgN5NZufktYeBb58k4IojITCc
Message-ID: <CAGXu5jK8OSJXT5eGK=J0msL9kc+fjOxFUyv=5NYbOH8savc5Xw@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the kbuild tree
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 6:12 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi.
> (+CC Kees)
>
> 2018-05-31 7:40 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
>> Hi Masahiro,
>>
>> After merging the kbuild tree, today's linux-next build (x86_64
>> allmodconfig) produced these warnings:
>>
>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_workarounds_nphy_rev7':
>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16563:1: warning: the frame size of 3136 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>  }
>>  ^
>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_workarounds_nphy_rev3':
>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16905:1: warning: the frame size of 2872 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>  }
>>  ^
>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_cal_txiqlo_nphy':
>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:26033:1: warning: the frame size of 2432 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>>  }
>>  ^
>>
>> I have no idea what caused these warnings to appear ... nothing in those
>> functions looks too bad.
>
>
> This has been triggered by the following commit:
>
>
> commit 0e461945f3504e09b8ecf947b6398adce1287a28
> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date:   Mon May 28 18:22:07 2018 +0900
>
>     gcc-plugins: allow to enable GCC_PLUGINS for COMPILE_TEST
>
>
>
> CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL was previously disabled
> for COMPILE_TEST, which is now enabled.

Weird -- I do build tests with plugins enabled pretty regularly. I
hadn't seen this before. I'll see if I can figure out what the
combination is...

> COMPILE_TEST now enables GCC plugin for wider test coverage,
> this is a good thing in general.

Yes indeed!

-Kees

-- 
Kees Cook
Pixel Security
