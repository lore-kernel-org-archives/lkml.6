Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0627723C19
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbJMFUgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0627723C19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeGDVX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:23:29 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39366 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeGDVX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:23:28 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so4166541uad.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b4D7vfxnUSWu6FfL76N61mSn7EsHZhgwSGPHTslCO7Y=;
        b=AbJMFUgXL0Mn7aWZg+32YUqgVb3dR4R5Tof8zJQNnB6qUncCCIVefartHidpXxoBm7
         gxctH8zFTpuw5Ieo+d5bRer6lCOFrsF8b2yFnz+I2+lqdedVawhsSHlU2gtOKg+rdnP0
         xNhWBlEM4txn1ZfR+9wyrPFzX1o+rh0zeS8yBb8S46e8hD380NU9dtZzXseMqquHp5mV
         W6V+g6ZuW1qb9ZLAS5Yo00gFO8s5QoO48aljvb0P/AQ3J0NY4qh0g203bUbeIuqHi/lq
         2Uuxtt2zW+QYyCYgLD4hnQg2fp9rjyySQu4iah5TlHTUACE7yQX6Mx5P9rCYUS7w12Vf
         ichQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b4D7vfxnUSWu6FfL76N61mSn7EsHZhgwSGPHTslCO7Y=;
        b=c4iQJaTxzXhGlm2UBg0ydGJTtNd3YIbBPmKv1XztheL2soDPWoQqhSfVuzrVsdQuv6
         Q8mepT+0acsAiEOpOP8CTvIvBO0J2J+qabUphlnSWI4BH+7dpxn+LshufIu2LMeBpBy8
         W9QQQx9jzdGK0ulUmd1fW+SZ2qtsYR9WQv/Ba0KKaijF1ZnQf+0q1RBGxUja1TKWytai
         /BN6rqbS2ponaNDZY2EzgdxNN3QllXU2rRd/9Q9qGth0CQBPuiKzPXUhxcCxKDDjyrbg
         +tjJmqwimZ0msU86sjMNvtns+2goqwka0VgeUKXH8rFAsklOkTCA51ZP9bR0rscJL9kB
         B92Q==
X-Gm-Message-State: APt69E2VSf2YC1L0UniziKaw1YLQLTLeVmBvjvucKKQVkmqrZ/BI1lkI
        BYeqQyWGp04NEvh+z3kUblT0DSc8aN6q+rJuDSP3SF/d
X-Google-Smtp-Source: AAOMgpdfy/5uLe37yL1uoccGF91KbhQCHlRwcPx0+8NmKyAKbuPt/8McR5xrr+M82wiXB5T/NZ8XIc0lcrj+nP4mdVI=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr2050642ual.141.1530739407329;
 Wed, 04 Jul 2018 14:23:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 14:23:26 -0700 (PDT)
In-Reply-To: <1530478650-20922-1-git-send-email-linux@roeck-us.net>
References: <1530478650-20922-1-git-send-email-linux@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Jul 2018 00:23:26 +0300
Message-ID: <CAHp75VfvuMgH40Fq0A94gZGF5buf5yDKUEckMhnSnbvyb4S5xw@mail.gmail.com>
Subject: Re: [PATCH] test_hexdump: Replace strncpy with memcpy
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 11:57 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> gcc 8.1.0 complains:
>
> lib/test_hexdump.c:84:3: warning:
>         'strncpy' output truncated before terminating
>         nul copying as many bytes from a string as its length
> lib/test_hexdump.c:82:19: note: length computed here
>
> Using strncpy() is indeed less than perfect since the length of data to
> be copied has already been determined with strlen(). Replace strncpy()
> with memcpy() to address the warning and optimize the code a little.
>

If it helps for some reason I'm not objecting to switch to memcpy().

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  lib/test_hexdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
> index 3f415d8101f3..1c3c513add77 100644
> --- a/lib/test_hexdump.c
> +++ b/lib/test_hexdump.c
> @@ -81,7 +81,7 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
>                 const char *q = *result++;
>                 size_t amount = strlen(q);
>
> -               strncpy(p, q, amount);
> +               memcpy(p, q, amount);
>                 p += amount;
>
>                 *p++ = ' ';
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
