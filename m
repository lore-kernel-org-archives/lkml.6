Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC4BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977E42075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbnXC0Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977E42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeIFP6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:58:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46460 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeIFP6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:58:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id e23-v6so8697010lfc.13;
        Thu, 06 Sep 2018 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qX0s+w4s7zSVsJUOzqGHeG5lPNl5ByWNXKAb1p+OSKg=;
        b=kbnXC0EbwM9oLJ5uuOkN5QZq24i2/Aikt28OLWvz5jHWuDsDdUeaRQ5xGFdBM63juK
         KprV5+GVJCC8wFObG+hal6+e2FAxoM799+WAik/KiON6OYasBqDTJ/5kgWv311TAWnaR
         1XqV61e8xoFfjK40dg8WtDXJ0G24se8+jBG1D1W2Hb6OrZmKZsii6N58J3Cb8pxbWOJD
         CPID3zD/eXodYw1x7MP5s/OHkQW+xiGxWHzawB0a9RcDuddrcuip+28h5u2LvwnUyVJ8
         5nhAg4p3k+o2i/ASjZYpOTlGxOKrxcWVqdsQ0DNHo5IjDMwkGwLDoEiYhqgJ/6iMy8Nm
         j/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qX0s+w4s7zSVsJUOzqGHeG5lPNl5ByWNXKAb1p+OSKg=;
        b=gl0uI+E3trF2/17bF7r26DBuOIhXOtVzrxmGzsTyFbrTI7hD+JK7de6PEktpW0q+Pa
         2buBYymzBLaRLoa0mCjraihGp7yjoxrQQHkLsAVKc4hiY6oSnZsTYqPDFw6vXMrJY2Ze
         VJ9FCLcV0e/JkITsdO3CTuvXokHQWdmmKIG01aHIzw6oVX5vMUvv/jp9XgzLQDCOuiO8
         XRkuTE66f8SzJilANbsrCtLhas29uyaMtk+lhHGdalsk36iJW1UT8fSi/f/Y8sdvuRHd
         TfxbCscW4DI9O95uFBfSyjgUbaEn3MTI/HedN9huWvh7dzbvWXtMNXuM/gAzSkl+cY93
         MZbw==
X-Gm-Message-State: APzg51ABf//dfrQObFo0024YZuuW81sGFexKlkvsHdSTFMmynG0PBFHo
        2TE9wbQKWQyaQkxFIbId/dDSLwEXf9tFy3p0iYof7A==
X-Google-Smtp-Source: ANB0VdYc2uattfTaG4bVYQlz47ENfE86pZtt1iJWSbLBzNcZfFxWQUspMuGwMQTjWL5V8yTo45K2LwiSkBMREbbANYk=
X-Received: by 2002:a19:d095:: with SMTP id h143-v6mr1619955lfg.16.1536233025787;
 Thu, 06 Sep 2018 04:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
 <20180904194944.19721-1-simon.k.r.goldschmidt@gmail.com> <20180906110926.GF5360@sirena.org.uk>
In-Reply-To: <20180906110926.GF5360@sirena.org.uk>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Thu, 6 Sep 2018 13:23:34 +0200
Message-ID: <CAAh8qsyMcL-acBf4nXq2RSE=Y43FMG8v+TuyvvmgGtkjHchAyQ@mail.gmail.com>
Subject: Re: [PATCH v3] spi: dw: support 4-16 bits per word
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 1:09 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Sep 04, 2018 at 09:49:44PM +0200, Simon Goldschmidt wrote:
> > The spi-dw driver currently only supports 8 or 16 bits per word.
> >
> > Since the hardware supports 4-16 bits per word, adapt the driver
> > to also support this.
>
> Please don't send new patches in reply to old patch serieses, it makes
> it harder to follow what the current version of things is and makes it
> much easier for the patches to get lost in the old threads.

Ok, no problem and thanks for the hint! Where does this requirement
come from? Patchwork or mail sorting habits?

Anyway, how does this continue, will you pick the patch or do I need
to somehow collect yet more reviews?

Regards,
Simon
