Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AFFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6374F2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7LjctBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6374F2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeIQVXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:23:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46973 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeIQVXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:23:54 -0400
Received: by mail-io1-f68.google.com with SMTP id y12-v6so11849490ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfuZKy81n9rWCLRCSZWeJXli7aIUYtbRaihXaoimp8c=;
        b=W7LjctBAj6w6kb038IwvP42j+6nGkfXQyQZMiQZ5Bw23DBN+RlXKAKcBkn7l917/QX
         Q1KF9xDiIVYUS3h5g5KnN+RvYwnOaV3WWsocG9St2Pqz1LOSqeCmJc4tim1bmZSa8i01
         lbDRyY6TfSGDzeOyhymjQ7mp+E7ZsndVYjTbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfuZKy81n9rWCLRCSZWeJXli7aIUYtbRaihXaoimp8c=;
        b=kPsyJ1wOCgGYAr+oPuQvJUcf/uflpi+R7RcBWGkU0/vnBFw8P272UZYAhJPEN/zZJ4
         5FYUpIZbHStrbDkH0rjaCXYiEfEKwU+VVsLkh3K/Sv3+WnYrV1bkR/fUNHyXYdjtz9ph
         sqbKlKLlfW4ghrRAUOoZKTDXcsJBDO+Vm6JPmCs425SVpHODP6p0pdmdAIzrd0/Ahe35
         I0p3Hbq0a7TWK+noQ6dRbzdVM38e2c53gzD8XNZu2wxCnoX1PAtG/Y0KI4HKiYKeFiwB
         Gh/87+mTW3ioOe99mvLsBj1YFny0jZd2sm1CmcR5GIkwWLeuY/QXDvRRB7kTDivHpcBq
         h6Lg==
X-Gm-Message-State: APzg51AZ/7pEr5SZW+r5WlW4QdexI+xIn0CDbG6HX8cZA1s3DQK2UiAW
        SdBhlsdCoK31+Xrns3Wk6l7lbsB35kWmOT1Lp+FZIw==
X-Google-Smtp-Source: ANB0Vdbk7C3nLKGPnBy+6BfLiunYY1aIJaBSk1ngsNBXSeQUHm5EvePEOrxKVDQgIp2d+LZ0yAkFMAwARC3Wg3xQJUM=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr21093287iof.304.1537199756747;
 Mon, 17 Sep 2018 08:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180913133704.15739-1-ricardo.ribalda@gmail.com>
 <CACRpkdYgC7Z79c3swKE=ZwEUfVTC+oijKOqo5HwVdXLOsTT8Mg@mail.gmail.com> <CAPybu_3aaCyw9e4FJpu2r7QbGUVzDrjPmfo4oSue1Ncu0jkLGQ@mail.gmail.com>
In-Reply-To: <CAPybu_3aaCyw9e4FJpu2r7QbGUVzDrjPmfo4oSue1Ncu0jkLGQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Sep 2018 08:55:42 -0700
Message-ID: <CACRpkdaY2T_MEDERnAhDfmYfhzdjpSx6x+K+r9X=krpAnR3TCA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Free the last requested descriptor
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 3:14 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:

> Just a heads-up
>
> I haven't seem the patch on your kernel tree at
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/refs/heads
>
> it is probably on your computer tree, but I wanted to make sure the
> patch is not lost in the wind :P

I was just travelling, it's in there now and pushed for next!

Yours,
Linus Walleij
