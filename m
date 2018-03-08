Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988500-1520516544-2-13576867909293151538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520516542; b=C/31OKwOZha1LfXX+f2vsyW1kzMjU9ihf9hpWXZq5ZlB3us
    HKClDongX1e0pOq4S8fzviDFZvULF1ipUA5NPewYw73kZuD3ZfYpSPUbXlhDSBpg
    77sBP+sSXCYS5Go7ikBGlGJM0PegO8J6oEP8WIZdNY4GN1p7ku1azPD0SJp4rKOT
    krxzZSlkOgyOLElOh81lHOdzWf3z+2Kydi9YnoKI7ZMOCALstC5w/itpsb4kJe4D
    sRS3oJIoGbIWASM4c2X+es/2mvnk1SZQIFyrrcRAs48ax2rBQkkCsUX2bCBOtIMJ
    LzXtuZ3lnzuPB+YM6I5hvpmubh9R7qYjL43aWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520516542; bh=bYNMd/lDvPVJroq1xsww0vZl+Ut8kzYo+kXupp
    MvrO8=; b=IFyYRjHAsFdEqkQseDPPLOSYletcBXD2zCiBWfWOh5xqhYBEBphiij
    wFlIpfE0Bk8YoUNUP8bWvaar3Z2rj8YD0aLt6xpbFWYifQtYpQWzaUJ7ffvlaY4z
    NSYHhlBTc5pZXUv//WoQqyT/XV1AgEaA6N737TxLWsEysjojBXNETEXKAmHZL55w
    fwpJdEPsoWeKIA5MpoPWyGKoP9NSV5gD5po8tRtKSiWMTrE2yY+r4STWLtEcnjt0
    MHygN3CPHlcCNF6WWvQayrq6JIX1EOFsiDB3iEvY69ivix+EoJLUlFC+VEaLnVay
    O4gRL4LmIo1IlbMbrTS5leh5UniJ61ww==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=AGk/DWxJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qH+TRpc3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=AGk/DWxJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qH+TRpc3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755179AbeCHNmT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 08:42:19 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:35479 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754806AbeCHNmS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 08:42:18 -0500
X-Google-Smtp-Source: AG47ELtTH9gjg3QcXvckNDnIOOmVdXc+xuu2cP+/E+ZtWFv5VbuGY2Uhbualbt+8KcxJBmtMwkpCnGcuRCf9+uLrxP8=
MIME-Version: 1.0
In-Reply-To: <20180303104554.5958-1-richard@nod.at>
References: <20180303104554.5958-1-richard@nod.at>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Mar 2018 14:42:16 +0100
Message-ID: <CACRpkdYOqt4xTqGmbSwd_R84NRD8GA9TsHEk_hJ68hhxwbsL_Q@mail.gmail.com>
Subject: Re: [PATCH] ubi: Reject MLC NAND
To: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Mark Vasut <marek.vasut@gmail.com>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <dedekind1@gmail.com>, tharvey@gateworks.com,
        stable <stable@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 3, 2018 at 11:45 AM, Richard Weinberger <richard@nod.at> wrote:

> While UBI and UBIFS seem to work at first sight with MLC NAND, you will
> most likely lose all your data upon a power-cut or due to read/write
> disturb.
>
> In order to protect users from bad surprises, refuse to attach to MLC
> NAND.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>

I'm sorry to disturb in this interesting discussion about what
"stable" really means as in "stable kernel".  Stable for who and
in what sense, that seems to be the question.

But my main problem here is to understand who the consumers
of the MLC NAND devices really are.

I hear some talk here about lab boards. But where is this
really deployed, large-scale? And who are the people that
will have their devices potentially not booting after this patch?

I am pretty sure these people are board support or
customization consultants with work being done for some
certain products, and not hobbyists and even less end
consumers, right?

What kind of devices are MLC NANDs being deployed in?
Certainly not laptops, tablets and phones, they all use eMMC
and even start to venture into UFS (unified flash storage).

What is using these flashes? Routers and switches? NAS boxes?
Industrial control? Automotive?

Or are (God forbid, but would not surprise me) talking about a
Linux instance running inside of eMMCs or UFS devices?

Yours,
Linus Walleij
