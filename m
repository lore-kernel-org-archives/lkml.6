Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3336438-1524783860-2-15436181865655462828
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524783859; b=CXmiGpBlFT30wufZWR8lRVxE4j7KKYa5xBg/0v82LT8AZTxvUl
    tH6x+1LmehGsywtH4xyo4HhWRHn+nEYFXwsV3wTCnqb5nzAXrhASzluM9tGL3h8r
    Fhu2iKoSL78Mdhus29YuwvshjJOMtE5oQb2wdrhToZkkFXdwMf3oF0/ISFOHIIyH
    uNK12/ti/M0mIePEIAAMHwFFY9RvOpOX94AGSvIxFnDOXrTfgzNmaWp7Gklmge8L
    cc/JovlmKBkLcA45glQSqB+dyxIq6dnwWdRQ251fIUbSgEwwo/NsnivqTouHXuz8
    LN4yShWcNFFlUMftgUZQa5HF2f6vn1JQIRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524783859; bh=P/llkDx6bldTlXgR8RaUsDB6R469NkjZYhTRl3Td7q
    4=; b=C1wfSD32NTN4/iJVUNzMNw6lE+IKs+OwwGGdldRQmQNPZSjNKdcCrxk8jl
    9cvFlA4Y84eL6Di8ro6FkhwKGHASgP3MnuOX0BUtYiI6luzFzVw/GsRB6D/UdCYQ
    7fKTwgxeejaChOz/IcOTRZF3XpITgG7ehCIY6Cj76CvRkiZffpHMoXjt18jWy/Jo
    K6SSXC1em2Y3RbqmD9IjpSTGlxYeLOJ5ETF4mUPrztWgBTA+LywsAPDHtTlm4Fnv
    GD5ipQCQtGtoN2x/pnx6f9d9+z0a5sipC3diZ6yvCg/QXKa02ERw/10kzE7KO1Dp
    Ae5XeMHKwqEgxiD9IeBHiClsrC8A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Z0A11zkH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pLLJ1EHm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Z0A11zkH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pLLJ1EHm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCwk1PBpfvkkGXGePv6IQXQOymf0dDpXQKEOHuytyeEl/RA8iJqKInz5sgYc7lsKyIiLU8/B/sElYv+moZi06WdKc3VYdOVDAH+UZlSShtxpkQlqNoWb
    i66F089GRCgPCFedb/noxZOY2wDPe9Wyq4C9FAmBM9nBT9GGiH+R3uXUq9DVhkqyq3wsnZ52rkEZosrSoDOKKXfrU2SeLwfqWU3o5v+obo3wtOULxxF9wMS3
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=e1gbiiAJYvSclKX5b2cA:9 a=QEXdDO2ut3YA:10 a=-hZp1XIjoRAA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754833AbeDZXEQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 19:04:16 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:39585 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754472AbeDZXEP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 19:04:15 -0400
X-Google-Smtp-Source: AIpwx498Txp2UUkkyrwt0YRWIGMnHEAjIGd/EAFG0Y/ZfFhlNHme1aBosihwhPFjG/1yQSEl4t+dFd85qtgqDkFN8l8=
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdoJV_3BucTjJ0xxd6cc6PYy3W0L8e_emmDmwZnhgXqvA@mail.gmail.com>
References: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1523893966-8884-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CA+Ln22E17WK2GA_6-AXZu9Z+Q_Nb86xO6npZvrCc21ciYwHt8w@mail.gmail.com> <CAJKOXPdoJV_3BucTjJ0xxd6cc6PYy3W0L8e_emmDmwZnhgXqvA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Apr 2018 01:04:14 +0200
Message-ID: <CACRpkdabT-rZ19=5JjbzzchB5eBQL7jCOBHAJ0QH0PkpRUEqBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl/samsung: Correct EINTG banks order
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS"
        <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 5:47 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> I fixed this, re-wrapped commit for 72-column and applied to my tree.
>
> Linus,
> I'll send them to you in pull request for next release cycle.

OK waiting for that.

Yours,
Linus Walleij
