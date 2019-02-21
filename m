Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D489C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4E62081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf/NVQlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfBUT47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:56:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44604 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfBUT47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:56:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id a3so4425539pff.11;
        Thu, 21 Feb 2019 11:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7i81LMu7iyoZ9SjUACWlR9UwJhZVtJB3b/j0E1pxkGI=;
        b=Wf/NVQlBwhevaWq/ZxF/KzGK0tdGntOPbniI5pW4WAIJJV2x51eVLuW4zclVS2EH+5
         fN3l/SvFDtm1ykfDOtg0kY54d4tJynKMAFRZaMQkRbrH7p4G2T7WuGAza2T1jtddrGjl
         Xich5lcBeGYQfFDZ5N/8GuKXqDP8396jjXpjx66jVeQ7jz10igSDBXbEEgTavEGlUUbz
         2rNpP1BWNWOjgUp9wiemziWlPcSgfKiPQCd5MwBZcQvbW0K28dC+xU8VORugbfNVHPou
         TCMImrxd81w2RyPFAaYspff0dZBfMWDX/TIKuUrWGhLeK/Aeg/gY3uGZH8urUW9UYHJ7
         PV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7i81LMu7iyoZ9SjUACWlR9UwJhZVtJB3b/j0E1pxkGI=;
        b=OP3jvo9k7e8I8+/s0FbJF8zLwOQCh3wBYpPhH9J74lfMQaOGIo3xdHGDkMfZTn9JbH
         gMRrW1o1U5X8vWXLgbqA8nJtGr9cAE9sjZgPW0SkVE14PzNZEWBmDm0r/l9zWHXQntYH
         9r2hqvRa2w3ZxeQHKp7pDCfrV3zwRsfQiy+BsILH5zilAlMsOZK7pq61zThTJ/nzhyRD
         s33f/nb1DvLjOMrL0Gsh7o8lFJvDg9N1eO2iqAKnQUjjUegXzznFNDyDu1l3ScA1BosR
         ML0QDSYpPmvjU5PQH3Bvaqchr/4K4PK/d9Ib7O3sBlS7OCucG1awVb0bp/SlwOEIDE3s
         bG1Q==
X-Gm-Message-State: AHQUAuaK3FmxStAQeOUIAXPtuU8oCrJPkc9b8NJZlMcgQaDSzJJhirr6
        61BCoYN38ezPEew3RorCmFQjiUuLMJThOUOuHEY=
X-Google-Smtp-Source: AHgI3IaGf5hmGBwjlPhKilZWwUKfkcgHtD6hqt/qz5Z6XqWe41kVGJXxOR3wtLyc8/njqLcjAIDrx9dW+H/E3m3+p/k=
X-Received: by 2002:a62:864c:: with SMTP id x73mr238350pfd.49.1550779018880;
 Thu, 21 Feb 2019 11:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20190221162627.3476-1-brgl@bgdev.pl> <CAHp75VfKq5rkLUzW3HL8+a0wmaqGz7nz09Ki0nc0TxQDJb=9DA@mail.gmail.com>
In-Reply-To: <CAHp75VfKq5rkLUzW3HL8+a0wmaqGz7nz09Ki0nc0TxQDJb=9DA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Feb 2019 21:56:47 +0200
Message-ID: <CAHp75Vdz=qQCie1PrcoTmF-TL+swWKLEzHQE=D5ubnmufxRD9g@mail.gmail.com>
Subject: Re: [PATCH] drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Feb 21, 2019 at 9:55 PM Andy Shevchenko
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

#ifdef ...
#else
return ERR_PTR(-ENOTSUPP);
#endif


-- 
With Best Regards,
Andy Shevchenko
