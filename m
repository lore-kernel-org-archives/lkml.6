Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5775EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD12208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxXhC8Jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD12208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbeGaLHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:07:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37076 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbeGaLHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:07:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id j8-v6so10233738lfb.4;
        Tue, 31 Jul 2018 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iO2BsSOB2kNp9NlPtU0bzUASY+6lQ1xa8riUfV0gQ88=;
        b=LxXhC8JdBLoM9M/l5I2zHWRj/Sh2h0SMfrC29KiR9lDxgLS/3TFDLXoHD71lmZrjAE
         9iEmnhpWHqlIDxT3tp5vKX2uYfVqXVrxbrSPODyq/8abHu1STRIVQXkgp6jTd9a1vDO6
         0mUTeUULjMo5X2AJ1RVaDqzkLTHVJ6rOGGL64/a+8Ug736FhuppRfQ5iJDbW5MEm6FiB
         t7+UAN3jSguD2snO6hTynuLmhYCnHi24kQspr/YngvfDzdQBX2zk7/wWbjUZjc/tLHLo
         FI055lHjv/ftOuIrRhgUOI55nXgfRlRxhBmbr81JbtmUqgfU2mh3hmFEjNbmPs8lALzs
         CnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iO2BsSOB2kNp9NlPtU0bzUASY+6lQ1xa8riUfV0gQ88=;
        b=U64+wDD7U4tLhZur1xVd5DntH2o7vrrioqIMQCuLe4hWW4VHtAT0Z7+TCvNaCjCJrx
         shjUo0K37/YnKZRwZwmt+88nvaPj21h7dcmaa0eflrdd0szx+33ZceObjcnXii/RnVER
         ULmr2WYaFSlFKEFYZBPVypNR3SEKtMHqeai97B3C4FoUrBRtk8+lwENr9LHTquvy/GKk
         C++vt48wQ6ys6ypKmvPk6MkEkgg19ZWrqRg8Amo8FQt+0JA+86ouoYysA2m6dJyX9Sch
         uAkGQ1v4hqkkXUvp8I8CBLJtTEAYHxEk4xfhQIkhWcFGqAdKdYRJw3JPVDwcvOALTe3m
         dnAw==
X-Gm-Message-State: AOUpUlETxTysiIj+b+gMn06C9TidVzMntVRC6u3vLE9kIzqmeO17oyxi
        RWVYYTS4PJNrIOwDyjbA0bgqoMV74+HK+azWNQo=
X-Google-Smtp-Source: AAOMgpfH/5qA7c8K8HAggqDUWead+oPfkZnIIcAPRYdKfUEKKFVKIhJW7dDLh2mWifLyRNHhapeZuIMvYjz2QermRKk=
X-Received: by 2002:a19:c742:: with SMTP id x63-v6mr12232029lff.9.1533029307676;
 Tue, 31 Jul 2018 02:28:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:631a:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 02:27:47
 -0700 (PDT)
In-Reply-To: <23282747-4ae1-d627-a537-590b9315b941@intel.com>
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
 <1532340508-8749-6-git-send-email-zhang.chunyan@linaro.org>
 <33ceb61c-3e09-c336-e9b9-87c01336f56c@intel.com> <CAAfSe-vVEve63y-Pc0QF6w7vc37cbbbOknGkp9SmocXyNX3J4g@mail.gmail.com>
 <f810df5a-2cc4-a534-9fdc-2575ae81cf4b@intel.com> <CAAfSe-uyjnBGk7w2KMgrgEYVgYY6p6EqCWTUW+r2BWDoYmPpLg@mail.gmail.com>
 <23282747-4ae1-d627-a537-590b9315b941@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 31 Jul 2018 17:27:47 +0800
Message-ID: <CAAfSe-v+Qe0yTJGhD33PwGV6YMi0Q2LxuF_X6H1sSHkxB9GAMw@mail.gmail.com>
Subject: Re: [PATCH V4 5/7] mmc: sdhci: add Auto CMD Auto Select support
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

On 31 July 2018 at 16:56, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 31/07/18 11:36, Chunyan Zhang wrote:
>> On 31 July 2018 at 16:05, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 31/07/18 10:04, Chunyan Zhang wrote:
>>>> Hi Adrian,
>>>>
>>>> On 30 July 2018 at 21:06, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> On 23/07/18 13:08, Chunyan Zhang wrote:
>>>>>> As SD Host Controller Specification v4.10 documents:
>>>>>> Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
>>>>>> Selection of Auto CMD depends on setting of CMD23 Enable in the Host
>>>>>> Control 2 register which indicates whether card supports CMD23. If CMD23
>>>>>> Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
>>>>>> used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
>>>>>> recommended rather than use of Auto CMD12 Enable or Auto CMD23
>>>>>> Enable.
>>>>>>
>>>>>> This patch add this new mode support.
>>>>>>
>>>>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>>>> ---
>>>>>>  drivers/mmc/host/sdhci.c | 61 +++++++++++++++++++++++++++++++++++++++---------
>>>>>>  drivers/mmc/host/sdhci.h |  2 ++
>>>>>>  2 files changed, 52 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>>> index 5acea3d..5c60590 100644
>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>> @@ -311,6 +311,23 @@ static void sdhci_config_dma(struct sdhci_host *host)
>>>>>>       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>>>>>  }
>>>>>>
>>>>>> +static void sdhci_enable_cmd23(struct sdhci_host *host)
>>>>>> +{
>>>>>> +     u16 ctrl2;
>>>>>> +
>>>>>> +     /*
>>>>>> +      * This is used along with "Auto CMD Auto Select" feature,
>>>>>> +      * which is introduced from v4.10, if card supports CMD23,
>>>>>> +      * Auto CMD23 should be used instead of Auto CMD12.
>>>>>> +      */
>>>>>> +     if (host->version >= SDHCI_SPEC_410 &&
>>>>>> +         (host->mmc->caps & MMC_CAP_CMD23)) {
>>>>>
>>>>> That is the host capability.  It needs to be the card capability.
>>>>
>>>> Could you please elaborate the issue?
>>>>
>>>> I thought we're setting for host here.  Do you mean we need to see the
>>>> card capability?
>>>
>>> Yes. SDHCI_TRNS_AUTO_SEL selects auto-CMD23 or auto-CMD12 based on this
>>> setting, so this must reflect the card's capability.
>>
>> Got it, but how to know if the card supports CMD23?
>
> At the moment the only way of knowing is if a request is received with mrq->sbc

Ok. I will move this setting to sdhci_auto_cmd_select() for use_cmd23 is true.

>
>>
>>>
>>>>
>>>>>
>>>>>> +             ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>>> +             ctrl2 |= SDHCI_CMD23_ENABLE;
>>>>>> +             sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>>>>>> +     }
>>>>>> +}
>>>>>> +
>>>>>>  static void sdhci_init(struct sdhci_host *host, int soft)
>>>>>>  {
>>>>>>       struct mmc_host *mmc = host->mmc;
>>>>>> @@ -329,6 +346,8 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>>>>>>               host->clock = 0;
>>>>>>               mmc->ops->set_ios(mmc, &mmc->ios);
>>>>>>       }
>>>>>> +
>>>>>> +     sdhci_enable_cmd23(host);
>>>>>>  }
>>>>>>
>>>>>>  static void sdhci_reinit(struct sdhci_host *host)
>>>>>> @@ -1093,6 +1112,36 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>>>>>              !mrq->cap_cmd_during_tfr;
>>>>>>  }
>>>>>>
>>>>>> +static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>>>>>> +                                      struct mmc_command *cmd,
>>>>>> +                                      u16 *mode)
>>>>>> +{
>>>>>> +     bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
>>>>>> +                      (cmd->opcode != SD_IO_RW_EXTENDED);
>>>>>> +     bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
>>>>>> +
>>>>>> +     /*
>>>>>> +      * In case of Version 4.10 or later, use of 'Auto CMD Auto
>>>>>> +      * Select' is recommended rather than use of 'Auto CMD12
>>>>>> +      * Enable' or 'Auto CMD23 Enable'.
>>>>>> +      */
>>>>>> +     if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
>>>>>> +             *mode |= SDHCI_TRNS_AUTO_SEL;
>>>>>
>>>>> As noted in patch 4, the CMD23 argument is not just the block count for eMMC.
>>>>
>>>> Probably I haven't got your point...
>>>>
>>>> >From what I understand, auto_sel mode doesn't need argument2. Doesn't
>>>> this work for eMMC?
>>>
>>> CMD23 always needs an argument
>>
>> But setting argument for CMD23 will cover the block count value we set
>> before, that will lead mounting emmc to fail.
>
> Does it fail because it contains cmd->mrq->sbc->arg or does it fail because
> it gets written twice?
>
>>
>>>
>>>>
>>>> The test platform I used was just eMMC only, haven't found problem.
>>>
>>> Because the bits that are missing from the CMD23 argument (reliable write,
>>> context id, etc) will not make the command fail.
>>>
>>>>
>>>> Thanks,
>>>> Chunyan
>>>>
>>>>>
>>>>>> +             return;
>>>>>> +     }
>>>>>> +
>>>>>> +     /*
>>>>>> +      * If we are sending CMD23, CMD12 never gets sent
>>>>>> +      * on successful completion (so no Auto-CMD12).
>>>>>> +      */
>>>>>> +     if (use_cmd12) {
>>>>>> +             *mode |= SDHCI_TRNS_AUTO_CMD12;
>>>>>> +     } else if (use_cmd23) {
>>>>>> +             *mode |= SDHCI_TRNS_AUTO_CMD23;
>>>>>> +             sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>>>>> +     }
>>>>>> +}
>>>>>> +
>>>>>>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>>>>       struct mmc_command *cmd)
>>>>>>  {
>>>>>> @@ -1119,17 +1168,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>>>>
>>>>>>       if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
>>>>>>               mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
>>>>>> -             /*
>>>>>> -              * If we are sending CMD23, CMD12 never gets sent
>>>>>> -              * on successful completion (so no Auto-CMD12).
>>>>>> -              */
>>>>>> -             if (sdhci_auto_cmd12(host, cmd->mrq) &&
>>>>>> -                 (cmd->opcode != SD_IO_RW_EXTENDED))
>>>>>> -                     mode |= SDHCI_TRNS_AUTO_CMD12;
>>>>>> -             else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>>>>>> -                     mode |= SDHCI_TRNS_AUTO_CMD23;
>>>>>> -                     sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>>>>> -             }
>>>>>> +             sdhci_auto_cmd_select(host, cmd, &mode);
>>>>>>       }
>>>>>>
>>>>>>       if (data->flags & MMC_DATA_READ)
>>>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>>>> index 81aae07..a8f4ec2 100644
>>>>>> --- a/drivers/mmc/host/sdhci.h
>>>>>> +++ b/drivers/mmc/host/sdhci.h
>>>>>> @@ -42,6 +42,7 @@
>>>>>>  #define  SDHCI_TRNS_BLK_CNT_EN       0x02
>>>>>>  #define  SDHCI_TRNS_AUTO_CMD12       0x04
>>>>>>  #define  SDHCI_TRNS_AUTO_CMD23       0x08
>>>>>> +#define  SDHCI_TRNS_AUTO_SEL 0x0C
>>>>>>  #define  SDHCI_TRNS_READ     0x10
>>>>>>  #define  SDHCI_TRNS_MULTI    0x20
>>>>>>
>>>>>> @@ -185,6 +186,7 @@
>>>>>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>>>>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>>>>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>>>>>> +#define  SDHCI_CMD23_ENABLE          0x0800
>>>>>>  #define  SDHCI_CTRL_V4_MODE          0x1000
>>>>>>  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
>>>>>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>>>>>
>>>>>
>>>>
>>>
>>
>
