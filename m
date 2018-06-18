Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92427C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A7B20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o95dkG72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A7B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936906AbeFRUmZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:42:25 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:38046 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755346AbeFRUmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:42:23 -0400
Received: by mail-ua0-f194.google.com with SMTP id 59-v6so11607663uas.5;
        Mon, 18 Jun 2018 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i1RZbPzgUOIcp++fwRNVex1S+AdGFKIoQnGtlpc2A5I=;
        b=o95dkG72RGfIqBB73vduaUcvNwwYF1DX4LipjEdvF9XlttI/MtyLtS7SmplJvw2IWP
         dpp2TyEP/VKux0vB7JdnG46Dx6n87+KRIV4JinoSl/E8VzI+ffnim3HyYaS47btP7TVM
         BGp84dal47eyfqxt7GzdHAun+Ucxw15+OHxe+JYPqdlmpk797dq+sdsvuPV2VaP3YrrI
         1I2EffAzUYpFPONxo+itkd4rji79RnzZjK7aAVlQ4PuxNE9SnH3nkE017tOQ37rCwJpc
         ljJIaTnPfOw2ZxoD0RS7TqiRU4cTCSVRq07ljOjaufGG2MPEhyidimGh9rsdWVBCXuM3
         JD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i1RZbPzgUOIcp++fwRNVex1S+AdGFKIoQnGtlpc2A5I=;
        b=iXp2VVwIs7CI/fj8CiRlpQmFlG9r44c6d45l+fEoB9Vue03B4D9kpMcVm//PQV5Rrd
         /jZRCzCoTIom/K3RaBl4KXhyRW+yd2nChkPoe9rBZFqyxVGrdcCoUrnB83aQq6pNbrDZ
         OFgQJHLVbmXzOEZN2gLQ//xoc/2KF7qbJ/9eR7YbXwVn73EB3kJnT+j+PbckCH5a9J4U
         atq7u6QKdoMEs9kS+sMq/7DYDzfcS9tPEw+0Opk+J01e/MnKzrnCwYW52Dtj/NKrwlV0
         M9Zt1q2qbhb94VOtlZtRQhY2lpE9DM1zJSfJVmSKsYtUMpj23S05oOKisyGGYhCNivI6
         ppdg==
X-Gm-Message-State: APt69E0UVXXyVNlsTsVzlrE27Xd67/GEgDt0S9LqNw0JGH+0eBYA1fZy
        dyjBZbHDf6yzMqXuJcKKAOorm3kmBJ5aNtU0lv8=
X-Google-Smtp-Source: ADUXVKLABfVmvMkv9ZZRNWG15Fo5aX8UACvwEhkAuaP4ceZ+cNXw69UZwDZDH5wNCj+pc+V/Ii2vbmUp9FMDaVUrx5M=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr8539763uae.199.1529354542867;
 Mon, 18 Jun 2018 13:42:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 13:42:22
 -0700 (PDT)
In-Reply-To: <20180618203750.28658-2-johannes@sipsolutions.net>
References: <20180618203750.28658-1-johannes@sipsolutions.net> <20180618203750.28658-2-johannes@sipsolutions.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jun 2018 23:42:22 +0300
Message-ID: <CAHp75Vf6fM-G505tccppceBdD+rc2yP=sYO1KYUJReeS+go-Sw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] bitfield: add u8 helpers
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:37 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> There's no reason why we shouldn't pack/unpack bits into/from
> u8 values/registers/etc., so add u8 helpers.
>
> Use the ____MAKE_OP() macro directly to avoid having nonsense
> le8_encode_bits() and similar functions.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
>  include/linux/bitfield.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 147a7bb341dd..65a6981eef7b 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -143,6 +143,7 @@ static __always_inline base type##_get_bits(__##type v, base field) \
>         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
>         ____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu) \
>         ____MAKE_OP(u##size,u##size,,)
> +____MAKE_OP(u8,u8,,)
>  __MAKE_OP(16)
>  __MAKE_OP(32)
>  __MAKE_OP(64)
> --
> 2.14.4
>



-- 
With Best Regards,
Andy Shevchenko
