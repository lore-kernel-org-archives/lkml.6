Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C784C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D032087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNfJKuTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D032087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbeKOTgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:36:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35359 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeKOTgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:36:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so16698673ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2Pw5BW4NobDaK7PabjATdfAwHvKgPLqbZxz0yWjFdI=;
        b=gNfJKuTq/4pctKGTRO+uyJrSVadUHqZkeSfVc9JAvjiFw6YyykCYDc3rC4Ho/Snfob
         jueY4hq3g48ld2OzbbuXDg/XrdPm8RL4W2NywHGC/3zyk7wtFhdEGfWThD4nMJEzFY49
         zORFcu66Qm2FkfTTMHSJ53RMs3RwEj2JpWBzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2Pw5BW4NobDaK7PabjATdfAwHvKgPLqbZxz0yWjFdI=;
        b=NmFwQYW5uJfqE9t83IrZTQrCNqc3XDf6nZA2ZMf+LpCjQ1O3xRLRCk/0fvlKdb3uuE
         dJZV455Neiqw/+s7vmozHmpr6iWTnbVSszsj27JZM3DKxYibC062cLuzteiAPim6f7S9
         +R9KzQHTsxXq8yg2ULTGN/aR6fbXhnB1X6b8J8ezmEcZy1/g3zBOSSn563i0m23vf5Tk
         N+Qjbi06RMH1CoNKBGh8+IXJvjgQ0Ye9yyVxriN93ecXMzK5JOxDEYhEKLXX1EZCyGgc
         pepdc+Pq7g8zbgJBCMZgO6tC37a6R45ZzsCggCsxqLQDUXcLljSLV90XnQeWgy81rKzV
         TfGA==
X-Gm-Message-State: AGRZ1gIf56c0T5B7wVyhwT8m9opGP3lFdnwHfMS/qFkE6F1bj7jNzo/Q
        L0URxYTixtK6T+lSG6LOsmFW8AvfCvbCEgYCUwURTw==
X-Google-Smtp-Source: AJdET5e8kpBjkoywQokynhJLJUnOdgUaIIizWFoMyUKVhiuHZNPoZ0AOcdk1ADIwhioTpaV2jaAcOpXLNQ7v3Ite+zA=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr3177273ljc.97.1542274141222;
 Thu, 15 Nov 2018 01:29:01 -0800 (PST)
MIME-Version: 1.0
References: <1541587358-17654-1-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1541587358-17654-1-git-send-email-narmstrong@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 10:28:49 +0100
Message-ID: <CACRpkdYpk1Mts9SxQq5nAdBBcWyZJouYgwR6uQaKMOe8o6u=OA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson-gxl: remove invalid GPIOX tsin_a pins
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 11:42 AM Neil Armstrong <narmstrong@baylibre.com> wrote:

> The GPIOX tsin_a pins wrongly uses the SDCard pinctrl bits, this
> patch completely removes these pins entries until we find out what
> are the correct bits and registers to be used instead.
>
> Fixes: 5a6ae9b80139 ("pinctrl: meson-gxl: add tsin_a pins")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Patch applied.
It doesn't look like a regression so I only applied it for
next (v4.21).

Yours,
Linus Walleij
