Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE214C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A17A2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSn0WLhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfBUMHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:07:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37118 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBUMHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:07:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id m9so4082559qkl.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGmORHON7PurEiv4frhU7uddTr3DVhA8QYH5qqWp1T0=;
        b=eSn0WLhKSErSZPH26vbyhSDhXHZzgzxfGeTqmGNP81ZJCYBoBNSSaQkphOm6ytWJag
         nylqZ+qtoQK4gzkRGdrDdMmuG03hbLlp0CM184lJSwPAwbxVZvm5VfvZ4I5IaJ5c3SQ9
         HLYzTYX4mW+ZN/RPaU3BA6+gHbDylPAO7tkQmmCUQI++AqD9uGUBFzkX32fba4yxvJ/4
         iPHk38Ke69aQvlUvd14z99Bwafs5a2MWk8D9vGmgL4o1QR0j1tqGV+8pnoCXz2MKO13D
         NdxQ2HX7RHkUoROgaQQ8SFMhQs5mdX2G564OKSodpnpfnXxsoRJAAgKpNCo8IUljnfKO
         tfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGmORHON7PurEiv4frhU7uddTr3DVhA8QYH5qqWp1T0=;
        b=JaUlBfyn5h7Z6k6F5UXmyWfr2l1b+OgdkiM5Kh7O676fWEQHNiQAvWkmQlk2y3NSF6
         pjr1ULbhq/8iuOXxHDqFfhc2ZAhg6jqTaVY2vholT0AXVnmaucU75jmuDJJIc+z0tcP0
         y1/037bv2LnxeX094aeCCdszGZslE31O4mFFvuyXhRrw+YC5KdsipOM3xgLTskvS6Llm
         fLpoPJik2stSCFpxKx0TRDzGTN6E2iEOHbhuROEoE6V61L6137vlyKylhRfZ5xeFFm/E
         xsr3vBLdSHyXSJZ9O+xkn1RMvASjNIT1romHfcf7i/s5p8XtVA9p+ICJ0Bbxat8qmhiI
         FN+g==
X-Gm-Message-State: AHQUAuZMOxxVrguJpumoln8F08I0yv3361eSE8hT5VXeKNLOtcvST2aV
        qQwntzkhGPb80CLx0nLFezXK2NGmfcQ6iydMXTo2bQ==
X-Google-Smtp-Source: AHgI3IYVMsqZtvjgIsvQ48B1zO1yPslUVWwZ4vRJkkXGg5FNR6H18EMhxCajkEe1Bu5nI90faBPOHfd//kP9rE6ie34=
X-Received: by 2002:a37:d649:: with SMTP id t70mr28833868qki.44.1550750826893;
 Thu, 21 Feb 2019 04:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20190220111240.10041-1-brgl@bgdev.pl> <20190220111240.10041-2-brgl@bgdev.pl>
 <20190220111650.GA13077@kroah.com> <CAMRc=MeXPsJCsKAnzUD7Cvhj2gy3pyd6X79e602awv3_Ys6mYA@mail.gmail.com>
 <20190220121506.GA23933@kroah.com> <CAMRc=Md0sqouS+p2RvW+fwM41eN5=P9Nd7V=gYuqxunfa3j-nA@mail.gmail.com>
In-Reply-To: <CAMRc=Md0sqouS+p2RvW+fwM41eN5=P9Nd7V=gYuqxunfa3j-nA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Feb 2019 13:06:54 +0100
Message-ID: <CACRpkdauvLkMs6HQiuuBy9ACVB+zmYY6W8FqmdUUQFrYZcHjaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drivers: provide devm_platform_ioremap_resource()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:53 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> > > Should this go through the driver-core tree?
> >
> > No need, put it through the tree for patch 2/2.
> >
> > thanks,
> >
> > greg k-h
>
> Linus,
>
> can you take the two patches for v5.1?

Yup both merged to the GPIO tree, thanks!

Yours,
Linus Walleij
