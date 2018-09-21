Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637CEECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE5621547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrYzrG7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE5621547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbeIUHg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeIUHg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:36:58 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC00A2154F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 01:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537494632;
        bh=jKzdj7jccLinGJ+3slgoITmnAjWHnsiKsaQQEpAvPKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KrYzrG7JoY2XL8I2GJLJxzghmTFkaceCUA0/ogCgxi2xME7D4FgMoTwCtXKzRJ/XN
         trGiqYxfyJfsJF9LLMmTYCTnc0IHVU2PaKtlYkc6ZhauzzenofBGEqbC2wVGSKT73Z
         cxfxD+fmsl1/MOhoV6UDQvPxaJX+aS3rv/EHKHA0=
Received: by mail-wr1-f46.google.com with SMTP id s14-v6so11214992wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 18:50:31 -0700 (PDT)
X-Gm-Message-State: APzg51DTYI34bJCal5bnUk91IjE/CjxrLltNr90NSVQxv8OfN0bK5LWB
        NOhQtKDr/h4R+WTnazxSa88nG2ovEGpSL5BDXbAkwg==
X-Google-Smtp-Source: ANB0VdYniFvnvoGLxwn9gdYn9bxOUWNsHtf4wxBfRYuYYLwmbdJ+5dNbv9G2EvQbVwcBavF9OeTwEOx2gt9/Z1oqbMI=
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr35875280wrh.148.1537494630108;
 Thu, 20 Sep 2018 18:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180921001513.12504-1-Jason@zx2c4.com>
In-Reply-To: <20180921001513.12504-1-Jason@zx2c4.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 20 Sep 2018 18:50:18 -0700
X-Gmail-Original-Message-ID: <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
Message-ID: <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
Subject: Re: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch seems reasonable, but you emailed the wrong people :)

On Thu, Sep 20, 2018 at 5:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> It turns out that KASAN in general will bloat stack frames in unexpected
> ways, not just KASAN_EXTRA. So, this patch trivially changes that
> default to be associated with KASAN instead of KASAN_EXTRA.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 4966c4fbe7f7..39078a080e29 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -222,7 +222,7 @@ config ENABLE_MUST_CHECK
>  config FRAME_WARN
>         int "Warn for stack frames larger than (needs gcc 4.4)"
>         range 0 8192
> -       default 3072 if KASAN_EXTRA
> +       default 3072 if KASAN
>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>         default 1280 if (!64BIT && PARISC)
>         default 1024 if (!64BIT && !PARISC)
> --
> 2.19.0
>
