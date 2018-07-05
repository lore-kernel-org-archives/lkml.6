Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA229C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61038219CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B406qzIY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B406qzIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61038219CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeGEO0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:26:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeGEO0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:26:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BC86F60646; Thu,  5 Jul 2018 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530800811;
        bh=sO/kX5k1NSSU0B//nK1iqEnZss2uyI71RGB2b13dEJo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B406qzIYotYSZtlZzQu5Wvl1ptGaOeKi59PExI8msMeeeNSj3ZKEj8EeCrTflzfsM
         RFuPcRUNsdMAFeePOBe7C9raIgQ1JKsbeRwOswWsFWC904fTZ/urI4JYJ6yr7wtcKW
         GtFPa2B7NUZy9wBjkXrHPEguoaZijON0Foc7rzrg=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44F5A60646;
        Thu,  5 Jul 2018 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530800811;
        bh=sO/kX5k1NSSU0B//nK1iqEnZss2uyI71RGB2b13dEJo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B406qzIYotYSZtlZzQu5Wvl1ptGaOeKi59PExI8msMeeeNSj3ZKEj8EeCrTflzfsM
         RFuPcRUNsdMAFeePOBe7C9raIgQ1JKsbeRwOswWsFWC904fTZ/urI4JYJ6yr7wtcKW
         GtFPa2B7NUZy9wBjkXrHPEguoaZijON0Foc7rzrg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44F5A60646
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 6/6] crypto: qcom: Add ACPI support
To:     Vinod <vkoul@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
References: <20180703060434.19293-1-vkoul@kernel.org>
 <20180703060434.19293-7-vkoul@kernel.org>
 <28000d33-5321-76af-7985-94a564a75336@codeaurora.org>
 <20180704041310.GV22377@vkoul-mobl>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <6d8ee620-80d5-b529-1256-0624b1fbd98d@codeaurora.org>
Date:   Thu, 5 Jul 2018 08:26:49 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704041310.GV22377@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2018 10:13 PM, Vinod wrote:
> On 03-07-18, 11:08, Jeffrey Hugo wrote:
>> On 7/3/2018 12:04 AM, Vinod Koul wrote:
> 
>>> +#if IS_ENABLED(CONFIG_ACPI)
>>> +static const struct acpi_device_id qcom_rng_acpi_match[] = {
>>> +	{
>>> +		.id = "QCOM8160",
>>> +	},
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, msm_rng_acpi_match);
>>
>> qcom_rng_acpi_match?
>> Looks like a copy/paste issue.  This causes a build failure for me.
>> I'm trying to see if it works otherwise...
> 
> Ah sorry about that, I though I had fixed it, looks like I missed to
> fold the fix.
> 
> Did it work for you?
> 
It seems to work.  Driver compiles, and loads.  Still working on the 
verification.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
