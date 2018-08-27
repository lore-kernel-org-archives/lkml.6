Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A4FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78987208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1jSlrWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78987208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeH0Lia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:38:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36603 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeH0Lia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:38:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id c21-v6so11177264lfh.3;
        Mon, 27 Aug 2018 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VsKirMMAbeZop9zyEh38wwWLeszhBqNQH+HIe1D4yXI=;
        b=V1jSlrWMl/nIV2Pna4i0VHZALtENmcS92GQhdzwRwo6S1lAF/hWohrCuaHme2IyHzR
         Xi92ZY2TDggAIVEhXBt8Jzga9i4rvrz61kY8hTMkiXlqBd21mI+I2YxuxVZ/tA0U1Rj+
         KaUHbjjRahsd4clRLGzcDcDpYXZHRMAQgkjfYyroeexfjEJB9nkZAw5NWL5bk7ZO7qRX
         Hj4hltfvZh00fuuu2gkSaVYbgAQ0n3XFFeO4OPBHcqxjkCij+x5QntuqWEKTrMCRWwOk
         7fnWlA9ZiCTv6i/MWn2mpqF+4AI0jhDXdE5XwNT0fpIcunFAwQA3CjIq8a+TchMUQhmr
         E+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VsKirMMAbeZop9zyEh38wwWLeszhBqNQH+HIe1D4yXI=;
        b=VI55zBeTARsillLg6KnEO4pw2s/Pnp2Iwb7Csqa4Uj4YWhxdktk0QdYIRAco6OVF3x
         2OPa7nn+hhznFQPOWEUPoTwyLxrfgeGt0966cseVMpkCgqpVmpmrZcljbfoB4knHjnKR
         KMZtIAoXLq9+lK7ixRIBcUcasVLKuviDHfB1CjbP/5SUCO97CyDm2mqbTUHrGFZnOVwX
         wXtnaQevM3Z65Mb/UXn+ygqaJ2fismwxtAL9ZnsLcFqPIdmjAur1Yb9j8oxCloEwWMUv
         4T3MC2UAH4lbrDzmfdmLWJtgokvZfSeRvuQjmv72RWtdZ2x2YstPOd2jlaN/JFG9fJLX
         dcTQ==
X-Gm-Message-State: APzg51B73EUMJHi1fk0fksOCD/SUNiHgpJm6VLomhN2vy51PwQ1d2D9y
        XWEDKPIE05rgO0oYC6o47z4RI+9EuJpVa/dglLY=
X-Google-Smtp-Source: ANB0VdaHRXTmhnUo5eiXhe3qQnew9aDl+kGwZ8l3qY25x8pTQunHqQPLC6ATu5va+84hgRhG4E5SqjL52BOZjF25SpI=
X-Received: by 2002:a19:115b:: with SMTP id g88-v6mr7466349lfi.57.1535356377252;
 Mon, 27 Aug 2018 00:52:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6318:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 00:52:16
 -0700 (PDT)
In-Reply-To: <f209e114-152c-65e0-4c24-53252818ab5d@intel.com>
References: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
 <1535102428-20332-6-git-send-email-zhang.chunyan@linaro.org> <f209e114-152c-65e0-4c24-53252818ab5d@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 27 Aug 2018 15:52:16 +0800
Message-ID: <CAAfSe-sC_NCkwU=-L-Rn1Bu9ZnHhA3TByM1Q7Wyzb6CH6yWSKA@mail.gmail.com>
Subject: Re: [PATCH V6 5/9] mmc: sdhci: Add 32-bit block count support for v4 mode
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 August 2018 at 15:07, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 24/08/18 12:20, Chunyan Zhang wrote:
>> Host Controller Version 4.10 re-defines SDMA System Address register
>> as 32-bit Block Count for v4 mode, and SDMA uses ADMA System
>> Address register (05Fh-058h) instead if v4 mode is enabled. Also
>> when using 32-bit block count, 16-bit block count register need
>> to be set to zero.
>>
>> Since using 32-bit Block Count would cause problems for auto-cmd23,
>> it can be chosen via host->quirk2.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 15 ++++++++++++++-
>>  drivers/mmc/host/sdhci.h |  3 +++
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 38d083c..05f9fff 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1073,7 +1073,20 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>       /* Set the DMA boundary value and block size */
>>       sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
>>                    SDHCI_BLOCK_SIZE);
>> -     sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>> +
>> +     /*
>> +      * For Version 4.10 onwards, if v4 mode is enabled, 16-bit Block Count
>> +      * register need to be set to zero, 32-bit Block Count register would
>> +      * be selected.
>> +      */
>> +     if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
>> +         !(host->quirks2 & SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT)) {
>
> Because 32-bit block count is problematic but also not essential, I would
> prefer to do the quirk the other way around. i.e. SDHCI_QUIRK2_USE_32BIT_BLK_CNT
>
> I would also add a comment to the definition of
> SDHCI_QUIRK2_USE_32BIT_BLK_CNT, like:
>
> 32-bit block count may not support eMMC where upper bits of CMD23 are used
> for other purposes.  Consequently we support 16-bit block count by default.
> Otherwise, SDHCI_QUIRK2_USE_32BIT_BLK_CNT can be selected to use 32-bit
> block count.

Ok, thanks Adrian!

I will address the comments and also rebase the whole patchset to v4.19-rc1.

>
>> +             if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
>> +                     sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
>> +             sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
>> +     } else {
>> +             sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>> +     }
>>  }
>>
>>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index f3b9ebc..0a1e25f 100644
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
>> @@ -462,6 +463,8 @@ struct sdhci_host {
>>   * obtainable timeout.
>>   */
>>  #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT                      (1<<17)
>> +/* Controller broken with using 32-bit block count in v4_mode */
>> +#define SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT            (1<<18)
>>
>>       int irq;                /* Device IRQ */
>>       void __iomem *ioaddr;   /* Mapped address */
>>
>
