Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF1520891
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRyqmkuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF1520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH0NxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:53:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40033 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbeH0NxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:53:25 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so12325803iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8oDe0d0GaWEjTdjOchuNbOKsGZ/SHxzb0secHWpFJsI=;
        b=WRyqmkuqUi0Xfgenaf95PrZn0Qbwzh2g/xUFO0tM7psmHjSGKenIrhiSluC65V9scQ
         H7V5sNWbyl6GmAerUpQsTKEZTFdUJlViGYgrOEcRcwAKX9GkyxeQ8cBBtOLyEl0r38b8
         qkBPApjq/rdMR3wDui52hcXA7K0xfVtTuVm48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8oDe0d0GaWEjTdjOchuNbOKsGZ/SHxzb0secHWpFJsI=;
        b=ukJzH4kING9WTDMJBrdnKXX7StkBcxrQXYqnt2nMF8JpbpRJpMSGeiOeomaVyo4nDy
         3YooJXJXpNw9+2AMjmUNQht91Bq7ZQ1qRJYCLPT5Y2dZnnLwccVKSNj5auuI3RFlhNbR
         yYgT1KZmQP9zlZvBMweVwf+CNFDTx8dcDysNo82gKqpwk76SCNeKwZos+pteXLRPU711
         LgRHxzlwXSGoowuBLdQ+XWSoz2eM88VzFTVHGBUzgZ6pADn6xFr4u6uALKjBxb5nKrkK
         qACMomGybRNyvc8tEWEPsGeO91WdYZo7bJfMv1Kj/cf6h8P6O7ywlo1Kl12B0EjIjXlj
         siNw==
X-Gm-Message-State: APzg51CyHW6nJkrhQ+pSf2PDNl+p09DrtfZrSAXTmj1aUas5fctzL3hJ
        iVRNJNpKWuttSUlkGBZhJtNdAYVNBhXRLfYmHjvU2Q==
X-Google-Smtp-Source: ANB0VdYCKIJWR7JmzVfU/MuKWhvotz9u/KsPAdpLNfZNgp6bmj1MW7hhLMxVPZuw1v4MXDJb2lzBd7Yl9bPIklbbhUw=
X-Received: by 2002:a6b:c995:: with SMTP id z143-v6mr9835010iof.266.1535364444255;
 Mon, 27 Aug 2018 03:07:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 03:07:23
 -0700 (PDT)
In-Reply-To: <9de08b30-cb92-01c6-caf3-c4abc3591dcf@intel.com>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
 <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org> <9de08b30-cb92-01c6-caf3-c4abc3591dcf@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Aug 2018 12:07:23 +0200
Message-ID: <CAPDyKFpL_o2N_yteF=rTH5gy4Mm-HrQU5bL5i8s2dWjpTK_Fng@mail.gmail.com>
Subject: Re: [PATCH V5 06/10] mmc: sdhci: Disable auto-CMD23 if stuff bits is
 set in CMD23 argument
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 August 2018 at 14:50, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 16/08/18 10:54, Chunyan Zhang wrote:
>> For version 4.10 and aboves, SDHCI_ARGUMENT2 is also uses to indicate
>> 32-bit number of blocks, it doesn't support stuff bits in argument of
>> CMD23, but only block count for the following command (CMD18/25).
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 9 +++++++++
>>  drivers/mmc/host/sdhci.h | 1 +
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index b3328ee..a72ad0d 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1729,6 +1729,15 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>               }
>>       }
>>
>> +     /*
>> +      * For version 4.10 and above, ARGUMENT2 register is also used as 32-bit
>> +      * block count register which don't support stuff bits of CMD23 argument
>> +      */
>> +     if (host->version >= SDHCI_SPEC_410 &&
>> +         mrq->sbc && (mrq->sbc->arg & SDHCI_ARG2_STUFF) &&
>> +         (host->flags & SDHCI_AUTO_CMD23))
>> +             host->flags &= ~SDHCI_AUTO_CMD23;
>
> I would prefer this be done in sdhci-sprd.c by hooking ->request().  Someone
> sent a patch recently to export sdhci_request().

Right. So I have picked up the patch you were referring to.
https://lkml.org/lkml/2018/8/20/140

Chunyan, you may now preferably base your next version on top of my
mmc tree's next branch.

[...]

Kind regards
Uffe
