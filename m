Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-582252-1523931293-2-7241011341551854076
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
    1523931292; b=J4oaT8midezRPxBRL/b+lUPCsLpYa7tYd5lCVA7EA15tY4vb8T
    u7I780pdnBXh9VE6N3SyBgiq6o8FkiVWW8tqbsXjUBdtzxG/NWC6jdQF1VVTzHSm
    m6TjhJN8ta48GpcYN5m3IsCPBSnzxcVon/b/7Ks+UUZr9ttmKDywuFqlYVMoJhhJ
    Lctmc2UXWBUHRGR45yQmc8NkPL4wHu2Y0WSxqDWVJQGSjbr7bxVUCnnjqYUrQN7w
    omKjqApj1EQhfiNicU3SAth8mCvCp88Bq0F3Nk8Zg2a1I4yFgwWTLHI9qNv5NAfq
    2Qmu2/L+4cDw6RNYuUEx6O0FmGc2Rhests4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523931292;
    bh=L6fgv929K3wC8++lslJOmYlnxdBPfQUDQVTAjmbvxk8=; b=gexjatkS0202
    kDD14txGqwEpcqGNURJhyCe2Il/UjoO2Tciwpg2d2QyxuF37u6Ls761EVVBHSySm
    ih6lN6z0t5JRS1wvXD2UT92JnGROGikvvdj82476s/sTvMzL6resOhuf6AoR+QLH
    P/s896kEJfKWsYGFjxe5QHf1n00ZLhpFBAcyeFqWhu1yTpOB2/dbCpBqv/CN0oaG
    gEqZ6xSUJVBrG3rhlveaR9gHBp1dMhLJEiBC0E+8U4/3lUG66jWvGRrkdSlaTdpY
    KyY1qOeKABB0OykB3JqnoyAclOoDJ8GeyFGj8L/c34kvkd+1qmHL74zgkrq7+qZg
    8DV0njwDoA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UAN7uFX4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fOJ9nJDY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UAN7uFX4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fOJ9nJDY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOgEHeRrjTdBJqtFJpTKoyUH6/21ArTSfTVGxkpqdZgZqROZu60/uNDyL5/PInMgep4Ab85XbmPA2M+JubUiAwiPCslowv7Ys2TiLRpS29z765MDMYBM
    5ACIPOwIgC/oe6Y8LK+wU0QRBvY/0YBqzlMtKhC7r35RdExJzxWzd6KLLpu+VY9PjJZsAc7F5dolvs+t2bHa18W+FmWwMFmBFPHtasoKFYry09g8XaRgVG6I
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=h7_fbOkM_H0A:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=A9TbSm-gHehrtiPu0xQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeDQCOY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 22:14:24 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:52213 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeDQCOX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 22:14:23 -0400
X-Google-Smtp-Source: AIpwx489JNchIS/JsazhA8ZfhT9iKVudOmZrW1GItuukKb2KrJfjiHLrT4p5IKHx6S5DP//o0YXrQZ35uKnRWu/38Rs=
MIME-Version: 1.0
In-Reply-To: <1523893966-8884-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1523893966-8884-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Tue, 17 Apr 2018 11:14:22 +0900
Message-ID: <CA+Ln22Hgn5VmeUAdcmHi64-HdRqpuGBBN9uUzmFTOBatagzXeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl/samsung: Document required order of banks
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
> This patch documents requirement coming from the way
> exynos_eint_gpio_irq() is working now, which expects
> EINTG banks to be at the beginning of the bank arrays.
>
> Cc: stable@vger.kernel.org

Probably no need for this one to go to stable, but either is fine for me.

> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 26 ++++++++++++++++++++=
++++++
>  drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 20 ++++++++++++++++++++
>  2 files changed, 46 insertions(+)

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Thanks for the patch!

Best regards,
Tomasz
