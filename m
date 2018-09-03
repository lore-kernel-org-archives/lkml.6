Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C032C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7EA20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahCYZtRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7EA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeICRQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:16:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44522 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeICRQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:16:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id d131-v6so258966qke.11;
        Mon, 03 Sep 2018 05:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2JHvI41TJ/c7Z73rqsV3JJCM5rXM5RyLn4XFLljeM4=;
        b=ahCYZtRqQArkRwr2d9Qmr/2CN99w9UaahMxMWLscP8VGwApzbGDxUCXubAQpeRSWmG
         895CU+xF3ztdCGSl8RnMrJsVePUdFyxHb7zmmnmcFXhduyYD23QFEI5MKiMRWkeYebhj
         Kbecs+BtzFcsUfOFH6W3hk5GGVdsGV1Y1F1MOu7LfSoAWCyifFFmtsY+H5bFM2C9Xy1b
         EgbCG+HZu9h8Eytt7kdrVvA/MB9zbc9t47UCrAidFk/tR38iJCuXsqDwj9x+LAMmihNo
         lHPsL6y39ZWy9YMYjmxNszuJ1pwfMhWgyeVKHRJdlu9mJGf0JCHkamFGKU2RYG+KsQfN
         oBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2JHvI41TJ/c7Z73rqsV3JJCM5rXM5RyLn4XFLljeM4=;
        b=YytzMTnBAppvNud/m8EbSV/O298VxsgQPz2N9O8YOAqxztEXoopDdE4vMP/1DJcsHq
         W6a7tWgKiP047EF9y1ccEAeDJOEsLxqkuqWo/wXAwsPeapzlegl2vEImQ4si/YU6ruw5
         JXNnxXe0BtZ65IM+TxJFoJbUqD46N30WPOt7JYGymsj8FXUb9v6XcOaXKtNgHmSExwtZ
         4smIdcdCx0T0BXgg6hva4exaOwCYqnXvWm+cYma59cBjhePVham59UowIF1YYbDRFHSb
         1EtB55A8N/SAl2R/HjLLgh7nClNsalJyYxwdl9omw8iaSHeT4abwZUVdClsNNmHcj1GX
         dMIg==
X-Gm-Message-State: APzg51Cous+EfUMSEIXjFQ0/XxYWdk243M4uk5aAxLY68k32q3wha/JA
        WWUUwaieGB3npy2UYDMZv5afhPfLZbbdfHac+ag=
X-Google-Smtp-Source: ANB0Vdb7UEAVuQA0OMYNuxnehI5mmMqR7MJPm4yca/zIclao90F/r0afjkC0wIhwrdmlrv1dgoqID0YM45dFPQfoldc=
X-Received: by 2002:a37:179e:: with SMTP id 30-v6mr24139123qkx.33.1535979376985;
 Mon, 03 Sep 2018 05:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com> <20180827185507.17087-2-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180827185507.17087-2-jarkko.sakkinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Sep 2018 15:56:05 +0300
Message-ID: <CAHp75VfM6w6OrgczpMOY8wMK8Uw_SLm+RHDitYjrnNSX4aTepg@mail.gmail.com>
Subject: Re: [PATCH v13 01/13] x86/sgx: Update MAINTAINERS
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:56 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Add the maintainer information for the SGX subsystem.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 24b200d91b30..877fbc6ef7a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7562,6 +7562,13 @@ L:       linux-gpio@vger.kernel.org
>  S:     Maintained
>  F:     drivers/gpio/gpio-intel-mid.c
>
> +INTEL SGX

It should go in between of

INTEL RDMA RNIC DRIVER
...
INTEL SHA MULTIBUFFER DRIVER

> +M:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> +L:     linux-sgx@vger.kernel.org
> +Q:     https://patchwork.kernel.org/project/intel-sgx/list/
> +F:     drivers/platform/x86/intel_sgx/
> +K:     \bSGX_
> +
>  INVENSENSE MPU-3050 GYROSCOPE DRIVER


-- 
With Best Regards,
Andy Shevchenko
