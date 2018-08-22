Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26634C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57E1208E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QjtyBSXZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OWmYLT4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57E1208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeHVUOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:14:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36944 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:14:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 83B3E60275; Wed, 22 Aug 2018 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534956509;
        bh=0bKtRcGHYMsSUoco/auyLHE/2s6UEOI4ocRsNFGloBc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QjtyBSXZvxdeA/NRpYR9Wcoei0DdsAUjHsMgw3YEZx0KRvn+pJRrcSPFADXsFiC8N
         eGrL08vAEqxuE/puZ0b87qJiNFlTJqPToBCB+owJiNywvxuZ013F3ONmlWlC+jA73V
         FXnr/KZFSQ2KQakf95d2hQSoK7prUI2gbDguNn34=
Received: from [10.226.60.158] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkumbako@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66F3C60275;
        Wed, 22 Aug 2018 16:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534956508;
        bh=0bKtRcGHYMsSUoco/auyLHE/2s6UEOI4ocRsNFGloBc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OWmYLT4isanxQGAzt8JtZF17SN6JzU6Xp1mvPqYXU4qabS+nOe2SljrImc5YexoU4
         HRIosTE+7LUoGb6oePLToi+KMHRnPC02+PR5dDbzpJ61cjB3zIYmgoUhw+0XLY2TNA
         CAqeUR9iu0zS3A4Yp9brx2UzMtn2bL1eUXFO15Dw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66F3C60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkumbako@codeaurora.org
Subject: Re: [PATCH] drivers: thermal: do not clobber cooling dev state from
 userspace
To:     Lina Iyer <ilina@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20180507175505.2389-1-ilina@codeaurora.org>
 <1532595308.2358.45.camel@intel.com> <20180814180447.GJ5081@codeaurora.org>
From:   Ram Chandrasekar <rkumbako@codeaurora.org>
Message-ID: <1fa9d64d-0f52-dba2-8777-799fa9272581@codeaurora.org>
Date:   Wed, 22 Aug 2018 10:48:27 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180814180447.GJ5081@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/2018 12:04 PM, Lina Iyer wrote:
> Adding Ram, so he can respond.
> -- Lina
> 
> On Thu, Jul 26 2018 at 02:55 -0600, Zhang Rui wrote:
>> On 一, 2018-05-07 at 11:55 -0600, Lina Iyer wrote:
>>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>>
>>> Let userspace be another voter for cooling device state instead of
>>> the
>>> overriding authority. It is possible that the thermal governor may
>>> find
>>> a higher cooling state desirable than what is recommended by the
>>> userspace. Separate out the current cooling device state from the
>>> userspace request and aggregate the userspace request with the
>>> governors' recommendation.
>>>
>>
>> hmmm, I don't understand this.
>> If the governor does not work well, we should either improve the
>> governor or use userspace governor instead.
>> do you have any examples that the kernel governor chooses improper
>> cooling state?
>>
Userspace governor and kernel governor could monitor different thermal 
zones for different thermal conditions and mitigate the same cooling 
device. In this case, the cooling device state request from userspace 
governor shouldn’t overwrite the request from kernel governor, rather it 
needs to be aggregated. This change is to aggregate the cooling device 
state requests between the userspace and kernel governors.

Thanks,
Ram
