Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032918AbeBNQtY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:49:24 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43812 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032823AbeBNQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:49:19 -0500
X-Google-Smtp-Source: AH8x227wHm1kPmSDDUwYS2fM2aRW6Romsd+B2hzkfw1S44cO3wsbMKYUad6nh3cDouGsGk8vKX/oldgJX4CCnq4fYLE=
MIME-Version: 1.0
In-Reply-To: <8261d041-ccd9-c0f8-4530-a4afb43ee7ab@users.sourceforge.net>
References: <8261d041-ccd9-c0f8-4530-a4afb43ee7ab@users.sourceforge.net>
From: Dan Streetman <ddstreet@ieee.org>
Date: Wed, 14 Feb 2018 11:48:35 -0500
X-Google-Sender-Auth: eecqMj3XeARPdqrM20sEOoaE32Y
Message-ID: <CALZtONBqJ26mzfN02Zs8OjwuoZFLY0vz5BO9tRwyovXF11=SMw@mail.gmail.com>
Subject: Re: [PATCH] crypto: nx-842: Delete an error message for a failed
 memory allocation in nx842_pseries_init()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Haren Myneni <haren@us.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 11:17 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 14 Feb 2018 17:05:13 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Dan Streetman <ddstreet@ieee.org>

> ---
>  drivers/crypto/nx/nx-842-pseries.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-842-pseries.c
> index bf52cd1d7fca..66869976cfa2 100644
> --- a/drivers/crypto/nx/nx-842-pseries.c
> +++ b/drivers/crypto/nx/nx-842-pseries.c
> @@ -1105,10 +1105,9 @@ static int __init nx842_pseries_init(void)
>
>         RCU_INIT_POINTER(devdata, NULL);
>         new_devdata = kzalloc(sizeof(*new_devdata), GFP_KERNEL);
> -       if (!new_devdata) {
> -               pr_err("Could not allocate memory for device data\n");
> +       if (!new_devdata)
>                 return -ENOMEM;
> -       }
> +
>         RCU_INIT_POINTER(devdata, new_devdata);
>
>         ret = vio_register_driver(&nx842_vio_driver);
> --
> 2.16.1
>
