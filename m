Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19029ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C091721470
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC++esJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C091721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeGQJqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:46:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33212 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbeGQJqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:46:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so370786ljj.0;
        Tue, 17 Jul 2018 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=chURNAgvrwHXXxWGTAVtOLs6g18i5+gldP0KxRgPQaE=;
        b=GC++esJIZpzHpinfmacA3R6L0S+fwXKOl/7gVi8G4g9QfgAwfHDJjkrfyJMtGk8tNv
         +u+bV0SKcawfF0r9i2Rv2RhZdH/toagYWkZSwVM1qhXbFTkFKeyfcaZG1pc+ZzfzOmZ4
         ChimVTn98+qR96YcGBisYdMxEl5Bwae0mXuP9NrxkXuBIX5Xib/F/Keox1oGTF68fz4P
         N3EWWlAz1DnD3625v1W6KcRXlul1xMe7Ze6yrflVOdRA+BpRlOOuWh0PEFMwdaf1xbjY
         Ffxcfcoyg3Ji0iFShh5n6DeAisRnxZFw9K0EwCFT3u+N5J2D8oewQ6AIKQVj/reZM0pG
         wyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=chURNAgvrwHXXxWGTAVtOLs6g18i5+gldP0KxRgPQaE=;
        b=Y8b1iD4vYNGqBgSCPTDIBtp2PkSthQjrIvWe9YxP9pObR4YQPYzRLffgsulif895Y7
         FZvlj9wGCxG4j2623uttiJneRMbL3F2yItK6tmflWnYeo+WK84Tvrdeuho3sgQqPW0Cp
         1HHKbGPxdwSOLfhoEukAcD3BP8yFa1KSBJ5tSrk42kevU2ex2oeuLMpYxzH4OtRtAtg+
         x1isXWjqUAe9uFS7bnlASWxPoUl2ZGTG7BksHAA3zBXluvWHxSodO1ZlyipF3cfc8YUL
         KwIPnVfSqGyEBKKSFRQGcSlmdvGDuqgiSEnvWa+ZqB2HQuU1FBBio3wAcS3HGHaKXm6c
         Pteg==
X-Gm-Message-State: AOUpUlGZ+8tNBThPOq2SDEKj96T0PIzUmcGsqlBNAgIxYwxeTjCYWC9T
        pTkJTMneyNzzZssBjRj7jFgA9QMp7WD/q4P5ZDQ=
X-Google-Smtp-Source: AAOMgpcaFj9og6RWDhx/ffaAMvUFN5GqH2sZNn6O6fx0Zs7cSWFMsVDkJF/lrYtUBizcPrdabyzR6slco0SLmgM4GWQ=
X-Received: by 2002:a2e:2d2:: with SMTP id y79-v6mr785667lje.100.1531818908080;
 Tue, 17 Jul 2018 02:15:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:631a:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 02:14:27
 -0700 (PDT)
In-Reply-To: <892181d5-61f2-55da-2a79-1d2cbfc00f8f@intel.com>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
 <1531106398-14062-5-git-send-email-zhang.chunyan@linaro.org> <892181d5-61f2-55da-2a79-1d2cbfc00f8f@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 17 Jul 2018 17:14:27 +0800
Message-ID: <CAAfSe-tJGM7GMb6pCAMhKVDu9XSEjmyGYkgVCQZr__C0Q0goiQ@mail.gmail.com>
Subject: Re: [PATCH V3 4/7] mmc: sdhci: add 32-bit block count support for v4 mode
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

Hi,

On 17 July 2018 at 16:29, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 09/07/18 06:19, Chunyan Zhang wrote:
>> When Host Version 4 is enabled, SDMA System Address register is
>> re-defined as 32-bit Block Count, and SDMA uses ADMA System
>> Address register (05Fh-058h) instead.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 4 +++-
>>  drivers/mmc/host/sdhci.h | 1 +
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 7871ae2..f64e766 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -889,6 +889,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>  static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>  {
>>       u8 ctrl;
>> +     u32 reg;
>>       struct mmc_data *data = cmd->data;
>>
>>       host->data_timeout = 0;
>> @@ -1021,7 +1022,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>       /* Set the DMA boundary value and block size */
>>       sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
>>                    SDHCI_BLOCK_SIZE);
>> -     sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>> +     reg = host->v4_mode ? SDHCI_32BIT_BLK_CNT : SDHCI_BLOCK_COUNT;
>> +     sdhci_writew(host, data->blocks, reg);
>
> The specification says to set 16-bit block count register to zero when using
> 32-bit block count.  It also says it is valid for V4.1 onwards and also for
> V4 with SDMA and auto-CMD23.
>
> So maybe we should continue to use the 16-bit block count register with V4.0

Ok.

Where can I get a V4.0 specification? I only have V4.10 on hands.

>
>>  }
>>
>>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 24fa58a..889e48b 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -28,6 +28,7 @@
>>
>>  #define SDHCI_DMA_ADDRESS    0x00
>>  #define SDHCI_ARGUMENT2              SDHCI_DMA_ADDRESS
>> +#define SDHCI_32BIT_BLK_CNT  SDHCI_DMA_ADDRESS
>>
>>  #define SDHCI_BLOCK_SIZE     0x04
>>  #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
>>
>
