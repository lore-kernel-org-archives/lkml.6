Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80790C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1881420844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4CY9UiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1881420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbeHALL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:11:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39619 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388746AbeHALL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:11:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so16257180lji.6;
        Wed, 01 Aug 2018 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uimI1Xv1IqpcZaPJgYJMmQZcB4UvF6/hfWWOmCTUss4=;
        b=a4CY9UiOvxgKqRhd6BkdA3a0Sj+LRdDsqOlot6X5r5SeeOGqKIljs07HJnFe4ew3Bl
         nOmveFYbckJLClIxwPFtrKha5BxXHzbPxCbsrw+cprx0EpVPXaeg3H2X42JbbWarkr2Y
         8l3egP6nXRu4uX2rDYkxwqV6+AWtLCvv3POsUwFIC01EAW9+GnGjYvMn/kQvmgpsVcPK
         uIUYMQqnA5xnUmGi/hdcbj4eQujhcwkpaDQEi3V4gmot3RodAagX7TD4kEu4K8ZEWtuN
         wW3CCcPVkMrFflgsAVnH6d5fwMES3t7HITHuUkiqpVJ3SdRPWwQWpKozWL/oYmdGd6R3
         HMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uimI1Xv1IqpcZaPJgYJMmQZcB4UvF6/hfWWOmCTUss4=;
        b=UerSimbRoE0v15bF0CquC+Njxc9PCqrjM3P1lz/e7Y2mNZsQEgaHnTbYDkY3tAsxZH
         wuPP4N+FWu+vTH1ExsoQiH607eXqGFYY5RSuz/jCcEYOTK8HBkjEJPGSN2Vz6FciMOxd
         S1HvrD9txaFmb9LPeJ2cJT+m0KlYdoHsHG+SRwTa+nC+mGUwtqJrS0LmPfiwuMfZ0oHH
         n5oZbgl7yawP8zNuLYCrdaLuiPiaoD2T6+RJbvI+NwAhxbPJWBPJ5z+tGMmPV1oo9g7d
         iPEvoyQOFrM5KgFMRk4qaFI+h5p3ak7XBombBM2F+NBnGOmMAJ1cvxU1EZM66c2+6AdV
         5ZzA==
X-Gm-Message-State: AOUpUlEIyNe7WL/PB5JUuqgCov5oF3TFKcXNuBB4iktt/rMi02lUek7l
        3VlZ8T/muuvD1SgPZc/7VvvOHcndoYc4ARv7LPU=
X-Google-Smtp-Source: AAOMgpcvvQI9zmmIBUnHx4dRKvi/GJw9qq+LV0ZhbVn8OAZMNc/1lduucXM7NTgSUlZlN5a+j1QMqMTWEyfjmj8ncds=
X-Received: by 2002:a2e:9c0f:: with SMTP id s15-v6mr12706175lji.97.1533115625971;
 Wed, 01 Aug 2018 02:27:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:631a:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 02:26:25 -0700 (PDT)
In-Reply-To: <c036244d-e944-f0c7-3efd-886def5fb22c@intel.com>
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
 <1532340508-8749-6-git-send-email-zhang.chunyan@linaro.org>
 <33ceb61c-3e09-c336-e9b9-87c01336f56c@intel.com> <CAAfSe-vVEve63y-Pc0QF6w7vc37cbbbOknGkp9SmocXyNX3J4g@mail.gmail.com>
 <f810df5a-2cc4-a534-9fdc-2575ae81cf4b@intel.com> <CAAfSe-uyjnBGk7w2KMgrgEYVgYY6p6EqCWTUW+r2BWDoYmPpLg@mail.gmail.com>
 <23282747-4ae1-d627-a537-590b9315b941@intel.com> <CAAfSe-vp_6zFPo+UYKiR+St1ajv8WXP_OL-OZh_POiUybzDHeQ@mail.gmail.com>
 <c036244d-e944-f0c7-3efd-886def5fb22c@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 1 Aug 2018 17:26:25 +0800
Message-ID: <CAAfSe-udgj-Cbwzf0dE+891KMcsR6BoqD+VSYgPuav5Jt35n1A@mail.gmail.com>
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

On 31 July 2018 at 17:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 31/07/18 12:20, Chunyan Zhang wrote:
>> On 31 July 2018 at 16:56, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 31/07/18 11:36, Chunyan Zhang wrote:
>>>> On 31 July 2018 at 16:05, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> On 31/07/18 10:04, Chunyan Zhang wrote:
>>>>>> Hi Adrian,
>>>>>>
>>>>>> On 30 July 2018 at 21:06, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>> On 23/07/18 13:08, Chunyan Zhang wrote:
>>>>>>>> As SD Host Controller Specification v4.10 documents:
>>>>>>>> Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
>>>>>>>> Selection of Auto CMD depends on setting of CMD23 Enable in the Host
>>>>>>>> Control 2 register which indicates whether card supports CMD23. If CMD23
>>>>>>>> Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
>>>>>>>> used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
>>>>>>>> recommended rather than use of Auto CMD12 Enable or Auto CMD23
>>>>>>>> Enable.
>>>>>>>>
>>>>>>>> This patch add this new mode support.
>>>>>>>>
>>>>>>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>>>>>> ---
>>>>>>>>  drivers/mmc/host/sdhci.c | 61 +++++++++++++++++++++++++++++++++++++++---------
>>>>>>>>  drivers/mmc/host/sdhci.h |  2 ++
>>>>>>>>  2 files changed, 52 insertions(+), 11 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>>>>> index 5acea3d..5c60590 100644
>>>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>>>> @@ -311,6 +311,23 @@ static void sdhci_config_dma(struct sdhci_host *host)
>>>>>>>>       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +static void sdhci_enable_cmd23(struct sdhci_host *host)
>>>>>>>> +{
>>>>>>>> +     u16 ctrl2;
>>>>>>>> +
>>>>>>>> +     /*
>>>>>>>> +      * This is used along with "Auto CMD Auto Select" feature,
>>>>>>>> +      * which is introduced from v4.10, if card supports CMD23,
>>>>>>>> +      * Auto CMD23 should be used instead of Auto CMD12.
>>>>>>>> +      */
>>>>>>>> +     if (host->version >= SDHCI_SPEC_410 &&
>>>>>>>> +         (host->mmc->caps & MMC_CAP_CMD23)) {
>>>>>>>
>>>>>>> That is the host capability.  It needs to be the card capability.
>>>>>>
>>>>>> Could you please elaborate the issue?
>>>>>>
>>>>>> I thought we're setting for host here.  Do you mean we need to see the
>>>>>> card capability?
>>>>>
>>>>> Yes. SDHCI_TRNS_AUTO_SEL selects auto-CMD23 or auto-CMD12 based on this
>>>>> setting, so this must reflect the card's capability.
>>>>
>>>> Got it, but how to know if the card supports CMD23?
>>>
>>> At the moment the only way of knowing is if a request is received with mrq->sbc
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +             ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>>>>> +             ctrl2 |= SDHCI_CMD23_ENABLE;
>>>>>>>> +             sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>>>>>>>> +     }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static void sdhci_init(struct sdhci_host *host, int soft)
>>>>>>>>  {
>>>>>>>>       struct mmc_host *mmc = host->mmc;
>>>>>>>> @@ -329,6 +346,8 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>>>>>>>>               host->clock = 0;
>>>>>>>>               mmc->ops->set_ios(mmc, &mmc->ios);
>>>>>>>>       }
>>>>>>>> +
>>>>>>>> +     sdhci_enable_cmd23(host);
>>>>>>>>  }
>>>>>>>>
>>>>>>>>  static void sdhci_reinit(struct sdhci_host *host)
>>>>>>>> @@ -1093,6 +1112,36 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>>>>>>>              !mrq->cap_cmd_during_tfr;
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>>>>>>>> +                                      struct mmc_command *cmd,
>>>>>>>> +                                      u16 *mode)
>>>>>>>> +{
>>>>>>>> +     bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
>>>>>>>> +                      (cmd->opcode != SD_IO_RW_EXTENDED);
>>>>>>>> +     bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
>>>>>>>> +
>>>>>>>> +     /*
>>>>>>>> +      * In case of Version 4.10 or later, use of 'Auto CMD Auto
>>>>>>>> +      * Select' is recommended rather than use of 'Auto CMD12
>>>>>>>> +      * Enable' or 'Auto CMD23 Enable'.
>>>>>>>> +      */
>>>>>>>> +     if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
>>>>>>>> +             *mode |= SDHCI_TRNS_AUTO_SEL;
>>>>>>>
>>>>>>> As noted in patch 4, the CMD23 argument is not just the block count for eMMC.
>>>>>>
>>>>>> Probably I haven't got your point...
>>>>>>
>>>>>> >From what I understand, auto_sel mode doesn't need argument2. Doesn't
>>>>>> this work for eMMC?
>>>>>
>>>>> CMD23 always needs an argument
>>>>
>>>> But setting argument for CMD23 will cover the block count value we set
>>>> before, that will lead mounting emmc to fail.
>>>
>>> Does it fail because it contains cmd->mrq->sbc->arg or does it fail because
>>> it gets written twice?
>>
>> Seems that the argument is too big compared with block count, hardware
>> think it is a super block count.
>>
>> More details of the error information:
>> https://www.irccloud.com/pastebin/uYlVEUsP/
>
> Does it work with auto-CMD23 instead of auto-CMD-auto-select?

No, so long as SDHCI_32BIT_BLK_CNT was set with cmd->mrq->sbc->arg
which is a big value, it would report error "I/O error while writing
superblock" when mounting emmc.

> Does it work if the 16-bit block count register is used?

16-bit block count register is Read Only on my board :-(

>
> Obviously, if we can't pass the CMD23 argument correctly then we can't use
> auto-CMD23.

On my board, if argument2 was limited to the maximum of 65535, then
everything works, otherwise I would see an error "EXT4-fs
(mmcblk0p28): I/O error while writing superblock".  Haven't found the
root cause. I will continue to look at the problem, any comments would
be appreciated.

Thanks,
Chunyan

>
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> The test platform I used was just eMMC only, haven't found problem.
>>>>>
>>>>> Because the bits that are missing from the CMD23 argument (reliable write,
>>>>> context id, etc) will not make the command fail.
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Chunyan
>>>>>>
>>>>>>>
>>>>>>>> +             return;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     /*
>>>>>>>> +      * If we are sending CMD23, CMD12 never gets sent
>>>>>>>> +      * on successful completion (so no Auto-CMD12).
>>>>>>>> +      */
>>>>>>>> +     if (use_cmd12) {
>>>>>>>> +             *mode |= SDHCI_TRNS_AUTO_CMD12;
>>>>>>>> +     } else if (use_cmd23) {
>>>>>>>> +             *mode |= SDHCI_TRNS_AUTO_CMD23;
>>>>>>>> +             sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>>>>>>> +     }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>>>>>>       struct mmc_command *cmd)
>>>>>>>>  {
>>>>>>>> @@ -1119,17 +1168,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>>>>>>>
>>>>>>>>       if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
>>>>>>>>               mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
>>>>>>>> -             /*
>>>>>>>> -              * If we are sending CMD23, CMD12 never gets sent
>>>>>>>> -              * on successful completion (so no Auto-CMD12).
>>>>>>>> -              */
>>>>>>>> -             if (sdhci_auto_cmd12(host, cmd->mrq) &&
>>>>>>>> -                 (cmd->opcode != SD_IO_RW_EXTENDED))
>>>>>>>> -                     mode |= SDHCI_TRNS_AUTO_CMD12;
>>>>>>>> -             else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>>>>>>>> -                     mode |= SDHCI_TRNS_AUTO_CMD23;
>>>>>>>> -                     sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>>>>>>>> -             }
>>>>>>>> +             sdhci_auto_cmd_select(host, cmd, &mode);
>>>>>>>>       }
>>>>>>>>
>>>>>>>>       if (data->flags & MMC_DATA_READ)
>>>>>>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>>>>>>> index 81aae07..a8f4ec2 100644
>>>>>>>> --- a/drivers/mmc/host/sdhci.h
>>>>>>>> +++ b/drivers/mmc/host/sdhci.h
>>>>>>>> @@ -42,6 +42,7 @@
>>>>>>>>  #define  SDHCI_TRNS_BLK_CNT_EN       0x02
>>>>>>>>  #define  SDHCI_TRNS_AUTO_CMD12       0x04
>>>>>>>>  #define  SDHCI_TRNS_AUTO_CMD23       0x08
>>>>>>>> +#define  SDHCI_TRNS_AUTO_SEL 0x0C
>>>>>>>>  #define  SDHCI_TRNS_READ     0x10
>>>>>>>>  #define  SDHCI_TRNS_MULTI    0x20
>>>>>>>>
>>>>>>>> @@ -185,6 +186,7 @@
>>>>>>>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>>>>>>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>>>>>>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>>>>>>>> +#define  SDHCI_CMD23_ENABLE          0x0800
>>>>>>>>  #define  SDHCI_CTRL_V4_MODE          0x1000
>>>>>>>>  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
>>>>>>>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>
