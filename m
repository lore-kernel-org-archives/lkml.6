Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AFB20665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLTxz+7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfBVQWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:22:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42083 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVQWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:22:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id d14so2134078ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBnDhiH6X97eUHuKpp9UTtGX0F0DwC5j05TLTxGf4Lk=;
        b=zLTxz+7WfFs/qSaUyD/KL9dsFXo5nR0vv1lwbfYRYszZhERqJdZlCPDjubcM8SbIHr
         AhM/NwNJg8MQSiMdONoL2WI8muBHBypfAiP/sXIZ/oyBNpDSmoFFnerlMV8Q+MysFppF
         PQB4DhCpk/d6e8Q5BenJcVvIKuOUeihUTAGwieRsmptITpO0KnIEwtl6ath5gcEROVXF
         XSam6MKhq5TYLPNaQ43OiBhRCqpe7Sag8osG6ehsX4t6yoU5xVhfcIxlkQwKXZ6Dy+al
         LWF0NJMG7C6uhpUrNZhvgebJQTIc1o65WxSYO1BlTTcJoUZpv8kr2E2huIOngPnfcosY
         WUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBnDhiH6X97eUHuKpp9UTtGX0F0DwC5j05TLTxGf4Lk=;
        b=IcSvFxUpJT4XVAeJw6sSVo/4kEZmwJJwgG6F/2EitKCfCEShwlsyJujZL4m45DKNjR
         W0O73J5ZRMOUvtPAgN2ns0BVCS3v5305gaP6lW57CvHIS3V0XBbMjqXAlfAKFnSWfHfc
         go/UzoG0CdLoLxgSWbew7AQReyGWeDpvL5M3mwa7yjU0U4jmdJVJkz4Dapo+xgYVrkxS
         +F62axoHIRKwMpHGlydWwXzIH+ic2n6KQEuoJmsAZ5Pyst5KcI23RAffRRJ5EGjZn5ns
         9WM2/BghnZLWmjVFM7Bp2T+CdTjVZfOg4NH60GC0OOppP/z46nlfiECiiT7M8OoLA3Bb
         nyHQ==
X-Gm-Message-State: AHQUAubBa+whmSOrQuIPM7+DksJpr3FleLcAWXf+nDksgetlbcx9Tx+J
        l5VLhO8pDzRaCp8Hdb0QUyQn2v2BRga0sRzN4Sf0qg==
X-Google-Smtp-Source: AHgI3IaSTyaQEJyl6WlDpcHvMDkaxAmnTLeQZXTtjvLdC1q2ZrVSUS06zCGCy2a1yCTJsDA7cTbB4OUqe14kNnfRq7M=
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr2923332ljc.97.1550852550648;
 Fri, 22 Feb 2019 08:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20190221162627.3476-1-brgl@bgdev.pl> <CAHp75VfKq5rkLUzW3HL8+a0wmaqGz7nz09Ki0nc0TxQDJb=9DA@mail.gmail.com>
 <CABGGiswPUe2PEmi_7a7SsB6vK7WVHysOoNkueoG+3h4RdfmB8Q@mail.gmail.com>
In-Reply-To: <CABGGiswPUe2PEmi_7a7SsB6vK7WVHysOoNkueoG+3h4RdfmB8Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Feb 2019 17:22:18 +0100
Message-ID: <CACRpkdbeyoQbVFDFq1Z3NXoWgu5F2a2pNQd9XJ4KkOws7_gUVw@mail.gmail.com>
Subject: Re: [PATCH] drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()
To:     Rob Herring <rob.herring@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 3:22 PM Rob Herring <rob.herring@linaro.org> wrote:

> Just a drive by comment, but IMO we should just get rid of HAS_IOMEM
> altogether. It is really just a !UML option as I think every other
> arch enables it. If folks really want to disable drivers on UML, just
> disable the subsystems.

I just got a build failure from S390 for the same thing so apparently
there is S390 Linux without IOMEM. I have no idea how that works
but whenever Arnd start talking to me about how S390 works
my head start spinning.

Yours,
Linus Walleij
