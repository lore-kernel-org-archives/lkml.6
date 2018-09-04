Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AAEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D2A2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2DXDg5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D2A2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeIDXwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:52:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38125 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIDXwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:52:44 -0400
Received: by mail-qt0-f194.google.com with SMTP id x7-v6so5358481qtk.5;
        Tue, 04 Sep 2018 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LCHG8zDXa81XkeCOcwjYV4vkKpWYX7U3uWMHLhR2f0=;
        b=H2DXDg5TPHY57GwH07jg5PqnXRf0vesd16Hy3swzZLAC5ae8gQsbBMbxKFWkW7S3RX
         PMfbYcOMI1FjR8AR6MsW0eAA/fXn9hePl5r9y9nCAo6V74u8JoEBAu6zsqiaF5BDtPEr
         o4twue7J/lfSrZ31NZq+6dhX4eH8MJbvunbSxGnquUc2euC5B0eYiRech0GM9nlTI5px
         QhjFHAXd3/qumguLRyt/YGZMimo+uebEWsRTRDBtiHt5gNrTeYlv3Fv0Y9o0cdW7wjPs
         +A3xDXGRmkeg64AWbD2jN6aIH/H2m3CwO+02DshIaQ8Srji15aYYDR/w+eo6gOa4kOgm
         eIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LCHG8zDXa81XkeCOcwjYV4vkKpWYX7U3uWMHLhR2f0=;
        b=qtpWlEjGc0Qnzj6D+/dpCCe/1V1385f3xVGPpeW2sKdXYkU5IOgwBsGn/D/FXtut7U
         MnX13l8xa3aZcm/CY6wmJryzylbiIO4vGDHFzyW756PfNne7ZqLhGMtSiN6WRxXttnQH
         VPEjrrkFdrJeoS3ud903b944KyqP2rFyfa7aJeg8vXvFCVUSOabVuPHhVauPsOASBjyk
         D09vDKPKg2qNCSPUSBIhLBBm6Lk9Cw4SQqV7ZZqjjLGNigR1W3TCW3Ty4kuPhuqu7KSW
         nx/Kb34oK8LxBkZ+tmqCvTqSDnUTnvBx0knTSpXpg3r935FTTWU4zwPxbIiLFyV/j3El
         PhNg==
X-Gm-Message-State: APzg51Af/uO2TOX2KzV/DLZFgCaCNcVad8t9TOY01dsoQjr7OW+OC67B
        KRzoZEREZ6+99/sYBCaajyk49sMZc6fymXiR+HM=
X-Google-Smtp-Source: ANB0VdZ7FvJeCKJVFAjrhlE/xEiVF9YgY+mvFqx73/vW6zC7eiQIvwqbEGcbEcz0pFRezxlBuYDazDNhWGL1dfQnGyI=
X-Received: by 2002:aed:2b83:: with SMTP id e3-v6mr30527852qtd.246.1536089172725;
 Tue, 04 Sep 2018 12:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180904200434.10442-1-afonsobordado@az8.co> <20180904200434.10442-3-afonsobordado@az8.co>
In-Reply-To: <20180904200434.10442-3-afonsobordado@az8.co>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Sep 2018 22:26:01 +0300
Message-ID: <CAHp75Vdptz=mj+FaAwKP1NCZPknZ2T4TCCu99Egzh37wbtQJmQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: fxas21002c: add ODR/Scale support
To:     afonsobordado@az8.co
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 10:07 PM Afonso Bordado <afonsobordado@az8.co> wrote:
>
> This patch adds support for reading/writing ODR/Scale
>
> We don't support the scale boost modes.

> @@ -44,7 +44,10 @@
>  #define FXAS21002C_REG_F_EVENT         0x0A
>  #define FXAS21002C_REG_INT_SRC_FLAG    0x0B
>  #define FXAS21002C_REG_WHO_AM_I        0x0C
> +
>  #define FXAS21002C_REG_CTRL_REG0       0x0D
> +#define FXAS21002C_SCALE_MASK          GENMASK(1, 0)
> +
>  #define FXAS21002C_REG_RT_CFG          0x0E
>  #define FXAS21002C_REG_RT_SRC          0x0F
>  #define FXAS21002C_REG_RT_THS          0x10

This hunk doesn't belong to this patch.

> +static const int fxas21002c_anglevel_scale_avail[4][2] = {
> +       [FXAS21002C_SCALE_62MDPS] = { 0, IIO_DEGREE_TO_RAD(62500) },
> +       [FXAS21002C_SCALE_31MDPS] = { 0, IIO_DEGREE_TO_RAD(31250) },
> +       [FXAS21002C_SCALE_15MDPS] = { 0, IIO_DEGREE_TO_RAD(15625) },
> +       [FXAS21002C_SCALE_7MDPS]  = { 0, IIO_DEGREE_TO_RAD(7812) },

This is just set of powers of two. No table needed.

> +};

> +static const int fxas21002c_sample_freq_avail[7][2] = {
> +       [FXAS21002C_ODR_800]  = { 800, 0 },
> +       [FXAS21002C_ODR_400]  = { 400, 0 },
> +       [FXAS21002C_ODR_200]  = { 200, 0 },
> +       [FXAS21002C_ODR_100]  = { 100, 0 },
> +       [FXAS21002C_ODR_50]   = { 50, 0 },
> +       [FXAS21002C_ODR_25]   = { 25, 0 },
> +       [FXAS21002C_ODR_12_5] = { 12, 500000 },

Ditto.

> +};


--
With Best Regards,
Andy Shevchenko
