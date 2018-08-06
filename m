Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172AFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C502421A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ6Y7dfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C502421A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbeHFNi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:38:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45222 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeHFNi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:38:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id j143-v6so8770508lfj.12;
        Mon, 06 Aug 2018 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xSitjpY0iq7aIvh0AchMyd+cIdFK0io7jfQzbgVihXI=;
        b=IQ6Y7dfLztUV1CNHan5r22zS0WFlyJcd66RGNC1YEq3ErKBzEZo9Y+8MvfgfYe/83z
         xQsDWmB3oULJTFHAJ3nCd9RUSOFZQoU72cb6hXMcNbuoAHWN0Qn8B71I1/TmOb28KczI
         b9+C2eGgwfUhHpUK3o5VTC3gj8UoT8YmOb7/ipNJ7/dqqVJDJvGB9yhB3Bqr8tvNQK8v
         qENns47XEoi8XgIkL4JK8xmJgGUAx5E266R3Vlu0cv+wVNRIBz2G5Wj5xgGa+CaMI2Gr
         rgg1avzqe1nLSaoOq+vD9fRXk3vNRbCbzpj0QbIKjvLxrzuoaEuKIf60iV3SVNRuYtLr
         uNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xSitjpY0iq7aIvh0AchMyd+cIdFK0io7jfQzbgVihXI=;
        b=jzIVaVBAOG3Mz1Cw2Zo+Ck2qoCciDltufH4CdaqoGgeTLFVhpAe4FZagbooaxXyR0q
         L8XlTWU0SRp1Y0qn5dLDBuGZRSMgAQazD246eq5iDqgPN8Pq1q/msMOorBUI4CyChEvZ
         A/xuHe9avuU51STKycLVr5fQ4xfPnTcqCcSTSJ6Euh8SAeAmzvWh7tx2sEQFDVYl9ZZA
         G5qlYkSghcCrloB+oLtCPEOIBJ68H/U9XHYAabx31SpgUcpLvy2fLLm3ChSW7ItAYzB5
         KS3uFRlFHmRWagomIJKyeOqxgj36M5MnMMJoASDiVf7Ws/bRmtx6FcPZ/mXKYhueMQ/J
         EM4g==
X-Gm-Message-State: AOUpUlFnIHRiaIbOVtiE1QcTucKdgQGMCJxcQuyu0tnZ+r0js0wGiT90
        FnsPz5b4L+SHAVqvnO6iw4uu8qErE8cb+Ju0w8k=
X-Google-Smtp-Source: AAOMgpc3+5AJCQr+0iCMdpcl0RP5O8W2LnQ3IEkVG9b/1ncD6U0TnQQ2jMJxTmYlTXgtQ9Hqy6jfGFn5mYsj1gAaa8k=
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr10580065lfg.142.1533554986586;
 Mon, 06 Aug 2018 04:29:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:631a:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 04:29:06 -0700 (PDT)
In-Reply-To: <3e586922-c5e8-fb3c-233e-06836f4dad48@intel.com>
References: <1532340508-8749-5-git-send-email-zhang.chunyan@linaro.org>
 <1532400671-23429-1-git-send-email-zhang.chunyan@linaro.org> <3e586922-c5e8-fb3c-233e-06836f4dad48@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 6 Aug 2018 19:29:06 +0800
Message-ID: <CAAfSe-vT0+9seTJwioY8Um0ch85Q_pDfbWC=uCyF2Ch+LEby-g@mail.gmail.com>
Subject: Re: [PATCH V4 4/7] mmc: sdhci: add 32-bit block count support for v4 mode
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 30 July 2018 at 21:05, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 24/07/18 05:51, Chunyan Zhang wrote:
>> Host Controller Version 4.10 re-defines SDMA System Address register
>> as 32-bit Block Count for v4 mode, and SDMA uses ADMA System
>> Address register (05Fh-058h) instead if v4 mode is enabled. Also
>> when using 32-bit block count, 16-bit block count register need
>> to be set to zero.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 14 +++++++++++++-
>>  drivers/mmc/host/sdhci.h |  1 +
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 920d8ec..c272a2b 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1070,7 +1070,19 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
>> +     if (host->version >= SDHCI_SPEC_410 && host->v4_mode) {
>> +             if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
>> +                     sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
>> +             sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
>
> So this is also SDHCI_ARGUMENT2 which is why there is a conflict with
> auto-CMD23.  We need to write SDHCI_32BIT_BLK_CNT only once, but also cater
> for eMMC which uses the CMD23 argument for more than just block count.
>

What you would suggest on how should we change here?

I've double checked with the hardware fellow within the company, the
sd host controller v4 (on our platform at least) would  use this
register as block count only, that's saying that it would not deal
with the flags (i.e. reliable write and data tag) of CMD23.

Thanks,
Chunyan

>> +     } else {
>> +             sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>> +     }
>>  }
>>
>>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 23318ff..81aae07 100644
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
