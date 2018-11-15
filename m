Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575E3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C61F22511
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0PVt956"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C61F22511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbeKOUNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:13:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34600 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbeKOUNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:13:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so13723949lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 02:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9xmuD29golhRbMzZC1OkEZTzZxnb+j9vpQuo3mwuWM=;
        b=j0PVt956gXPXEAICuMY/qFKZt/1deiJxcydV2B58zufHMdyqv+pOwc7/OhpqzrilcK
         sGFzCgas1RDG+Y2DWBOEnBwftqIMi0iyJRrjY225CmTmzs1T25TONTkPsHzcLHp2/7CI
         85Jc1R1zmBj0nVV0bP5JyhDMmJZwVyfMv7zfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9xmuD29golhRbMzZC1OkEZTzZxnb+j9vpQuo3mwuWM=;
        b=qj09LmG/Lsfjyj+VZVi+SyYpOiIFIWuvRA9Fq5a7pE1SqznCL5w1X6ZaLiIiYmQYde
         x2U+ZUzYoj6B+TalOv0bMa9RY5xcq1ENcon8oPJKT0zUmTs3jNiPj7+OHTb2q9y2ys/k
         yWvinqodpgoSqhvqvjsYkS7Zwk+wv3YxGpSrRxHwieG8ddK/wiFj8VwbuubbCstPirBk
         rI1YjgMrX1smDR2jkZOJ9xdt7hOEZLBuFeqrab5vw3+gzrs4IbOz4B/whoa6hvBqo5fq
         PC6zl8y5Yu5jtY0CdPqhbADDoWiHInhtwig94jYuQO62xbWjh/pgYYJPKdbBIdmX5pJG
         qsaQ==
X-Gm-Message-State: AGRZ1gJ/MRGu5+69mq/tUTGxpoSefkwBg3BTPRudINqOHe2Aa40H/rYg
        75RMBYhAqHzL+DtcNXBAxeIQto4yym6XkYJw37g0Dy+Wmsw=
X-Google-Smtp-Source: AJdET5diWcql3sbmVXUYXSGTxnDNOBauhiz8knyC8bgLJj/at7ZO4jfozURFNNCfrXyTVKXjISFGbU0gUa/6ZORnmQA=
X-Received: by 2002:a19:5154:: with SMTP id f81mr3223929lfb.96.1542276402376;
 Thu, 15 Nov 2018 02:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org> <20181107174844.5381-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181107174844.5381-5-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 11:06:27 +0100
Message-ID: <CACRpkdbk+KHtt2q=i5kUYOtPCmq4PsnhBxnC=2iSVVLg5ekL7g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] pinctrl: mediatek: Add initial pinctrl driver for
 MT6797 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     sean.wang@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 6:49 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add initial pinctrl driver for Mediatek MT6797 SoC supporting only
> GPIO and pinmux configurations.
>
> Tested-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Sean Wang <sean.wang@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied!

Thanks for fixing this driver.

Yours,
Linus Walleij
