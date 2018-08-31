Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901FFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241B620837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAHQVUDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241B620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeHaNfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:35:10 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45089 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaNfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:35:10 -0400
Received: by mail-io0-f193.google.com with SMTP id e12-v6so9888600iok.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kmH4FpxskWB7J+CIQjQAd8CsquD+iRnjti3CipHCGl4=;
        b=PAHQVUDJPj5n/XkDm1yB34/0BcvQuoLccr6HXg0i56EQ9p93TWIQPIpcKVw7rnL+0p
         +0XAaEwc0lDw+Mejqh6JzZA6MzsGy4RoHjbXGa2COCwqAOWSVz7TGX3fifCwntTTmwQs
         GygPnLB4eQkJpJSxSNPqj667418MARqlpL5iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmH4FpxskWB7J+CIQjQAd8CsquD+iRnjti3CipHCGl4=;
        b=slDYCsW8mEkz+Y2zmv9GmugbgW0SK1HVlCUC0FtnFvOM6gMqwKhHNMNdf7U+GFibcw
         JNsKIgcHcnktFhCT4uojoHHmmj4Q2rrFeH8hOkEViti0rHeA+xZKu7XcWyGWOMprJi3l
         a4nWD9k1P61KbzF1DPAsggii2LHJ9jRhLLqGcnDOW7asEzh8ICz83SKCzydzBoaIGdV+
         uGNxEn/v+BdfsPp2/QcCb7uFpDr823ilTeuxyHIo8+znqlZYfyNca7nY/ezglG43RyiI
         Ndx4D7vOXN4eqoVMErsQAmtgBc7K69huklD3Z8WHy/v53JJ/Fe2TasJNZA8HaomD6E8A
         td5A==
X-Gm-Message-State: APzg51B2yp9nBH8x7L6P1c6o6PKaCgGa2I9rH1FHiwlhvL/ZPM8T1QVM
        AbbtoBVGwFnkhE7rejqwxWMAwWmx8NFIwqSnfQwWjQYINd4=
X-Google-Smtp-Source: ANB0Vdb5CupP20IFDkQDCzgcyNYP2HhlPzHUlpplCR0CcHAPDxEO1s3j/EK3Bi46xrK8E+lC0NYJbdqTHlBDKqXsOXY=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr10852238ioa.277.1535707714656;
 Fri, 31 Aug 2018 02:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180830164935.42791-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180830164935.42791-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 Aug 2018 11:28:23 +0200
Message-ID: <CACRpkdZyyoUdfC=6prpCrzfOcFeE6U6GR-1hHkRfQYi_LaGcGw@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: Add myself as designated reviewer of
 Intel PMIC GPIO
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 6:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There are few Intel PMIC GPIO device drivers which I would like
> to review.
>
> Note, Intel MSIC is old system controller that based mostly on PMIC
> integrated in it. Thus, I included it as well.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
