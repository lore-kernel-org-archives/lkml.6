Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACDCC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048CE24715
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jubHHkmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048CE24715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932603AbeGDDD0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:03:26 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33439 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753623AbeGDDDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:03:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id u14-v6so3183483lfu.0;
        Tue, 03 Jul 2018 20:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RNmXcrYd2wT2fnFEyy+Dhe4+Rj0tTtnM+6PukaKZB24=;
        b=jubHHkmBbckn4VW5VMyLhVgTSbDGvo0XAdVd4viZg++2YlpGzB690rfRzDF6/sfopq
         +hixFh+lW6urg336DUwZePD09UHs7W2u59ihFfoIkJ7j4bSa5Gdil2gAjIMylqng4+uv
         UDZdIqkdL+/VvK+SSJUKrZtlwNxBvKOxsTJLBnG4TQNduMuHEaCsbpqcY4n5FQEqeURd
         bBnK74hn1FQxkmzFJGLJUnGWi36+kRfaqSzzqD4mRRXvKI3EdBTYh2G3kuHfhZtLOHpB
         c4Ku5+PaRtKct2TyUfVqV2k7v96nEu+tzdEYfvbthG7Z4QB88UXZpJq2mgtTNe2F83Uj
         3KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RNmXcrYd2wT2fnFEyy+Dhe4+Rj0tTtnM+6PukaKZB24=;
        b=mfoAW4vPg7ngmlIY6Rp/WM40PnV4I2Y11RuMIxwVgAMlhN87hGxNcYZtL3hIZF7Ul+
         e3LmTEfh8WYub+AJDx0/k3XAZvvCAvA/flMu4i1mpGdoGj6/SVM61P0QRpXmpi7nGiSW
         NVw3f/2wT3zM/m334Y4OBE0IYEeXfMf0GxPUdMCelUrK00CfsLV9xVX4dMcyqJc8m31/
         0895AwYvJ3fR9RrJVHXSMTjbwkT10KcioQ/WpkudzwnqcH+7jNz2U5rMJzWIcKe5BjHq
         yiaYz5tr0krrCcArLGdDenl/gSbgjnWRko3MISSgicBtn4g1gok202BsfS1gXPxYn3u+
         TRng==
X-Gm-Message-State: APt69E3kBnunUqCEoPxzoWmZ0p/QEcPxHhQat0rZEbniUZDGnj1hVIsw
        Yi9SiTUskk2hAgcrN64NnJ7mtbRlXPWUpqd+eak=
X-Google-Smtp-Source: AAOMgpcrf7K5PQqPciXB30vYX7hXg7325Uq/qa3aPiLVmxusFdflbh7Bm/fOtk+48Ue5L48v18wexkpcWbrdfYGd+vY=
X-Received: by 2002:a19:b519:: with SMTP id e25-v6mr135732lff.119.1530673403379;
 Tue, 03 Jul 2018 20:03:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:1796:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 20:02:42 -0700 (PDT)
In-Reply-To: <2eb994d3-7f23-6ff8-4740-7a444a581e9d@intel.com>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-3-git-send-email-zhang.chunyan@linaro.org> <2eb994d3-7f23-6ff8-4740-7a444a581e9d@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 4 Jul 2018 11:02:43 +0800
Message-ID: <CAAfSe-tegyiEhHrJ+9pqbhm+sYDnd3WwuSEc4p7qDMDpYJw-xw@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] mmc: sdhci: made changes for System Address
 register of SDMA
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 June 2018 at 19:22, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/06/18 05:04, Chunyan Zhang wrote:
>> According to the SD host controller specification version 4.10, when
>> Host Version 4 is enabled, SDMA uses ADMA System Address register
>> (05Fh-058h) instead of using SDMA System Address register to
>> support both 32-bit and 64-bit addressing.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index cf5695f..f57201f 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -805,6 +805,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>  static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>  {
>>       u8 ctrl;
>> +     u32 reg;
>
> reg could just be an int.

Why? Shouldn't addresses be unsigned?

>
>>       struct mmc_data *data = cmd->data;
>>
>>       if (sdhci_data_line_cmd(cmd))
>> @@ -894,8 +895,10 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>                                            SDHCI_ADMA_ADDRESS_HI);
>>               } else {
>>                       WARN_ON(sg_cnt != 1);
>> +                     reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
>> +                             SDHCI_DMA_ADDRESS;
>>                       sdhci_writel(host, sdhci_sdma_address(host),
>> -                                  SDHCI_DMA_ADDRESS);
>> +                                  reg);
>
> Shouldn't we support 64-bit SDMA in version 4 mode?

I will address.

>
>
>>               }
>>       }
>>
>> @@ -2721,6 +2724,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>                */
>>               if (intmask & SDHCI_INT_DMA_END) {
>>                       u32 dmastart, dmanow;
>> +                     u32 reg;
>>
>>                       dmastart = sdhci_sdma_address(host);
>>                       dmanow = dmastart + host->data->bytes_xfered;
>> @@ -2733,7 +2737,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>                       host->data->bytes_xfered = dmanow - dmastart;
>>                       DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
>>                           dmastart, host->data->bytes_xfered, dmanow);
>> -                     sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
>> +                     reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
>> +                             SDHCI_DMA_ADDRESS;
>> +                     sdhci_writel(host, dmanow, reg);
>
> Shouldn't we support 64-bit SDMA in version 4 mode?
>
>>               }
>>
>>               if (intmask & SDHCI_INT_DATA_END) {
>>
>
