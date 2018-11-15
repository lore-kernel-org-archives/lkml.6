Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B62C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9EC22419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHh2mbRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9EC22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbeKOUPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:15:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40716 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeKOUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:15:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so16757472lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 02:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EV9Xaw3aIvcjaEeSQdkxEOQrgYQVryj9pE4wCPEaBMI=;
        b=XHh2mbRV/0AnIRxs158CJyuPBmA/L68zsw0fbUtjhdZ17lCz7Wux7Dm03oakNiviJl
         5X4jML4r2Nc3cKQRrr+zg0E+CY27J+/uFEKpLYqRtyV/DQp0jz1QhW9YiRRpOA2xEiXS
         InRW1MkIhh+f77mWNoOrEcrF1PuFkTjZ3rvE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EV9Xaw3aIvcjaEeSQdkxEOQrgYQVryj9pE4wCPEaBMI=;
        b=nquzBrOLwYECHNQBZsbRo8B7+0ftu9XOa2hvnoG6P+wYVN1kPQDJYY4LjkCxbyPBTP
         jDJ5OyIkzw6bWGNRVjzhxQBulJtoE8UwXpFQwpp2CnNl2la08MD78VNMqXooPJ1QLuh6
         UKyZBcdaV3a8zRZ/CvPBN/XCekarfCUpbznMe/TfG0NlUob4PKWgDOIsW5NTpNrQ+UUj
         NjBjJYLQGtkQQE/qzmeOWzG1pMLjLU1Lm7C3/RIbXRWCgf8q/A7lHa1oSlu5EPfP4v1p
         pFaAgwl6MFY9sMAPBVh0KLw/EuDwCL7XWZpHsmOApQb/gihaNiU4WciJp9a18RIWEnt0
         Mjag==
X-Gm-Message-State: AGRZ1gLEfZaHtY/omIRrN4UgT5gWeJpFrm7X0v+2PipNP21SxW6LcGKo
        pazWZw8lunF8pLT9i0au4N5J7+iX6BpRbkV5OkeifQ==
X-Google-Smtp-Source: AJdET5f+M1xP/rt8wD+vxwYeEds5yXVA0HJnTCCvjvfHBPQXuVLhkghg6x24P9YCAP1GgRuD4uwQKGlTG1iz3neCs0I=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr3261775ljk.4.1542276479500;
 Thu, 15 Nov 2018 02:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org> <20181107174844.5381-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181107174844.5381-4-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 11:07:48 +0100
Message-ID: <CACRpkdafzzsMdCSNPsk_FaF1iqJv=oXwKvB-rq5j5Ey+RNd=JQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: mediatek: x20: Add pinmux support for UART1
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

> Add pinmux support for UART1 on MediatekX20 Development board based
> on Mediatek MT6797 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
