Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EFEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1B22145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHeKcIq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbeLQPu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:50:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32889 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLQPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:50:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so14594810qtp.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ldKOKjb5iGrBm6OqHWNoW9m68c3V5xn91+9CTYx+mk=;
        b=aHeKcIq7VPNXyjTLeKIdorgNe+9BrilQdhhf26pCMEjqL6trVZjSVLF8Itrsc//cA+
         N9aNbUTRH5dwplKd+Z4EduzA9glnvq3kXMKyhcZpenoUqCnHjV/us1nttT9ofchd+zUn
         euxcgXRYxiC7or4oyI3T9wx9xm0KYUgizeBxXHCq66XsEFYB1z+Tm1vM7fdWR77yc2F0
         MFEqY6oWhrrU6Kn+r0bUm1Hd0zZdRtzXIeAgfqfY1hcI6jGvwb0YEiWKPwDfHACcLoaG
         OHhlXjE39tExdteEhRaKEjoSrxQkErgF0KX0WS7x6irzuAaf5bIIVC6ElHdAIcVR0R8E
         xscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ldKOKjb5iGrBm6OqHWNoW9m68c3V5xn91+9CTYx+mk=;
        b=PyIds3I+h1JH8H8qqt5UImVaIECwiNx75aFwOKCFjnu9cJjrTQb+gnhZoedET3YrV3
         gM7j3sOAfNoTE6Ev7SHTxYAdm3tJeU0jphEg0mEg7gk6/YBGpbHzr7Y4unfk+ptwL7Yd
         uUizhk/JSMAqgnGZcaIrUdG5ucaWAMs9okJKmbPo3HPvTod3tsau28w/LeoUSHDWiy7t
         KVBLE+AAZcgxLuLmwoqQ2+DmF8+l3VOI5lf28ij7eXK7auNLop4AJkgCMC/BMAih5Q4O
         ioolPRb7jFAaM09M/vFoNsCdhaTQGsTohWyaNuoSHQ2p8vc8GzYgm0QaMTZkH8R9Nphw
         kyjg==
X-Gm-Message-State: AA+aEWYPcNL8jansDzdKXB9aljginEhsLzCrhKQdZHGY+krESsibOq0j
        zW0j5uuknyKmQ6NewQf8f84koh87cedjqfmT/CE=
X-Google-Smtp-Source: AFSGD/UuFFrldGZt3PUrcxSZzMC/SAM4hidBq3Ir6X0uLiDNWBI86QiYoAO6k8aW1HeFVFxXlFuiKrfEEIQR0nxwT34=
X-Received: by 2002:a0c:9aca:: with SMTP id k10mr13839239qvf.185.1545061825322;
 Mon, 17 Dec 2018 07:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com> <20181215001843.62404-2-ncrews@google.com>
In-Reply-To: <20181215001843.62404-2-ncrews@google.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 17 Dec 2018 16:50:14 +0100
Message-ID: <CAFqH_53RaC8YKbfPYusGYb+qydP5N+BD7r23+pyrZdnHQbDxSg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] CHROMIUM: cros_ec: Remove cros_ec dependency in lpc_mec
To:     Nick Crews <ncrews@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@google.com>,
        Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Many thanks for sending this upstream. Adding Guenter as also might be
interested and some minor comments below.

Missatge de Nick Crews <ncrews@google.com> del dia ds., 15 de des.
2018 a les 1:21:
>
> From: Duncan Laurie <dlaurie@google.com>
>
> In order to allow this code to be re-used, remove the dependency
> on the rest of the cros_ec code from the cros_ec_lpc_mec functions.
>
> Instead of using a hardcoded register base address of 0x800 have
> this be passed in to cros_ec_lpc_mec_init().  The existing cros_ec
> use case now passes in the 0x800 base address this way.
>
> Signed-off-by: Duncan Laurie <dlaurie@google.com>
> Signed-off-by: Nick Crews <ncrews@google.com>
> ---

For this patch and the rest of this series remove the CHROMIUM tag
from the subject. Use the format 'platform/chrome: cros_ec: ...'

>
>  drivers/platform/chrome/cros_ec_lpc_mec.c | 54 +++++++++++++++++++----
>  drivers/platform/chrome/cros_ec_lpc_mec.h | 45 +++++++++++--------
>  drivers/platform/chrome/cros_ec_lpc_reg.c | 43 +++++-------------
>  3 files changed, 85 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
> index c4edfa83e493..18bd9f82be6c 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_mec.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
> @@ -24,6 +24,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/mfd/cros_ec_commands.h>
> +#include <linux/mfd/cros_ec_lpc_mec.h>

This file does not exist, you'll get a build error with only this
patch applied. I think the file is already included.

>  #include <linux/mutex.h>
>  #include <linux/types.h>
>
> @@ -34,6 +35,7 @@
>   * EC mutex because memmap data may be accessed without it being held.
>   */
>  static struct mutex io_mutex;
> +static u16 mec_emi_base, mec_emi_end;
>
>  /*
>   * cros_ec_lpc_mec_emi_write_address
> @@ -46,10 +48,39 @@ static struct mutex io_mutex;
>  static void cros_ec_lpc_mec_emi_write_address(u16 addr,
>                         enum cros_ec_lpc_mec_emi_access_mode access_type)
>  {
> -       /* Address relative to start of EMI range */
> -       addr -= MEC_EMI_RANGE_START;
> -       outb((addr & 0xfc) | access_type, MEC_EMI_EC_ADDRESS_B0);
> -       outb((addr >> 8) & 0x7f, MEC_EMI_EC_ADDRESS_B1);
> +       outb((addr & 0xfc) | access_type, MEC_EMI_EC_ADDRESS_B0(mec_emi_base));
> +       outb((addr >> 8) & 0x7f, MEC_EMI_EC_ADDRESS_B1(mec_emi_base));
> +}
> +
> +/*
> + * cros_ec_lpc_mec_in_range
> + *

For this and all other functions that you are documenting below use
the standard kernel-doc format, please. See:
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

> + * Determine if requested addresses are in MEC EMI range.
> + *
> + * @offset:      Address offset
> + * @length: Number of bytes to check
> + *
> + * @return 1 if in range, 0 if not, and -1 if there is an error
> + *         such as the mec range not being initialized
> + */

Can't you use 0 if it's ok and -errno if it fails here? Will you
handle 0 and -1 errors in a different way?

> +int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
> +{
> +       if (length == 0)
> +               return -1;
> +
> +       if (WARN_ON(mec_emi_base == 0 || mec_emi_end == 0))
> +               return -1;
> +
> +       if (offset >= mec_emi_base && offset < mec_emi_end) {
> +               if (WARN_ON(offset + length - 1 <= mec_emi_end))
> +                       return -1;
> +               return 1;
> +       }
> +
> +       if (WARN_ON(offset + length > mec_emi_base && offset < mec_emi_end))
> +               return -1;
> +
> +       return 0;
>  }
>
>  /*
> @@ -71,6 +102,11 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
>         u8 sum = 0;
>         enum cros_ec_lpc_mec_emi_access_mode access, new_access;
>
> +       /* Return checksum of 0 if window is not initialized */
> +       WARN_ON(mec_emi_base == 0 || mec_emi_end == 0);
> +       if (mec_emi_base == 0 || mec_emi_end == 0)
> +               return 0;
> +
>         /*
>          * Long access cannot be used on misaligned data since reading B0 loads
>          * the data register and writing B3 flushes.
> @@ -86,9 +122,9 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
>         cros_ec_lpc_mec_emi_write_address(offset, access);
>
>         /* Skip bytes in case of misaligned offset */
> -       io_addr = MEC_EMI_EC_DATA_B0 + (offset & 0x3);
> +       io_addr = MEC_EMI_EC_DATA_B0(mec_emi_base) + (offset & 0x3);
>         while (i < length) {
> -               while (io_addr <= MEC_EMI_EC_DATA_B3) {
> +               while (io_addr <= MEC_EMI_EC_DATA_B3(mec_emi_base)) {
>                         if (io_type == MEC_IO_READ)
>                                 buf[i] = inb(io_addr++);
>                         else
> @@ -118,7 +154,7 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
>                 }
>
>                 /* Access [B0, B3] on each loop pass */
> -               io_addr = MEC_EMI_EC_DATA_B0;
> +               io_addr = MEC_EMI_EC_DATA_B0(mec_emi_base);
>         }
>
>  done:
> @@ -128,9 +164,11 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
>  }
>  EXPORT_SYMBOL(cros_ec_lpc_io_bytes_mec);
>
> -void cros_ec_lpc_mec_init(void)
> +void cros_ec_lpc_mec_init(unsigned int base, unsigned int end)
>  {
>         mutex_init(&io_mutex);
> +       mec_emi_base = base;
> +       mec_emi_end = end;
>  }
>  EXPORT_SYMBOL(cros_ec_lpc_mec_init);
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.h b/drivers/platform/chrome/cros_ec_lpc_mec.h
> index 105068c0e919..a81cc6a8b621 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_mec.h
> +++ b/drivers/platform/chrome/cros_ec_lpc_mec.h
> @@ -24,8 +24,6 @@
>  #ifndef __CROS_EC_LPC_MEC_H
>  #define __CROS_EC_LPC_MEC_H
>
> -#include <linux/mfd/cros_ec_commands.h>
> -
>  enum cros_ec_lpc_mec_emi_access_mode {
>         /* 8-bit access */
>         ACCESS_TYPE_BYTE = 0x0,
> @@ -45,35 +43,46 @@ enum cros_ec_lpc_mec_io_type {
>         MEC_IO_WRITE,
>  };
>
> -/* Access IO ranges 0x800 thru 0x9ff using EMI interface instead of LPC */
> -#define MEC_EMI_RANGE_START EC_HOST_CMD_REGION0
> -#define MEC_EMI_RANGE_END   (EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE)
> -
>  /* EMI registers are relative to base */
> -#define MEC_EMI_BASE 0x800
> -#define MEC_EMI_HOST_TO_EC (MEC_EMI_BASE + 0)
> -#define MEC_EMI_EC_TO_HOST (MEC_EMI_BASE + 1)
> -#define MEC_EMI_EC_ADDRESS_B0 (MEC_EMI_BASE + 2)
> -#define MEC_EMI_EC_ADDRESS_B1 (MEC_EMI_BASE + 3)
> -#define MEC_EMI_EC_DATA_B0 (MEC_EMI_BASE + 4)
> -#define MEC_EMI_EC_DATA_B1 (MEC_EMI_BASE + 5)
> -#define MEC_EMI_EC_DATA_B2 (MEC_EMI_BASE + 6)
> -#define MEC_EMI_EC_DATA_B3 (MEC_EMI_BASE + 7)
> +#define MEC_EMI_HOST_TO_EC(MEC_EMI_BASE)       (MEC_EMI_BASE + 0)
> +#define MEC_EMI_EC_TO_HOST(MEC_EMI_BASE)       (MEC_EMI_BASE + 1)
> +#define MEC_EMI_EC_ADDRESS_B0(MEC_EMI_BASE)    (MEC_EMI_BASE + 2)
> +#define MEC_EMI_EC_ADDRESS_B1(MEC_EMI_BASE)    (MEC_EMI_BASE + 3)
> +#define MEC_EMI_EC_DATA_B0(MEC_EMI_BASE)       (MEC_EMI_BASE + 4)
> +#define MEC_EMI_EC_DATA_B1(MEC_EMI_BASE)       (MEC_EMI_BASE + 5)
> +#define MEC_EMI_EC_DATA_B2(MEC_EMI_BASE)       (MEC_EMI_BASE + 6)
> +#define MEC_EMI_EC_DATA_B3(MEC_EMI_BASE)       (MEC_EMI_BASE + 7)
>
> -/*
> +/**
>   * cros_ec_lpc_mec_init
>   *
>   * Initialize MEC I/O.
> + *
> + * @base: MEC EMI Base address
> + * @end:  MEC EMI End address

Since you're touching this function, please fix the documentation
format also. Thanks :)

>   */
> -void cros_ec_lpc_mec_init(void);
> +void cros_ec_lpc_mec_init(unsigned int base, unsigned int end);
>
> -/*
> +/**

Unrelated change.

>   * cros_ec_lpc_mec_destroy
>   *
>   * Cleanup MEC I/O.
>   */
>  void cros_ec_lpc_mec_destroy(void);
>
> +/**
> + * cros_ec_lpc_mec_in_range
> + *
> + * Determine if requested addresses are in MEC EMI range.
> + *
> + * @offset: Address offset
> + * @length: Number of bytes to check
> + *
> + * @return 1 if in range, 0 if not, and -1 if there is an error
> + *         such as the mec range not being initialized
> + */
> +int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length);
> +
>  /**
>   * cros_ec_lpc_io_bytes_mec - Read / write bytes to MEC EMI port
>   *
> diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
> index fc23d535c404..4cba259b5b1e 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_reg.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
> @@ -59,51 +59,32 @@ static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
>
>  u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
>  {
> -       if (length == 0)
> -               return 0;
> -
> -       /* Access desired range through EMI interface */
> -       if (offset >= MEC_EMI_RANGE_START && offset <= MEC_EMI_RANGE_END) {
> -               /* Ensure we don't straddle EMI region */
> -               if (WARN_ON(offset + length - 1 > MEC_EMI_RANGE_END))
> -                       return 0;
> +       int in_range = cros_ec_lpc_mec_in_range(offset, length);
>
> -               return cros_ec_lpc_io_bytes_mec(MEC_IO_READ, offset, length,
> -                                               dest);
> -       }
> -
> -       if (WARN_ON(offset + length > MEC_EMI_RANGE_START &&
> -                   offset < MEC_EMI_RANGE_START))
> +       if (in_range < 0)
>                 return 0;
>
> -       return lpc_read_bytes(offset, length, dest);
> +       return in_range ?
> +               cros_ec_lpc_io_bytes_mec(MEC_IO_READ, offset, length, dest) :
> +               lpc_read_bytes(offset, length, dest);
>  }
>
>  u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
>  {
> -       if (length == 0)
> -               return 0;
> -
> -       /* Access desired range through EMI interface */
> -       if (offset >= MEC_EMI_RANGE_START && offset <= MEC_EMI_RANGE_END) {
> -               /* Ensure we don't straddle EMI region */
> -               if (WARN_ON(offset + length - 1 > MEC_EMI_RANGE_END))
> -                       return 0;
> +       int in_range = cros_ec_lpc_mec_in_range(offset, length);
>
> -               return cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, offset, length,
> -                                               msg);
> -       }
> -
> -       if (WARN_ON(offset + length > MEC_EMI_RANGE_START &&
> -                   offset < MEC_EMI_RANGE_START))
> +       if (in_range < 0)
>                 return 0;
>
> -       return lpc_write_bytes(offset, length, msg);
> +       return in_range ?
> +               cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, offset, length, msg) :
> +               lpc_write_bytes(offset, length, msg);
>  }
>
>  void cros_ec_lpc_reg_init(void)
>  {
> -       cros_ec_lpc_mec_init();
> +       cros_ec_lpc_mec_init(EC_HOST_CMD_REGION0,
> +                            EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE);
>  }
>
>  void cros_ec_lpc_reg_destroy(void)
> --
> 2.20.0.405.gbc1bbc6f85-goog
>

Thanks,
 Enric
