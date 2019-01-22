Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDA0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6CE20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGjaf8ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfAVJGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:06:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36164 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfAVJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:06:01 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so26746360qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 01:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHgTGvDQNLneHl1sLVz/iOlBo3Y3FfgIUDXXLo/M9gc=;
        b=EGjaf8ZKaj1A32LkJOTIEQ1p1u8U44kik2dunwdFxDbcHBgUm9BHjv5Sf00RBNe9HE
         JNtnv6sctBuRKWlSO7/rmgRBzzJy0NIKBW2th8HEDZT1aWthPVaVM6E6d4xuvheE+W5+
         j4j6RNQ9kq/GaGYzmM8JYtfhZ/Y7QMY9sbu+HXSNWhAUA8dkCLPNUzIEsCAt8+5BN5am
         pXDD9I5ygBv14QYKB2fFFfVksYqBfTCoaCQAi631pip8Kn9hrakngmg2jQQNpNUiIus9
         FPmVRcw5cIfzQQE7SHoLbGSJd8P192ZjB1AyiPWG5o9oWvZ86pP8V1PTJcIKVWYOfm4C
         ONww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHgTGvDQNLneHl1sLVz/iOlBo3Y3FfgIUDXXLo/M9gc=;
        b=Mh9z09lko2FiXQzHMyx9CnHGN3rf/iCiz/fvphXG9QjV6xYVHbUpU7SNg4OhBaF6D1
         pJSfy9NQ6OsnsnqHqTM0dY9kt0ZOrjx3Wp+YGD7RFgFtSV0S/03cXDaXkMgDRYMaOy/Y
         Y7Oxwhw8vkqE3mbxl/YDmWh7V+S3zGAyrbWvz75XoqdB6FPm3njVnPfaQ2F9jENxjFA9
         QLJoZmUyXwW7nbSBZ3nDXcU+lk9E/YKIKxEs6onCFjO8M7qdMrT0ixzMMfJAUMonggD6
         5bN6NkPep2rt1lpg+Fz27sTBA/AM9pXPjZXHeMmU5XByYu5JXjopojnV6E6tXt1B5nPO
         5TBw==
X-Gm-Message-State: AJcUukfGcFlCkvEoZxQjwTjx3j8X9/ziznPn1quGSXNhLpJJAetRfPs3
        eAUoC2wJ2NoxrTArQea9HxeffoWG72bADIBQLvU=
X-Google-Smtp-Source: ALg8bN7kD5l0SXurfgg8qBnYP3/Ta3Muohy6EZDNJ4VeNnJs+HcbSqOUHDpOWDp8qM4dJUPoEnBi9dQGO9z3+gekWPI=
X-Received: by 2002:a0c:a8e3:: with SMTP id h35mr28201215qvc.92.1548147960017;
 Tue, 22 Jan 2019 01:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20190119001422.48186-1-ncrews@chromium.org> <20190119001422.48186-2-ncrews@chromium.org>
In-Reply-To: <20190119001422.48186-2-ncrews@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 22 Jan 2019 10:05:48 +0100
Message-ID: <CAFqH_52qMBjtFLL6dOs4K4P-bMidERzBZaXFrLLyaBWQkLW_Mg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] platform/chrome: Remove cros_ec dependency in lpc_mec
To:     Nick Crews <ncrews@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Simon Glass <sjg@chromium.org>,
        Daniel Kurtz <djkurtz@google.com>, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Nick Crews <ncrews@chromium.org> del dia ds., 19 de gen.
2019 a les 1:17:
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
> There are some error checks that happen in cros_ec_lpc_mec_in_range()
> that probably shouldn't be there, as they are checking kernel-space
> callers and not user-space input. However, we'll just do the refactor in
> this patch, and in a future patch might remove this error checking and
> fix all the instances of code that calls this.
>
> There's a similar problem in cros_ec_lpc_read_bytes(), where we return a
> checksum, but on error just return 0. This should probably be changed so
> that it returns int, but we don't want to have to mess with all the
> calling code for this fix. Maybe we'll come back through later and fix
> this.
>
> Signed-off-by: Duncan Laurie <dlaurie@google.com>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>
> Changes in v3:
> - Change <= to >= in mec_in_range()
> - Add " - EC_HOST_CMD_REGION0" to offset arg for io_bytes_mec()
>
> Changes in v2:
> - Fixed kernel-doc comments
> - Fixed include of linux/mfd/cros_ec_lpc_mec.h
> - cros_ec_lpc_mec_in_range() returns -EINVAL on error
> - Added parens around macro variables
>
>  drivers/platform/chrome/cros_ec_lpc_mec.c | 52 +++++++++++++++++++----
>  drivers/platform/chrome/cros_ec_lpc_mec.h | 43 ++++++++++---------
>  drivers/platform/chrome/cros_ec_lpc_reg.c | 47 +++++++-------------
>  3 files changed, 83 insertions(+), 59 deletions(-)
>

For my own reference:
  Acked-for-chrome-platform-by: Enric Balletbo i Serra
<enric.balletbo@collabora.com>

> diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
> index c4edfa83e493..782e238a8d4e 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_mec.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
> @@ -23,7 +23,6 @@
>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> -#include <linux/mfd/cros_ec_commands.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
>
> @@ -34,6 +33,7 @@
>   * EC mutex because memmap data may be accessed without it being held.
>   */
>  static struct mutex io_mutex;
> +static u16 mec_emi_base, mec_emi_end;
>
>  /*
>   * cros_ec_lpc_mec_emi_write_address
> @@ -46,10 +46,37 @@ static struct mutex io_mutex;
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
> +/**
> + * cros_ec_lpc_mec_in_range() - Determine if addresses are in MEC EMI range.
> + *
> + * @offset: Address offset
> + * @length: Number of bytes to check
> + *
> + * Return: 1 if in range, 0 if not, and -EINVAL on failure
> + *         such as the mec range not being initialized
> + */
> +int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
> +{
> +       if (length == 0)
> +               return -EINVAL;
> +
> +       if (WARN_ON(mec_emi_base == 0 || mec_emi_end == 0))
> +               return -EINVAL;
> +
> +       if (offset >= mec_emi_base && offset < mec_emi_end) {
> +               if (WARN_ON(offset + length - 1 >= mec_emi_end))
> +                       return -EINVAL;
> +               return 1;
> +       }
> +
> +       if (WARN_ON(offset + length > mec_emi_base && offset < mec_emi_end))
> +               return -EINVAL;
> +
> +       return 0;
>  }
>
>  /*
> @@ -71,6 +98,11 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
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
> @@ -86,9 +118,9 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
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
> @@ -118,7 +150,7 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
>                 }
>
>                 /* Access [B0, B3] on each loop pass */
> -               io_addr = MEC_EMI_EC_DATA_B0;
> +               io_addr = MEC_EMI_EC_DATA_B0(mec_emi_base);
>         }
>
>  done:
> @@ -128,9 +160,11 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
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
> index 105068c0e919..896fffd174b3 100644
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
> @@ -45,27 +43,23 @@ enum cros_ec_lpc_mec_io_type {
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
> +#define MEC_EMI_HOST_TO_EC(MEC_EMI_BASE)       ((MEC_EMI_BASE) + 0)
> +#define MEC_EMI_EC_TO_HOST(MEC_EMI_BASE)       ((MEC_EMI_BASE) + 1)
> +#define MEC_EMI_EC_ADDRESS_B0(MEC_EMI_BASE)    ((MEC_EMI_BASE) + 2)
> +#define MEC_EMI_EC_ADDRESS_B1(MEC_EMI_BASE)    ((MEC_EMI_BASE) + 3)
> +#define MEC_EMI_EC_DATA_B0(MEC_EMI_BASE)       ((MEC_EMI_BASE) + 4)
> +#define MEC_EMI_EC_DATA_B1(MEC_EMI_BASE)       ((MEC_EMI_BASE) + 5)
> +#define MEC_EMI_EC_DATA_B2(MEC_EMI_BASE)       ((MEC_EMI_BASE) + 6)
> +#define MEC_EMI_EC_DATA_B3(MEC_EMI_BASE)       ((MEC_EMI_BASE) + 7)
>
> -/*
> - * cros_ec_lpc_mec_init
> +/**
> + * cros_ec_lpc_mec_init() - Initialize MEC I/O.
>   *
> - * Initialize MEC I/O.
> + * @base: MEC EMI Base address
> + * @end: MEC EMI End address
>   */
> -void cros_ec_lpc_mec_init(void);
> +void cros_ec_lpc_mec_init(unsigned int base, unsigned int end);
>
>  /*
>   * cros_ec_lpc_mec_destroy
> @@ -74,6 +68,17 @@ void cros_ec_lpc_mec_init(void);
>   */
>  void cros_ec_lpc_mec_destroy(void);
>
> +/**
> + * cros_ec_lpc_mec_in_range() - Determine if addresses are in MEC EMI range.
> + *
> + * @offset: Address offset
> + * @length: Number of bytes to check
> + *
> + * Return: 1 if in range, 0 if not, and -EINVAL on failure
> + *         such as the mec range not being initialized
> + */
> +int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length);
> +
>  /**
>   * cros_ec_lpc_io_bytes_mec - Read / write bytes to MEC EMI port
>   *
> diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
> index fc23d535c404..1d9f3b7ffb3e 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_reg.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
> @@ -59,51 +59,36 @@ static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
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
> +               cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
> +                                        offset - EC_HOST_CMD_REGION0,
> +                                        length, dest) :
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
> +               cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
> +                                        offset - EC_HOST_CMD_REGION0,
> +                                        length, msg) :
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
> 2.20.1.321.g9e740568ce-goog
>
