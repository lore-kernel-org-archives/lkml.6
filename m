Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EA0AFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED5A2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOMwZlI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED5A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933220AbeFLKnS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:43:18 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42887 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932800AbeFLKnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:43:16 -0400
Received: by mail-lf0-f65.google.com with SMTP id v135-v6so35238053lfa.9;
        Tue, 12 Jun 2018 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jfdEz6HIX60bNCem1hIYEutbWh93nEKvEH3wGgCw99w=;
        b=qOMwZlI2HHBUxSv2VhjfTwFjKGpaEwPlm0fuXMssm5gG4XC6RRBoMyuHgfXDaLf/Dj
         +l8WtosO4aQWYumPLm7D8imI9o3gEJ7pD4boN8oD8qTTe9nS9q1gteizFr5b182gXIzI
         EbjCiRQHkyaWyBmNhG5XyHntq3r+YTdtj0syZb6mm6dvjDHv7o+sB3aBXcF4mhk4q8dX
         3cTWRqyS+BOlCOQtyEUzcVl2H3M+wDqJyTGs1v6A/nmRag5u2KRrT87bCllgJm3Lcrob
         7nOpWJieFpYy1SxU3OhTE60qtIApotxRVGaHxa2GRPMsOG/MW+xojt/XGerd8LMQ6dpC
         UM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jfdEz6HIX60bNCem1hIYEutbWh93nEKvEH3wGgCw99w=;
        b=dismxJS8ltpJzSfwHA4s0DUvIn2S+ZRby1QPJ1RUh7+CSemJj0kxPUBxD0GMm1m90i
         Ar2s27Euk5kviiE8CLTueiWLE5fGdl9HVv3KZLvNByCCvEC4d81fQRrIc/Odeira2Fbu
         CPjaqkYWztDmkhGCHPdtebGwPKDM+HEcSKUJuCMYSZXLZ5el4LCOvD+jSUItGLAcGxvw
         xFKsWEn0yldEmtTtfDFKF+/CU0aHvhwGM5O+xYpBx2GBIrBmO/QP/9aXGmAFDDQpvsh0
         pjkRi6XkZkWrHsYeAiTS8bVkb7c2pnyY02onZoNgNkG3trfB/09gV31EBkSRe69UteiG
         fo6g==
X-Gm-Message-State: APt69E1dgLgx5tls82ipKDArsHVV0h1R6yQrZvv698EdiInhsGl49fIP
        KAJIejpLtuco+s2gJcAjy/oMXJjQsXjni91gO1LTUA==
X-Google-Smtp-Source: ADUXVKKcZNBMG4vdqVqqRKFjC27jZ0G3YtAElYKe7Ry8NdOsjcgtl0kU5f/DIgXU4uq6aVCFNConVkYDIggUMzNfiLg=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr1873958lfc.55.1528800195258;
 Tue, 12 Jun 2018 03:43:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 03:43:14
 -0700 (PDT)
In-Reply-To: <CAMuHMdXJg0mYbs=e0QJMDb=A+bRbPsNF=TJzSumSjjOK3yJw2Q@mail.gmail.com>
References: <20180525210843.1821071-1-arnd@arndb.de> <CAMuHMdXJg0mYbs=e0QJMDb=A+bRbPsNF=TJzSumSjjOK3yJw2Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Jun 2018 12:43:14 +0200
X-Google-Sender-Auth: OPfsCsDihIRDT17PTO5KhYi8YOI
Message-ID: <CAK8P3a2=v5cazbSvdAMX8yf0x=PmCAQatQR6ZD=N0oM5-RGoUQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE disabled
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 9:25 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

>> --- a/drivers/pwm/pwm-stm32.c
>> +++ b/drivers/pwm/pwm-stm32.c
>> @@ -484,9 +484,7 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
>>  static const struct pwm_ops stm32pwm_ops = {
>>         .owner = THIS_MODULE,
>>         .apply = stm32_pwm_apply_locked,
>> -#if IS_ENABLED(CONFIG_DMA_ENGINE)
>> -       .capture = stm32_pwm_capture,
>> -#endif
>> +       .capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
>
> Cool, I didn't know IS_ENABLED() can be used in static initializers.
> I guess it's too late/much work to use this trick in e.g. SET_*_PM_OPS(),
> as there are lots of places protecting the functions by #ifdefs?

It's one of those things I've been planning to do for a long time, but as
you noticed, we can't just change the macro but have to come up with a
replacement that works without those #ifdefs. Unfortunately, nobody has
come up with a good /name/ for those macros, which is still the main blocker ;-)

      Arnd
