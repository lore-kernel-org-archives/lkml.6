Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E18C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8052145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lj+lK9ZX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lj+lK9ZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8052145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeIXNJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:09:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeIXNJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:09:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE449605FF; Mon, 24 Sep 2018 07:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537772920;
        bh=nx/ThUbDFVqDJLJWFy//XAzMziLD6Xqqgqncvcf8ef0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=lj+lK9ZXqeai0+FKSWDWqdqTneqEujMlhYuoJQC1VfgnDLpxj13ne6S9nEIFloeBt
         sy3uQIpvyM7+VvNn/DvqTqZN34q+FJjrVOYd2J4lMVZTDjLKMd8IcdiKm7N8gt3Nzt
         U9Rtxut+Z/bJ5+ZSoByFJI56Ke24Tb9FsuPVJyWI=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 553D5601C3;
        Mon, 24 Sep 2018 07:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537772920;
        bh=nx/ThUbDFVqDJLJWFy//XAzMziLD6Xqqgqncvcf8ef0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=lj+lK9ZXqeai0+FKSWDWqdqTneqEujMlhYuoJQC1VfgnDLpxj13ne6S9nEIFloeBt
         sy3uQIpvyM7+VvNn/DvqTqZN34q+FJjrVOYd2J4lMVZTDjLKMd8IcdiKm7N8gt3Nzt
         U9Rtxut+Z/bJ5+ZSoByFJI56Ke24Tb9FsuPVJyWI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 553D5601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v3 2/2] remoteproc: qcom: Introduce Non-PAS ADSP PIL
 driver
From:   Rohit Kumar <rohitkr@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org, linux-kernel-owner@vger.kernel.org
References: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
 <1535975560-8200-3-git-send-email-rohitkr@codeaurora.org>
 <a93b3178a09584dc0b4bed55ca4816a3@codeaurora.org>
 <79bee282-e8a4-a1e6-56e3-6ea7e20c0233@codeaurora.org>
Message-ID: <614ab0e7-b751-4bf9-72f9-33fdd57594ec@codeaurora.org>
Date:   Mon, 24 Sep 2018 12:38:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <79bee282-e8a4-a1e6-56e3-6ea7e20c0233@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/2018 12:19 PM, Rohit Kumar wrote:
> Thanks Sibi for reviewing.
>
>
> On 9/22/2018 1:11 AM, Sibi Sankar wrote:
>> Hi Rohit,
>>
>> On 2018-09-03 17:22, Rohit kumar wrote:
>>> This adds Non PAS ADSP PIL driver for Qualcomm
>>> Technologies Inc SoCs.
>>> Added initial support for SDM845 with ADSP bootup and
>>> shutdown operation handled from Application Processor
>>> SubSystem(APSS).
>>>
>>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>>> ---
>> ....
...
>> ....
>> Also I see the following warns on stopping the adsp remoteproc, 
>> couldn't root cause it though:
>
> It should be issue in Q6 drivers. I will check and update q6 drivers. 
> Thanks for reporting.
>

Checked this warning. This is a core driver issue fixed with 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/base/core.c?h=next-20180924&id=2ec16150179888b81717d1d3ce84e634f4736af2 

>>  device_del+0x84/0x29c
>>  platform_device_del+0x2c/0x88
>>  platform_device_unregister+0x1c/0x30
>>  of_platform_device_destroy+0x98/0xa8
>>  device_for_each_child+0x54/0xa4
>>  of_platform_depopulate+0x38/0x54
>>  q6asm_remove+0x1c/0x2c
>>  apr_device_remove+0x38/0x70
>>  device_release_driver_internal+0x124/0x1c8
>>  device_release_driver+0x24/0x30
>>  bus_remove_device+0xcc/0xe4
>>  device_del+0x1f8/0x29c
>>  device_unregister+0x1c/0x30
>>  apr_remove_device+0x1c/0x2c
>>  device_for_each_child+0x54/0xa4
>>  apr_remove+0x28/0x34
>>  rpmsg_dev_remove+0x48/0x70
>>  device_release_driver_internal+0x124/0x1c8
>>  device_release_driver+0x24/0x30
>>  bus_remove_device+0xcc/0xe4
>>  device_del+0x1f8/0x29c
>>  device_unregister+0x1c/0x30
>>  qcom_glink_remove_device+0x1c/0x2c
>>  device_for_each_child+0x54/0xa4
>>  qcom_glink_native_remove+0x54/0x15c
>>  qcom_glink_smem_unregister+0x1c/0x30
>>  glink_subdev_stop+0x1c/0x2c [qcom_common]
>>  rproc_stop+0x40/0xc0
>>  rproc_shutdown+0x6c/0xc0
>>  rproc_del+0x28/0xa0
>>  adsp_remove+0x20/0x5c [qcom_adsp_pil]
>>  platform_drv_remove+0x28/0x50
>>  device_release_driver_internal+0x124/0x1c8
>>  driver_detach+0x44/0x80
>>  bus_remove_driver+0x78/0x9c
>>  driver_unregister+0x34/0x54
>>  platform_driver_unregister+0x1c/0x28
>>  cleanup_module+0x14/0x6bc [qcom_adsp_pil]
>>  SyS_delete_module+0x1c4/0x214
>>
>
> Thanks,
> Rohit
Thanks
