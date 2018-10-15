Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930EAC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4132E20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/mmGVte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4132E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeJOWKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:10:21 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35085 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeJOWKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:10:21 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so27935962itp.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7G7Op1EcZSBMYBHVx12DGDonIG9x/fcT7AAkIA1kRY=;
        b=M/mmGVtew9knGzeEZ3kGtUvYVqdDWlSFRFtDdreYqSWYbti7Q2vM7IQ/MfovqxlGLC
         5da653L9ytLblETn/z+tidSKmIm2Ed5rhC9KK87zenX0KZe7CoNMwHaVxaQcUzSgVTrq
         5v3qx//oysaUh0ExPwgpC5CwUdy/vJcaiKiDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7G7Op1EcZSBMYBHVx12DGDonIG9x/fcT7AAkIA1kRY=;
        b=jVRjY4jHON5FQkPvkgy31IhFmLZ3QGBSfYGCKUO9xEperxQvs7L/yAC5SGir51552D
         eyg9TQMAdUvECTwSdP+efGXmKI86c62q1vdR1kzPM7ZWNFtIBXGhFcw53IYdks6U2Kd1
         a7Mvrwc+ngCh3NzcUySX6nNE4T17sF3qR0IswTqCdiYlgNz05pXRaEk5J0bHbazg19it
         RtBCKBRvJrlW/HisX1hlxrss2NoJzrsCExZGk8EDmxoJSO8G1EX1qP0JxbxK5lWkVwqA
         yGLP+vOopdumeYP/oFVHNhT+9E75OLTLOr1+n7atJL5espRLJubuZkC+bzR8WqcBL31y
         8K+A==
X-Gm-Message-State: ABuFfoivo8k8E1zXCmbBAvjlNh0kKvxRa19ZNAZl+n2mVZ+65fSG127U
        LsSQzQRh6XYusmgcdeyYgjRpJ70VD7nC02MAGq3PGg==
X-Google-Smtp-Source: ACcGV61AVpzlI5pAyf2MXsresOc9auvoXZUR2Br8mAzh1B7wAnq6a+TvjD0btpaAfIz014HpvJHMMyzcHUq+JwZhC1Q=
X-Received: by 2002:a24:7b50:: with SMTP id q77-v6mr11267559itc.154.1539613491081;
 Mon, 15 Oct 2018 07:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <8bfd2cd6-702a-878c-ac41-b61698835f1a@infradead.org>
In-Reply-To: <8bfd2cd6-702a-878c-ac41-b61698835f1a@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Oct 2018 16:24:31 +0200
Message-ID: <CACRpkdYMfvPAsfvJ2UyXXt-M9goyUfXumF=0suzGHqVZO=k2Kg@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: fix SNPS_CREG kconfig dependency warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eugeniy.Paltsev@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 5:46 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix kconfig warning for GPIO_SNPS_CREG:
>
> WARNING: unmet direct dependencies detected for OF_GPIO
>   Depends on [n]: GPIOLIB [=y] && OF [=n] && HAS_IOMEM [=y]
>   Selected by [y]:
>   - GPIO_SNPS_CREG [=y] && GPIOLIB [=y] && HAS_IOMEM [=y] && (ARC || COMPILE_TEST [=y])
>
> Drivers in drivers/gpio/Kconfig depend on OF_GPIO, not select it.
> This prevents attempting to build when OF is not enabled.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
> Found in mmotm but comes from/applies to linux-next.

Patch applied, thanks!

Yours,
Linus Walleij
