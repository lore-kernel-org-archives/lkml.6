Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0968C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D28A21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYjpbBqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389943AbeLUKv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:51:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34555 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbeLUKv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:51:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so4336535lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nehIxIZjjZ5ickgaBSxRh3ZWlTxD18XxHB1b+MCmSvI=;
        b=LYjpbBqOIyCL5337pFj6sFVEMjw0mB1cbWtP+QDbIdZIT+SenNTGS1qGdTHny0jz5I
         LbUgx/LU/cF/9L+4vxRkpodCzh4mDFFPy1aHUQpTce7xgSOBw46x84v7+0HKRIF4NY+v
         MWd9ddlm5I5eIisGA2MrUsLmbP5pcg0PUNhi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nehIxIZjjZ5ickgaBSxRh3ZWlTxD18XxHB1b+MCmSvI=;
        b=ZGVQ9LlqalX8Lbbxk5vBc/r9Lb8yvg1IC5+QnIBE+higSszc4RGDNl7S1wrkBUB8zg
         ljE/4wvmRj500dBsrQSWHnd2tgJLAKrrl+E1ncvpTGfYRHlJ8Md45qqFM2TQuXhNI78T
         OZp+GUNFgkk38eOSLoOY5ukCnb/cPcGzt5H27UsLcP0pPRroG6GVuGr4JtD6cXxyQQ1q
         vOS8yVxEFO3AarEEy7rOrCCDU9ZOePR4MWNNtm0pcnPtiJeW0AAdU1KRqzaPn5+clIvR
         RBBPmxX414jFgtM2fsXicWtHHr+1Fe6AI76NC9kAUKWBksRaR6NKOnwdpXKxRr7lANgE
         9jgQ==
X-Gm-Message-State: AJcUukcunRjiLgttZwQanXE4N+I2Iw8wrIo0Bcew/LRnuV6rwTlJgcGY
        KV3o+tmthXQbFr/1hFfp6LzvHreDDNBcwCAJ6/yY0A==
X-Google-Smtp-Source: ALg8bN7jqkSg8uWjGSa1e9DzopQ2aBukK44YkN3DFeCE9E5QM+iJ1kCm6KKIA7/hjihr0Nt1N/FFJw8GP/MRv08kAEs=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1270198ljj.9.1545389487537;
 Fri, 21 Dec 2018 02:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20181220144431.11143-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20181220144431.11143-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:51:15 +0100
Message-ID: <CACRpkdaM-N9BmG=bFZAkZcojcKbXDnar0tRWAW0a3E1VwsD==A@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: ocelot: add MSCC Jaguar2 support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 3:44 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Jaguar2 has the same register layout as Ocelot but it has 64 pins, meaning
> that there are 2 registers instead of one.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Pulled out v1 and applied this instead.

Yours,
Linus Walleij
