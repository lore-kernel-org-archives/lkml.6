Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F1C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711BA20684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L8W1DtK/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ntx7AdYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711BA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJDTko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:40:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbeJDTko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:40:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A03260C6A; Thu,  4 Oct 2018 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538657255;
        bh=CqBTB/QUpVDFg8y1jMDx9F5OFMy9U7t9Eei6taBSi3U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L8W1DtK/1mLGPNfNUZT6gvuWcOo1WKoz3wNdB326NgzWCJWA8wwIHUjJqD4GobvuJ
         +Hu1iSDmQ11GojiOPUhz4/9H53e3c5HO8G1TALzFIPdv/EqujD23OrCOH33IWfuxzh
         wO8qmcTeZQ93n1A/q4mas3NRg8/0dkP7/UatOyo8=
Received: from [10.252.220.101] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08C5B6043F;
        Thu,  4 Oct 2018 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538657254;
        bh=CqBTB/QUpVDFg8y1jMDx9F5OFMy9U7t9Eei6taBSi3U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ntx7AdYiDR8koK9ri66bkfPO2QrEAAvzXce19y4lP1kNsQxTtzIKE9ID+8MCtVHuK
         KVrAS1SvY+B/V01v5NHEM7acB/YBYGXykLzxAgvg9DVW2zC5xb7uHoHEnTf/ORLrHc
         ehLDDRyiTwlr6240hDJhkhz1uBCTC7alGlmPUcJc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08C5B6043F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V2 1/3] mmc: sdhci: Allow platform controlled voltage
 switching
To:     Evan Green <evgreen@chromium.org>
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        Doug Anderson <dianders@google.com>, vviswana@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
 <1537424558-17989-2-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft7k6gsX-xbW1cr+z2SYeHh=zbmNoUxxXOuG9zZz+DYcWQ@mail.gmail.com>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <535b31b6-def4-63fd-c8a1-d1a10d8b4566@codeaurora.org>
Date:   Thu, 4 Oct 2018 18:16:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft7k6gsX-xbW1cr+z2SYeHh=zbmNoUxxXOuG9zZz+DYcWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,


On 9/22/2018 1:38 AM, Evan Green wrote:
> On Wed, Sep 19, 2018 at 11:24 PM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> From: Vijay Viswanath <vviswana@codeaurora.org>
>>
>> Some controllers can have internal mechanism to inform the SW that it
>> is ready for voltage switching. For such controllers, changing voltage
>> before the HW is ready can result in various issues.
>>
>> During setup/cleanup of host, check whether regulator enable/disable
>> was already done by platform driver.
>>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   drivers/mmc/host/sdhci.c | 22 +++++++++++++++-------
>>   drivers/mmc/host/sdhci.h |  1 +
>>   2 files changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 99bdae5..04b3fd2 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3616,6 +3616,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>>          unsigned int override_timeout_clk;
>>          u32 max_clk;
>>          int ret;
>> +       bool enable_vqmmc = false;
>>
>>          WARN_ON(host == NULL);
>>          if (host == NULL)
>> @@ -3629,9 +3630,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>>           * the host can take the appropriate action if regulators are not
>>           * available.
>>           */
>> -       ret = mmc_regulator_get_supply(mmc);
>> -       if (ret)
>> -               return ret;
>> +       if (!mmc->supply.vmmc) {
>> +               ret = mmc_regulator_get_supply(mmc);
>> +               if (ret)
>> +                       return ret;
>> +               enable_vqmmc  = true;
> The coupling of logic strikes me as a little bit odd, it's saying if
> vmmc is already present, then don't turn on vqmmc. I guess what it's
> trying to say is "hands off all the regulators, I've got this". It
> might be cleaner to set enable_vqmmc based on whether or not
> mmc->supply.vqmmc exists before the get_supply call, rather than
> coupling it into whether or not vmmc exists.
>
> Actually, what might be even nicer is to change
> mmc_regulator_get_supply to only get supplies that it doesn't already
> have. You'd still have your enable_vqmmc local, but the
> mmc_regulator_get_supply call would be outside the conditional, and
> the logic of "don't enable vqmmc if it existed before" would make more
> sense.

Yes, its saying if platform driver has already controlling the regulators,
don't enable/disable them anymore.
Agree with you on the conditional check.  Will update it to Vcmmc 
instead of vmmc.

>> +       }
>>
>>          DBG("Version:   0x%08x | Present:  0x%08x\n",
>>              sdhci_readw(host, SDHCI_HOST_VERSION),
>> @@ -3880,7 +3884,11 @@ int sdhci_setup_host(struct sdhci_host *host)
>>                  mmc->caps |= MMC_CAP_NEEDS_POLL;
>>
>>          if (!IS_ERR(mmc->supply.vqmmc)) {
>> -               ret = regulator_enable(mmc->supply.vqmmc);
>> +               if (enable_vqmmc) {
>> +                       ret = regulator_enable(mmc->supply.vqmmc);
>> +                       host->vqmmc_enabled = !ret;
>> +               } else
>> +                       ret = 0;
> I think it's preferred that if your "if" had curly braces, then the
> else part needs it too. Actually, can you move the if (ret) pr_warn
> stuff up and inside of your if statement above? That keeps the logic
> together, and then you don't need an else case at all!

sure. Will update.

>>                  /* If vqmmc provides no 1.8V signalling, then there's no UHS */
>>                  if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
>> @@ -4136,7 +4144,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>>          return 0;
>>
>>   unreg:
>> -       if (!IS_ERR(mmc->supply.vqmmc))
>> +       if (host->vqmmc_enabled)
>>                  regulator_disable(mmc->supply.vqmmc);
>>   undma:
>>          if (host->align_buffer)
>> @@ -4154,7 +4162,7 @@ void sdhci_cleanup_host(struct sdhci_host *host)
>>   {
>>          struct mmc_host *mmc = host->mmc;
>>
>> -       if (!IS_ERR(mmc->supply.vqmmc))
>> +       if (host->vqmmc_enabled)
>>                  regulator_disable(mmc->supply.vqmmc);
>>
>>          if (host->align_buffer)
>> @@ -4287,7 +4295,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>>
>>          tasklet_kill(&host->finish_tasklet);
>>
>> -       if (!IS_ERR(mmc->supply.vqmmc))
>> +       if (host->vqmmc_enabled)
>>                  regulator_disable(mmc->supply.vqmmc);
>>
>>          if (host->align_buffer)
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index b001cf4..3c28152 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -524,6 +524,7 @@ struct sdhci_host {
>>          bool pending_reset;     /* Cmd/data reset is pending */
>>          bool irq_wake_enabled;  /* IRQ wakeup is enabled */
>>          bool v4_mode;           /* Host Version 4 Enable */
>> +       bool vqmmc_enabled;     /* Vqmmc is enabled */
> This is kind of unpleasant. It's confused by the fact that other host
> controllers have a vqmmc_enabled member, but they use it to mean what
> it sounds like, "is vqmmc currently enabled". Here you're really using
> it to mean "don't ever disable vqmmc in sdhci, because the platform
> code sort of owns vqmmc". It only "sort of" owns it in that sdhci is
> still free to call regulator_is_supported_voltage and
> mmc_regulator_set_vqmmc, but somehow not regulator_disable. Is there
> any way to clean up the semantics here?

Except the regualtor_enable()/disable() calls other regulator-operations 
are direct
operations. Only enable() & disable() uses a reference couters to track
whether number regualtor_enable() calls matches with number of 
regualtor_disable()
calls or not.

In V1 patch-set this was done without need to this flag but it was suggested
have this flag for ensuring enable/disable counters are in sync.

>>          struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
>>          struct mmc_command *cmd;        /* Current command */
>> --
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>>

