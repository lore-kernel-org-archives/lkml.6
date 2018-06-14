Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4481BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEADC208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdldeZBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEADC208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754779AbeFNI75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:59:57 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46124 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754581AbeFNI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:59:55 -0400
Received: by mail-vk0-f66.google.com with SMTP id b134-v6so3190916vke.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F8qEJPDDDWpumXfNh8L/chH9OAKqoNRjsTxbrjqq4M4=;
        b=VdldeZBbyKWiaLHEUXzx7uA3189lEECo/kUbFEAQHHdyx4XbnkKVDe0ZKev7rckga+
         72oZ5+jClU99IrEK38i49JzMBqGtLrjt0OyATOQ5GFUAiOBjnU6KMglEYpfVbyRNsWV/
         fnRtHE4AIQjmeviU1YpzFHaBZn6/3p28wW2UQKuIJEEDtR1wVUTpSrO7reU2RuwOsMzE
         +gDU1MQN98nTyMyP+ZoZ58sDEjy/nsGOnEMSxsN0+0Zf4OJmJ8KNZpxBv2Klq4fT9gZp
         MkgFQ0oab98k+jxv695d5fPVR8JR2oA+Njpnn1KCna8RPPA8LKwDI/97FZo4r58OwdqX
         Mo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F8qEJPDDDWpumXfNh8L/chH9OAKqoNRjsTxbrjqq4M4=;
        b=fBlrRo3TyHFj1nUXpdUKyh/pyo2UUB+FD407MXqIh/1Oex3gv4of+JVCNdxa+leroX
         mPpWN+7rcEC1G6QMXQ1Na68XCgKagl1L91H3Uh39RTz1dX+vfLH25KVxKWmAZN9Q3oJw
         hzZxWmpCi7wZwUpWSGusFTNukkBXffyhrYU1vjaw7YsvrAnMnydcZk3SqCjJQxz8w+Hb
         hahgO0F+N+oIt5T4Emdu3CgtTl3h/umCZwZtiH8fhHkYZnu5HftbZAFj1ON3Gi+zRLr+
         GIMFO9+gPF8KTpvEQeNv8HrpKCKV8V/nZf6G8Ht6q8j0MdZpRcepCCNYJka5pP1qUqKw
         YrgQ==
X-Gm-Message-State: APt69E3ESlsBEVfaDs8bGgSjtPfP0miMGm/HUmeRWb21MR8h4D42RiCw
        yDR7d9y0YOMrGUXjG5Jy6Q2A3O519RvY7IHRbX6oSQ==
X-Google-Smtp-Source: ADUXVKK1/p0IfkREhL8ernZSIH41YnF/snc3GfAweB1tr7TbcErzmXqy4gvOOl2HQWh2iZI5d6PsMQ2l+8hdnlai8pw=
X-Received: by 2002:a1f:7283:: with SMTP id n125-v6mr999781vkc.26.1528966794706;
 Thu, 14 Jun 2018 01:59:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 01:59:54
 -0700 (PDT)
In-Reply-To: <20180613171840.29827-1-thierry.escande@linaro.org>
References: <20180613171840.29827-1-thierry.escande@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jun 2018 11:59:54 +0300
Message-ID: <CAHp75VcjiTFuUPHQJzVdL6Q-_UQUyZvs5La2tbrNW_ycg+YPbg@mail.gmail.com>
Subject: Re: [PATCH v3] lib/test_printf.c: accept "ptrval" as valid result for
 plain 'p' tests
To:     Thierry Escande <thierry.escande@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 8:18 PM, Thierry Escande
<thierry.escande@linaro.org> wrote:
> If the test_printf module is loaded before the crng is initialized, the
> plain 'p' tests will fail because the printed address will not be hashed
> and the buffer will contain "(____ptrval____)" or "(ptrval)" instead
> (64-bit vs 32-bit).
> Since we cannot wait for the crng to be initialized for an undefined
> time, both plain 'p' tests now accept the strings "(____ptrval____)" or
> "(ptrval)" as a valid result and print a warning message.
>

LGTM.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> ---
>
> Changes in v3:
> - Use "(____ptrval____)" for 64-bit
> - Update commit message headline
>
> Changes in v2:
> - Remove wait_for_random_bytes() usage
> - Remove Acked-by from Tobin as the proposed solution is not the same
>   anymore.
>
>  lib/test_printf.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 71ebfa43ad05..31f00b8ca657 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -206,6 +206,7 @@ test_string(void)
>  #define PTR_WIDTH 16
>  #define PTR ((void *)0xffff0123456789ab)
>  #define PTR_STR "ffff0123456789ab"
> +#define PTR_VAL_NO_CRNG "(____ptrval____)"
>  #define ZEROS "00000000"       /* hex 32 zero bits */
>
>  static int __init
> @@ -216,7 +217,16 @@ plain_format(void)
>
>         nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
>
> -       if (nchars != PTR_WIDTH || strncmp(buf, ZEROS, strlen(ZEROS)) != 0)
> +       if (nchars != PTR_WIDTH)
> +               return -1;
> +
> +       if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
> +               pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
> +                       PTR_VAL_NO_CRNG);
> +               return 0;
> +       }
> +
> +       if (strncmp(buf, ZEROS, strlen(ZEROS)) != 0)
>                 return -1;
>
>         return 0;
> @@ -227,6 +237,7 @@ plain_format(void)
>  #define PTR_WIDTH 8
>  #define PTR ((void *)0x456789ab)
>  #define PTR_STR "456789ab"
> +#define PTR_VAL_NO_CRNG "(ptrval)"
>
>  static int __init
>  plain_format(void)
> @@ -245,7 +256,16 @@ plain_hash(void)
>
>         nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
>
> -       if (nchars != PTR_WIDTH || strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
> +       if (nchars != PTR_WIDTH)
> +               return -1;
> +
> +       if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
> +               pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
> +                       PTR_VAL_NO_CRNG);
> +               return 0;
> +       }
> +
> +       if (strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
>                 return -1;
>
>         return 0;
> --
> 2.14.1
>



-- 
With Best Regards,
Andy Shevchenko
