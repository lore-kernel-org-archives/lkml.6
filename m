Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67FEEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1830B208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7SqGi65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1830B208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935160AbeFLRCC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:02:02 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:38908 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933792AbeFLRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:01:57 -0400
Received: by mail-vk0-f67.google.com with SMTP id b77-v6so14814924vkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wiamB9695Kt3tgHnqO55jvqa3/eVhAB0n02Y16Oi5d4=;
        b=A7SqGi65yKC4FhZ4nPFcZ6bidBA5kbw9nDuTpr68NgbNnzfUsrviKJPy89BIFsZCm0
         cKnb2BGXBHirSvzFlNj33oP819kdy0+1TCxGPnkJbGSOVsb/5sx714ePwWfshy3iW3j6
         nSknnxyHpjhJpIh4NBMNYJ+r4N0enWVCiEfOq+6ZP3MxGCrqvn4ayq9jg74Ce85EpHOK
         sG0Ib1N75+RmHN0bS+jR9ct1dsswvLSa1ojeyU2vY4W4nupZG2yqp8K9vXJ800kestGM
         7MlIO8qqJKmFhHto68h/24mFqgQaAhqwm1p1hzfH4HgSjtsj1xIcv6VgoKTZTP42YpSv
         iHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wiamB9695Kt3tgHnqO55jvqa3/eVhAB0n02Y16Oi5d4=;
        b=gQhN8BxxOEB5iKVG7zmbS622v62igixr0vkO7SGCA87Q3bG+aTMcpZVmQXazCnf23v
         BPzX6DiP5BsFUTpvyoLMfhkjulaZjufmDSOO0Mwd2eJVok3FVqjm7RpZi4rhDRCUKOJw
         U1/2hsORdckZiUYpxLWmj/hkXDaMNkhiP36A9hjKPVl2UjbfaOhTzuynnVoARa4/Dvqz
         irp7mD2pWxdktE8yhWbVgi4u1lV0Lq6oO+wNPvxG65BGOi3F84ATfU/BDZ69lDRddGu+
         Q0skjwex71KmBDbziu+D2ICIs0Hwmw5JZJ/wlFatjapzj1LRmYWkX00wZeaL4knbE9HJ
         22xQ==
X-Gm-Message-State: APt69E1lCmWJR4w5ntAFEJjHEniDpQJ3spsOphtHPujQXTeS/mhHyYvI
        92BbD7GH7Ol6KtvcoB0RG759tXGCD49645AU5xBHj8xm
X-Google-Smtp-Source: ADUXVKKd9knenDlTa4QyuCiUUU/200H40DN9kK1RZuzJ4uL+6KgkLuc6Jsz4Yoi2GwBX7IJqzAsZxKnOugBNOgcDRrQ=
X-Received: by 2002:a1f:d1c5:: with SMTP id i188-v6mr807923vkg.131.1528822915446;
 Tue, 12 Jun 2018 10:01:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 10:01:54
 -0700 (PDT)
In-Reply-To: <1528432379-9605-1-git-send-email-jananis37@gmail.com>
References: <1528432379-9605-1-git-send-email-jananis37@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 20:01:54 +0300
Message-ID: <CAHp75VfKBkZ3znZn4YQPyOCrzT8aKZ0OAFTP2uErhoEgD13Z+A@mail.gmail.com>
Subject: Re: [PATCH 1/4] Staging:rtl8192e Replace function names by using
 __func__ identifier
To:     Janani Sankara Babu <jananis37@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>, Rene.Hickersberger@gmx.at,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 7:32 AM, Janani Sankara Babu <jananis37@gmail.com> wrote:
> This patch is created to solve the warning shown by checkpatch script
> Prefer using '"%s...", __func__' to using ', this function's name,
> in a string

Have you even tried to compile it?

NAK

>
> Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index c466a5e7..3c7ba33 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -127,7 +127,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
>         }
>
>  #ifdef VERBOSE_DEBUG
> -       print_hex_dump_bytes("rtllib_ADDBA(): ", DUMP_PREFIX_NONE, skb->data,
> +       print_hex_dump_bytes("%s(): ", __func__, DUMP_PREFIX_NONE, skb->data,
>                              skb->len);
>  #endif
>         return skb;
> @@ -178,7 +178,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
>         tag += 2;
>
>  #ifdef VERBOSE_DEBUG
> -       print_hex_dump_bytes("rtllib_DELBA(): ", DUMP_PREFIX_NONE, skb->data,
> +       print_hex_dump_bytes("%s(): ", __func__, DUMP_PREFIX_NONE, skb->data,
>                              skb->len);
>  #endif
>         return skb;
> @@ -243,7 +243,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
>         }
>
>  #ifdef VERBOSE_DEBUG
> -       print_hex_dump_bytes("rtllib_rx_ADDBAReq(): ", DUMP_PREFIX_NONE,
> +       print_hex_dump_bytes("%s(): ", __func__, DUMP_PREFIX_NONE,
>                              skb->data, skb->len);
>  #endif
>
> @@ -441,7 +441,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
>         }
>
>  #ifdef VERBOSE_DEBUG
> -       print_hex_dump_bytes("rtllib_rx_DELBA(): ", DUMP_PREFIX_NONE, skb->data,
> +       print_hex_dump_bytes("%s():", __func__, DUMP_PREFIX_NONE, skb->data,
>                              skb->len);
>  #endif
>         delba = (struct rtllib_hdr_3addr *)skb->data;
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
