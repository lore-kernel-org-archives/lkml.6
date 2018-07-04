Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D1EC6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF73C24774
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsjgyuP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF73C24774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeGDDED (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:04:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42716 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeGDDEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:04:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id 1-v6so3085855ljv.9;
        Tue, 03 Jul 2018 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rb8qpFAfSlNC7mgVSNlMPxQZ07SoK9cspSY1qZM2a9Q=;
        b=jsjgyuP9DjIWtv85Y18iHCVc2ElLda9NZsE+JD/34M6iiV6nWasH4SpA/zCzgRuV6V
         BRvr58REjDilWWXA6KGVNBEtA/OUvbp5mmB2NElwvBrlFGr9CBD3wDMtUtIbc4EVylMa
         a5yH5xFWJUvaCCzKBpwdzDRQ8jjXyK8QW8CT21hZFNHKdxqpXwsg5QilIrjewoL4Pzaq
         3fvsFV4vso0yCGb6txA0k9tN0AITEN2yJdicusYacm2LyDwpIg2YRr2j+m+d6Uj3u1H8
         X7rBpIR23dUDPcnIIPENnPBl3uQNioRmF44dIuWfud1Qkl2wLm9+HVKbvxHXU3VOqvh3
         lThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rb8qpFAfSlNC7mgVSNlMPxQZ07SoK9cspSY1qZM2a9Q=;
        b=EAoMIzUW+PS21CO5s+dj8UW2kC2Ju49Z8KnL6mwXEHGDufZ84qAmfmoTpwjjYBMz1x
         bOvH+/43kIKTWOm3wujSfZeD3wlN5FT/Qi7ZxO9CVl+GOw2tWNPkBoxfLDw/SbIYC0RU
         TM3Bhz5B9EVecMSGlAnh9XlIYdvGNvEmFM0hEBaiyGNOT49FulkBOv5B77ptZBzZhTmk
         SaTX1H2eDzuvf5XyvcmrUFhgCTwXVWLfW1l6bkY8K37TtWUtJjZ07hTwrvpzck/gcYEn
         n1+DcEd00AuIP24pSNfcgiEGPVLz1SDJ/bFmrT68pFose7DgUDFtZGb0a2vAp6Q0cMC4
         6U9A==
X-Gm-Message-State: APt69E0CjYEOpsFWGfHcMoW/uxDRDOUk7A+lgJKE5R8BDnfn2msm47eJ
        zsaP44xMy8rLmT0xgRvXjeysasOL40RDpbJS1QA=
X-Google-Smtp-Source: AAOMgpc1jTp/6MpRZwkgcYmAMnQLuwu4SCYu0xpA2Q9GBv5tXdu7kf0UaXVyBo7DxFAFEgfc9psJ3uS83oUMWN76hyM=
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr141690ljc.56.1530673440623;
 Tue, 03 Jul 2018 20:04:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:1796:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 20:03:20 -0700 (PDT)
In-Reply-To: <2c91af23-da14-ed70-91b3-d7bfb06f3141@intel.com>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
 <1529028255-6022-6-git-send-email-zhang.chunyan@linaro.org> <2c91af23-da14-ed70-91b3-d7bfb06f3141@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 4 Jul 2018 11:03:20 +0800
Message-ID: <CAAfSe-uzbnfAgN6hPhJo39POOOqbz6Ac+2b5B6gnpe7ZeAW3HQ@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] mmc: sdhci: add CMD23 support for v4 mode
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

On 23 June 2018 at 03:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 06/15/2018 05:04 AM, Chunyan Zhang wrote:
>> Host Driver Version 4.10 adds a new bit in Host Control 2 Register
>> for selecting Auto CMD23 or Auto CMD12 for ADMA3 data transfer.
>
> We don't support ADMA3.  It would require changes to the block driver.
> So is this change needed?
>
>>
>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 16 +++++++++++++++-
>>  drivers/mmc/host/sdhci.h |  1 +
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index b8ee124..3b2af7e 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -954,6 +954,20 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>              !mrq->cap_cmd_during_tfr;
>>  }
>>
>> +static inline void sdhci_set_auto_cmd23(struct sdhci_host *host,
>> +                                     struct mmc_command *cmd)
>> +{
>> +     u16 ctrl2;
>> +
>> +     if (host->v4_mode) {
>
> Isn't this only for a V4.1 controller, and doesn't the mode have to be "Auto
> Cmd Auto Select"?

I will send another version of changes for this new mode "Auto Cmd
Auto Select", let's see if the next iteration gets better then.

Thanks for your review,
Chunyan

>
>
>> +             ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +             ctrl2 |= SDHCI_CMD23_ENABLE;
>> +             sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>> +     } else {
>> +             sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>> +     }
>> +}
>> +
>>  static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>       struct mmc_command *cmd)
>>  {
>> @@ -989,7 +1003,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>                       mode |= SDHCI_TRNS_AUTO_CMD12;
>>               else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>>                       mode |= SDHCI_TRNS_AUTO_CMD23;
>> -                     sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
>> +                     sdhci_set_auto_cmd23(host, cmd);
>>               }
>>       }
>>
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 1e84539..d5e1c10 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -185,6 +185,7 @@
>>  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
>>  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
>>  #define  SDHCI_CTRL_TUNED_CLK                0x0080
>> +#define  SDHCI_CMD23_ENABLE          0x0800
>>  #define  SDHCI_CTRL_V4_MODE          0x1000
>>  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
>>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
>>
>
