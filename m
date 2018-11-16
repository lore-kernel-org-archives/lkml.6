Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3E3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA3B2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXG0Qkwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA3B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeKQH60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:58:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46833 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeKQH60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:58:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so21556130ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5JMgiW7Ohb+2bh8Dn23WL3AL1mGIsZrBg7H6lKNE4I=;
        b=VXG0Qkwjz+HGbTU6GrNwm8NWzUvgq15sfiEBu4NiVHruQc6PK6u9tLbk/FByU658g6
         6x1M7ZXxkLGdpGTldg7kduCBA+CNaJJWgtnox4uvJjidgTMJjMm+xBkj2VgmbPR6HpN6
         InMlH/pmNhqAQzywziqvrF5TPkKFrO8Fia1Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5JMgiW7Ohb+2bh8Dn23WL3AL1mGIsZrBg7H6lKNE4I=;
        b=QspuJw9OHjhB82yD2xoYdGYooBpI1I/VtQRbobU4PPrCoFpN6UTdcy+VbVXaKq6o6c
         VIs6YAXn1pNIXr9RC1Pf3hnyzeR28W2WWLE2gLV1Y+Agxb9t9VSM5vrcdgGTic4q3Pn0
         7N+6vbTFY9UJbAvBQ7XlyIumcY98Lqo3PzUdkSJdrWxfLscCQql+Bcq6EhmKA6WrjbP9
         C4sbP13Wy6YvA09k8c/1Uzn3Nt9atIyPga7xjaUsGfhyREQD4r1NsVmU3Zum4r567Lge
         EfcGErj0Xm+o5hYb8l8widuFY2U8GJxY8j5PE8BpRtwASmQrGpDsxPqNUm9BciOKU0Ol
         3bQg==
X-Gm-Message-State: AGRZ1gJi385Wd4P6V4619Wtpyc7bGwVz7Ja9iPNLNSstFnSKxZfVS0b4
        En3QDiucIlRwHSaaPBYU+wSGsYRiT/YqvD7TtLyRqw==
X-Google-Smtp-Source: AJdET5eLi0w3MC2yzgdGwQw9R+9VIxiLDNwXLNwzSwm2qbPVnSAZ6lZFTo0dN9t7FI0y2DlVfYkbcIPXlge1k1aWFzs=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr6887616ljp.12.1542404658332;
 Fri, 16 Nov 2018 13:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20181108165255.9940-1-brgl@bgdev.pl> <20181108165255.9940-4-brgl@bgdev.pl>
In-Reply-To: <20181108165255.9940-4-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Nov 2018 22:44:06 +0100
Message-ID: <CACRpkdYvxJrkz3k7F5yQPtmg1m=YYR-5UEWCVkVnmf9prQNoxA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: mockup: implement get_multiple()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 5:53 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> We already support set_multiple(). Implement get_multiple() as well.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Waiting to see how I should apply patch 1+2 but all looks
good to me!

Yours,
Linus Walleij
