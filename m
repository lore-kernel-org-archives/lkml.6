Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-732471-1524066447-2-11256031548993228018
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524066447; b=dApjZZ72f/f66gJcJa+Sr0oXO04c58FjrfCmQS5BI4qyB7560x
    B1O8EZLF8NygA17IKC90jdCRZFxHjjFkuYoFLw++9JfHdu1lTNyr+60EB7X0HpBs
    fp5yK7AuWeP6Mo9RVyWOgKDIXM08XmjF41CxtQXMDbm0PldIawdZLOJ9F25w+e80
    zQ7r9cN/t8VifMHnXkrNQgFB5ikjyyCetzenykM/htCebjFpe6UP3JnHxl6wDJsa
    REHQlPbBeAlocc1ytsRSa6gi5mW0EyQ+31U6vbiIcFZGDdW6M+JWmY81dT+bB7KX
    I3YPTQLENM/2bU+VNYzqEayKK7HibHnSerZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524066447;
    bh=3TNUzPAksRwe94Er8s39pmNbdCzeT+taILtNYyzdlqM=; b=HHt6u2/zqlkV
    XsrxfknDi4s79AkKpG6cWZEOFPEj0hYPgGCiHpQWvCC20+LhAl5egyi+6rnVaMv7
    HQyAmXsWpzDCu24363dIv6g8EWsEvVEkGcUx8etZkd0kXUEsJY8/wNI+vgrYk8/r
    YdctskQ/0B2kBC/WsFAaqUpb9qy6ngopVOxa7yc+ygpOHRYyG7ymoMX/bJkhsSJL
    mNLys9zdAtsU6BA7hswYFkfEq+/U+IPF8xJxcfT+k/6/7g2nUC9awiEQD9/t1EvQ
    qb/VVp7XR0hJJr0n7LJ9x94QyDYZrmQiBbENMgFKheySmqW8V6jUn5pbR/u0Af6m
    COsybRTApQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfNhug1igybmxaNgIXr8xJ8PjENsWfI7isLnEB7plm1oCtoJRnoIWX4kWKX2gUpQtqUUkuBBS9oDZLWeiEJ1Ylo+O7nQZzn8vLeM9cApCsQL9w1KYen+I
    itEDP83mMBTkT1Ke54Ox2gR1nM9rxTuEvPUn2LfjAnon2e6bxY+hrqAug4lgAd3mPNY5PyhD6TEyEKXRDxEKuJ2fXSTgHYYJzTFHeuNdhiQKuju1capAMKqz
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=dVykQjDST6t0mbZJQyEA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753662AbeDRPrJ convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 18 Apr 2018 11:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753639AbeDRPrI (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 11:47:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1F32175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx4+TSIk6Nn7qupJW5mxpCoC/kfMU8ADCMH5twz7K5ILVUm8mix4Zg8g6cOXEVajBDYSE1zDaN0nrpzw0nuBHgSE=
MIME-Version: 1.0
In-Reply-To: <CA+Ln22E17WK2GA_6-AXZu9Z+Q_Nb86xO6npZvrCc21ciYwHt8w@mail.gmail.com>
References: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1523893966-8884-2-git-send-email-pawel.mikolaj.chmiel@gmail.com> <CA+Ln22E17WK2GA_6-AXZu9Z+Q_Nb86xO6npZvrCc21ciYwHt8w@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 18 Apr 2018 17:47:04 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdoJV_3BucTjJ0xxd6cc6PYy3W0L8e_emmDmwZnhgXqvA@mail.gmail.com>
Message-ID: <CAJKOXPdoJV_3BucTjJ0xxd6cc6PYy3W0L8e_emmDmwZnhgXqvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl/samsung: Correct EINTG banks order
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
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

On Tue, Apr 17, 2018 at 4:12 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> 2018-04-17 0:52 GMT+09:00 Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>:
>> All banks with GPIO interrupts should be at beginning
>> of bank array and without any other types of banks between them.
>> This order is expected by exynos_eint_gpio_irq, when doing
>> interrupt group to bank translation.
>> Otherwise, kernel NULL pointer dereference would happen
>> when trying to handle interrupt, due to wrong bank being looked up.
>> Observed on s5pv210, when trying to handle gpj0 interrupt,
>> where kernel was mapping it to gpi bank.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 023e06dfa6882f500b9c86fd61f0b1913aa07f36 ("pinctrl: exynos: add exynos5410 SoC specific data")
>> Fixes: 608a26a7bc04a39cfd7041f31ca2b2100113d14e ("pinctrl: Add s5pv210 support to pinctrl-exynos)

Use short SHA (for example: git config --global core.abbrev 12; git
config --global pretty.fixes 'Fixes: %h ("%s")' ; git config --global
alias.sf 'show --pretty=fixes' ; git sf COMMIT).

The subject prefix should be "pinctrl: samsung:" (git log --oneline --
drivers/pinctrl/samsung/).

I fixed this, re-wrapped commit for 72-column and applied to my tree.

Linus,
I'll send them to you in pull request for next release cycle.

Best regards,
Krzysztof
