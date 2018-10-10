Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116ADC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA28D2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="mx4LYVpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA28D2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJJPMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:12:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39517 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJPMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:12:38 -0400
Received: by mail-it1-f193.google.com with SMTP id w200-v6so6653531itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ducCvaY0sUVlKqm7bJ3vn/1bCxA0Xxy78UnvNJd6N3w=;
        b=mx4LYVptTUO3j2b2cZ6OudFW3xInTanZYoCMex4NLsks6A/FVK154Vvxjipmu9i46F
         aH5n7sMTyv8QRQGgT0SzS56Y5kcSRYbqluHqdh4xcsHjNeFwEG30RX7J1oOlc7UJobER
         cSSZ5BX2YqZKScklMUuCxIr2XblFur0s3nnQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ducCvaY0sUVlKqm7bJ3vn/1bCxA0Xxy78UnvNJd6N3w=;
        b=GXqn1e/eonSPxTcHAhvH4rDTJBOj62MJYP85ZT6virWwOWGHojeX/KVnvljeGsDP1G
         xHw1vlKyIuGM0yv0lLiAWxYDgqskJPx1a4HdkBR8Pgnt0Ksl4Q3up/tB754LgcX4s9BG
         bGEGup/ST1tmxIwKYsP/Kz7J62PgBrNrwoT7bviBbFhXjFYd+MlWVmVG7YBlIyz5xBjM
         D2XCM+bsNCc79MTFR/LdrfqJFEBbZ0dVQuuaQjvIauIIFKkYPp15lU28xFhl81cObaPY
         8ZTiPI7tO6CiG/XXa+tOste2jFpV+Nc2+OC5Iw/k4jaJ6ekafQsiO6qKgJ5jE6H2zO0d
         f5tw==
X-Gm-Message-State: ABuFfoh2cnosdlbIT8GHq4PFm4/TuQc1MBElhr0y+fHvqIHcFAzyFIN8
        FbzzdhkofWQ0i+iK0mwejadUWF/q3ojlKTCFyvprHA==
X-Google-Smtp-Source: ACcGV60Ne9uEPlG//cYAhTHVYZ4pTvc5vjeAe1JuQA/whTuauXuDraNuWWHul5+On7n4TWK1iWDXeAZxGIx8dBHItc0=
X-Received: by 2002:a24:e34a:: with SMTP id d71-v6mr3943646ith.155.1539157900924;
 Wed, 10 Oct 2018 00:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181008210904.9362-1-colin.king@canonical.com>
In-Reply-To: <20181008210904.9362-1-colin.king@canonical.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Wed, 10 Oct 2018 15:51:29 +0800
Message-ID: <CAJCx=gk-rsNOPsXXSHYN2x6PtNpDKCUDvuf1=XEp_Q_L=sOfyA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ina2xx: fix missing break statement
To:     colin.king@canonical.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        stefan.bruens@rwth-aachen.de, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 5:09 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The IIO_CHAN_INFO_SCALE case is missing a break statement and in
> the unlikely event that chan->address is not matched in the nested
> switch statement then the code falls through to the following
> IIO_CHAN_INFO_HARDWAREGAIN case.  Fix this by adding the missing
> break.   While we are fixing this, it's probably a good idea to
> add in a break statement to the IIO_CHAN_INFO_HARDWAREGAIN case
> too (this is a moot point).
>
> Detected by CoverityScan, CID#1462408 ("Missing break in switch")

I'm not familiar with running Coverity scans myself, but is this CID
some publicly accessible report?
If it is an in-house scan then it should be dropped IMHO

- Matt

>
> Fixes: ca6a2d86acae ("iio: adc: ina2xx: Allow setting Shunt Voltage PGA gain and Bus Voltage range")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/iio/adc/ina2xx-adc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index d1239624187d..9bc5986780b9 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -250,6 +250,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>                         *val2 = chip->shunt_resistor_uohm;
>                         return IIO_VAL_FRACTIONAL;
>                 }
> +               break;
>
>         case IIO_CHAN_INFO_HARDWAREGAIN:
>                 switch (chan->address) {
> @@ -262,6 +263,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>                         *val = chip->range_vbus == 32 ? 1 : 2;
>                         return IIO_VAL_INT;
>                 }
> +               break;
>         }
>
>         return -EINVAL;
> --
> 2.17.1
>
