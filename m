Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeEGUY5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:24:57 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:34384 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeEGUY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:24:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 07 May 2018 22:24:51 +0200
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de
Cc: robin.murphy@arm.com, nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] ARM: clang support
In-Reply-To: <20180325180959.28008-1-stefan@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch>
Message-ID: <d099cce32d109caefd2fc39196ce5bca@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-2.11 / 15.00];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         DKIM_SIGNED(0.00)[];
         BAYES_HAM(-2.01)[95.13%];
         RCVD_COUNT_ZERO(0.00)[0];
         TO_DN_NONE(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.2018 20:09, Stefan Agner wrote:
> This patchset fixes some remaining issues when building the ARM
> architecture using LLVM/clang.  The patchset requires the following
> kbuild change:
> https://lkml.org/lkml/2018/3/19/1756
> 
> With that patch and this patchset applied and I can successfully
> build (and boot) the multi_v7_defconfig with 4.16-rc5 using clang
> 5.0.1 and 6.0.0.

Russel, Arnd, any comment on this patch series? How can we get it
merged?

I was thinking patch 1 through armsoc since that is the way previous
patches have been merged.

Note sure about patch 2, Russel can you comment on Thierry's email?

And patch 3 through 6 through Russel's tree?

--
Stefan

> 
> This version also adds a patch to mitigate a often printed warning
> about duplicate 'const' declaration specifier when using get_user().
> 
> Stefan Agner (6):
>   bus: arm-cci: use asm unreachable
>   efi/libstub/arm: add support for building with clang
>   ARM: trusted_foundations: do not use naked function
>   ARM: drop no-thumb-interwork in EABI mode
>   ARM: add support for building ARM kernel with clang
>   ARM: uaccess: remove const to avoid duplicate specifier
> 
>  arch/arm/Makefile                       |  2 +-
>  arch/arm/boot/compressed/Makefile       |  2 +-
>  arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
>  arch/arm/include/asm/uaccess.h          |  2 +-
>  drivers/bus/arm-cci.c                   |  2 --
>  drivers/firmware/efi/libstub/Makefile   |  3 ++-
>  6 files changed, 14 insertions(+), 11 deletions(-)
