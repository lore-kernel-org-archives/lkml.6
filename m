Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53610C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01497215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eNtyxRtF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eNtyxRtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01497215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeI0RRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:17:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0RRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:17:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A729B60B72; Thu, 27 Sep 2018 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538046002;
        bh=jS1nmCIpqujG+mfxRrARKy+iWzwTv6mhvNTOgaKkBI0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eNtyxRtF9DAkSthMZUJxBxLueq47PfAQL/mbJtStN+EuGXYvtdq6JaNnZsWZzh5qT
         RDKHNnoKjx2CBHalyPSF2kbRacu6Q5PpLW6TdjNE2Wc+GmkDbBugo98Jvsbl+tkekf
         kFoJfMvoR7sD9lOWHZl5WYCpLdnCAO8jr6Ypiz9M=
Received: from [10.206.25.139] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD0F260214;
        Thu, 27 Sep 2018 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538046002;
        bh=jS1nmCIpqujG+mfxRrARKy+iWzwTv6mhvNTOgaKkBI0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eNtyxRtF9DAkSthMZUJxBxLueq47PfAQL/mbJtStN+EuGXYvtdq6JaNnZsWZzh5qT
         RDKHNnoKjx2CBHalyPSF2kbRacu6Q5PpLW6TdjNE2Wc+GmkDbBugo98Jvsbl+tkekf
         kFoJfMvoR7sD9lOWHZl5WYCpLdnCAO8jr6Ypiz9M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD0F260214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated
 dynamically
To:     Doug Anderson <dianders@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org>
 <1537887875-29494-3-git-send-email-vbadigan@codeaurora.org>
 <CAD=FV=VxLR6v3vyimjznrqa1Tj5rPziPQX7Pt+wJRR+xm1N-0A@mail.gmail.com>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <e6f0c8c6-cd0f-33b9-30da-ab09953449ca@codeaurora.org>
Date:   Thu, 27 Sep 2018 16:29:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VxLR6v3vyimjznrqa1Tj5rPziPQX7Pt+wJRR+xm1N-0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,


On 9/26/2018 3:58 AM, Doug Anderson wrote:
> Hi,
>
> On Tue, Sep 25, 2018 at 8:05 AM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> +       /*
>> +        * Whenever core-clock is gated dynamically, it's needed to
>> +        * re-initialize the DLL when the clock is ungated.
>> +        */
>> +       if (msm_host->restore_dll_cfg_needed && msm_host->clk_rate) {
>> +               msm_host->restore_dll_cfg = true;
>> +               mmc_retune_needed(host->mmc);
> Using the boolean "restore_dll_cfg" to communicate like this seems
> really fragile.  I have no basis in fact, but I worry that something
> will happen in the meantime that really ought to invalidate the
> "saved_tuning_phase" but the boolean will still be set.
>
> Is there a reason you can't just call msm_config_cm_dll_phase()
> directly from sdhci_msm_runtime_resume()?  Perhaps after the
> clk_bulk_prepare_enable() call below?

I can do that.

But we don't need to restore the clock phase for all speed modes since 
every mode
doesn't use DLL. Only few speed modes (only SDR104 mode for SD card)
would need to restore DLL setting. So I would need to do some extra checks
for performing this operation for only required speed modes.
And we should re-initialize the DLL first before programming the phase.

I wanted to reuse the existing logic which does all these things. So did 
this way.

>
> -Doug
Thanks
Veera
