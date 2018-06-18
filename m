Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896A8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CFC208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6IaTgMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CFC208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968102AbeFRIqO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:46:14 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55327 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936546AbeFRIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:46:09 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so10841463itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6Yfq6wCu6rRaR2/c5Off/0iFTw6Ejs9PKA+QMwf23nM=;
        b=d6IaTgMq0vWr6ztkH/UkkhHMeubXayH5TCVTjLQpE3FYhOZ0IvjPLUzTTDZUsuBMP6
         pWVBv+Rs3yvTVeI/n9DZrwL5O67qkhrZnhVkevfJVJ5+afRAVSkS1bqWSkem2WNAx3fX
         kc876XXNLLYNbntFrGmYT1+OXte4pv0OyEeeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6Yfq6wCu6rRaR2/c5Off/0iFTw6Ejs9PKA+QMwf23nM=;
        b=ZF5zIcP402HmT+J5mUxOrG2/j4q+aqhbGoNLXHgS7CLYaqeZHgy8FLTPhQuAV79nW5
         qjSeURDvjqpTM0EC+oY13x9/F4PXdLQ8owCGpF30VVxgHwfepArxlV79g5PYx1yO+9bi
         l6aGFz1SQmmipyrHk3cNJ1otb3VMBIw7t0a+T2HFkK9iu7e2zTGC1l5i+Ip5+aenquJC
         6KJ62C+cpgKxUgfChG1wHRbfHijoC0CBIsl/s7xZxHdp+R5aEloWUOd9Xnb5lByPa6Qn
         67/hn/vYPGfpNO9+U2z5mOKLJFrKrh6L0eoRwn4DsBjZRN3465JHBEZsC0PIByCPjKhP
         p6Aw==
X-Gm-Message-State: APt69E1PMiZo5PfbUpf01ZI12pF42l51qGZpnw3crk3crK3BefcFw8vN
        ZQ4KtFZVcF45V3lneafqZgRR7sup/7GKpitmRqmB5g==
X-Google-Smtp-Source: ADUXVKKkJaxufDuWC/PIjbQNgcItbtV0eu34G0qWllMPuyVO4IAQMj4op+c5nSaZ+ttoXbHFkrOfmHi70fNezFY1F9w=
X-Received: by 2002:a24:19ca:: with SMTP id b193-v6mr9018325itb.135.1529311568554;
 Mon, 18 Jun 2018 01:46:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 01:46:07
 -0700 (PDT)
In-Reply-To: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jun 2018 10:46:07 +0200
Message-ID: <CACRpkdbX0R+ipasLfZi80yf2OBU0TuDT-0KoUJBvrQz3Zj6eFQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Renesas R9A06G032 PINCTRL Driver
To:     Michel Pollet <michel.pollet@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Magnus Damm <damm+renesas@opensource.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 1:00 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:

> *WARNING* -- this requires:
> + R9A06G032 base patch v9
> + R9A06G032 SMP patch v5

Is that required for the pin controller itself (compile-time dependence)
or is it required to boot the system (run-time dependence)?

We can merge support for pin control ahead, that's fine.

> This implements the pinctrl driver for the R9A06G032.

Geert Uytterhoeven and Laurent Pinchart maintains the Renesas pin
controllers, and this one is for some reason a totally new one in
drivers/pinctrl/pinctrl-r9a06g032.c

Is it totally different from the other "great old ones" in the SuperH-PFC
series or is there some other reason why it was done like this?

Please include Geert and Laurent on subsequent postings,
their review is pretty much required to move forward with
this.

Yours,
Linus Walleij
