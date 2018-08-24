Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3235C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3862147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syq3M/k3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3862147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeHXK0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:26:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37913 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbeHXK0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:26:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id i7-v6so5917306lfh.5;
        Thu, 23 Aug 2018 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZPCQnBlLlhbf3VeeCfEdv+Ec/fINg7gVR7Xlqsyz9DQ=;
        b=syq3M/k3QGE81BwFgNNrDW6bP7taaLo2PEpw9fJsJ/f4T21a441W7FHVuQQbVNunkq
         2eCMw1ZSor6SYM2d+zBAplT87FTD2ccFzHzXM0Kf/y10+i7oU4BpDHheKTVQPGswYazn
         tYi6vDghIoIjIMHtPas5SD+nWNfFPy03KoRYzaBR0SJ91Qn6VzPYTlcvKHCdnmxkA+Js
         K2y49Lk0eapH/EMOKxd26Slmih1yE/JZrwXyLyZ3mIBJFhQiUixmGN5F4T+qziJBz2n6
         AEbdu/sBZAOH+Uu/Zzh9RShoFWee61RCz63mOuRHofomkVWA3iLTlkY3G/whsuGGRqNb
         QUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZPCQnBlLlhbf3VeeCfEdv+Ec/fINg7gVR7Xlqsyz9DQ=;
        b=J0vEZViIgf8HcPUm5J+rb62eqH0MX12nqIRwVQw/kCXKTxKW3LguxWU5+a5eM4188y
         Hn493APE3kab9l6b81TLSf70riE8IiOkPJs17MRBA1farsGTgHNiWKRELsV+D3RbW4tS
         4pYMAR9YIEYSQJfun2lHeM3hBWDlU/exMDUJtCdjz15pwsVJEHomBUjj4SMpCAjjhXRu
         r81KQ+J8S26g7A+FyywioHPLreCcXf139VWDD2u9u3cViEWqX8rnMK1sZafbxv8AyV2l
         O+RvZeo6Joc7tQTvybxA1H7KSR09KnLsxLWV8XqlQN/S/X67rWVErf3MYBrCuqEOu5A+
         um5Q==
X-Gm-Message-State: APzg51Buim4RQco70jOMz8+hP3onhzYjG4o0I0FMmCnEyspOjPCoMxwp
        ZZpRfh9rrLmesuU6zPF/muuPFhh//Y/iaSXIP8o=
X-Google-Smtp-Source: ANB0VdaBazkbMAQwabGeW710XyrKbfjeICNog7Kzq6wnBlQkOSKTp7ewnWCJS2EG9Nf6JN/LW1Zz62W5nkSTKVgLSN4=
X-Received: by 2002:a19:eb83:: with SMTP id f3-v6mr332682lfk.89.1535093609344;
 Thu, 23 Aug 2018 23:53:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6318:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 23:52:49
 -0700 (PDT)
In-Reply-To: <0dc112ca-1c01-d8ae-c6f0-80492264f5a4@intel.com>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
 <1534406064-10065-8-git-send-email-zhang.chunyan@linaro.org> <0dc112ca-1c01-d8ae-c6f0-80492264f5a4@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 24 Aug 2018 14:52:49 +0800
Message-ID: <CAAfSe-uZ3ghR+8dZ7CD03UnGX2Uf1fv=-5s656ZkybcU8LWzJQ@mail.gmail.com>
Subject: Re: [PATCH V5 07/10] mmc: sdhci: Add Auto CMD Auto Select support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 August 2018 at 20:55, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 16/08/18 10:54, Chunyan Zhang wrote:
>> As SD Host Controller Specification v4.10 documents:
>> Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
>> Selection of Auto CMD depends on setting of CMD23 Enable in the Host
>> Control 2 register which indicates whether card supports CMD23. If CMD23
>> Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
>> used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
>> recommended rather than use of Auto CMD12 Enable or Auto CMD23
>> Enable.
>>
>> This patch add this new mode support.
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 67 ++++++++++++++++++++++++++++++++++++++++--------
>>  drivers/mmc/host/sdhci.h |  2 ++
>>  2 files changed, 58 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index a72ad0d..06c2ae9 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -312,6 +312,23 @@ static void sdhci_config_dma(struct sdhci_host *host)
>>       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>  }
>>
>> +static void sdhci_enable_cmd23(struct sdhci_host *host)
>> +{
>> +     u16 ctrl2;
>> +
>> +     /*
>> +      * This is used along with "Auto CMD Auto Select" feature,
>> +      * which is introduced from v4.10, if card supports CMD23,
>> +      * Auto CMD23 should be used instead of Auto CMD12.
>> +      */
>> +     if (host->version >= SDHCI_SPEC_410 &&
>> +         (host->mmc->caps & MMC_CAP_CMD23)) {
>
> The caller has already checked those conditions
>
>> +             ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +             ctrl2 |= SDHCI_CMD23_ENABLE;
>> +             sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>> +     }
>> +}
>> +
>>  static void sdhci_init(struct sdhci_host *host, int soft)
>>  {
>>       struct mmc_host *mmc = host->mmc;
>> @@ -1095,6 +1112,44 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>              !mrq->cap_cmd_during_tfr;
>>  }
>>
>> +static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>> +                                      struct mmc_command *cmd,
>> +                                      u16 *mode)
>> +{
>> +     bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
>> +                      (cmd->opcode != SD_IO_RW_EXTENDED);
>> +     bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
>> +
>> +     /*
>> +      * In case of Version 4.10 or later, use of 'Auto CMD Auto
>> +      * Select' is recommended rather than use of 'Auto CMD12
>> +      * Enable' or 'Auto CMD23 Enable'.
>> +      */
>> +     if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
>> +             *mode |= SDHCI_TRNS_AUTO_SEL;
>> +             /*
>> +              * Note no need to set SDHCI_ARGUMENT2 here, since for version
>> +              * 4.10 and aboves, it doesn't support stuff bits of CMD23
>> +              * argument but only number of blocks which have been set
>> +              * already during prepare data.
>
> The argument will only have already been written in v4_mode.

It seems that we still need to set SDHCI_ARGUMENT2 here, if adding a
quirk for broken using 32-bit block count and also moved below to
sdhci-sprd.c

"
+     /*
+      * For version 4.10 and above, ARGUMENT2 register is also used as 32-bit
+      * block count register which don't support stuff bits of CMD23 argument
+      */
+     if (host->version >= SDHCI_SPEC_410 &&
+         mrq->sbc && (mrq->sbc->arg & SDHCI_ARG2_STUFF) &&
+         (host->flags & SDHCI_AUTO_CMD23))
+             host->flags &= ~SDHCI_AUTO_CMD23
"

>
>> +              */
>> +             if (use_cmd23)
>> +                     sdhci_enable_cmd23(host);
>
> Need to ensure that SDHCI_CMD23_ENABLE is cleared for !use_cmd23
>
>> +             return;
>> +     }
>> +
>> +     /*
>> +      * If we are sending CMD23, CMD12 never gets sent
>> +      * on successful completion (so no Auto-CMD12).
>> +      */
>> +     if (use_cmd12) {
>> +             *mode |= SDHCI_TRNS_AUTO_CMD12;
>> +     } else if (use_cmd23) {
>> +             *mode |= SDHCI_TRNS_AUTO_CMD23;
>> +             sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>> +     }
>> +}
>> +
>>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>       struct mmc_command *cmd)
>>  {
>> @@ -1121,17 +1176,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>
>>       if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
>>               mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
>> -             /*
>> -              * If we are sending CMD23, CMD12 never gets sent
>> -              * on successful completion (so no Auto-CMD12).
>> -              */
>> -             if (sdhci_auto_cmd12(host, cmd->mrq) &&
>> -                 (cmd->opcode != SD_IO_RW_EXTENDED))
>> -                     mode |= SDHCI_TRNS_AUTO_CMD12;
>> -             else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>> -                     mode |= SDHCI_TRNS_AUTO_CMD23;
>> -                     sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>> -             }
>> +             sdhci_auto_cmd_select(host, cmd, &mode);
>>       }
>>
>>       if (data->flags & MMC_DATA_READ)
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index daf8c1e..a8d5be5 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -43,6 +43,7 @@
>>  #define  SDHCI_TRNS_BLK_CNT_EN       0x02
>>  #define  SDHCI_TRNS_AUTO_CMD12       0x04
>>  #define  SDHCI_TRNS_AUTO_CMD23       0x08
>> +#define  SDHCI_TRNS_AUTO_SEL 0x0C
>>  #define  SDHCI_TRNS_READ     0x10
>>  #define  SDHCI_TRNS_MULTI    0x20
>>
>> @@ -186,6 +187,7 @@
>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>> +#define  SDHCI_CMD23_ENABLE          0x0800
>>  #define  SDHCI_CTRL_V4_MODE          0x1000
>>  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>
>
