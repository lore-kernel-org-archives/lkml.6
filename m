Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BCF32C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5388D208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrZw5i7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5388D208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934955AbeFMJKi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:10:38 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38047 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934141AbeFMJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:10:36 -0400
Received: by mail-it0-f65.google.com with SMTP id v83-v6so2882448itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 02:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6+JEXxLKlS4kZ3nvhPjRnNN5vb6l/RMTBMhsBnT47hE=;
        b=WrZw5i7zTsKlgU+MTrb/yNEspszxnpExnjz4mpmAtKAnM7kPQUdvrqQULjNzlAQdpK
         tTuHLLRyhhA0kBbS0H9qAofbsXclkYGzvKveTCfROd2lalGC76yXdXM8j7H7FnlBs0Nd
         /7n0gyB7arNUS75+CclIwSFnmmiQyG7ZWzvgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6+JEXxLKlS4kZ3nvhPjRnNN5vb6l/RMTBMhsBnT47hE=;
        b=TCkfiwSRNpqx/HXiC2y+sYJeaWn4zXSoBqRPRCrVZBSt3jvGqVWop4FDatMQmofoA/
         ln4e61M0qqIgUJKWMhaU80/OAypvP0L7qLEKVxRJKITeLWRFsXNP/v3zycjpLk0MEdOS
         icD6yGbTrKfD9qbxM2/PKalqa7MJaYOJVUha0FLBZBHK6b4X4PUZv5eefrg15x4WQP7U
         5gKH6TIvTWNaqLv6e47jeiaYTxu/1vM1/WuVOeoLkL/g0Cuu1sj5BTgdV4GDZKMEV8UN
         2OKoxom2EWbz5d7PzgLPsoOC2qtiz54RR7RZPu4fhgwkPyp55KgkdYCe1QZ7puNvTRoO
         0TwQ==
X-Gm-Message-State: APt69E2YNNkj4CXWx8da0OnrB7FNB3ZrkaUP8UYXdbXLzSuIwa6tjzXk
        IKbcqyldC3J7LXlMl2hSjgrxlTTGLoPFXyXWRKGpVrFSdtw=
X-Google-Smtp-Source: ADUXVKIe8HDPz9dvzPaPXo0czY/YaWKZOYdFVuyN7YuU38FiBy+8+zFz5WG5m0nJRUnnA3Adt0fjJDzsZbBso3y2iPk=
X-Received: by 2002:a24:19ca:: with SMTP id b193-v6mr3919194itb.135.1528881036181;
 Wed, 13 Jun 2018 02:10:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 02:10:35
 -0700 (PDT)
In-Reply-To: <20180604141528.15635-3-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com> <20180604141528.15635-3-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Jun 2018 11:10:35 +0200
Message-ID: <CACRpkdabaH2yiYNnQHBru=-Snb3Eeni2eDAa9mjsa-3DqMC72g@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: ftrtc010: let the core handle range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 4:15 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> The current range handling is highly suspicious. Anyway, let the core
> handle it.

Hmmm. I have datasheets, do you need some input about the hardware?
Something I should patch?

> The RTC has a 32 bit counter on top of days + hh:mm:ss registers.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
