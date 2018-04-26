Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2141624-1524729576-2-16717396401892920393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524729576; b=My1RGNcru1QhYrulnwjOr4lPSkJQSMrwwPp8hjR36ovTKVA0E4
    EvDQyvYInQx7yXMcrr+n7+BJtma0n/C8c6zDgDTviknfaXPgoWzb7B76Kx26wibG
    X2AkXDbMYeAmoeJf4my9zjNhvQeytN29Guo8ixuQJfVkjxQ3b5py8ApoBHBlma/K
    AVHKfnBCiJ/FoQpoPr2ovQq4jaNNiQ2Zo2W0+NMr6+vqp/GPjPx0JIY/CUqM2u09
    GHG/6IjTHvY5KXedUXUZRUwzsXO8LmtlOFHxUYOmvebUffaiMqFf3By0fdnouBZo
    6OaW0265355tIVoT4XIiQGLrk4hiqv+aaZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524729576;
    bh=hD68ksdYbvGiniCe15j9aLw9xd07a/orNvYV29baOS4=; b=FA/+yJbr3osR
    uHHHKLj2MZFcXHajtJhySnRodD1kpcqKUD+dYJEwbw/LnBdQKiMHO1M+7Yh0fCGx
    p7cHhJFZCKrkUzxHV/HnrMWP5GnRddIgzkQv3z3AcBIh8OAVfldUGug4Cvje8Hfu
    aDzbivQ3nnm/DNzyNcja39Jb5S5j1tQ28GyhwG4D/h/J7xDxzuc3GBTmt44ZIfVE
    TsGiwB7tq65/FH+FCsl9Jm+088h+T8KtYaXRZMMn2bZuoDuYraWwjYO4dT6plQT8
    Vt9ZCwm9gf59bYMC6/p7wdpL6FTztzyGzPv7VQpJvApvekl2SPqq46Hx+5TjZ41Q
    tmgAtezbOQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC/iUxE6n0dhT5OkblL4oM+5HVlX2j0dkucoi20fLwz+qp5/h56RL96vprAXa6KnHjBL6YGpJVw7GRJduHkj4P6Ny84YcS+7DJJ+dIhsjnZ+oEZ58S0W
    xHaQHm4TXmuLAkkB+JNtKns6roB5edh6nYRTVOLN1SpLtjGxNN8yyl2E17K8vSEGmtYD38VhvZ17VfYWafjW6xnvJmG77/wZR1RiiwtGaKQneSVZdUzWTWaU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=xbilytGdl697PjAK-u0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754415AbeDZH72 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 26 Apr 2018 03:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753362AbeDZH7S (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 26 Apr 2018 03:59:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EAB2183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx4+ejdSsBhnjVCseh6D6JxZgcb3XdzBUGA7hB+rqz/nJ/vGUW3BeC+LW8JpX9ckKJF0i9MhWoKVQLb40YqfVqxc=
MIME-Version: 1.0
In-Reply-To: <5AE12E4A.90907@samsung.com>
References: <20180424203239.21885-1-krzk@kernel.org> <CGME20180424203603epcas5p4cdd2039eabe7039e4daf286ed4c1ecc0@epcas5p4.samsung.com>
 <20180424203239.21885-7-krzk@kernel.org> <5AE12E4A.90907@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 26 Apr 2018 09:59:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc4oDAFThxVszOrCr+yEaK85W3AeYTcLFyGm0-6TLyZyw@mail.gmail.com>
Message-ID: <CAJKOXPc4oDAFThxVszOrCr+yEaK85W3AeYTcLFyGm0-6TLyZyw@mail.gmail.com>
Subject: Re: [RFC 06/10] thermal: samsung: Remove support for Exynos5440
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 3:41 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Hi Krzysztof,
>
> On 2018년 04월 25일 05:32, Krzysztof Kozlowski wrote:
>> The Exynos5440 is not actively developed, there are no development
>> boards available and probably there are no real products with it.
>> Remove wide-tree support for Exynos5440.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  .../devicetree/bindings/thermal/exynos-thermal.txt |  14 +-
>>  drivers/thermal/samsung/exynos_tmu.c               | 155 +--------------------
>>  drivers/thermal/samsung/exynos_tmu.h               |   1 -
>>  3 files changed, 4 insertions(+), 166 deletions(-)
>
>
> After applied this patch, I tested the build and found out
> 'exynos5440' keyword. There is one comment including 'exynos5440' as following:
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index f92f470bce21..cb525228cfe1 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -943,7 +943,7 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
>          * Exynos3250, Exynos4412, Exynos5250 and Exynos5260 incorrectly
>          * states that INTCLEAR register has a different placing of bits
>          * responsible for FALL IRQs than INTSTAT register.  Exynos5420
> -        * and Exynos5440 documentation is correct (Exynos4210 doesn't
> +        * documentation is correct (Exynos4210 doesn't
>          * support FALL IRQs at all).
>          */
>         writel(val_irq, data->base + tmu_intclear);
>
> After removing it, looks good to me.
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks, I left this comment intentionally as it has some meaning even
when Exynos5440 is not supported.

Best regards,
Krzysztof
