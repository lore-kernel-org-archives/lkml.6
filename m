Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC2FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B515220833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cDBV0ZzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B515220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbeIXS7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:59:53 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37169 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbeIXS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:59:52 -0400
Received: by mail-it1-f193.google.com with SMTP id h20-v6so10300139itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uhWtW2S0Df1YfLcL57eGwD0SSebDed+7aINxaUk1qDQ=;
        b=cDBV0ZzFMO2tQ1cqajFrGhmchIK3SjScY9qeRYqTFbhv9C+mJ2iqoaRUNXxbjMm+Fl
         03EQrvM70ajwzJGYWRCxk9apofDu4pXS9Te06DBdJKqwgBjRqTzXmdcblQ48IjEH2jrC
         gkN/fi+qkXK0m/WP1j29npr79awamI3N5+P1aVeZFst50YARpY5BRtd1LJzHqcwDQ8Nq
         SmP5KgGpHsGrxQyeUjEXUHif+gVUvJMwG9jPp7jOUVe4/elZAnKLK73H5fQI5HHg4PdS
         DIYzvdwa7/35FIdJk2+X8usNkLu/FGkxKLldmDw+8vSodjeThmkTmlg3HT55Y6khj4XV
         sL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uhWtW2S0Df1YfLcL57eGwD0SSebDed+7aINxaUk1qDQ=;
        b=CzAnmf+p0eK/3ajmeQsBcQlQJX9vqTltjcxHJ1EwwBmZjOuFff6R1M4FQ8uYYGmuTB
         z74Pnx5bCd0Hkbq9ivxX7m3WcSk5HTyITQQhHAOl7YoJ9bbwfV6o7ZsGa8E+v7B5aA1I
         0wtfXNtaxIS84OvxUsxZx6tbkHP0xN4evvuqooBil8woE34Fvp4HibtoO9jYkDwFjLV6
         deOsqd7upIoU4ESRPHKV6w4xiXwKx7UDvZaiAuec86op8yPp4EBOYXEs+mhrleK3Pgu3
         E+5yaIWmCuE8vG5tlGmrPcwYHH76J600GrOq7iW4rRwezLgXyFvW5ifk1gYuofkwbVDe
         dwtg==
X-Gm-Message-State: ABuFfogDDNMth8+99z1Y+fA1ZSgH5iJhOq+FmAKGAvN3Y0N0+2hhyIhE
        XkgSlO9V18N5EKgwB8U7W49RQA/PaLn4l/PlPssBcA==
X-Google-Smtp-Source: ANB0VdZO3cJe2Qs/ed7/DlZQwVJosT4bw2AmcCpywjGm1K6oOHXGCtHeUIAuagBiUZ3Pt6iM68EGvWKZe/2D7PPco+g=
X-Received: by 2002:a24:6e96:: with SMTP id w144-v6mr7876043itc.111.1537793869819;
 Mon, 24 Sep 2018 05:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180924113103.999624566@linuxfoundation.org> <20180924113122.447077803@linuxfoundation.org>
In-Reply-To: <20180924113122.447077803@linuxfoundation.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 24 Sep 2018 14:57:38 +0200
Message-ID: <CAMRc=Mc92mF18Tax+6hPdAYnw4t4_pD3FjVOGAzxttJCRP5gdA@mail.gmail.com>
Subject: Re: [PATCH 4.18 177/235] gpiolib: dont allow userspace to set values
 of input lines
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        alexander.levin@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 24 wrz 2018 o 14:41 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> 4.18-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Bartosz Golaszewski <brgl@bgdev.pl>
>
> [ Upstream commit e5332d5437764f775cf4e3b8ca3bf592af063a02 ]
>
> User space can currently both read and set values of input lines using
> the character device. This was not allowed by the old sysfs interface
> nor is it a correct behavior.
>
> Check the first descriptor in the set for the OUT flag when asked to
> set values and return -EPERM if the line is input.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpio/gpiolib.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -449,7 +449,13 @@ static long linehandle_ioctl(struct file
>
>                 return 0;
>         } else if (cmd =3D=3D GPIOHANDLE_SET_LINE_VALUES_IOCTL) {
> -               /* TODO: check if descriptors are really output */
> +               /*
> +                * All line descriptors were created at once with the sam=
e
> +                * flags so just check if the first one is really output.
> +                */
> +               if (!test_bit(FLAG_IS_OUT, &lh->descs[0]->flags))
> +                       return -EPERM;
> +
>                 if (copy_from_user(&ghd, ip, sizeof(ghd)))
>                         return -EFAULT;
>
>
>

Hi Greg,

FYI Linus suggested that we don't send this one for stable:
https://lkml.org/lkml/2018/7/20/1065

Best regards,
Bartosz Golaszewski
