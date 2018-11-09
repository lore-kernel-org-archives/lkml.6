Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75670C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B70420827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4RBczLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B70420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeKIU4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:56:44 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46610 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:56:44 -0500
Received: by mail-yw1-f66.google.com with SMTP id v5-v6so1422138ywa.13;
        Fri, 09 Nov 2018 03:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5dNdHpiQ+1oo1jUOViTpP0xdazNfPTpsqcc2Xk3taM=;
        b=P4RBczLhrmI7zcYlDBiEWIcuUFM3e605iKf+WB4nv2NF8OROzFzAN3+lH95mFw87+J
         UJ+xAoDFlORgfkVH8e6yeG8IKUDXKUQrBz/T3wiwTWkrStiYYHGjRp/Zqk6out+JScFF
         WagSjxWefo7CI3N2/HmefiDTb7inKGr298/4jCbgF5EEnV3WbIsD/ho/5F8211t4zKAc
         8jDdf7n1zRlQS9VVnTvpzTRJPtwOdQUGT7QXvWYUvkUEobHXG55miJCTFZQ9l4p7zsNA
         W4soVNHWvAcLRMwTaylWGdhb3wjDPHL7oA+Rw0H28aqvDEDvj+El1W0aXAKBKpgF7wtC
         vnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5dNdHpiQ+1oo1jUOViTpP0xdazNfPTpsqcc2Xk3taM=;
        b=D9lM/UnafywsmKa/2s1LNUBvdeFmqdmy+6otKkeo/JeTtYU8GMcB300oBD2eGHetH2
         SQW0Az/wNfGVWzAEAZrm4RwEP+enko5gOZ5Nukzy63tLlZ4jAfsRvnc6cm+ElqoC0qS1
         gAJksHf2wJHoNtxRLmblmuyH7Mb8RP290Kzhzup9L30G6ZfU3L4FrepyRBZ6R0xI1qtj
         yCjXAIdAnUH8BSdhEw2ojcbUl37a5gav5lh1PiDPrsT+cnDlLOYOsowuVXOBSg8p/PeW
         J7BXVU1A0z8NRjM8Jinw5qXsXP73fuBgSAfWW08DlOhC5ilP4P/t8wADMFokq40VAcKW
         ydCQ==
X-Gm-Message-State: AGRZ1gKmIjx4mB+4WgaR6gh3uw32J2MhxsH2YK6MROekNKejVOvVS3M8
        f2K3/8njuK4L3iipnw4C+I36Iy0AfdGcrkwaM3c=
X-Google-Smtp-Source: AJdET5cuwPEwRvgoz+ukhiXL54kOKiu6VywRDULXUG9NZSdcckI2q+BPyQHnw2XU+S5m/KA5exPptYcmBdPLaEcqJpE=
X-Received: by 2002:a81:7c0b:: with SMTP id x11-v6mr8031983ywc.490.1541762194080;
 Fri, 09 Nov 2018 03:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20181028143403.2285-1-diego.viola@gmail.com>
In-Reply-To: <20181028143403.2285-1-diego.viola@gmail.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Fri, 9 Nov 2018 09:16:22 -0200
Message-ID: <CA+ToGPF06Vv8g31mR+Jtz4LjY-Cpxf2catvJ8NC1ONJnWhajgA@mail.gmail.com>
Subject: Re: [PATCH] Blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
To:     axboe@kernel.dk
Cc:     hdegoede@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 11:34 AM Diego Viola <diego.viola@gmail.com> wrote:
>
> med_power_with_dipm still causes freezes after updating the firmware to
> the latest version (DXT04L5Q).
>
> Set model_rev to NULL and blacklist the device.
>
> Signed-off-by: Diego Viola <diego.viola@gmail.com>
> ---
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 6e594644cb1d..a7f5202a4815 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4553,7 +4553,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>         /* These specific Samsung models/firmware-revs do not handle LPM well */
>         { "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
>         { "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
> -       { "SAMSUNG MZ7TD256HAFV-000L9", "DXT02L5Q", ATA_HORKAGE_NOLPM, },
> +       { "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
>
>         /* devices that don't properly handle queued TRIM commands */
>         { "Micron_M500IT_*",            "MU01", ATA_HORKAGE_NO_NCQ_TRIM |
> --
> 2.19.1
>

Hi Jens,

When do you plan to merge my patch?

Do you have any objections?

Thanks,
Diego
