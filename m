Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDFDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EAF20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDRyNOZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EAF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbeGKNIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:08:22 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50793 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387729AbeGKNIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:08:21 -0400
Received: by mail-it0-f67.google.com with SMTP id w16-v6so3492849ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IR8gHxhJpLPBD4bBTI7qYZwQv5dB7zSSf0yho6+XIb8=;
        b=kDRyNOZf7ypeQrLK6ZayPqTqcEicu8r3h3+PWNk0hEbgR1CAxUFYBi5l0Fomg4X5ZJ
         5QSlh2tIONJNUfqZp6NIGLRbO+B/3usVKr6NWl+EG2nmtL21chjngfhUnTt3nuhONg9U
         TMLhCwiCOhIX+iyEZ3N7jeU94CsxKCAQKyAO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IR8gHxhJpLPBD4bBTI7qYZwQv5dB7zSSf0yho6+XIb8=;
        b=uDdx7CdVIb99sXWkfzIpVYeqiZpSzH+0TGQT95ruiMdzXbeCu+tbJ8DAsKZPpywAxZ
         krOF0pEJC4S0DynLr0RfiOypbnBD6Xgm0GuzKEday4ua2AmxXuWS6+2722Kk/DXAzJQO
         kxNtnvAi2JwhgRYzxy5g2WXwlwM3TVayFAHwAwDePPUafIClKHJXK0Bu3aRigfQfkWz5
         PgfMfHfq6ZHMHuv8EnXIGX0oPIE8UEsUKO1T+yoHgUYMN6fmIY5TN+qTZCNbYBEIU5Kx
         In5HfIecHmtoot2H+BfOfEhy1dyNf25ORNAm1YUHs103DciXSar8DeX4UJOzvra1inqZ
         mgjQ==
X-Gm-Message-State: APt69E3xC++PHgypMAyfjtx871IM8WRxtHSASho0JCDGqAhzhZ4uX3NW
        Ac4uzXk1kv40+gi3AwwES5C9/M8EUjWqG4hC67YacA==
X-Google-Smtp-Source: AAOMgpekbcH9YEN1YhgEHMCHwLQI+qPfUS9y+Od8uEmzaV+yK7fs26ZYl44P6UKdhNyyP5m32ejyTPE9IymsuGqswvM=
X-Received: by 2002:a02:570c:: with SMTP id u12-v6mr24229013jaa.142.1531314246051;
 Wed, 11 Jul 2018 06:04:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 06:04:05
 -0700 (PDT)
In-Reply-To: <baf7647f-47e7-dfe0-102c-9f7f48b3a363@intel.com>
References: <20180705113937.16414-1-stefan@agner.ch> <baf7647f-47e7-dfe0-102c-9f7f48b3a363@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Jul 2018 15:04:05 +0200
Message-ID: <CAPDyKFqLg-uyK+KXS-2oTrukSjx+WBG9rb0Uj430-47MpVawsw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: disable clocks before changing frequency
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 July 2018 at 14:29, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 05/07/18 14:39, Stefan Agner wrote:
>> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency
>> is set to 0. However, it could be that the stack asks for a frequency
>> change while clocks are on. In that case the function clears the
>> divider registers (by clearing ESDHC_CLOCK_MASK) while the clock is
>> enabled! This causes a short period of time where the clock is
>> undivided (on a i.MX 6DL a clock of 196MHz has been measured).
>>
>> For older IP variants the driver disables clock by clearing some bits
>> in ESDHC_SYSTEM_CONTROL.
>>
>> Make sure to disable card clock before chainging frequency for uSDHC
>
> chainging -> changing
>
>> IP variants too. Also fix indent to make disable/enable clock look
>> alike.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 85fd5a8b0b6d..aa48f4b2541a 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>>       int div = 1;
>>       u32 temp, val;
>>
>> +     if (esdhc_is_usdhc(imx_data)) {
>> +             val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>> +             writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>> +                     host->ioaddr + ESDHC_VENDOR_SPEC);
>> +     }
>> +
>>       if (clock == 0) {
>>               host->mmc->actual_clock = 0;
>> -
>> -             if (esdhc_is_usdhc(imx_data)) {
>> -                     val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>> -                     writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>> -                                     host->ioaddr + ESDHC_VENDOR_SPEC);
>> -             }
>>               return;
>>       }
>>
>> @@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>>       if (esdhc_is_usdhc(imx_data)) {
>>               val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>>               writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>> -             host->ioaddr + ESDHC_VENDOR_SPEC);
>> +                     host->ioaddr + ESDHC_VENDOR_SPEC);
>
> Ideally each patch does only 1 thing.  Please make white-space fix-up a
> separate patch.
>
>>       }
>>
>>       mdelay(1);
>>
>

It turned out that I had already applied this one. I am going to
re-base my next branch next week, so dropping the patch by then.

Until then, the patch is reverted.

Stefan, please send a new version addressing Adrian's comments.

Kind regards
Uffe
