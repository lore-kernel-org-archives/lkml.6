Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B57C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B201020671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="V/Bs8aMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B201020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeGYIp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:45:56 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34574 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbeGYIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:45:56 -0400
Received: by mail-it0-f66.google.com with SMTP id d70-v6so16978052ith.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YKv+O+ZFPBruswx5V99r6fXrNuFwUUi43U/mIJQ2v28=;
        b=V/Bs8aMfDd9BvZDqqn4Pf4brxOJJ5S7jUQXXJJLzFOY9M0GlUcSmnVk5GLZVH1yxB9
         vaMcjX+qppuU9ZwgmWV0dIei3E1TpPXI+rK1yoMYjwrTnuV8oftKmY4DY/+na1fcGv+1
         3B8098arCF9QQI4twrAwsBOUNQkJjSWIjac2EvHwfe2ksdKX1NK2N+iwX7Hjzgvz4ZyH
         P5+fQW5WctFvXQMn34fyXzustpP+yxjGjAImi0l65/dFxil+85oBCi5qyySL1fu9JqQJ
         /cJ68V37TscIFTrd+zS0PM1T3aYQhIRl4h8Z5YPa9VrNGQQ7y7grGbQFARgqiLtWqH86
         H1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YKv+O+ZFPBruswx5V99r6fXrNuFwUUi43U/mIJQ2v28=;
        b=ngF6wF+VlZOcTmOzM1xvPXcEMUuAZEPw4TWoUMVVzDNHYKuCa1RcOXpmDhspXCbOnt
         ZRwwJAwia36OLa7EBO6u22t+jTIFAT4obwNJq7rkijGZX8gH7UsHZ3kogpiaML5MtrMv
         qppmaSiuIHjg6ImhqVVdIF+u/Ufsyb4FleNeUV+suOLsjRiFSmfcxwsihl6txijzpaf5
         ybTqv9BiOlOovFB3eJaF/CyIQzen1SttwgzWM3fX9x/d5lLJoHo3Hb79lmg9Dt1w0Bcq
         T1X5FBM4bE0UJFTeXZ7DquNK11akEr4LOh2ndIuDfHCdFrMjHnk+UFfCFizwDy21Pm45
         tK7g==
X-Gm-Message-State: AOUpUlETXEU1eETw3uEJFtP1sDzZ0LrpIC1fJYgtoobYkWV5PP4Yjdgm
        d9/nfJnxD/UozLsDGeXlPd0LFg/MGd9TP4xDbIB1KA==
X-Google-Smtp-Source: AAOMgpcCSgdDY4amSWSvFCcEirHuSBRV+4CfIubefpt7K0mi8a8bx9gJuTeC3dBrXDur3l7jYUPOpP7JWvk4xcZHlJQ=
X-Received: by 2002:a24:5e0b:: with SMTP id h11-v6mr5345823itb.80.1532504131411;
 Wed, 25 Jul 2018 00:35:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 00:35:30
 -0700 (PDT)
In-Reply-To: <1532488822-5622-2-git-send-email-alanx.chiang@intel.com>
References: <1532488822-5622-1-git-send-email-alanx.chiang@intel.com> <1532488822-5622-2-git-send-email-alanx.chiang@intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 25 Jul 2018 09:35:30 +0200
Message-ID: <CAMRc=MdHAU8Y==hhhV6L7o1-J9LfTUZrDMYCLm+rASpagFMNmQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width property
To:     "Chiang, AlanX" <alanx.chiang@intel.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        "Yeh, Andy" <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        tfiga@chromium.org, jcliang@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-25 5:20 GMT+02:00  <alanx.chiang@intel.com>:
> From: Alan Chiang <alanx.chiang@intel.com>
>
> Currently the only way to use a variant of a supported model with
> a different address with a different address width is to define a

There's some copy-paste problem here. I fixed it.

> new compatible string and the corresponding chip data structure.
>
> Provide a flexible way to specify the size of the address pointer
> by defining a new property: address-width.
>
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 61d833a..aededdb 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -72,6 +72,8 @@ Optional properties:
>
>    - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
>
> +  - address-width: number of address bits (one of 8, 16).
> +
>  Example:
>
>  eeprom@52 {
> --
> 2.7.4
>

Applied both to for-next.

Bart
