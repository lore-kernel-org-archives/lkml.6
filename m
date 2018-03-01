Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519907029; cv=none;
        d=google.com; s=arc-20160816;
        b=SX2G8+UXeLrfqy0wWUwQ+zd+22VjLsZrZ5fg4F1u7d1Z7PM0XxQnOUaQzZH06Oj0lY
         cGhvUfSqgCgvwGhD4DPnlBZqpELJ1kLXgoyNV/VgaOxn3jS9bqYnr3/onFIxcWgX/idD
         ms7H9QoLoqSTAjlQRtWkrOAtBZxfpy/xn0BJR3/qEAsbPOWF7OqWybQgWT+Oa5XWMcl+
         yeUVVCkPJylDUIRx9mlV489aYzfa6uPllYd6/2SF60UXLk/yAlNKk6VvPTp62n+91ngH
         reM8GGc6dFPg0rMnFCMEgentHOTCFb7iLMMKnsIEJ2zTsuhT02LVfrn1XdZw6Ca4/rnx
         G5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=RKgZ8FN9osT9NoHrByU3zv1wMiFbT/jhBUZSRVEuoF4=;
        b=mRTf3xqd+7hCPwzA8TJO1537L6T/GtcF/KrM6+qcR9DRB+XElILNX6gizhbNVbpKzB
         DK3qbJ26NQ6qA3r52Bq6FmslMjI0n0NB1Vscg9hUPIugTUvUUhcT5/4DzPZZRqXXZjjM
         hZEhGNwEQKyeOr20nMc7e05l/TGYeFuoguYUJKU9Zsij7y29qO3XVFkQdjCrGsvfYnMg
         W49Rv/zumv9AVExPbv1Zu+Tp4MkaEuPODs/NBh7du9Na5AqM4F9AcvQ7xQT9M1oL4uIy
         TqzY1Phxdm0F55z7/5rv9JNrj6h95u2prZqxKPYwCxZaC27M9IjS8rCmwnAJq0aHLpFf
         l0sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H255byv3;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H255byv3;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtmVPmgE0aWhLx3CdGZNyYtBtOHGXsf+o6XgZ6OVLbFpIKydj0WnfyGkGLXkSkx9RPwjv2GFcy2lGy429L35PI=
MIME-Version: 1.0
In-Reply-To: <20180301105641.1650792-2-arnd@arndb.de>
References: <20180301105641.1650792-1-arnd@arndb.de> <20180301105641.1650792-2-arnd@arndb.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 14:23:48 +0200
Message-ID: <CAHp75VdXzOKs+CAWEgTbY=K8qfPwqT_e6s6OetRbb3584FkX8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: rts5208: rename SG_END macro
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Anshuman Khandual <khandual@linux.vnet.ibm.com>, Jens Axboe <axboe@kernel.dk>,
	devel@driverdev.osuosl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593732643242216068?=
X-GMAIL-MSGID: =?utf-8?q?1593738033343050236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 12:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> A change to the generic scatterlist code caused a conflict with
> the rtsx card reader driver:
>
> In file included from drivers/staging/rts5208/rtsx.h:180,
>                  from drivers/staging/rts5208/rtsx.c:28:
> drivers/staging/rts5208/rtsx_chip.h:343: error: "SG_END" redefined [-Werror]
>
> This changes one instance of the driver to prefix SG_END and
> related constants.
>

Thanks, Arnd. This is right thing to do by my opinion.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 723fbf563a6a ("lib/scatterlist: Add SG_CHAIN and SG_END macros for LSB encodings")
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/rts5208/rtsx_chip.h      | 12 ++++++------
>  drivers/staging/rts5208/rtsx_transport.c | 10 +++++-----
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/staging/rts5208/rtsx_chip.h b/drivers/staging/rts5208/rtsx_chip.h
> index 4f6e3c1c4621..8a8cd5d3cf7e 100644
> --- a/drivers/staging/rts5208/rtsx_chip.h
> +++ b/drivers/staging/rts5208/rtsx_chip.h
> @@ -339,13 +339,13 @@ struct sense_data_t {
>  #define CHK_BIT(data, idx)     ((data) & (1 << (idx)))
>
>  /* SG descriptor */
> -#define SG_INT                 0x04
> -#define SG_END                 0x02
> -#define SG_VALID               0x01
> +#define RTSX_SG_INT            0x04
> +#define RTSX_SG_END            0x02
> +#define RTSX_SG_VALID          0x01
>
> -#define SG_NO_OP               0x00
> -#define SG_TRANS_DATA          (0x02 << 4)
> -#define SG_LINK_DESC           (0x03 << 4)
> +#define RTSX_SG_NO_OP          0x00
> +#define RTSX_SG_TRANS_DATA     (0x02 << 4)
> +#define RTSX_SG_LINK_DESC      (0x03 << 4)
>
>  struct rtsx_chip;
>
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> index 8b57e17ee6d3..716cce2bd7f0 100644
> --- a/drivers/staging/rts5208/rtsx_transport.c
> +++ b/drivers/staging/rts5208/rtsx_transport.c
> @@ -308,7 +308,7 @@ static inline void rtsx_add_sg_tbl(
>         do {
>                 if (len > 0x80000) {
>                         temp_len = 0x80000;
> -                       temp_opt = option & (~SG_END);
> +                       temp_opt = option & (~RTSX_SG_END);
>                 } else {
>                         temp_len = len;
>                         temp_opt = option;
> @@ -407,9 +407,9 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
>                         *index = *index + 1;
>                 }
>                 if ((i == (sg_cnt - 1)) || !resid)
> -                       option = SG_VALID | SG_END | SG_TRANS_DATA;
> +                       option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
>                 else
> -                       option = SG_VALID | SG_TRANS_DATA;
> +                       option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
>
>                 rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
>
> @@ -555,9 +555,9 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
>                                 (unsigned int)addr, len);
>
>                         if (j == (sg_cnt - 1))
> -                               option = SG_VALID | SG_END | SG_TRANS_DATA;
> +                               option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
>                         else
> -                               option = SG_VALID | SG_TRANS_DATA;
> +                               option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
>
>                         rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
>
> --
> 2.9.0
>



-- 
With Best Regards,
Andy Shevchenko
