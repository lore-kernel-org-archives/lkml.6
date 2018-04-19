Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeDSNfZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:35:25 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46576 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753675AbeDSNfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:35:20 -0400
X-Google-Smtp-Source: AB8JxZoyjwRtEfEaeMz4Pnf4K9Ld2JBKStEnLU9TP02ZVhD1saR/CinV/W9xYBEN5+NAfWj50V+c2zPkDtIFxtpNPDs=
MIME-Version: 1.0
In-Reply-To: <21ef6561299cdbbe0f3571c5048a2eaf5eb43bc7.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
 <21ef6561299cdbbe0f3571c5048a2eaf5eb43bc7.1524143428.git.greentime@andestech.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 15:35:19 +0200
X-Google-Sender-Auth: hn7fi26gTbDlGrpKa_slKDzcQPU
Message-ID: <CAK8P3a06HEqLg6Vjj41tFXpG_2iMGEw8kKS4X=B7EuW3vYZ+2A@mail.gmail.com>
Subject: Re: [PATCH 9/9] nds32: Fix the allmodconfig build. To make sure
 CONFIG_CPU_LITTLE_ENDIAN is default y
To: Greentime Hu <green.hu@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>,
        Guenter Roeck <private@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 3:18 PM, Greentime Hu <green.hu@gmail.com> wrote:
> This way we can build kernel with CONFIG_CPU_LITTLE_ENDIAN=y and allmodconfig
> will be available.
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  arch/nds32/Kconfig.cpu | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
> index ba44cc539da9..b8c8984d1456 100644
> --- a/arch/nds32/Kconfig.cpu
> +++ b/arch/nds32/Kconfig.cpu
> @@ -1,10 +1,11 @@
>  comment "Processor Features"
>
>  config CPU_BIG_ENDIAN
> -       bool "Big endian"
> +       def_bool !CPU_LITTLE_ENDIAN
>
>  config CPU_LITTLE_ENDIAN
> -        def_bool !CPU_BIG_ENDIAN
> +       bool "Little endian"
> +       default y

Can you still build 'allnoconfig' after this? It will default to big-endian now,
and I'm not sure if this works with an nds32le toolchain.

On other architectures, we pass -mlittle-endian/-mbig-endian to the
compiler to force it into whichever mode the kernel is configured for,
but you don't seem to do that (or your gcc can't do it maybe).

     Arnd
