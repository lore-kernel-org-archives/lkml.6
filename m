Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AB2C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9D4273B0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eo9rXbOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9D4273B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965630AbeF2M1f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:27:35 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44500 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755418AbeF2M1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:27:30 -0400
Received: by mail-io0-f196.google.com with SMTP id q19-v6so932054ioh.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uSk6Z5HlIlUWsjDdk1pVu9b2KOvd8bjj//u8YNRjyHI=;
        b=Eo9rXbOqI+0sKSAI658sVvO5c2DnVbWrTJwD3jFcV0A8r4Zi3jMMqFLXgrFJ14dvIn
         GrQ9ok+ab0p9QBPyMhL7k/ZWjHKDYL5uE/3mTQr/zXn4IGZuCdW4OPw921iwWwg0I5mm
         h3AJaEUy6jTLnDIXBusOuoUSW9mXOQcDQd+k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSk6Z5HlIlUWsjDdk1pVu9b2KOvd8bjj//u8YNRjyHI=;
        b=jze9XZ7fZIxB3394m6n/zYd0yT5Sks3/jQTaDxC/hllxvnRHlol3d2UPUSZu8DR2Sa
         MxsLgxjtGzj9hLJJcV/z6Hh6WWVIysIL7KfOJzqWxhH7fSdghxtoLg0Ova3sG0/dVCp8
         LYZ45A7aJeRDPfrLBYKKKcfiS4w6sgRPjQu69vJK1kN6hicdez0Tal/Mo/d2qnq+3XKJ
         TzomEzLxbr2lZzQd/G7HKF038G3Z2nj6DT+UPsGS8HVyxUewh8OX/rFDeS8vy1eauWr7
         dmaAy73bRJ8g4LZmqrGm9v6VlWeP6sXTfp9gdhOCyYRNiRvXXdCtPVhvjXmR0tFfs33z
         G/vw==
X-Gm-Message-State: APt69E1PgyQsio8FyJEH+89XnNFuWiuyFsurkKkGWUOHMSGTZFD/q3HG
        bVRq01lwK7sRQnp5cZGbPWJA8NpylaWpobzJYDiyZg==
X-Google-Smtp-Source: AAOMgpeFJ4KSo4MPh701dsKT0NcJYoDuuwL9lF5W0J3YLu54cPtHNCFNLXXeWetw7zy5MLO+bCWFEbmPYf/i6CYFEPs=
X-Received: by 2002:a6b:6c0b:: with SMTP id a11-v6mr11849419ioh.175.1530275250087;
 Fri, 29 Jun 2018 05:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180623045954.6729-1-manivannan.sadhasivam@linaro.org> <20180623045954.6729-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20180623045954.6729-2-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 14:27:18 +0200
Message-ID: <CACRpkdZ1kE3Bop+8rdwJHFcV-Ss3F0LwHUA8zC7nepyxCyGEbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: Add gpio interrupt bindings
 for Actions S900 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 7:00 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add gpio interrupt bindings for Actions Semi S900 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied.

Yours,
Linus Walleij
