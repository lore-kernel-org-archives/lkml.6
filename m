Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BB4C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672392081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TS41cWMg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FAdklouO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672392081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeLKNfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:35:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44908 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKNfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:35:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DA62060B12; Tue, 11 Dec 2018 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544535351;
        bh=3mhP44VEIklL1jEzZwWVjjGbYjG1kMIxVeJ26hT3k4E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TS41cWMg7uifZYJ07FavNoZtZeSAvmTC28j+19y5geTm65tvYkrVt64aXV4soCAWf
         EjzLXmTg9R2ipAioS3D74cpYVUjwrTZXAdIRrqMba1IahZiRZg9tuFvMolrZcdC7mu
         pSSCP+9eofd9aecW3EJTU7aT1Q5VLwbzyrmrMEKI=
Received: from [10.79.160.15] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71CDB60224;
        Tue, 11 Dec 2018 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544535350;
        bh=3mhP44VEIklL1jEzZwWVjjGbYjG1kMIxVeJ26hT3k4E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FAdklouOeKVKz0Kiz1+uf7R0z5dhv5CZ43/eksVqzj4fPnvwfa/u+1Bx7XrHkmLbh
         sBAZkJHSXJdl+53RBO9qJfAl4YgbLYSZxD6CKnrinBs/0CHV2kNsEm/xwk3APzxZVN
         6LKEHn00WGpu6xXzcO2BOXrJGxa6ComEw1iKYhz8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71CDB60224
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
 <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
 <20181205061600.7zglbpkgbktn27am@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <82b168d1-79bc-f454-8e19-4f7630a34069@codeaurora.org>
Date:   Tue, 11 Dec 2018 19:05:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181205061600.7zglbpkgbktn27am@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

Sorry for the delayed response. Thanks for the patch.

On 12/5/2018 11:46 AM, Viresh Kumar wrote:
> On 05-12-18, 09:07, Taniya Das wrote:
>> Hello Stephen, Viresh
>>
>> Thanks for the code and suggestions.
>>
>> Having a NR_DOMAINS '2' makes the driver not scalable for re-use.
> 
> Sure, I didn't like it either and that wasn't really what I was suggesting in
> the first place. I didn't wanted to write the code myself and pass it on, but I
> have it now anyway :)
> 
> It may have a bug or two in there, but compiles just fine and is rebased over
> your patch Taniya.
> 

The design here assumes that there would not be any per-cpu/per-cluster 
based SW requirement for the HW during frequency transitions, which 
again makes me think that we would require to re-introduce these 
structures again in case we have such requirements in near future.

Also I think leaving the structures also helps us debug any boot up 
issues looking at the ram contents of the per-(cpu/cluster) structures 
with the contents from the firmware.

Hope these above helps us to go ahead with the current SW design.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
