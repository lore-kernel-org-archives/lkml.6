Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA2EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AE120700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lClCo6fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfBVOWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:22:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38031 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfBVOWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:22:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so1981350otf.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 06:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9SDN7dqJacD1GN3oeQM2fpj43Q/aIqnmX7cc2ol54s=;
        b=lClCo6fzxAtT+Lm/n/Hqzvo0F+IjlbBifLJry6KnWNyXVzsv7GXi6oa1pIPYzVn7t3
         oSowjtSgVd1gUvqLdpuHmiPf32WZpl75QuSVyJSLEHSn306DBtmvfhiEt6raIVAxG+fG
         LGNDQBbS/dEB/R9LLMSGV6HLg1Uy+oTiRBwr9w2c5QC1UISw797LkeocmG8eKnZMaQCI
         0R6UIy+Gnx/avkTnw4pP9IF559SoGsnY1c5ew9nrWtCtHSOfQEqU/m4vIbWn3zTg8dIS
         IP7+mxgOlxccOTqf8ZV1NLigP04bBnbI1SDYOOh5Nw1LRSz3O7WNPAe6U+66+GhiNv1d
         b4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9SDN7dqJacD1GN3oeQM2fpj43Q/aIqnmX7cc2ol54s=;
        b=CktDBf+3WTVTimO2VuF0+icjqHnZk+aNz7vu4XUq/WDncCCp1jVyKq6MrU6hA5Rx8x
         dZ/fFdAomjk76wnW/3G739UTcyp9ibGBCWLS2394xVwQZ7pnCvb8KfwT+Glyj5Kr4orJ
         GQk2MWC4OLRT4frhTKu82wnV2+GDKl/p+LH+Em96Gb10Yuydkrr+jmoBpYA6WkMTQi07
         kbeMjkmN2YwOP3FeQcF2qew0LVeS1lAfs0VpTfFr80HroB/bCfBfih3uAquZg9LCSbmB
         0jfx5x947YLowv22FCnBONdR2+VMXFPxgyD0zgy1pHqwlK+S517W4Yqwd/8ttmaZnVQo
         wQZw==
X-Gm-Message-State: AHQUAuZezyyyTvNILvUytOa7D8b6PI9Fw40SGSw9K8EPKuf/S0Y075p9
        7d7ll3lXd8132AjplaSmJYS7/3b5VCdSVYRny+jJEw==
X-Google-Smtp-Source: AHgI3IY6imePKmuhbBEv22jYuGMszEQ/iGPQ7ToGjA0ejNwsznpAzee3yq7hkkHigcu/7DlYiNryYZQ3BdmpZY6srdM=
X-Received: by 2002:a05:6830:1292:: with SMTP id z18mr2781095otp.161.1550845365026;
 Fri, 22 Feb 2019 06:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20190221162627.3476-1-brgl@bgdev.pl> <CAHp75VfKq5rkLUzW3HL8+a0wmaqGz7nz09Ki0nc0TxQDJb=9DA@mail.gmail.com>
In-Reply-To: <CAHp75VfKq5rkLUzW3HL8+a0wmaqGz7nz09Ki0nc0TxQDJb=9DA@mail.gmail.com>
From:   Rob Herring <rob.herring@linaro.org>
Date:   Fri, 22 Feb 2019 08:22:33 -0600
Message-ID: <CABGGiswPUe2PEmi_7a7SsB6vK7WVHysOoNkueoG+3h4RdfmB8Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 1:56 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Feb 21, 2019 at 6:27 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We only build devm_ioremap_resource() if HAS_IOMEM is selected, so this
> > dependency must cascade down to devm_platform_ioremap_resource().
>
> > +#ifdef CONFIG_HAS_IOMEM
> >  void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
> >                                              unsigned int index)
> >  {
> > @@ -96,6 +97,7 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
> >         return devm_ioremap_resource(&pdev->dev, res);
> >  }
> >  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> > +#endif /* CONFIG_HAS_IOMEM */
>
> What about declaration in *.h?
>
> Perhaps you may just do this inside the function?

Just a drive by comment, but IMO we should just get rid of HAS_IOMEM
altogether. It is really just a !UML option as I think every other
arch enables it. If folks really want to disable drivers on UML, just
disable the subsystems.

Though now with kunit mocking, there's a desire to enable HAS_IOMEM on UML, too.

Rob
