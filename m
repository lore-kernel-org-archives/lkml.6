Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30315C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDF320840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fwa6qVp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDF320840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeKIR2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:28:05 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40066 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeKIR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:28:05 -0500
Received: by mail-it1-f195.google.com with SMTP id e11so1943605itl.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 23:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YgESXJg7JF3T3fapWZ/KGi3xj99jOt56OTy9AvPrYtA=;
        b=fwa6qVp4/2BVS/D6zt/f3PVMbtbNGgwColFAbPYpvyrofC+DQowPTXcHG6ptLKirVU
         ueJZm1yqRLTrqJKfXwHyVO6CSCEsJMsMDI/OtpPwnl49eWfdpslxeLjlpq0dqClJTnFy
         fA2KmsTWQvU8/R3i57Cv408LKkT/xH8RHWPE8b8qYw+6GXwzL4/hteBiquf5CVTxKggh
         kSyp2yaUUqD8UfmzqtqWG7OEbo1DtJI7LrgrPU7EEkYib8wk57c/4TS7K7YG9LRv9LNw
         JAvXowkR0Q8AV7UftOSs3jyVuFIdlzSrMc6xsNCGkFXEa9ZR0DK8yoW50ZUrZPi1mLpH
         +XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YgESXJg7JF3T3fapWZ/KGi3xj99jOt56OTy9AvPrYtA=;
        b=YZwDodVxO4N9Ns+eXlvi7RaKGszAc1OILzfIURjpVZZeCdC9xyxDEsEWfi+PjExccr
         3hx5FjvZLt/cZVTqYCuSSg4hUS2sQHoHjZzx/FGfxErYWwpXh8g0cTHSjm1af4ZSseAw
         JOqcC1e627F4sNiPIHFGVgN6PszU1Al/gqQDwt9N1pKDIdhIzFWQTv0kTzHfsdtMvFD+
         HYeh1ou0e4RxN1GDVVislpHT6ZF7L8zSOUfDU+htUdT0SXyYX4bR64F5vGYNck7NryEx
         a01DgBz7Zd81PyuSswJlfOXl0dqu0bDOzLPcXpe/D3FRKZRSXGh5KvKbe5BnlJehcN1F
         uU8g==
X-Gm-Message-State: AGRZ1gJcE4znc3iFrxKZrl/rLp0Vti56+ys9HWclNHkNQ5Q7dQ+rRzQm
        b904MO+HQe5z+qZrXq18fdfmsWZssqA78yn7NPNHGw==
X-Google-Smtp-Source: AJdET5dcbKi1IpZr6+VFrY5jRb6XwqVVTexUmFJu71hN6lAWQbJtCC84Du/0FE6PyiCqWIyro42RRXjZpiXlbFWI7nM=
X-Received: by 2002:a24:a70e:: with SMTP id a14-v6mr1317640itf.74.1541749723245;
 Thu, 08 Nov 2018 23:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20181108215129.641434673@linuxfoundation.org> <20181108215129.753982396@linuxfoundation.org>
In-Reply-To: <20181108215129.753982396@linuxfoundation.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Nov 2018 08:48:32 +0100
Message-ID: <CAMRc=MdckdCj=dwn8J6Y5O1gPPykGrzK50td24_iFOa-MwEEJQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 01/31] eeprom: at24: Add support for address-width property
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        "Chiang, AlanX" <alanx.chiang@intel.com>,
        "Yeh, Andy" <andy.yeh@intel.com>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 8 lis 2018 o 23:08 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> 4.14-stable review patch.  If anyone has any objections, please let me kn=
ow.
>

Hi Greg,

this looks like a new feature, not a fix. Are you sure this should go
into the stable branch?

Best regards,
Bartosz Golaszewski

> ------------------
>
> [ Upstream commit a2b3bf4846e5eed62ea6abb096af2c950961033c ]
>
> Provide a flexible way to determine the addressing bits of eeprom.
> Pass the addressing bits to driver through address-width property.
>
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/misc/eeprom/at24.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 4cc0b42f2acc..ded48a0c77ee 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -577,6 +577,23 @@ static void at24_get_pdata(struct device *dev, struc=
t at24_platform_data *chip)
>         if (device_property_present(dev, "read-only"))
>                 chip->flags |=3D AT24_FLAG_READONLY;
>
> +       err =3D device_property_read_u32(dev, "address-width", &val);
> +       if (!err) {
> +               switch (val) {
> +               case 8:
> +                       if (chip->flags & AT24_FLAG_ADDR16)
> +                               dev_warn(dev, "Override address width to =
be 8, while default is 16\n");
> +                       chip->flags &=3D ~AT24_FLAG_ADDR16;
> +                       break;
> +               case 16:
> +                       chip->flags |=3D AT24_FLAG_ADDR16;
> +                       break;
> +               default:
> +                       dev_warn(dev, "Bad \"address-width\" property: %u=
\n",
> +                                val);
> +               }
> +       }
> +
>         err =3D device_property_read_u32(dev, "pagesize", &val);
>         if (!err) {
>                 chip->page_size =3D val;
> --
> 2.17.1
>
>
>
