Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D7BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349C520842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4Za/gGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349C520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeIYPAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:00:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42846 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeIYPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:00:13 -0400
Received: by mail-io1-f68.google.com with SMTP id n18-v6so19834797ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cTGfDyko6EJa/1U8+oOmobay7ODVbC7xyYSYb1x6+io=;
        b=C4Za/gGp2rR3YHR7hgvrRRgjD0EWOGCJTxBiSvujLYwQ7MteL4hxt467Op8uGR8EcV
         hXr0SmDP8eB3Z9bK24SDip0L6YxXve/b0sKtFWC/khoahS3rn+pxKs5YSsz7o3Hn2ziA
         yOw6f8GblckVv7NzUGPOkjfdL/PPLhxZPuk7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cTGfDyko6EJa/1U8+oOmobay7ODVbC7xyYSYb1x6+io=;
        b=mJjtLxM9T00Kn8bFEZpp1o0yIHizvhGMftfw3LoGMQa51zOfjPlbu00xeh1KscksP/
         cc5hAYFSXu3cYHSIqdJBsMkWGhxqMwBVLSkIOThBwCLQSL9AhF4sGtXCF4s+fRTSCCNc
         cwvKW8yKpvy5ai2Vcus+LIRwLHy9GWa2hE3nicpL1rp14usJTAm+O3Gm59CUHQCFLvf5
         cuITfCoSA4zGN0VHi8kHi2128VaK53Lo+JE6r87losmDKfIHcAIMKhAOTjF18lTL/yjY
         60jmSbI2t+z99zE6X09FkwDFFhCXmiuZpNV78XmNNxXRvoeVQ0eQcJqPfc3+I+i8GNAd
         EZYw==
X-Gm-Message-State: ABuFfohalAYxVV9o5hzXNDrv5cHUlbJuD9TTh2+7czxslg0PZ2p274LU
        WpgKJ8RCRcTYwmbyUWTpvsBDJ4y74LsnmTTf/JMm6w==
X-Google-Smtp-Source: ACcGV61K8LJKn7I3zeV4Dbx/saWJZLA6hGOgfiGeDfUBYnP83RcWrciWIe68h9dpjG9BaZ6wrlBStlHDiK9N44hqEnk=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr2097811iog.175.1537865623372;
 Tue, 25 Sep 2018 01:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180923111727.10378-1-brgl@bgdev.pl> <CAMRc=MfZ8jRZHgXBq9TeYm5VpmLzwG7gF-NMYay9Zg-iEgFQDQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfZ8jRZHgXBq9TeYm5VpmLzwG7gF-NMYay9Zg-iEgFQDQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Sep 2018 10:53:30 +0200
Message-ID: <CACRpkdb7zKfa_e6WWHncg+gxGncsC_Bx7gpkhJyutH4tqJRkew@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: use device properties instead of platform_data
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        vincent.whitchurch@axis.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 9:35 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> niedz., 23 wrz 2018 o 13:17 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
> >
> > Some users want to introduce device tree support to the mockup driver.
> > Let's make it easier by switching to using generic device properties.
> > The driver stays compatible with previous use cases and after this
> > conversion there'll be no need to change the way probing of mockup
> > GPIO chips works.
> >
> > Tested with libgpiod test suite.
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
(...)
> Linus, I just noticed that we either need to drop the check for
> -ENOENT or add an else that returns on any other error. I'll need to
> send a v2

OK business as usual.

> but I'll let you first tell me if you like the general idea.

I don't know, I'm a bit ignorant about the idea, scope and
ambition with device properties.

In my book this relates to the fwnode concept, but maybe
I'm wrong?

Mika, please fill us in here. The device properties in gpiolib
came in the patch
"gpio: Rework of_gpiochip_set_names() to use device property accessors"

Yours,
Linus Walleij
