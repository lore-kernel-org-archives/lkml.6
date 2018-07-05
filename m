Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF75EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A99024137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdQOGVZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A99024137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbeGENJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:09:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50832 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeGENJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:09:19 -0400
Received: by mail-it0-f68.google.com with SMTP id u4-v6so11897108itg.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rrEvH/1kdbJSslVlZVmThCbaMF8pie9M0KRmJP0/dZw=;
        b=bdQOGVZ0+41ktf5XiNlK6A8zzAH216ARMsl9w0c5YkNzeqdKZZsOGahVOghzZs+inA
         MBDoC+fizxYiXz7L/K9I+RhG11qy5cuC3RDlcEmIosmxqcxwyxRNgkLKECZ7/tQBd9wT
         royT6WfHZ4HngFa7DKnhx6ZOFMdzDcTzsmkt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rrEvH/1kdbJSslVlZVmThCbaMF8pie9M0KRmJP0/dZw=;
        b=liaXM4EjsxcKHVvG7+JhZcnigm/bwN/bVUttaD6/+TaCGIPF8RtTdAy2yXlPkcCp5D
         tE3fv1FROTDCVHmxYo2xR9na7o1/kTFyTOlv70Z81UIX/f7uNET8tevIHlFGDOxcUWj1
         55OdmHIZkqeWo0Ft43EkNRQavLkY5VZkDhtTcGYLd5w99zd5FkF12kxxdyp54vaLYy7N
         kAFuVIznDKWwtEf19okX67b7LsYmet7vvSFAIhoX1+6TxMBFEhHsG2fxSQiB0q3SmJX8
         16H74rc3BKJxz5i7JV8d8XtsKjPs4sZorMnEGx9czOEuCxuNduyl3rKzvPXKUuCT/M2H
         6glg==
X-Gm-Message-State: APt69E0X3t2w85N1/1mwWPsCd7N9Y5orG+etUCsVX4elu0Pnz5Rkx2Cb
        7Bj94imoeSjT2xYm/XfUG5To49c1wNVW02mSfYKZkw==
X-Google-Smtp-Source: AAOMgpcWHLSyXraYWNQxCtaMRz3CIxl5FIaYigMLX7MrJKL9uQS3bLNZOUvd+XJBZJC9UbAD++zKZlD3aO1P4zs4s9M=
X-Received: by 2002:a02:94af:: with SMTP id x44-v6mr4910462jah.121.1530796159013;
 Thu, 05 Jul 2018 06:09:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:09:18 -0700 (PDT)
In-Reply-To: <20180703225659.GA14443@embeddedor.com>
References: <20180703225659.GA14443@embeddedor.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 15:09:18 +0200
Message-ID: <CAPDyKFrQEnA4jYH4cVBq1-AFHWKHKuXSh63M1f0XVyi-7h53Rw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Hu Ziji <huziji@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 July 2018 at 00:56, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Warning level 2 was used: -Wimplicit-fallthrough=2
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index a35804b..c335052 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -526,6 +526,7 @@ static bool xenon_emmc_phy_slow_mode(struct sdhci_host *host,
>                         ret = true;
>                         break;
>                 }
> +               /* else: fall through */
>         default:
>                 reg &= ~XENON_TIMING_ADJUST_SLOW_MODE;
>                 ret = false;
> --
> 2.7.4
>
