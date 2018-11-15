Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C348422419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcUHwk/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C348422419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbeKOUOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:14:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42077 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbeKOUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:14:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so10108134lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 02:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxzd5MBZH9zzK+XKhursnZ1G2JQb3P8B2Gj/36JGOYg=;
        b=FcUHwk/iIRfQCTRSkOa+F++/PkHIN4Q3g3GrJ6QjcOfJRm0P/x8Vn/Drnl7vPIx5oz
         OBGRhdUObQklOfWRd733LMyKQJVoxO9u5hyXoKd/ToI1A74IFj7LqecDTXUv1yAG1x3C
         bowrNFiJak6lDtbJyagS7d44gN0HNBipS8IIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxzd5MBZH9zzK+XKhursnZ1G2JQb3P8B2Gj/36JGOYg=;
        b=Rn1kE9xpRFxbRCL3EmDKmWcyfxdYGO3nfZZcTdFoUpxWVgmRi/TEvUWx1rx7qA/n1y
         Z5OasW9MaDgLDzXOsicS4Wmh+77FwXpnN5Uf0DWvz6eP/npI5PTe0Ia/Dpk3xmDuvMxs
         Sl8PwC2NUgTF7fm2eudfIvqkM7wlJn9ZWHkLzpqvA1B51WMazj6EQRmMKrC1A7XikGaa
         V+uZiCy7EKDtEx1D4Fx58z+OxlFIrD80R54BUP4AELQOKqQE5pmt6t3+gu/XeOw9tJRT
         uL7HsufP9IO980gmIFo/wrqQGk+eCpvJqjMTihsJRZ72KZeR9aytfDkkmivxBmtXVn8m
         F3dQ==
X-Gm-Message-State: AGRZ1gKO+7/cgb2+K11ZcI8yxjciij74QPGN2K5VG31dmDFnPyTsPVZk
        yZ7+aeO77RYiQdC57NLskMzV15nDTptbixnqeLrgVw==
X-Google-Smtp-Source: AJdET5cn0FAntD2uVapUYoXNwfwOgArbRaztzmgsKfkOQT+nK1+WE1g8e4YdBB+lgek2cI5q0cJvr7C7cNnm5qkUzM8=
X-Received: by 2002:a19:f813:: with SMTP id a19mr2959523lff.67.1542276430843;
 Thu, 15 Nov 2018 02:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org> <20181107174844.5381-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181107174844.5381-3-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 11:06:58 +0100
Message-ID: <CACRpkdY=YF8q=1wYigLH83LLHsGdTO_VEpAP=oj8ojqbmLKQNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] arm64: dts: mediatek: mt6797: Add pinctrl support
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

> Add pinctrl support for Mediatek MT6797 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
