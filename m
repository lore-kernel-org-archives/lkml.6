Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA407C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA162178F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dowhile0-org.20150623.gappssmtp.com header.i=@dowhile0-org.20150623.gappssmtp.com header.b="aG+IbEFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA162178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbeHDB2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 21:28:44 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45122 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbeHDB2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 21:28:44 -0400
Received: by mail-io0-f193.google.com with SMTP id k16-v6so6335479iom.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 16:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fSh8YeEFLf9MRSEMRBZQHCegftWKTj3r7hA4jOWfZOw=;
        b=aG+IbEFAge1xuCAF67cpK0a/ABU0V0wkur9oX5vFUexEKM0+Hyo7xk1dcXwd818d1k
         fAHhq23q/v7SW2LC8dpokYTYdcKcVblp0UfoHwg6h9X04oq86RUuiKqLU4S0aQ0SlgSp
         io/HJLH+t2+ZJkXBA5DlwZWjij0t0kGHZKkA4h3oFm9kS+5Sttl1gVRBLBPHAMsfzxmy
         fHw9FKMtRIaAh1N/gRlj1OUnbgG+lHIZx0awXSOCqC5cGPNE5Ze+KXNmi1jc7S7q8FJC
         cKL/VyJBO4E30pNweX0gNuNCdGnELFYTozunP1BYwuoyJWsOKUQv3ywt4ehs2WPgFyCF
         z9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fSh8YeEFLf9MRSEMRBZQHCegftWKTj3r7hA4jOWfZOw=;
        b=KqiwOfdVgecQ62VfcEA8YrHo5kkABvpXZyUV2dHKtmXGeSxV3xobQQLB5oya9PrKrF
         DFy2NsM+uTGL/xEi/O3DS0C5mJazlsmDXxfO6OuHw1v9kIamJlkBq6J4T4Clj3JIOuNM
         PfLwZKuFjyfPHOIQwlPk+cWlElSbMZuseW4PasMcTtOZbee+Y0Pto5GEowM2NmKFrQC5
         18kkhdOT0hPjdslJJDYxur2YzaZUdoVBA6njxEFbibs3k4nR6IZc4X7R6HkvQ+qltukd
         7L6D4HS3iQ3GFbcLUixw3Aw28pkBUtdVVNPITjopj7itFmFm9fjEl56CfFJJcCrPS8BA
         8PVw==
X-Gm-Message-State: AOUpUlHT1i7dMdOUiMrFcU/JZmCNcfRtlEllFTv1lF3QDTLC1KgRp0vH
        0ssqtUTdUKCYpYDS/0OXTHXG0Ev37KT36Ybd42V7xg==
X-Google-Smtp-Source: AA+uWPwa4P0i/ugIcRBQbMla52CBl+y3GyleBDKb35FsI7GBIjj2O+H2/I4jxjZ2qsEDC+eEadQWRZ7Ieh15UtLPHyE=
X-Received: by 2002:a6b:103:: with SMTP id 3-v6mr8282945iob.78.1533339020139;
 Fri, 03 Aug 2018 16:30:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:4285:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 16:30:19 -0700 (PDT)
X-Originating-IP: [90.168.169.92]
In-Reply-To: <20180725155302.4718-1-krzk@kernel.org>
References: <20180725155302.4718-1-krzk@kernel.org>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Sat, 4 Aug 2018 01:30:19 +0200
Message-ID: <CABxcv=k-BS04gZKGQqE1=CLhNk79yOHC9_CcrB6=UJ9xYNqGMg@mail.gmail.com>
Subject: Re: [PATCH] mfd: sec: Export OF module alias table
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jul 25, 2018 at 5:53 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> In case of Device Tree platforms, even though the Samsung PMIC sec
> device is instantiated from DT, the driver is still matched through I2C
> module alias.  That is because I2C core always reports an I2C module
> alias instead of DT one.
>

Just a heads up that this already changed in v4.17 since commit
af503716ac1 ("i2c: core: report OF style module alias for devices
registered via OF").

> This could change in the future so export DT module alias.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/sec-core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
> index ca6b80d08ffc..9613b4257302 100644
> --- a/drivers/mfd/sec-core.c
> +++ b/drivers/mfd/sec-core.c
> @@ -146,6 +146,7 @@ static const struct of_device_id sec_dt_match[] = {
>                 /* Sentinel */
>         },
>  };
> +MODULE_DEVICE_TABLE(of, sec_dt_match);

This driver can't be built as a module since its config symbol is
bool, so technically this macro isn't needed. But it's a no-op when
the driver is built-in so it's harmless to have it.

Best regards,
Javier
