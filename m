Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D64FEB4D12
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57152124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPwAen+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57152124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeGLSgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:36:36 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43269 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeGLSgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:36:35 -0400
Received: by mail-ua0-f193.google.com with SMTP id x24-v6so19027477ual.10;
        Thu, 12 Jul 2018 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=19lfVRTK1OLnvntaQQ9ww/7HLa6k3c5c0aH9LrTHLi8=;
        b=sPwAen+pJZ0t0S7fc42RcP3drn2wxs5L4xzk/hlBr3WZST3r5KFzDFVOgL8kmN5Id8
         8sPcCyHu4vCgtDVMyl1lguXijn0eeHA14U8DiripZu76V/nGkulF8Z2ACa0Al1D57gCk
         UOKqi9u7ZvVZO8deRjBRDEYFq+i0duFMBQI7YTEc+Mj+b7yZ+JmHKJLTM7eKx8pNXBAc
         bNSIW5ZhpJKb9QYhYj7EhHqODx/ezfcZrp2Hzl0R2IzTgWKsLpSRvWeyexdnq+6tPcZC
         21IYPfkqLN9ySSxzHxM2vG7HiYQiZevVJvCHL33AJWSXb/MGuxltsTCFQOyoA3Dpm2Md
         VExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=19lfVRTK1OLnvntaQQ9ww/7HLa6k3c5c0aH9LrTHLi8=;
        b=ueeRxuIILffj7A6X0QDef06YyVtBjxvzjYdMwWyuvdjKQ9Na1Iu6GiPi2Pub+GC3c7
         WE9FLz7ArljP9u+nJvAR+toE+JcLnpDkvipe12h+hy8lHYxrk31BqSbzE7w7kuyB49M5
         dO8ztMnvfUNoTomhnbxJghWeyvsCDoHnlSpYN1RP3PSuQ24DmdrDAmY9epQOu8+r3qE3
         QrWBOrBs+g6ejkkxUl7FR1+AJzoISoAP62x7olsbxPKdqLAI889zTRNX74/d8F9mZ83G
         QH/2+vaaHAcsWZssoKLji8jjogDCEmfZyc+8QVNaAgdeM1MxFXD8y9ekMqfYDoply7FN
         4L8Q==
X-Gm-Message-State: AOUpUlEsEMkMvHfYWINZjribmNYF2hcUBKNElBk3UI9dAZStuCLzxFY1
        UAGGcwpfE4RzdsUh6a/wWUm7KinqIGlD1BlSv84=
X-Google-Smtp-Source: AAOMgpfWhvPDqTum527/0hzjnUTNc2gUg73ol9lExPouZmvJpr9n+6Kij5ZdEcYs2gDU9QAIVy+CZF+sMpuZA+1EtFI=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr2176744uad.12.1531419951518;
 Thu, 12 Jul 2018 11:25:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 11:25:51
 -0700 (PDT)
In-Reply-To: <1531409786-20180-1-git-send-email-stefan.popa@analog.com>
References: <1531409786-20180-1-git-send-email-stefan.popa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 12 Jul 2018 21:25:51 +0300
Message-ID: <CAHp75Ve+S7UDyLva_PY4s=cjKoSY+aMfWDUEHb6tp4AxGtGsDg@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio:adxl372: Add sampling frequency support
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 6:36 PM, Stefan Popa <stefan.popa@analog.com> wrote:
> This patch adds the option for the user to select the sampling frequency.
> Also, the user can read the available frequencies and read the currently
> set frequency via the read_raw function. The frequency can be set via the
> write_raw function.
>
> When the frequency is set, the bandwidth is also checked and ensured
> that it is constrained to at most half of the sampling frequency.

> +static int adxl372_find_closest_match(const int *array,
> +                                     unsigned int size, int val)
> +{
> +       int i;
> +
> +       for (i = 0; i < size; i++) {
> +               if (val <= array[i])
> +                       return i;
> +       }
> +
> +       return size - 1;
> +}

Perhaps it's time to extend bsearch with something called
bsearch_closest().

-- 
With Best Regards,
Andy Shevchenko
