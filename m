Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEFCECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFA521525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/NnYBXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFA521525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbeIUFeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:34:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33617 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeIUFeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:34:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id m26-v6so9935392lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 16:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1oDaNhElPqcrC2hoJp3bs3kI0OA5fh15EnW9woSUiMw=;
        b=m/NnYBXYvkGIiSFv7Lpegwm47v0cUdn/6JEdHzNk+zLbpAh4s5ElZQyOW8RwXeMi0v
         MSA5+k1QXoC2jWyPWb1Hc/RmmDaqWxJJaVushXmh/du6GImUmp8vuDlRwV9FnkNmRa4c
         IyEEh5To6cRrYMcVuksDgSPehbDVqV+LeXO/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oDaNhElPqcrC2hoJp3bs3kI0OA5fh15EnW9woSUiMw=;
        b=qW8M696Ui+xueAS43IXMzLKuB2Lwk4aiCf9WxbXB0+zPwSAzdrLWW4tieEZcARCnxP
         8yQ3gS6oydVvx25VANWMZc50PMCbZeVwYj3AjRmwz7rwhwyB7Z++OL442lu/yJd23s/+
         6It+OnyRuhIlQRRdPMod7oOziZzF3uH6RfLhYMmLgKs1O1sZCOgiuv/oU2Vy459NFyGa
         0OwrUBRw5Ce7by0A21uGqM1gv8e75tXQff/XOotmaizKjKzBn6luzEzg1zkNsFOJ0yXv
         C/k2mTfuLfvjbMkOPWdOEvPYSQWBn8X84q+j8EWnQtZfzhGTXPhk7L9a8M5bLN/A2vMo
         GjGQ==
X-Gm-Message-State: APzg51Bcwt5UqlOJ3qf7XVR+Sen+AReQx1EMQoofPPvNUyyZ8ZDYnUNu
        4i4/hjVHufFHf1GCSUl7sv2R5qJt7W+CJz91d/or8Q==
X-Google-Smtp-Source: ANB0VdbsHmhNfVgigKZy4u1Ephu8yCg7JTVe3lYSmBzlgYc1dlb1iEszLlcX6U9ATCtPN/W4LkhUFGtQ4+vDz3s0TTQ=
X-Received: by 2002:a19:1a93:: with SMTP id a141-v6mr2890632lfa.23.1537487290804;
 Thu, 20 Sep 2018 16:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <20180920224055.164856-2-ryandcase@chromium.org> <3b7c090f-42ef-1b5d-0708-0b3b52d49302@infradead.org>
In-Reply-To: <3b7c090f-42ef-1b5d-0708-0b3b52d49302@infradead.org>
From:   Ryan Case <ryandcase@chromium.org>
Date:   Thu, 20 Sep 2018 16:47:59 -0700
Message-ID: <CACjz--kKjm4PnXR8Zfe2BvDYDu4KQ=3nNWfXAPwz3o_JAOw5Vg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
To:     rdunlap@infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 3:46 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/20/18 3:40 PM, Ryan Case wrote:
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index de03d67bcd2b..36922e12c3b0 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -549,6 +549,12 @@ config SPI_RSPI
> >       help
> >         SPI driver for Renesas RSPI and QSPI blocks.
> >
> > +config SPI_QCOM_QSPI
> > +     tristate "QTI QPSPI controller"
>
>         Is that       QPSPI correct?
>         This is the only place that QPSPI or PSPI is used in this patch.
>

Thanks Randy, that is a typo. I'll fix this in the next revision in a
day or two pending further feedback.
