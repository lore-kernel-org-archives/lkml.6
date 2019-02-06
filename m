Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084C2C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7323218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLBGZwtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfBFIYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:24:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41120 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfBFIYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:24:31 -0500
Received: by mail-lf1-f66.google.com with SMTP id e27so4687091lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 00:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btInbofCJRx1SCqTzId7Kc38oZooKG3fUFjk73JWQpY=;
        b=QLBGZwtHPoHI+xdn6rlLvqjkaQVgGxGpz1s/0u3SQVLVaWZ6RPjL8TjRQ3PGwY4Lr2
         o7ZvupTIOCAKQDh4LZ164vx9gPcfpNUMdVdd6nKjS8DQy+82ggEReHdThJLsTrNetsz0
         YhjrCpByZA7AdPrryXeAqd9EKyDsg3mobjhKCIfqKp6obGaVv2ta+FpRA91LbQnlGo64
         EJVX+PQndTWLFea/xI/2+h+QPhwdoYjLNQQsZVv584i9M9azedakIq1Jgbt06rPxOUOD
         2NOcYPEQvT08fz6sYWCcc1ER+OJ0DqKy4wer867JNC/SxgkyyCjmuRIHBOprSDYN8X7N
         z1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btInbofCJRx1SCqTzId7Kc38oZooKG3fUFjk73JWQpY=;
        b=rLjn9oSKiPpAytJoQ/JLJZyuDjRfaro3WRHyLKy1DNqQU5zjLYKuKGmSjv51hIfV2G
         p16VYu04NVfCORa/Xx8vn13mPcVJaCLXZrXyp6pRsJH9SS+C3SUZ9G+zyOpjc4/riqyP
         80VXIn/e3izmJHdHisC13+4pTLEhDdzSItcqLrxas8FrLkhsCZ18IPVVXJFDp8fIjHBq
         ICkH8PPQaw3Igoox+8XCjtB/AthoEXbOd6+K/QP+K6qUHXwsTfVtKcP9Mi+UrDo4jZVT
         MDjmN3bO9Ze7+FCTZpEeZZNXXH5hszTOMHUV6hyYVFXPF1AChD+dGj1tXsiHip9JZQ+j
         fBhQ==
X-Gm-Message-State: AHQUAubaju50q9OCkFNhsxp9REFXkjGAcswZAkzcemQxPt2V0H4zVQuH
        qkpjFAEjBKK+9eGKLrxPdswczUZZwgfJnrL7HDVJYg==
X-Google-Smtp-Source: AHgI3IbffUo/JZomllQ00i3PQ/KcyLP5qmvYCIio/v6rYRb08ki+2gStKTZIEmJzrlvhfcC/Qi7AdVruM0/C4BBs1Ig=
X-Received: by 2002:a19:c502:: with SMTP id w2mr5619490lfe.168.1549441469085;
 Wed, 06 Feb 2019 00:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20190131172953.27339-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190131172953.27339-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Feb 2019 09:24:17 +0100
Message-ID: <CACRpkdbWmxib6QBOdOxZV87OhDzB-ygNTFwOjL5uaPtk51_1tg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: qcs404: Correct SDC tile
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 6:30 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> The SDC controls live in the south tile, not the north one. Correct this
> so that we program the right registers.
>
> Cc: stable@vger.kernel.org
> Fixes: 22eb8301dbc1 ("pinctrl: qcom: Add qcs404 pinctrl driver")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied for fixes with Vinod's review tag.

Yours,
Linus Walleij
