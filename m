Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52B8C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D48420866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJK91Zyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D48420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeINLUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:20:15 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:56076 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:20:15 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so1123234itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 23:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l9+o+bV7Rt8IpYYIJJ7hPF9mB+q7qIY0ZJibnFV7rbc=;
        b=DJK91Zyo46dDvY8tRgUVKs545a7v5fAa2cWULlBXY21yxjHUC8EQzysfzCPC5dFEQr
         dtdJBaKlfe/u2b+QAZ1kejJOzLEK5ZR4IRGzQucepyE19DoZMCy/auUFL7aTCtt6bJJ8
         9plmklcM2e0pGfwqh6egWP0DPqtcL/mbcjvEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l9+o+bV7Rt8IpYYIJJ7hPF9mB+q7qIY0ZJibnFV7rbc=;
        b=ouEsCnUyX8iwGLCAQTWmnzKtIysVrQAbzCNj5WbcfQJKvw+gvQoiTv53YtjXWnvs3C
         ThnPZrNYtcqpj2O95xJK9WBJU6//RtlFkTGoYVTetyOOe40z/i8BuAkCPOyDP5691fq3
         O4mZ96m2yHe9hzxbrWTuF+r5nXG/6dnOJazRBjlzvUbXeyvnHx9jKA550uNniNF4evJ9
         XwDws/pG3ZPj6e+SeKeQPpVvdanlaZtoF1kBMuKZloeRy3nznakLkUKR44c6CPfxHghx
         XOF0w+2nr3knrc/B3OGfiyal7fd4VMrjqeV+1+/Ejb/Ojpkaz0Z63L1Ad6jUNOcafE5W
         SO6g==
X-Gm-Message-State: APzg51BlFmBZUO2weYtSxoqYOOaBpRmIVFwXAISfnKyzsOEjMCGz64Qn
        JxiBzZU6vFOWP74wGvccGz/ofndmIxHQrgAn3x05cw==
X-Google-Smtp-Source: ANB0VdZkFa28P4oSTYwQpjMeuV5lGF8nalWawD/1JJIaNCBdCV0nO7TZy3enB4O6kyJOkpgGs4dX7Ewq18ProG1DbXM=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr1095029ita.148.1536905240783;
 Thu, 13 Sep 2018 23:07:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 23:07:20
 -0700 (PDT)
In-Reply-To: <20180913185913.GA8471@embeddedor.com>
References: <20180913185913.GA8471@embeddedor.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 14 Sep 2018 08:07:20 +0200
Message-ID: <CAKv+Gu_ny+CZ+SRT2bN2UdrxVchxeSdd999Eqy91fwJEG=MEmg@mail.gmail.com>
Subject: Re: [PATCH] i2c: synquacer: fix fall-through annotation
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 September 2018 at 20:59, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Replace "fallthru" with a proper "fall through" annotation.
>
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/i2c/busses/i2c-synquacer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
> index 915f5ed..2184b7c 100644
> --- a/drivers/i2c/busses/i2c-synquacer.c
> +++ b/drivers/i2c/busses/i2c-synquacer.c
> @@ -404,7 +404,7 @@ static irqreturn_t synquacer_i2c_isr(int irq, void *dev_id)
>                 if (i2c->state == STATE_READ)
>                         goto prepare_read;
>
> -               /* fallthru */
> +               /* fall through */
>
>         case STATE_WRITE:
>                 if (bsr & SYNQUACER_I2C_BSR_LRB) {
> --
> 2.7.4
>
