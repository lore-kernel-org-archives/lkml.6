Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825FBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD5520866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G97+wlrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeLTMfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:35:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39902 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbeLTMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:35:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so1212369lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=d+MOXg7RX46ppNn2t+HJ2iusF00TZYgDl/TAVlFufoI=;
        b=G97+wlrNdbnMi/DLOPm7yo5FuhGWAjd5q8k5WpV+eZaVQ9ZoaObcBmVeRfurlaDk55
         PGjkwwuAhVBLCw2DhW+Letcnk8NrmO9jdBCNH+05J5Ul3SXyv8ECEGKexIiOmoJhqa0F
         /cJVzHgQxJQOAlkE+t55etbbrxOjNTrrwAspgcAQf3HJA5l3skeuTQ5j6EewU3hPYP9b
         LQrhBcBbISIzXx031cAeBt7eAq+4Huf2BmA2LDkWZA54QFbFXD7NR7pMMI+xV/r2ijns
         mq/mwamJd0Vl4j6MkasDbR0a6k4rlMzs1bCpGjJOzJ7RVpsMpDy8xaO0ZM74QbNzQRAb
         6FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=d+MOXg7RX46ppNn2t+HJ2iusF00TZYgDl/TAVlFufoI=;
        b=aM+VSX1Wea96lge4biKU8iXfM1cHtEVrjJtm1sQELlCBUYW9EooVgxiYIlVhYFPXre
         eI2x7k2kpV8+zLQsN9aCQyqxjQpjWqNzugttizF8tXmJ6pKWxz/iIHv/Xr6VJkC1fKoA
         0phVCsJ14pvAoYNflxt0eC0trxkFBOj8ffh30Jtptalh7QD6I8+UGa45xcnuESUnbCce
         rGbf33Sqdf26wvzjQrZWpgKHuseuvuZDKgVRi8kzJBC5vsM24r3hErCdc6eGw0753ar4
         +DXfPnjgCQDOF3jYet1uodT16pp+JpVN7zOxwbj9BYzcI7a26sJQ90VK+O0HFTIcVuU9
         XfgQ==
X-Gm-Message-State: AA+aEWbIS9NjWU7LWLwn3gXaEInwkt2IIg2a3EJmk5A8rSr3zV6KCfbn
        B3YDT1DeULsZL7YGN3bJB9o=
X-Google-Smtp-Source: AFSGD/VOhr+AgCmNP7CzojqzZ3si+xZJgFEg0tAkVwpPmmzw9CBuhzTiwxDJYEaBOJkT/W9YauOUGg==
X-Received: by 2002:a19:2c92:: with SMTP id s140mr14466763lfs.42.1545309299307;
        Thu, 20 Dec 2018 04:34:59 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id a18-v6sm3967024ljk.86.2018.12.20.04.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:34:58 -0800 (PST)
Subject: Re: [PATCH 08/14] drm/bochs: atomic: set DRIVER_ATOMIC
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-9-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <42edc361-ea12-23e1-b4ac-ee077f000523@gmail.com>
Date:   Thu, 20 Dec 2018 14:34:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-9-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Conversion to atomic modesetting, final step.
> Set the DRIVER_ATOMIC flag.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/bochs/bochs_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index f3dd66ae99..278f9d2e7f 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -81,7 +81,7 @@ static const struct file_operations bochs_fops = {
>   };
>   
>   static struct drm_driver bochs_driver = {
> -	.driver_features	= DRIVER_GEM | DRIVER_MODESET,
> +	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>   	.fops			= &bochs_fops,
>   	.name			= "bochs-drm",
>   	.desc			= "bochs dispi vga interface (qemu stdvga)",

