Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1378EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25402084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbfAKNqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:46:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38880 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfAKNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:46:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so13146104ede.5;
        Fri, 11 Jan 2019 05:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUA/PcXRiLWKAGT4dUBVJTHpTyI6a9FA+BaQwVjmR6U=;
        b=qpUj7ot5NkDGcylcAGVyQVXXgCorGgSH2IgHGMhk4tMQu7HeY8E0s7Z1r6Nx4Dzp01
         B2/cTaWq3ksuY4AuN02bbsfUw8rf7QtiOqYeQPiltcSpeg63Upa2iaqnl2iz3VISWIPr
         c4rX354P2rekO4bj1xppxce6DhlJmWHyfy2sZWVmoRQiG3bPH5ZgcDvktQP6PLL1k3rr
         ZqgxGpIHFcnrUlGntRoTkwzyTsDuWxYqsvW7oLBOhMFBxUYNVZY3nq7IbRYFZh9FBWUF
         3ReIB6xNZFnjQR8c/eEZcL2ka2hoCktHK/n7Uo5WDVGntO7ug2aGcDFIO5y9sHgjKRyz
         YiaQ==
X-Gm-Message-State: AJcUukchlW5bW2ojJF/z7t7ujYcmFhwf3fQwcFPygbpZZQmwArVvZX1U
        aUFyjpu9H8WAsb1CrhQWN5NCecUGSVk=
X-Google-Smtp-Source: ALg8bN6sSKnKP8309M72v9xBvx1o5AeQXAz7Dyzq6omwSioXLP4A2oOUadLU8ArkAqkDqlMS1HLl7g==
X-Received: by 2002:a50:8e95:: with SMTP id w21mr12802981edw.198.1547214395348;
        Fri, 11 Jan 2019 05:46:35 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id z40sm2442474edz.86.2019.01.11.05.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 05:46:34 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id j2so15311762wrw.1;
        Fri, 11 Jan 2019 05:46:34 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr12959026wrv.87.1547214394542;
 Fri, 11 Jan 2019 05:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20190110082633.6321-1-wens@csie.org> <20190110152632.hdlo3h4e7yzzjtug@flea>
In-Reply-To: <20190110152632.hdlo3h4e7yzzjtug@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 11 Jan 2019 21:46:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v67h3W9-aeN+Y62af=g+RjZiKwi_pw-VYstTds7R13ox4g@mail.gmail.com>
Message-ID: <CAGb2v67h3W9-aeN+Y62af=g+RjZiKwi_pw-VYstTds7R13ox4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: sunxi: Increase size of regulator array
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:26 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Thu, Jan 10, 2019 at 04:26:32PM +0800, Chen-Yu Tsai wrote:
> > On the A80, the pin banks go up to PN, which translates to the 14th
> > entry in the regulator array. The array is only 12 entries long, which
> > causes the sunxi_pmx_{request,free} functions to access beyond the
> > array on the A80 and the A31 (which has pin bank PM). While the
> > accessed data is still valid allocated data within the same driver
> > data structure, it is likely not a pointer.
> >
> > Increase the size of the regulator array from 12 to 14. This is a simple
> > fix. While we could have the code take into account the fact that R_PIO
> > pin banks start from PL, or maybe even dynamically allocate the array
> > based on the last pin of the pin controller, the size reduction probably
> > isn't worth the additional code complexity.
> >
> > Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> I definitely overlooked the R_PIO case, sorry. I guess the proper fix
> would be the first alternative one you suggested, and we should take
> the pin_base into account. There's no need to store twice such a large
> array for this case.

OK.

I wonder if we should try to get rid of pin_base though, at least as far
as the pinctrl core is concerned. In other words, in our description we'd
still have PL0 == 352, but when the pin is registered, PL0 == 0. This is
OK since each pinctrl device has its own numbering space. And it would
match up with what we use for GPIO.

It would also be better to nail this down one way or the other if we want
to use the gpio-ranges property.

Either way this would be a separate patch.

ChenYu
