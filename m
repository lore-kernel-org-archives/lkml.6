Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998A621104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijuYgLiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998A621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeKSXiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:38:52 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34034 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeKSXiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:38:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so21282567lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 05:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fz1V6zhigR8EAn2GmOvM1hx5R+S0FIRG7GiekrEHrnA=;
        b=ijuYgLiUT0agW6JgaOL/ShUfdko9EU9R8jN0MveqD7Or1FeFZBAWfTTvs/mov5qGm2
         yPzEJgn84ZO5v8ztC19SkWwZ/XWWBnqNN20WRoE7dJI1mhejHhcQM5hq8fzpa4IvgkpZ
         1yQfRCQFzAJhSpbIFKjljQGKt1815m00+axw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fz1V6zhigR8EAn2GmOvM1hx5R+S0FIRG7GiekrEHrnA=;
        b=tcluxHt3oAcHS+PR7ayASvKznNwgaT63+H2JVbwBab7iFt+L6iG8/1+pa/Ersvf0fb
         0eiIGEex07rZ5j1U2uTjrZWJWZK0pGUlOSZsMYFptAySiHN11Z7AVHwcFnynwrbihy9e
         tkJScgZxW5hcPqbYBmvDM5L2juygQzSUNPRO/3PBuLbaXrSLqRxkNnhk5csm7KybZC/c
         xTMnRRW339GFoY1+dqh/MS5tP1UdEv5/5LaxSj6gMQASGn7KR9uZfD9qeXfAyyg9ceHg
         i9sBsodXCAmgBtnNZxBhO6RCqLKG2zqxlQlx2M6KG3CFJJJbWUhJx0edUe9Wi4xzS19w
         QA5Q==
X-Gm-Message-State: AGRZ1gKJv0tRY6+WRC5aI7spgXDB9n/WeIsxit4/a0q1a0I+9kOg2HwP
        G1bHlAg7EYUiB6tDB30n2c4qLEx6/5U6k+A5XFu+Tg==
X-Google-Smtp-Source: AJdET5ceR4gYuwoeF1FzM9lymad/TSoRx7VQJwhr7Y7LPmrltgFtJuVRCvWmXW4k2Qv68aog53Rs3t8RFbDAeZI7Dtk=
X-Received: by 2002:a19:c801:: with SMTP id y1mr10303588lff.53.1542633314219;
 Mon, 19 Nov 2018 05:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20181115124748.268286-1-pn@denx.de>
In-Reply-To: <20181115124748.268286-1-pn@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 14:15:02 +0100
Message-ID: <CACRpkdbBmujFjpu0uyH4vTN8BUfp8Mq0Yt1KWnfTkihQ34pJLA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Add Actions Semi S700 pinctrl support
To:     pn@denx.de
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, mp-cs@actions-semi.com,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        linux@cubietech.com, saravanan sekar <sravanhome@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 1:48 PM Parthiban Nallathambi <pn@denx.de> wrote:

> This patchset adds pinctrl support for Actions Semi S700 SoC.
> Pinmux functions are only accessible for pin groups while pinconf
> parameters are available for both pin groups and individual pins.

This v7 patch set applied for v4.21, thanks a *lot* for your work!

Let's see if there is some bugs to shake out in the linux-next
builds, the grunt work is done.

Yours,
Linus Walleij
