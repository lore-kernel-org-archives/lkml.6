Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3102847-1519659041-2-18077880895787129754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519659040; b=iyX/pBinYnbzrcrTFbCT0BKcAq3by62560njh57kGHzk129
    82QjYfWoB1ZQMknVwcwEj8D+yOMCHUJZJglt43n+w2TOtk4XBdMqdHcwyIeWPHYo
    cChBGzHDwS/UenlWAuur0MaS1IeENhqjyAvt/3AIqQNRxiWs7oqDjA/auDk8edSF
    /haHL0I5FUhp90LBqPrinlM0+C3NRMITcwetNZjxyPr7IJnnASptMKtQ21tWPq6u
    vCecP93hW0Koe8wCAa0RZH8w0aE2jQ38qxpOdcenemxAtWlAiJo3+OzJlqFRc2Pv
    kZU7xwn+WT63ifh8z3LzCzRufvnHvuxJ0zopmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519659040; bh=vvHxQ7qC3nT+L+M8eIbA0Fe6kjnacOr2ApvlnS
    rP7MY=; b=AOLmJEn/KAQixgSmAjbhf0u4O4JKtUOXLrj0dBvxDhwrULPjgZASjG
    IEmnSq+Gkntl6bDBigR8NxrWoQrsz4ny64Y7yvPx24XcoyCU4IyVITbLCVrK6KUE
    NipgZFkJVcmME5fpSpG45Qt9dglkq5FytOWPXdn2ccZpkWilz8Qa7TpVVz6VgQRd
    jj+fM8Nibtdozk4I0l6gu+P2BZSfiIqjP1eNit/4dLGDD9i17nPvRNipVtGyuOxa
    VVrWie46N/Ms3Bz/koKCqxW3pGK3CsH1tQijduX91mIHhiVxRCM4b5VjZvFEt7L3
    5WcgPEnynIeXU/TtCi93Z4IVEaAsUxVQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeBZPaG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 10:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBZPaF (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 26 Feb 2018 10:30:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA9B21772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x227uBuS4Z6P9Vr8E1gDQee1SMdgNE8Nt0olJZl02XDrd7u+s00+6vocixJBv044ylr4gVqBvxXWepi/QEkrWzV0=
MIME-Version: 1.0
In-Reply-To: <20180221085541.14556-5-a.hajda@samsung.com>
References: <CGME20180221085607eucas1p1a08c82fac832049d79705b4222422fa9@eucas1p1.samsung.com>
 <20180221085541.14556-1-a.hajda@samsung.com> <20180221085541.14556-5-a.hajda@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 26 Feb 2018 16:21:48 +0100
X-Gmail-Original-Message-ID: <CAJKOXPczu67vPQEzQZvFRZGVNBpk0U6GJhSnb4dYWSgTY+Unog@mail.gmail.com>
Message-ID: <CAJKOXPczu67vPQEzQZvFRZGVNBpk0U6GJhSnb4dYWSgTY+Unog@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 9:55 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> OF graph describes MHL data lanes between MHL and respective USB
> connector.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v4:
> - added missing reg property in connector's port node (Krzysztof)
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 32 ++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 3 deletions(-)

You have a duplicated '};' so kbuild complains so I assume there will
be next iteration of this. Beside that I am okay with both, so I will
take next version when your bindings and driver changes get
acked/accepted.

Best Regards,
Krzysztof
