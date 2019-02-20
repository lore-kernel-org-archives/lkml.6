Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C89C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D402146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqThqVkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfBTIsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:48:39 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52472 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBTIsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:48:38 -0500
Received: by mail-it1-f195.google.com with SMTP id r11so13490310itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNv2M4P5hK8vgl+eEJHQlpufyDv1dYpTyKt+009n7Uw=;
        b=mqThqVkDspJaz5CY5k2iqD8S1pFo/0Ti1z1sv+zIE/SGBgsYvx52W8qastq4wlde7m
         cikr+OQxHtsnh7fKdI2AJtpbEfIThOBkhDY7iX7vN4AyfB1vdouIymnrlMy0BTGmBZy/
         Nf0qWtdg12knaEymlwAgdpcNVPjuKvnEK3V1bQ3lLr2BQTRt0WakJi63ITvujbHNJIB8
         gjwCnh1FqIPLcKANSgKa+czMLwx3X4JbDDa8znGXnD4Z2NsPdasca0yPb27+/dZWQpLm
         mauKeYzMBbgDn2eSe+gFbn7Hb87xXb4vjDQ5x7G6WWWGBgZ3AUkUrxwWI4WWrkacVxgz
         1g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNv2M4P5hK8vgl+eEJHQlpufyDv1dYpTyKt+009n7Uw=;
        b=tcGAWGp8zYCN59/0J8w6u8r4e/LlVAnUxJF+ZLrnpfaJMvPKdA4rPcA9LuUu0P9Rev
         IxIPSj7Q1WilcVtkql/HX2eUY1ZxjcEOW5/zRmX/pUPsqPxRqaql+8vT1iGMNFzuCQ6H
         6t2z5Rp9wf4TGdU/BDLfa21Jfn4BAPsdSvyUN8O2NE26oZySJsHWiSf9OSm6gQiVJIl3
         vj5fAtHyGC45IdkkHj2fQU5/eDicQTUs3uBQDpz2pWUI+m+ItqSDSYK+j5xPn5Z/ljh2
         768kO8kUC9UyKt1Xn0+7KhcgIWmHeAMz4kaUQbduycRvSNIlsugx8J1NWp03Wjx0uOqE
         NpIg==
X-Gm-Message-State: AHQUAubC5kTwzOBOFMZA2PBwpzc4E8lfOX1ldaZUig8K7LL19K5QEy2b
        4FXaGJ7hiGJlYtKVx0NJt2dSoB2WhavP4z/DjADmSQ==
X-Google-Smtp-Source: AHgI3IYv/DIoBrv+G3AUYclKLXmS8iLMb6iKWzvgdJfeJ22yOOi2PHT6E8ijaHvfp0g6HADCq4BjxSZTQZf+g+L85sQ=
X-Received: by 2002:a24:d4c1:: with SMTP id x184mr4308688itg.174.1550652517943;
 Wed, 20 Feb 2019 00:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20190220045946.7452-1-vaishali.thakkar@linaro.org> <20190220065541.GA8860@kroah.com>
In-Reply-To: <20190220065541.GA8860@kroah.com>
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
Date:   Wed, 20 Feb 2019 14:18:27 +0530
Message-ID: <CANNG1HXOjyENGocm6qyhoS7Os8AU00e+2_HhqJ_8r7sXQkHOPw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] base: soc: Export soc_device_register/unregister APIs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 at 12:25, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 20, 2019 at 10:29:46AM +0530, Vaishali Thakkar wrote:
> > From: Vinod Koul <vkoul@kernel.org>
> >
> > Qcom Socinfo driver can be built as a module, so
> > export these two APIs.
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
> > ---
> > Changes since v1:
> >       - None
>
> This is fixing a build breakage introduced by an earlier patch.  Please
> rearange the patches so that breakage never happens.

Ok, yes. I'll put it as patch two [before adding socinfo driver].

> Also, any chance you can properly "thread" your patches so they all show
> up together?  git send-email does this automatically...

I'm using send-email only but I was sending it one by one. I believe
that's the reason why didn't come as a thread. I'll fix that in next version
too.

> thanks,
>
> greg k-h
