Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B54C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E773220880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550671191;
	bh=Ud5jdsFYmSg0ZW5/m31OCJLPGcn72YaVm0ChgdxLfuA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cRhaKo2FCA7yoFOBrNut0PJSU2nAp76IG0CKw+K8/qYdyVBC2N6/6bcbrboCGY4L7
	 dzQ+eVI0JIwR5+Bu2t41Qvee+H+KjIuk4ZtZ+FM62JrUNQXf2hBLllUOghLIHgZkYd
	 EA8G4NVlAaqRC7J63UMN5lZbVczxvuu7syaVDaZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfBTN7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfBTN7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:59:48 -0500
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97B922183F;
        Wed, 20 Feb 2019 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550671187;
        bh=Ud5jdsFYmSg0ZW5/m31OCJLPGcn72YaVm0ChgdxLfuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E+BuyOCEFRhGhXZyV470muEmYhe5q47bUMt/wF2Gi/QHUvt1f/Mo+U/D91fkrRxqE
         Jr0A0dMoinHAeFemKJ72cpSwwjytmhlhchJh/hjeSekN0acuit8cHajFvKuBRwpXt5
         ASt4zIi9ifC0ipzXk/3r9I1D08x6+isaqYC8qExE=
Received: by mail-lf1-f46.google.com with SMTP id v7so17663170lfd.2;
        Wed, 20 Feb 2019 05:59:47 -0800 (PST)
X-Gm-Message-State: AHQUAuZHXSejx/hnLPBC7mARNOOMnCeQ3ogysBZy/fI1xrmQTBlGGJBv
        UhZ935LXWgEK73l0GdqRR+2lEhSj+pSMeVu9QBE=
X-Google-Smtp-Source: AHgI3IY+0B2iQKWk2fzKTKhsS0W87BddOqWyWa+1UJI1wXIbSLKWgt6UG1/re8aFf1EkDVQycKchEv0fWqzpwMY/IYE=
X-Received: by 2002:a19:d83:: with SMTP id 125mr19889468lfn.159.1550671185658;
 Wed, 20 Feb 2019 05:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20190219130337.21353-1-stuart@menefy.org>
In-Reply-To: <20190219130337.21353-1-stuart@menefy.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 20 Feb 2019 14:59:34 +0100
X-Gmail-Original-Message-ID: <CAJKOXPediHZqN3MRMYUaQT_jKyvb_20fxZm8paV1AVysWHScsQ@mail.gmail.com>
Message-ID: <CAJKOXPediHZqN3MRMYUaQT_jKyvb_20fxZm8paV1AVysWHScsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Devicetree updates for Exynos 5260
To:     Stuart Menefy <stuart.menefy@mathembedded.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 at 14:03, Stuart Menefy
<stuart.menefy@mathembedded.com> wrote:
>
> These four patches are stand alone updates for the Exynos 5260 device
> tree, which do not depend on any other code changes. They either
> fix issues or add functionality which is already available
> on other Exynos devices. They were previously posted as version 1
> of the larger patch series "Resuscitate Exynos 5260 support"
> https://www.spinics.net/lists/linux-samsung-soc/#65035
> which was only posted to the samsung-soc mailing list.
>
> Changes since v1:
> - Removed from larger patch set for easier review
> - Applied reviewer comments to patch 2/4 "Add high speed I2C ports
>   for exynos5260"
> - Expanded patch comments
>
> Stuart Menefy (4):
>   ARM: dts: exynos: Use bustop PLL as the source for MMC clocks on
>     Exynos5260
>   ARM: dts: exynos: Add high speed I2C ports for exynos5260
>   ARM: dts: exynos: Add interrupts for dedicated EINTs on Exynos5260
>   ARM: dts: exynos: Fix interrupt for shared EINTs on Exynos5260

Thanks for the changes. All look fine to me but it is too late to pick
them up in this cycle. I will take them after merge window.

Best regards,
Krzysztof
