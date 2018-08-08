Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BA6C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDFA219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHCNRpJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDFA219C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeHHOpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:45:32 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44587 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeHHOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:45:32 -0400
Received: by mail-ua0-f194.google.com with SMTP id k25-v6so2069358uao.11;
        Wed, 08 Aug 2018 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=btxlbvw8kOGF4PfaKrfMeUaWI5285Z3/2NofmV5txFI=;
        b=GHCNRpJ6a8s62kmVzdqvEo+rOLyZSwlxgzwQjgtxvsffeUH3u+/mU+jkgkofqOLNjx
         kL4IcQNagSrBjh6JF6Ge3QSKKDyQE6Pg/cxcqVkdusBiiZM+NtSprcyvFVr/YlSE2+OM
         +ix6RzYq7pDsnjQt2Ps/zB3cVI7xRn/pppHhrOXYJKdZveYEcU0cD8QBqEXj10CR2AYm
         lew4iKJL1hyjoWjXteTCjmSDGMGSBKVqCLt6mE5xhdC64aUTBhdtAxKKvMDK3+YHNoES
         wAaA0XrDwei/LYY/1nhdW0yMZ3yQbN9TO5V1RxSsjtayJl2eX/I/e4nDeDM6rY2CTivu
         vHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=btxlbvw8kOGF4PfaKrfMeUaWI5285Z3/2NofmV5txFI=;
        b=TDzMYnhZrBaSc50pOjM5ciA+z/rei1G1zcxjt9pAfo3m3la/6iqCu+3N5sA/gIWbL5
         fukS1eLE+vgiSDqgVYmk/lpA27pYVsqxO/y97M2jSwQxXicf7CwjX+r7wdsab2iRyjjq
         EHZ+EINd1dBgkIhgHmkIGyEQjBccCuArjvAZ3nVlvk+jFC+tZM+Dn7nDwoNUO6JVVBEu
         T/bwNw3J0b2+pJwqWRKORQT3JJF+Nz/2IWOyGblxMKpRL58/ZdzFfbePmUjjIkkmXr3X
         5zeV1kKXMsq4g/Pgl1xfo313HO+zHubSHR0rLWpNJxnl5ZuezrO4degABwNKNjm1ONaD
         vMng==
X-Gm-Message-State: AOUpUlEULx4ZUvQWTisRWgsm8I2t1Jn7SGtI14Gt4URbye9lEeLK8Zps
        sI9Oo/t2vY3xY4SDzVRMx2ev9YIspd/hnm9xhE0=
X-Google-Smtp-Source: AA+uWPzN1LLm1b5oRzqWioSXy29l713D+OiwA4CwjmbbnoxQDA2Lb4/4KdkgZ8P4AKVxWBij9h4V9QZAPZOUxJ3o9nk=
X-Received: by 2002:a1f:b503:: with SMTP id e3-v6mr1684654vkf.97.1533731163555;
 Wed, 08 Aug 2018 05:26:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 05:26:02 -0700 (PDT)
In-Reply-To: <CAAh8qswXPmcT94x69qDmf8RumT4+uRBwQEvJSu9agaq_e7FH-Q@mail.gmail.com>
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
 <CAHp75VdmrwZ4P0xrOOqpJaU7iuKS8zXGcRTg4zLrofZLdcb=8Q@mail.gmail.com> <CAAh8qswXPmcT94x69qDmf8RumT4+uRBwQEvJSu9agaq_e7FH-Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 15:26:02 +0300
Message-ID: <CAHp75Vc24DM9jqBdKa1xjXfJjA_BpZq9H1PAwM36sQGfZ99zFw@mail.gmail.com>
Subject: Re: [PATCH] spi: dw: support 4-16 bits per word
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 2:58 PM, Simon Goldschmidt
<simon.k.r.goldschmidt@gmail.com> wrote:
> On Wed, Aug 8, 2018 at 11:45 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Aug 8, 2018 at 10:14 AM, Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com> wrote:

>> n_bytes = round_up(8);
>> dma_width = round_up(8);
>
> I guess you mean:
>
> n_bytes = round_up(transfer->bits_per_word, 8);
>
> But that would yield 8 or 16 where we need 1 or 2.

Indeed.

> Reading spi-imx.c, this might work:
>
> n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);

Yes.

-- 
With Best Regards,
Andy Shevchenko
