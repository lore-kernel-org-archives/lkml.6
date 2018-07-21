Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9455ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BBA206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEJ7k7qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BBA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeGUQhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 12:37:03 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33255 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbeGUQhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 12:37:03 -0400
Received: by mail-ua0-f193.google.com with SMTP id i4-v6so9267132uak.0;
        Sat, 21 Jul 2018 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vZ0w8NyDNU6xL1u3nc0ExNEhGmCa8gdU8KmAupNt0w4=;
        b=TEJ7k7qUdcU2GLFEZTszKd6wyasB9DkStsgDllH++rhmSfrmSqUB/fCrXktdRfNXYJ
         pmzLQOQQ02VIO35/bZ83S2tnhFefx23ZU5B9gRl0Z5kux5u/lA1ESBkW9IuGd3WKgzcB
         F6CaVqYUwKrJ3udlEk/4pfe3fXfq0b2xRd53fbQHaCrQVlhqGHfphZvIJIShWw7o8T1s
         hs6FTOH75vDlVnDi+GLW6/KuzkuE+JOQg52FyluGTEwKtYqwEQg5XVZhbaI77N91le2e
         ZxNn/H1UCBc6UiC86ewrn+5gwR32ZFdCNk2cBR2lCF5itBT2+cDnUxeP+5iKmVPqjqLJ
         11zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vZ0w8NyDNU6xL1u3nc0ExNEhGmCa8gdU8KmAupNt0w4=;
        b=FpTd3E2FGfSfc2zcqQeGu8bvqTWfkg2FmMmIM0JxGR2/KSPSdvk3gbAyXpOn1kvnjy
         Rg/8JpSfgSjs3KdPq+vuEHowFMLStslZaPXD8nmwEMr5Yoh4OKDA8YjUa++YhVxUdXG7
         jXaFOt6TLdO2JuRxuufHg3XCsRBwgAuoTuHQIPm+NTtCftJBC3XtihfzEWNHxeAFWHuw
         msDnftg0keRf+VOh2D34i2/uNlwZ+L0DAEngNqf/EEzq8EuaxeJC/D1WQSJ1+cEx2oHB
         B27VztRIqj4eFfTcRQ5ajCWoZcwpeDS9cxr3C1F2f2ypzU4HdsNTs2/YPbMoXd8+w6c5
         sMlA==
X-Gm-Message-State: AOUpUlG1PqMULgBior84XNqIvja9Z06HYSH0R3Jpl3dEGrw3JoDiUwRY
        tDd6YhnaGX3I/H9qUcqndypRHVoUPiYakrLHZSE=
X-Google-Smtp-Source: AAOMgpevrS7dNuWBMbMb4egvdfT5wq6Jqf86os0E3SY8wB50UkmxSgkllV5NlA7sh7j2GZ3o5AsL5oREVQmsu/cGU4c=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr4321442uad.12.1532187832995;
 Sat, 21 Jul 2018 08:43:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 08:43:51
 -0700 (PDT)
In-Reply-To: <20180721153607.GA11127@himanshu-Vostro-3559>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
 <20180721161934.75066d97@archlinux> <20180721153607.GA11127@himanshu-Vostro-3559>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 21 Jul 2018 18:43:51 +0300
Message-ID: <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 6:36 PM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:

>> > +   /* Look up table 1 for the possible gas range values */
>> > +   u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
>> > +                           2147483647u, 2147483647u, 2126008810u,
>> > +                           2147483647u, 2130303777u, 2147483647u,
>> > +                           2147483647u, 2143188679u, 2136746228u,
>> > +                           2147483647u, 2126008810u, 2147483647u,
>> > +                           2147483647u};

This one needs perhaps a bit of though, but...

>> > +   /* Look up table 2 for the possible gas range values */
>> > +   u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
>> > +                           512000000u, 255744255u, 127110228u, 64000000u,
>> > +                           32258064u, 16016016u, 8000000u, 4000000u,
>> > +                           2000000u, 1000000u, 500000u, 250000u, 125000u};

...this one obviously just a not needed one. You may replace it with a
one constant and simple calculation to get either value (index from
value, or value from index).

-- 
With Best Regards,
Andy Shevchenko
