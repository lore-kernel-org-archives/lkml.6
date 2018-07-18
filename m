Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFBCECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16752084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LitqV/F9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16752084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbeGRLA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:00:27 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43851 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeGRLA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:00:27 -0400
Received: by mail-vk0-f65.google.com with SMTP id s17-v6so2197938vke.10;
        Wed, 18 Jul 2018 03:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eKz3aEpn6filWjWzCzUm3D6AnFsuTjLJgcZOf66vkWY=;
        b=LitqV/F9uO7PqFf2fttb5BUo8nMqElIoWd9TQEnrA3MRUUos+5dLtObgpxVoP5QHkf
         FGan9WhE8BkLARtGrDP5rdkQXCAqyjpv1N4BHk5R6HF/HKE36V2FcRTiQ+DXcazMQf+L
         QYTujxGFyUI1K9TRPpnfk+xgF77dMjhBNIh+AyMo5SEUcNCce3SUQTNJIbaM7KHiQK1z
         StIEK0Ww5+xLzUsh6TTSQRoIjbvuyRBBg3RHM5P+3nWHHCjfZ+1hFhi9qCRWejI6u1P/
         4+h04WK2hIAtSnYV21Q+XCtGkUPWgEF+plhA9g+1OvR7NroqwC2bF9Ve1VEv6HLkO+xh
         OcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eKz3aEpn6filWjWzCzUm3D6AnFsuTjLJgcZOf66vkWY=;
        b=Wc7N3h1f1IG2w0h+n0OWRAkSZ9OHalbdmVVzgg6SR6iRlP49iBQNzHFnINAkNS828K
         p9tw65kg7VudxUcZqTxGVrw0/qWu0S/nX6ZSNqkS1VqpycSpeOJ2lwO4U2KN6JV90msx
         ws6kcWx23prPGLnKLgLz8OJT+7H00B/KCADBrxyeX58gI/S6Ck2fLdeC3DvCE5ErrxwX
         3su9bzCzHqeyxJCtJk/W12qZBQ0YDAviQfi0tKtWJowIYwS3FtT78PTo4a4RLN1JlMKs
         yneqrsTwE7Rtie+V7wfvXDsA/ObfYFDMLYlazaY1AGBo5n0aJNO2VUS9mksz2d/ofDiq
         dcbw==
X-Gm-Message-State: AOUpUlH9Y5zvMsasZms26Am0ipLmckNjur3ikbMftgU6/1O/Qq9jmNU4
        +mxR2NCV3OB4L6UoINUOBUQ1Ezt2LKx+Zh/lpoC2gw==
X-Google-Smtp-Source: AAOMgpeEGA4vJ2xPjlWKsaNaVCat2E0WfDs2stkI2oockOaqddZ3X0EjWwDpntNWJr8hSTUBcc+n5hZ+PFkyaajKMaM=
X-Received: by 2002:a1f:7d09:: with SMTP id y9-v6mr3007682vkc.15.1531909393544;
 Wed, 18 Jul 2018 03:23:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:23:12
 -0700 (PDT)
In-Reply-To: <20180718100601.GA30600@han>
References: <20180718100601.GA30600@han>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 13:23:12 +0300
Message-ID: <CAHp75VcUJ70dtNcGfuJbo473ddOJ4_RdgcNsk_sVE5uVeHf_4Q@mail.gmail.com>
Subject: Re: [FIXED][PATCH] dell-laptop: Fix backlight detection
To:     =?UTF-8?Q?Damien_Th=C3=A9bault?= <damien@dtbo.net>
Cc:     Darren Hart <dvhart@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 1:06 PM, Damien Th=C3=A9bault <damien@dtbo.net> wro=
te:
> Fix return code check for "max brightness" ACPI call.
>
> The dell laptop ACPI video brightness control is not present on dell
> laptops anymore, but was present in older kernel versions.
>
> The code that checks the return value is incorrect since the SMM
> refactoring.
>
> The old code was:
>   if (buffer->output[0] =3D=3D 0)
>
> Which was changed to:
>   ret =3D dell_send_request(...)
>   if (ret)
>
> However, dell_send_request() will return 0 if buffer->output[0] =3D=3D 0,
> so we must change the check to:
>   if (ret =3D=3D 0)
>
> This issue was found on a Dell M4800 laptop, and the fix tested on it
> as well.
>

I have pushed this to my review and testing queue, thanks!

But I'm going to push this to Linus this week since it's definitely
stable material.

> Fixes: 549b4930f057 ("dell-smbios: Introduce dispatcher for SMM calls")
> Signed-off-by: Damien Th=C3=A9bault <damien@dtbo.net>
> Tested-by: Damien Th=C3=A9bault <damien@dtbo.net>
> Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/platform/x86/dell-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/de=
ll-laptop.c
> index f1fa8612db40..06978c14c83b 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -2185,7 +2185,7 @@ static int __init dell_init(void)
>                 dell_fill_request(&buffer, token->location, 0, 0, 0);
>                 ret =3D dell_send_request(&buffer,
>                                         CLASS_TOKEN_READ, SELECT_TOKEN_AC=
);
> -               if (ret)
> +               if (ret =3D=3D 0)
>                         max_intensity =3D buffer.output[3];
>         }
>
> --
> 2.18.0
>



--=20
With Best Regards,
Andy Shevchenko
