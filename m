Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27FDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829DD217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XykRR9YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbfAILOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:14:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37826 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbfAILOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:14:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so3175541pgb.4;
        Wed, 09 Jan 2019 03:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/eNZY9q6gMJBzLpRRrOPLNavhG3GG/u1nKZ8Oan4i3M=;
        b=XykRR9YQuf7yi/o+TBvhRT+b9CRbZgWn4kboppAUocs8xJDaXIRe5pWmWK0+5PpKqq
         +oQ2cbeDA3SH9Z6IwTBGanbn3wVNxPPerzWYapCdngt4i/M0vQ9HheXLD4f9f8GdKfmk
         NcRazBf6Vk2gV3g1Ou+LE0+6lG1RIGMvwyk/Z5t70J11CkhucOBD+ipSPclhdRZxigc5
         Tx1YgTHgng19FKpowh/Do1WDCgZE6YOEgDNRuILAXf8nKbPTZN6KL4RWvzm+46e0AV9T
         lYXKFdxsj45yjdJoD0FGDKt/huVNg6FbkbZ61Oc4DICNWnX+Zt3elswR2KPAtnGg/GOL
         O2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/eNZY9q6gMJBzLpRRrOPLNavhG3GG/u1nKZ8Oan4i3M=;
        b=UDfOWdqjyY6AyfeNkYQH1Exvsw5gt90x/1cGYZ/l7b0JO78dx9jn5GrgqGanfEbCju
         SkPx3BOHjp/3j2VuoKyU0utoAOh5eyUZBxqafOC81m6oO9vR8LAEGZGxrJ8na2tsSZ4y
         qHznsRMlvGmkwNKqMkHFxhTGAXpxtraKCBCHXzHlp20neFAOXFbJGEbiLMrBr/nXV9aY
         vesQLkLAMLWEqwjlwOOW6vMnStmQlrFjuG9ca3M37L5udXYcyezHpfmq8zjXyYR+BKs6
         tkWqKoDVp7vg/AtZWCSMC5/pUG9FUdY1WSQg4sfPTpQHvOZKJ0XMQ5p1lZUUBLcGGeEg
         1FWA==
X-Gm-Message-State: AJcUuke1CeQaxpW3PMlk/YVg7NUOIiNseGajx/HZ0/Gm5zUMjkxpGw3H
        b4l0NaKeXVpZs6h2IHnmoTPvgXzYJPttcbKpZR8=
X-Google-Smtp-Source: ALg8bN6Ii0qL+nFHo00LYgP8+gc2FFonpfKji2qQUiXyg/1u3ZeLEza3v51nAoaZOOwiAcmerM5QdD/LF/fdajxu8TU=
X-Received: by 2002:a63:f615:: with SMTP id m21mr5098236pgh.428.1547032459101;
 Wed, 09 Jan 2019 03:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20190108175818.705110-1-lkundrak@v3.sk> <20190108175818.705110-8-lkundrak@v3.sk>
In-Reply-To: <20190108175818.705110-8-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Jan 2019 13:14:08 +0200
Message-ID: <CAHp75Vf=B4TxZ5ETXaezQAm3HGzQ6cNkApwxq+3_fw92phumkw@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] Platform: OLPC: Use BIT() and GENMASK() for
 event masks
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 7:58 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Just a cosmetic tidy-up.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>
> ---
> Changes since v1:
> - This patch was added to the set.
>
>  include/linux/olpc-ec.h | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/olpc-ec.h b/include/linux/olpc-ec.h
> index e28f72416a57..c4602364e909 100644
> --- a/include/linux/olpc-ec.h
> +++ b/include/linux/olpc-ec.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_OLPC_EC_H
>  #define _LINUX_OLPC_EC_H
>
> +#include <linux/bits.h>
> +
>  /* XO-1 EC commands */
>  #define EC_FIRMWARE_REV                        0x08
>  #define EC_WRITE_SCI_MASK              0x1b
> @@ -17,17 +19,16 @@
>  #define EC_EXT_SCI_QUERY               0x85
>
>  /* SCI source values */
> -#define EC_SCI_SRC_EMPTY        0x00
> -#define EC_SCI_SRC_GAME         0x01
> -#define EC_SCI_SRC_BATTERY      0x02
> -#define EC_SCI_SRC_BATSOC       0x04
> -#define EC_SCI_SRC_BATERR       0x08
> -#define EC_SCI_SRC_EBOOK        0x10    /* XO-1 only */
> -#define EC_SCI_SRC_WLAN         0x20    /* XO-1 only */
> -#define EC_SCI_SRC_ACPWR        0x40
> -#define EC_SCI_SRC_BATCRIT      0x80
> -#define EC_SCI_SRC_GPWAKE       0x100   /* XO-1.5 only */
> -#define EC_SCI_SRC_ALL          0x1FF
> +#define EC_SCI_SRC_GAME         BIT(0)
> +#define EC_SCI_SRC_BATTERY      BIT(1)
> +#define EC_SCI_SRC_BATSOC       BIT(2)
> +#define EC_SCI_SRC_BATERR       BIT(3)
> +#define EC_SCI_SRC_EBOOK        BIT(4)    /* XO-1 only */
> +#define EC_SCI_SRC_WLAN         BIT(5)    /* XO-1 only */
> +#define EC_SCI_SRC_ACPWR        BIT(6)
> +#define EC_SCI_SRC_BATCRIT      BIT(7)
> +#define EC_SCI_SRC_GPWAKE       BIT(8)   /* XO-1.5 only */
> +#define EC_SCI_SRC_ALL          GENMASK(8, 0)
>
>  struct platform_device;
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
