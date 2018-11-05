Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73105C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CF52081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNYZNMSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CF52081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbeKEWm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:42:59 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35558 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKEWm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:42:59 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so6344874itj.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 05:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rvYjZ1qca0VX3+3SueX81QrgJpkniRq28GvN3nb0PVo=;
        b=hNYZNMShg+B1oNqnssdhO4CxrOWyEwNtoehfAGDQ2EGOdGUOuWsNwrY62v8Xdf7Tfv
         bX7BuRgd2L7Lnz6aaQd9mhl3DPPLJZjEY8Gm6s5zUVN9oh44X7fCePnKRxEps9vbw8Io
         l5mkZ2jpolRlBTeQvVfKVa+4MYZTwe2YcMY6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rvYjZ1qca0VX3+3SueX81QrgJpkniRq28GvN3nb0PVo=;
        b=DLGnIIlxcr7BMiMK0u+INoPlaUS7CWlgEph1v67j8q2sDjPV6TrtKn4S+NSIE5SX1l
         3SlW8yk7XYX01bRncB9B3A9SCrmhu9ib7uiSicJEQMNWESisVu36564nNKRUTMoYidfg
         XptrrwiPHxViH0Hfcx+aRRWK2nVWe6y+v6PYeMsHdQoP+mJuAJF7XDF5TfEYHWZxqnDp
         CCreKXl3ieKSOx8tNEGnNxq9SiS7qSORDUL4Jnw3WGfXNkLm5kcnvgPaFDmEe2SQh4kx
         x77Z96IMzI9UCGwXJxDaHaWMY8WviwMDD5HB4RyiTWyRXG8RyaG+nolvyzppSdVkh3Dl
         Y4Jw==
X-Gm-Message-State: AGRZ1gIyN0SzZL3qhzd/pxHUr4q6lbV0eHiylKhsk+eC7OsByuRY/gTA
        tNH2BVP5C0SEk7yiG2XNn6yfINevjvor805fnAHMCQ==
X-Google-Smtp-Source: AJdET5fgnWPC02yEs7xBokRetcNoxkBECzHs6w2HyYp/g/xtQ5gCNNzw8V8jXiyxykqvRZmb4ZSKthu4I40LeU5Q4Xc=
X-Received: by 2002:a05:660c:383:: with SMTP id x3mr6076823itj.121.1541424194022;
 Mon, 05 Nov 2018 05:23:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 05:23:13 -0800 (PST)
In-Reply-To: <20181024032356.3388-3-vt@altlinux.org>
References: <20181024032356.3388-1-vt@altlinux.org> <20181024032356.3388-3-vt@altlinux.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 14:23:13 +0100
Message-ID: <CAKv+Gu-DHURWHZdyLY5Tbw5-Te-e_-89k-R91Vv3xRKchhvkYA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] crypto: streebog - register Streebog in hash info
 for IMA
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 October 2018 at 05:23, Vitaly Chikunov <vt@altlinux.org> wrote:
> Register Streebog hash function in Hash Info arrays to let IMA use
> it for its purposes.
>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  crypto/hash_info.c             | 4 ++++
>  include/crypto/hash_info.h     | 1 +
>  include/uapi/linux/hash_info.h | 2 ++
>  3 files changed, 7 insertions(+)
>
> diff --git a/crypto/hash_info.c b/crypto/hash_info.c
> index 7b1e0b188ce6..b0b91eb0973a 100644
> --- a/crypto/hash_info.c
> +++ b/crypto/hash_info.c
> @@ -32,6 +32,8 @@ const char *const hash_algo_name[HASH_ALGO__LAST] = {
>         [HASH_ALGO_TGR_160]     = "tgr160",
>         [HASH_ALGO_TGR_192]     = "tgr192",
>         [HASH_ALGO_SM3_256]     = "sm3-256",
> +       [HASH_ALGO_SB256]       = "sb256",
> +       [HASH_ALGO_SB512]       = "sb512",
>  };
>  EXPORT_SYMBOL_GPL(hash_algo_name);
>
> @@ -54,5 +56,7 @@ const int hash_digest_size[HASH_ALGO__LAST] = {
>         [HASH_ALGO_TGR_160]     = TGR160_DIGEST_SIZE,
>         [HASH_ALGO_TGR_192]     = TGR192_DIGEST_SIZE,
>         [HASH_ALGO_SM3_256]     = SM3256_DIGEST_SIZE,
> +       [HASH_ALGO_SB256]       = STREEBOG256_DIGEST_SIZE,
> +       [HASH_ALGO_SB512]       = STREEBOG512_DIGEST_SIZE,
>  };
>  EXPORT_SYMBOL_GPL(hash_digest_size);
> diff --git a/include/crypto/hash_info.h b/include/crypto/hash_info.h
> index 56f217d41f12..91786b68dbdb 100644
> --- a/include/crypto/hash_info.h
> +++ b/include/crypto/hash_info.h
> @@ -15,6 +15,7 @@
>
>  #include <crypto/sha.h>
>  #include <crypto/md5.h>
> +#include <crypto/streebog.h>
>
>  #include <uapi/linux/hash_info.h>
>
> diff --git a/include/uapi/linux/hash_info.h b/include/uapi/linux/hash_info.h
> index eea5d02c58de..5e8b8d952ba0 100644
> --- a/include/uapi/linux/hash_info.h
> +++ b/include/uapi/linux/hash_info.h
> @@ -33,6 +33,8 @@ enum hash_algo {
>         HASH_ALGO_TGR_160,
>         HASH_ALGO_TGR_192,
>         HASH_ALGO_SM3_256,
> +       HASH_ALGO_SB256,
> +       HASH_ALGO_SB512,

Could we make this HASH_ALGO_STREEBOG_xxx please?

>         HASH_ALGO__LAST
>  };
>
> --
> 2.11.0
>
