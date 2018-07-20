Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CC1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D693C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0HgCQIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D693C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeGTVXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:23:54 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40554 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeGTVXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:23:53 -0400
Received: by mail-it0-f65.google.com with SMTP id 188-v6so16187995ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsTa8EbT4PK4sPyt3u6kvijbGWL/f1rQz0EjJXIkBAA=;
        b=P0HgCQIRDzEWKPim2cthoGaaPyxGu2emilIYFlEbiSnxLw2nbwhvImwt0Rc14PfKUd
         FFlc84ioJPaPnugOdKU5OmstrAXTIBk789VTE1+nBtxhTehZIh6DxlzZ0jo/bHE7nWZi
         5USZdw6dSUzq7dB8CSpMfC942sFGQvKKhr6nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsTa8EbT4PK4sPyt3u6kvijbGWL/f1rQz0EjJXIkBAA=;
        b=HUtAbX78IQ6XxmXKqPlLX1OpPRlP0hiRZGYgcezJxdM8Vz6wDYGl++ieYVGMfBCGNx
         dVHIwQFZH1pxrdEXgjKxSQF03PS8zq/tvnnMRB0wHPUADS4P+Q7efOR2Z7ANSUW1isC/
         blUnUMzkKMK2JG1Vi/F9eeSIekzskR1ypD0prhutjVKka7oT1EKPnptaItnoSuxNV6Yf
         /EJvPO6IB6qcrJTrQW07ckkE86OgvglbAI9Yi2aKo68tAyZaPbMh9qqifN4onNT3Uwxn
         h2Hag+Lwbd0npbb92W2nGJtwew41XTHL+g+h03Qibf14dxCWruRDqmuyPOz2G8d7ZC0Y
         3b7Q==
X-Gm-Message-State: AOUpUlF8MdwqUc2xRY++iz2ZSaPlEQahBK3nq/4X8mPildKDjOWFPoCi
        ifBOM/mKkB2Tf99PBeMEKJWQVOMYg1rfHAqB+NT1OQ==
X-Google-Smtp-Source: AAOMgpfGgQsXq4Yct2z80hRwbIPrA1g5khM/9zAWqMSpHhzRLq2zlDXxw+eln5r8TQKLSni6LvrjdCB+N1N0LnCvSuc=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr2761082iti.135.1532118840191;
 Fri, 20 Jul 2018 13:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180716083424.11157-1-brgl@bgdev.pl> <20180716083424.11157-2-brgl@bgdev.pl>
 <CACRpkdaWGwhJ1D683R+7TV0JsUg-pNYZ2xm_0+16O2NgnBo+4g@mail.gmail.com> <CAMRc=MeZX0r1khVBY72_XgyUfW=GLFG-=hUuqZHWYgCRwFkUrQ@mail.gmail.com>
In-Reply-To: <CAMRc=MeZX0r1khVBY72_XgyUfW=GLFG-=hUuqZHWYgCRwFkUrQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Jul 2018 22:33:48 +0200
Message-ID: <CACRpkdayVPE9bzuDLp-WC0qA360JdFrUwgcDuDjuvjEk82ZKLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: don't allow userspace to set values of input lines
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 4:13 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 2018-07-16 15:40 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
> > On Mon, Jul 16, 2018 at 10:34 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> >> User space can currently both read and set values of input lines using
> >> the character device. This was not allowed by the old sysfs interface
> >> nor is it a correct behavior.
> >>
> >> Check the first descriptor in the set for the OUT flag when asked to
> >> set values and return -EPERM if the line is input.
> >>
> >> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> >
> > Patch applied! Thanks for fixing this.
>
> Thanks. Do you think we should Cc stable on that one?

Nah. It's not a regression. (Not like things that worked before
stopped working.)

Yours,
Linus Walleij
