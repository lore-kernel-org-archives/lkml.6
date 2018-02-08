Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeBHP6Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:58:24 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44664 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeBHP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:58:23 -0500
X-Google-Smtp-Source: AH8x225A8ktT9BbUHl3QDCmC+ipKe1B+LMNgDl6sQpSd27ciQ+vDwXUTCy6JkTARmuAd1O6/KOr/HM3OiPgAKcoZ5jQ=
MIME-Version: 1.0
In-Reply-To: <20180118201348.18053-1-clabbe.montjoie@gmail.com>
References: <20180118201348.18053-1-clabbe.montjoie@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 8 Feb 2018 16:58:22 +0100
Message-ID: <CANiq72k4CqzAAOKcK0c4uGWPNxeztDn733+1cphzM7zOiz+N_Q@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: img-ascii-lcd: fix typo on select SYSCON/MFD_SYSCON
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, paul.burton@mips.com,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2018 at 9:13 PM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> img-ascii-lcd select un-existing SYSCON kconfig name.
> This patch fix this error by using the correct MFD_SYSCON kconfig name.
>

CC'ing Paul & Ralf in case they want to ack.

The mistake seems to be in the tree since the addition of the driver
in 0cad855fbd08 ("auxdisplay: img-ascii-lcd: driver for simple ASCII
LCD displays").

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Thanks,
Miguel

> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/auxdisplay/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 2c2ed9cf8796..d9ab60ed6c9b 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -138,7 +138,7 @@ config IMG_ASCII_LCD
>         tristate "Imagination Technologies ASCII LCD Display"
>         depends on HAS_IOMEM
>         default y if MIPS_MALTA || MIPS_SEAD3
> -       select SYSCON
> +       select MFD_SYSCON
>         help
>           Enable this to support the simple ASCII LCD displays found on
>           development boards such as the MIPS Boston, MIPS Malta & MIPS SEAD3
> --
> 2.13.6
>
