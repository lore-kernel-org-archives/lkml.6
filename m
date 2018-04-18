Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-705158-1524066518-5-10097559204223964769
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524066518; b=frFcQJc3f31raASnO8kIrVN4F2fmEQ1FH81ZzEYviGeKp86MeM
    X52pqIxYHfpk/AqIW+dev19AlUu6mmG+yAzaVPekbVcECCG0H8MQEYdGcCX0PnhW
    R69V7r+ozC6hqezn+D/jsu5UgUywxS94C0PekHSGc9ZnRQWCUAbF+EXeXKh6uzmJ
    a0EeVYDTXppZxl/6mIwQAgIrVhbcT9TFqg5zP4Io2Q91E93ZVyB8nMUG+qFmR3Sl
    OFpldcZCpzkRxJeGOLHe3x7aKtZspoN5u66TKAgDvF0DBbCZA1OWAhjD1dEfdEaC
    NcG3+nRhK6pJea5y22oxqEdmg2ecee2Bf1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524066518;
    bh=N20iwob2p1+WybWVG5Xv4hSNoYvAXlPHygs7eWhjAvU=; b=Wi0UBuYj0wzL
    +f+/BAKiMB0lyEsFNk7biQg8Beh/UIuiqC7f33SjuncF74AVUKop06VjXrrZ+6Sv
    lXwDc5OfWhICgSOwFnEs6miRmVGRncOGMW2RZqTPPR66LrvtrNos+VpxYx6JdRDx
    qvZWg4ebtZuM4fd7mophAkg/cB48wqnBF+YAMA/jwBAJ2H3XBSKXP4RSzA8xn0GF
    0SpOdjRdS/s6DnDEIMwOqr2STlRBarvUderx5N1TSL1rjiEzBrbpQGXOt7UJvrFT
    2WP3ML4UL+wfh5HssEF6RepMKaQ/paYy1Jz4RRs7PSHIHaHTqVqTH1M4hCTP+tMr
    +3g04MBqbw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
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
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPl5EyYEUxy+c8Cqd3YHF9XP5qA22c9XM6njsSU3MPR8OJ3I8GMRAqS/crS+mLM5852Xnwq+pDfZ7s6xydcKONYRuAkMCCm2gsRoCosgJKCjyZCggXa7
    74i1/9EUgZXtGmPGqgOHHOMwz0hC83pqAlhTjDgCBMPIpLTHCIVN0eaqrhc6zhrDkWygUT+SVlNYklpvDrUg8c4Q0f47IM/SQhF/N/4ZqIWqv1u494M+miTI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=p7gPUlwSaSNSUYUih2EA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeDRPsE convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 18 Apr 2018 11:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753420AbeDRPsC (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 11:48:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B3721838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx493F+lEJAc8ARmy3horDx4NZGZ6cyEa4+3Ug814f9iIhpSI9FuZ5TlVF/MmKIF1uVxPdSM2If4PVKjfoVQ20ho=
MIME-Version: 1.0
In-Reply-To: <CA+Ln22Hgn5VmeUAdcmHi64-HdRqpuGBBN9uUzmFTOBatagzXeg@mail.gmail.com>
References: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1523893966-8884-3-git-send-email-pawel.mikolaj.chmiel@gmail.com> <CA+Ln22Hgn5VmeUAdcmHi64-HdRqpuGBBN9uUzmFTOBatagzXeg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 18 Apr 2018 17:47:59 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc_0RenBVA+wDshqD3Q0S3kCu_60v_V5XMCvtWeOv+Hrg@mail.gmail.com>
Message-ID: <CAJKOXPc_0RenBVA+wDshqD3Q0S3kCu_60v_V5XMCvtWeOv+Hrg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl/samsung: Document required order of banks
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS"
        <linux-samsung-soc@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 4:14 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> 2018-04-17 0:52 GMT+09:00 Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>:
>> This patch documents requirement coming from the way
>> exynos_eint_gpio_irq() is working now, which expects
>> EINTG banks to be at the beginning of the bank arrays.
>>
>> Cc: stable@vger.kernel.org
>
> Probably no need for this one to go to stable, but either is fine for me.
>
>> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
>> ---
>>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 26 ++++++++++++++++++++++++++
>>  drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 20 ++++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Thanks, applied without cc-stable.

Best regards,
Krzysztof
