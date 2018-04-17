Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-582252-1523931205-2-2388274069841162174
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523931205; b=AWK2ilSb1kkPFyJ8h6N9bfY9h18Zl5i04aFD1YvIxJyXA4Ba2r
    st2XrhK8NmjgfAJPTn0sME+Uo7YGw0kXFoQ2GDpuY4kHP1PxceB++lb+lRVa+1bH
    qTHUxFyPlOaJkuVZOhuZAm/e2QFdVTeoo4h0oXAwJw5yV6CyRHtkAniNArJTLai5
    4cVP+ZQHwktcLwv/iNfi24i0ajtAxpT/T23HdcBHBHF7BYmx6E2HmdtrxCtdTM0R
    wsjULRxrgq1DbUsefocXrwY99IQ0Q82or4+Ekow2glIfnAiZRjNXl6vWGFisgC1v
    2FfmMkY3QeYBabQIaMarfJ14gs9E90UTnq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523931205;
    bh=QGjtV3O/DrK6lnYly1K1W/cYLvxCsxl6oSXYIxL4DNk=; b=L/lR2+RMqHXV
    J/dZnqSknJtS+bcf16EBKyNqlwn7HTGfow0O2dbsEgmAdUn4lWxmJP9OHbrSaoPe
    pQ6tJFardCdAwng1rDXkxs+y/iTy87qGq5ZFYpjaNlQ7EpXRs6kr+ZdPhZCWx2Bg
    SoHJPafzOiOI3bu6+9xEl0JFUlXkVMp9RAx184Ld8CydeCUQhXrseHpbWf8tnJS/
    PNVCmJpMOUoeCJtD57V1IRVOMKAIaWIFHop3PwGIKYG431DHRtMC1vsvS63zOWlb
    AA8owqcopIoq/5Y8q+ZvyAtGUKLtDjfZwXaC0g/cFgfUDJyjTd0Duw+oqDW3Hpk3
    vI5rgVJ20g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r60Zb7wd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dy6ZQm+h;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r60Zb7wd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dy6ZQm+h;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJnDVhrU4dhxWFBs2GlJoDA0fmxoNw6wbT/Rq8ozW6R1AiVhFUGZ4q3WQpQs3Rr4N0HeBVKTVR+BKlzBcS9PvG4nuOztPDLRfr8zjJAHZ/7/navj2bYu
    oS+44g6je8JLUpJ3DYbMxDGF1mmKmrYfERBNDAL9qKkflq7z41dSsQUiToweDyNyeRUY2Bdyt5DkA4sPWJAvloUuZMAlmHBMYrTvxzoP01LBbfox+1NcDY/g
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=h7_fbOkM_H0A:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=SMflBSaePRqU9fWy4dQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeDQCMl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 22:12:41 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35961 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeDQCMj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 22:12:39 -0400
X-Google-Smtp-Source: AIpwx48C9Jym6z37SY/XXz871YSG83jDywdmUyh/I6o3cvV42MCmR+9MjCbFNXlUNUYgbMm0Isq72Dkr2FdEfdZ5BaM=
MIME-Version: 1.0
In-Reply-To: <1523893966-8884-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1523893966-8884-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Tue, 17 Apr 2018 11:12:38 +0900
Message-ID: <CA+Ln22E17WK2GA_6-AXZu9Z+Q_Nb86xO6npZvrCc21ciYwHt8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl/samsung: Correct EINTG banks order
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS"
        <linux-samsung-soc@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-17 0:52 GMT+09:00 Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com=
>:
> All banks with GPIO interrupts should be at beginning
> of bank array and without any other types of banks between them.
> This order is expected by exynos_eint_gpio_irq, when doing
> interrupt group to bank translation.
> Otherwise, kernel NULL pointer dereference would happen
> when trying to handle interrupt, due to wrong bank being looked up.
> Observed on s5pv210, when trying to handle gpj0 interrupt,
> where kernel was mapping it to gpi bank.
>
> Cc: stable@vger.kernel.org
> Fixes: 023e06dfa6882f500b9c86fd61f0b1913aa07f36 ("pinctrl: exynos: add ex=
ynos5410 SoC specific data")
> Fixes: 608a26a7bc04a39cfd7041f31ca2b2100113d14e ("pinctrl: Add s5pv210 su=
pport to pinctrl-exynos)
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>
> Changes from v1:
>   - Limit changes to s5pv210 and Exynos5410. Exynos3250 will be handled l=
ater.
>   - Added cc stable
>   - Added fixes tag
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Thanks for the patch!

Best regards,
Tomasz
