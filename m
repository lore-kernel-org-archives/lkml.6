Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E744ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC36420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/ZrYFA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC36420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbeGWIMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:12:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45781 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387915AbeGWIMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:12:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id q5-v6so15937462ljh.12;
        Mon, 23 Jul 2018 00:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+r1iMyc+42ftRkTTq9YRJROctWLQaEII4JimFrcDxsw=;
        b=R/ZrYFA2C6gxgl9igD7y0iqdwUaCoBnyY2aOP9f223YKq4dVoQbkj2NTE8J8cH+aX0
         /6Ej5ulxKSTXwY47nPWAYYM8l8GNuuFsSN4KZcTMlvuE3IAsXd6rGm6GTVOCKvogKtqQ
         XolInVjamrQdb0BYz+98r8tmFFR0DDqbOtzV9Gutlmix12xpHmBPe+oqhh6OjdVtj8ig
         9XuA+pwzHketAGIvoCO+LKS2f7A8jwCfHTfoK2t/m4+uMZDqQicYac/ZdKBeVduPluza
         aG7adRqVghbvLwIuiRsbHO36JXnQP0QJrn97Wfwj+sxRQ3mG9IPXlNVwzYBeJ9JYbdkO
         aXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+r1iMyc+42ftRkTTq9YRJROctWLQaEII4JimFrcDxsw=;
        b=JNJ/n9m8eFS/eiA30KwP5nyEPeiuYLsQTGx88O8rxNpuzW5MIrMG4vEhyW4Wz9AFma
         YFX/8daAocJEeJx1EAbJbXuEQs7H64AC83fdUz9cdgaAoier+Emg6FcWl/u9isTSbSst
         0DyEj6Q0+bLxLQf+CBUkbtk3Tt5Eu7rJYhjK7BL973vzrA1Me81WVhu4ikxWZYBbW7Ul
         rkEGAPLXZ37eSs8oy2rMSqSTRZjPAmJx6vQafW0qny89ljEuHDRftf2/aG/yUSbIQHtf
         0pHCx6oKFrHpTt7yaA1XGm9lqQi7AEE9JrzoPr7g0+oLBkZZLayB40Etrgdvip5yi9XQ
         7WVA==
X-Gm-Message-State: AOUpUlFeJY5aXz5JhS6OE2I12f/zFQGD2QAociF27CFbulNzK2ZRDveq
        59oPofZ8U0YRI8D0L+GyQ67n+DXu1/V1ONURYsQ=
X-Google-Smtp-Source: AAOMgpck7gIykNBjm6A/8zktG8LfOcz1yAPCcvd1Dp3nyqDcrpH03Exjd0OVoaCUhX7gdaQBgaikZpQhRsuPYqxrkSA=
X-Received: by 2002:a2e:9f4d:: with SMTP id v13-v6mr4426951ljk.42.1532329934551;
 Mon, 23 Jul 2018 00:12:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:631a:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 00:11:34
 -0700 (PDT)
In-Reply-To: <892181d5-61f2-55da-2a79-1d2cbfc00f8f@intel.com>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
 <1531106398-14062-5-git-send-email-zhang.chunyan@linaro.org> <892181d5-61f2-55da-2a79-1d2cbfc00f8f@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 23 Jul 2018 15:11:34 +0800
Message-ID: <CAAfSe-v1J3tW7O0D4=yTTqk=sXx3cvdFS=V9dj4fOcRx3S5UPA@mail.gmail.com>
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

I found that the 16-bit block count register is zero without being
wrriten by driver, and the weird thing on my board is that the
initialization would be interrupted by SDHCI_INT_ADMA_ERROR if setting
"16-bit block count register" to zero manually.  So I will add a check
of whether it is zero already before writing it.


> V4 with SDMA and auto-CMD23.
>
> So maybe we should continue to use the 16-bit block count register with V4.0
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
