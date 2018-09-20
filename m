Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F4EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934E521533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ykomb5c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934E521533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeIUEWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:22:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34135 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeIUEWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:22:23 -0400
Received: by mail-io1-f65.google.com with SMTP id c22-v6so10136595iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 15:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kW89ZDcdN6ntlPOVDFYEN9c9HT7XKN+R0Czrqisj4Y=;
        b=Ykomb5c58cT0fN4aVXVN5CHnIXa7xPvVJNDTVxsZ5uX3+NNghV924G0kPaKkqof1Bm
         V4t0oqYLqiLiO6mCOFP3J08RMPcdIaKLFkHmqZdSBxLfgA8f+G2XZ6U19F2NGolwBQJA
         noKQv5LFpefL0GXLY/P0nhKu5FZ+nAiEwHzc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kW89ZDcdN6ntlPOVDFYEN9c9HT7XKN+R0Czrqisj4Y=;
        b=UMGI45bmCR96257nEiEW7hsyyQHU1IZFAdPVhW+W+FkPZAKKX3LJV7gJVUbq8vrC1r
         KiV9fRGtFB6XkJtAoFLdYxu2IYbn/Z/oTuSg45iqcKVbjv0Ivg3XmknuyioeYnJ9MpFm
         HABA+hzy6MQotP5r99fm33EXzOkPe6j/b1ERgTffHttGFCxf0TgsD03UmUs2Eo8oH5Pp
         uqHO145BNctvvj4eRLcRApT1kRg/ShwmUYS6sUrGeJ08o2dBjturk83IIFdbCsy389QV
         PxnsaTNBae1Q0wU6loCTkPbQNEjtpgJhlbj9lAsBgRJNkCul7SHu8hr3YOYya5OYEocQ
         86cw==
X-Gm-Message-State: APzg51CV5ozYp7yioC/zalamzL4WHip/1NhTrxJQvDcu8bQiPymjKXRK
        ZzA3iqCuMiFHTMZnkLAhrCnXyw5iJUqW4uCgPFx9Jg==
X-Google-Smtp-Source: ANB0VdZAAK25mg3iBCah8JV0OoJfqJp5grGwlFW7NwtZ3zZ1+EjlXMVWQVd4YYTgfYGp3saOk586brVW2WXKbsvN/yw=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr38714317jab.87.1537482998060;
 Thu, 20 Sep 2018 15:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com> <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
 <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
 <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org> <CACRpkdYGpEVG9gqPxNaOsD55k9idEfGaxOUrObbN9VZS06x5jw@mail.gmail.com>
 <bcb79947-dfe0-e5e2-fb48-3b6992720f01@kernel.org>
In-Reply-To: <bcb79947-dfe0-e5e2-fb48-3b6992720f01@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 15:36:26 -0700
Message-ID: <CACRpkdbz0hyjy5U3-xo8Oi-ojB_H3=DEwuJtmoqJTJQNiAYYaA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     timur@kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 5:35 AM Timur Tabi <timur@kernel.org> wrote:
> On 9/20/18 12:23 AM, Linus Walleij wrote:
> > I think most gpiochips easily survives calling the .get_direction()
> > early, Qualcomm's stand out here.
> >
> > Now that we have .valid_mask in the gpiochip could we simply just
> > add this back, resepecting valid_mask and avoid checking the
> > direction of precisely these GPIOs?
>
> Can you be more specific?  One of the proposals made previously was to
> add a check in msm_gpio_get_direction(), but that was rejected because
> the consensus was the valid_mask checks in gpiolib are sufficient.

What I mean is that $SUBJECT patch might not hurt Qualcomms
GPIOs (not crash the platform) if and only if it is augmented to not
try to get the initial direction from lines masked off in .valid_mask
if .need_valid_mask is true.

Whether it makes sense semantically is a different debate, but it
seems possible to reintroduce calling .get_direction() without
hurting anyone.

Yours,
Linus Walleij
