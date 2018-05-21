Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeEULgq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:36:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53772 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeEULgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:36:35 -0400
X-Google-Smtp-Source: AB8JxZqPo427+SQOk+3OMca8OI0K9yu8G4N8if3RmUXUgnTK+t9sId/1ZNNxUGvvJX5mfkD65ernIgzE3/velQwugiQ=
MIME-Version: 1.0
In-Reply-To: <20180516192022.23541-1-malat@debian.org>
References: <20180516192022.23541-1-malat@debian.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 21 May 2018 13:36:34 +0200
Message-ID: <CAPDyKFr2Bf_Ngtwp5pPU8Q956Ok4Ut8HLDsNxFvk-iU445Huvw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: propagate correct returned value in mmc_rpmb_ioctl
To: Mathieu Malaterre <malat@debian.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4LBaoOV000341

On 16 May 2018 at 21:20, Mathieu Malaterre <malat@debian.org> wrote:
> In commit 97548575bef3 ("mmc: block: Convert RPMB to a character device") a
> new function `mmc_rpmb_ioctl` was added. The final return is simply
> returning a value of `0` instead of propagating the correct return code.
>
> Discovered during a compilation with W=1, silence the following gcc warning
>
>   drivers/mmc/core/block.c:2470:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Thanks, applied for fixes and by adding a stable tag!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 9e923cd1d80e..38a7586b00cc 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2485,7 +2485,7 @@ static long mmc_rpmb_ioctl(struct file *filp, unsigned int cmd,
>                 break;
>         }
>
> -       return 0;
> +       return ret;
>  }
>
>  #ifdef CONFIG_COMPAT
> --
> 2.11.0
>
