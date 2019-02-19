Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6643C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF3321773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOTj3BiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbfBSCCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:02:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45057 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbfBSCCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:02:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id h10so13486304lfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcnbqpCZV7oZoIeFWkaBpZMqNsVEuoeZic15bWPHp4U=;
        b=VOTj3BiTqO8tygUakZez2iDk8g9RuLXtjFVQeCcX7KTnF/D27OqHOWwuwUFMD2QlcD
         11Rf0gu5FxN5P4CdteT9pSTNsToSRwf/MCDYARJfCBJmE+lJGfa0Ae9HxmPfA3EpW0I3
         lZR1UcEfUhfAOHf6fc9wUSzniBjvQ9tJ51tVApekq09PeMp+8g18ky80uvI+P3SVB1hP
         ZAwyS63MGFSSCWiAe7IIomG53pj0sovLda17VHiwVfu7wnsQ2ZZjSP2U3E1QO1UT7bE6
         2FDu6yw2TjZbk4t9hWZD4fAgzgas/w4MG7u0AI4SkrjqBnocjq1M3exv7py/rkTpUQYv
         tfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcnbqpCZV7oZoIeFWkaBpZMqNsVEuoeZic15bWPHp4U=;
        b=jzX+3G3bTESWUrKIAey/Y4eJhqTzBFQtYv7S40k9ggaRubVTUBbgYC06ixzySep4e+
         fO0z/INhXCfdqmepFsCwPcjgFhF0v2DHSILtNIZGJljztjSiW4XaNtOoCmVgi2+3AFB3
         ypjkb/aFQN8D1EA3MMkadl+PVFebHEYoEHomSiG9ojCllYdpGUqBkcG5F6GNa6Pbvftg
         bFG3vT2drj+7lB2r3OOBkR2eOaI3Ho0K6E4U011GhedjjgQcuILdwzd//BV68f5NomJA
         wA68gJipNhzBpE1fJDKGA2kjUEwdT/6zxWgZjBZnWQtyAmJcOhDUYxZnJWlb0U4GwxiZ
         SBTw==
X-Gm-Message-State: AHQUAuZTun+wD7oFf8kffBYZIHidZYGCxnSyFvDnEBpcHvcoA7eOwO+L
        F/6Bl0sj+vQFSWDWwS3x9Ljl9p6BERmKCmejaPLWkg==
X-Google-Smtp-Source: AHgI3IZH5avpCEY957HeWO2K0OrdiPCxvFFUGA0f+RZnJODls9Ap9yN5ArFCNUm5mXEle8zeqL1p3V1d12SGqxIM+Ls=
X-Received: by 2002:a19:e601:: with SMTP id d1mr16451771lfh.71.1550541740276;
 Mon, 18 Feb 2019 18:02:20 -0800 (PST)
MIME-Version: 1.0
References: <3818909a5d6f956ef30ff25cfc42f7550d062086.1550201284.git.baolin.wang@linaro.org>
 <ad2fbe222ad715b3f7e6e093a7f822743e465f9a.1550201284.git.baolin.wang@linaro.org>
 <20190218200737.GA7091@bogus>
In-Reply-To: <20190218200737.GA7091@bogus>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 19 Feb 2019 10:02:08 +0800
Message-ID: <CAMz4ku+YUfOzWf4gAvicEq6hONK9m54oRxrYX_L6PtDcoV2-ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: sprd: Change to use SoC compatible string
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 at 04:07, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Feb 15, 2019 at 12:55:19PM +0800, Baolin Wang wrote:
> > Change to use SoC compatible string instead of wildcard string.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> > Changes from v1:
> >  - None.
> > ---
> >  drivers/gpio/gpio-pmic-eic-sprd.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
> > index ac573da..24228cf 100644
> > --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> > +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> > @@ -364,7 +364,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
> >  }
> >
> >  static const struct of_device_id sprd_pmic_eic_of_match[] = {
> > -     { .compatible = "sprd,sc27xx-eic", },
> > +     { .compatible = "sprd,sc2731-eic", },
>
> You need to keep the old one if you care about backwards compatibility.
> If you don't then state why in the commit message.
>

As we discussed before, our dts and drivers development are still in
progress, and we always recompile and ship device trees at the same
time as we compile and ship the kernel, so we do not need care about
backwards compatibility.

Yes, I will add the explanation in the commit message. Thanks.

-- 
Baolin Wang
Best Regards
