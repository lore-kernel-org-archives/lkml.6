Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B48213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEwsT+4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B48213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeJAQgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:36:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34827 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeJAQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:36:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id r191-v6so9390054lff.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=aoxUv1amQS309vw9heAFYM23S2w200754FaqxEoKKV0=;
        b=SEwsT+4e3zDgNhWF2iBlvAd1cItsk/L4aTIh5E4rc7dkTPJmtprL4VV3FtM2HkA9XO
         Ae23U4r0IvyTVUuOrDK892WJh+tWvmZL/U7diyBYy/U+pZJlQm+3VjxD1mtJj60iucYo
         Xh3GmzkNTVk/C/n6xB2O/Pfamd0D1fWKkgMlQbGKlCDvIGPDEYvAaFZDvsuzGJyW32Y8
         8S7Js1BxZj0fVGaSujJUR8NoIBtvUaHEC8zpUpa2DbZHKsXv0dNzxVDXu+y6jb2/Okqg
         UwX1qp8IVK3C5z9oeskxLlJ/AClTh13KxSJQLSHOd+V1sFXEIjA0y4Prba9odPeHOWKq
         OAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=aoxUv1amQS309vw9heAFYM23S2w200754FaqxEoKKV0=;
        b=RhblNO/EXAKMOC10XP+4ByMOhY3H2XqMWND7yVxEgyCEbPZ7xHayhD4f9bDc6vN3t8
         Z5gW8MPwUOiGic2PiKW5ZQCp5IaPyAFVVDzJK5aOjCiqwz2PvJvmzOMFqzS4H7fw7Ot9
         wSWK9ljbN6OAd2LSAYGLPYQm9HzihKJ+n8RpvAoPjeno/W89Kt4+ZvyZ+dK/7/byXzzM
         l7Q2GHjgBTpVUiTwwUaQ6boUt4h99bijPZUjBdr/07xoedX2zwDrqXuMChWtT1BGLVRw
         ZQokHKare6TV8FgMt1YgRmn48+6QY/hY3/HLj31n2QuRAlbcPET7y+BvgBEzB/D3DjEX
         OpCA==
X-Gm-Message-State: ABuFfohiWMeIBivMHNk6k2AWXzkvQxjuWvwimd0FAdUIue5lSaw+EtnP
        r7ftUKpGYk6V7cKdP9ag3RM4OGIF9USiwzyYw44=
X-Google-Smtp-Source: ACcGV62BUbzd4tYcspnEbXk9Fxir4odYnc3F47wSjKDuYNWsAUBUkohKGMZjFWLuk4VCW4pyrRMgbmWrBqKJq8MU41g=
X-Received: by 2002:a19:7411:: with SMTP id v17-v6mr4918784lfe.49.1538387946091;
 Mon, 01 Oct 2018 02:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com> <20180905143643.9871-7-ricardo.ribalda@gmail.com>
In-Reply-To: <20180905143643.9871-7-ricardo.ribalda@gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Mon, 1 Oct 2018 11:58:49 +0200
Message-ID: <CAPybu_2WZd8w-HbW-7gn=Z+9LmRYV--pag--xjT=UBDgcxWYnA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] mtd: maps: gpio-addr-flash: Split allocation in two
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

PLEASE do not apply this one!

There is a bug, value from gpio->addr is lost.
On Wed, Sep 5, 2018 at 4:37 PM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
>
> Instead of making one allocation and then calculating the addresses of
> those two pointers in that area make two allocations. This simplifies
> the code.
>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/mtd/maps/gpio-addr-flash.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
> index 8f5e3dce9be3..9455a8448064 100644
> --- a/drivers/mtd/maps/gpio-addr-flash.c
> +++ b/drivers/mtd/maps/gpio-addr-flash.c
> @@ -205,7 +205,7 @@ static const char * const part_probe_types[] = {
>   */
>  static int gpio_flash_probe(struct platform_device *pdev)
>  {
> -       size_t i, arr_size;
> +       size_t i;
>         struct physmap_flash_data *pdata;
>         struct resource *memory;
>         struct resource *gpios;
> @@ -218,8 +218,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
>         if (!memory || !gpios || !gpios->end)
>                 return -EINVAL;
>
> -       arr_size = sizeof(state->gpio_addrs[0]) * gpios->end;
> -       state = devm_kzalloc(&pdev->dev, sizeof(*state) + arr_size, GFP_KERNEL);
> +       state = devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
>         if (!state)
>                 return -ENOMEM;
>
> @@ -228,7 +227,12 @@ static int gpio_flash_probe(struct platform_device *pdev)
>          * away their pointer types here to the known types (gpios->xxx).
>          */
>         state->gpio_count     = gpios->end;
> -       state->gpio_addrs     = (void *)(unsigned long)gpios->start;
> +       state->gpio_addrs     = devm_kzalloc(&pdev->dev,
> +                                            sizeof(state->gpio_addrs[0]) *
> +                                                               gpios->end,
> +                                            GFP_KERNEL);
> +       if (!state->gpio_addrs)
> +               return -ENOMEM;
>         state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
>
>         state->map.name       = DRIVER_NAME;
> --
> 2.18.0
>


-- 
Ricardo Ribalda
