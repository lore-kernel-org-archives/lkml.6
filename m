Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeEaBNK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 21:13:10 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:34061 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932563AbeEaBNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 21:13:08 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w4V1CnII022070
X-Nifty-SrcIP: [209.85.213.48]
X-Google-Smtp-Source: ADUXVKIoKGlTNg6Dt2ktqaqxQmx/Vq5fN6WHrymCywVBFkQApUJ9X0wNUoNWU6l3E8IBxuxwxeG9FUz1OA3eToCTUH4=
MIME-Version: 1.0
In-Reply-To: <20180531084037.2f8b4c1e@canb.auug.org.au>
References: <20180531084037.2f8b4c1e@canb.auug.org.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 31 May 2018 10:12:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjVCPwfJ-opUkW3+XTM0uk9PSo3XiyGwCAMKkK05WnxA@mail.gmail.com>
Message-ID: <CAK7LNAQjVCPwfJ-opUkW3+XTM0uk9PSo3XiyGwCAMKkK05WnxA@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the kbuild tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
(+CC Kees)

2018-05-31 7:40 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Masahiro,
>
> After merging the kbuild tree, today's linux-next build (x86_64
> allmodconfig) produced these warnings:
>
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_workarounds_nphy_rev7':
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16563:1: warning: the frame size of 3136 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>  }
>  ^
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_workarounds_nphy_rev3':
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16905:1: warning: the frame size of 2872 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>  }
>  ^
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function 'wlc_phy_cal_txiqlo_nphy':
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:26033:1: warning: the frame size of 2432 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>  }
>  ^
>
> I have no idea what caused these warnings to appear ... nothing in those
> functions looks too bad.


This has been triggered by the following commit:


commit 0e461945f3504e09b8ecf947b6398adce1287a28
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon May 28 18:22:07 2018 +0900

    gcc-plugins: allow to enable GCC_PLUGINS for COMPILE_TEST



CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL was previously disabled
for COMPILE_TEST, which is now enabled.



COMPILE_TEST now enables GCC plugin for wider test coverage,
this is a good thing in general.





-- 
Best Regards
Masahiro Yamada
