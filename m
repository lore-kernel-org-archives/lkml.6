Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5C7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F2520C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lFmQYvJT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XwTJXss1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F2520C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeIXSEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:04:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbeIXSEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:04:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5DAF66078C; Mon, 24 Sep 2018 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537790542;
        bh=MqUWBtKgDTnMkd+dXqt/8H+YzwELxi3xqYhR6M/XuPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lFmQYvJTCjve8a6w66Q9a01E9piBaJRxZTGnrQL+DdqcDXOMcRHarRqjlCj/TqrUn
         2nAocRfbz8MGivALu8j34UHIY2F3AjKKoV5G4yJaVPhMlvQhCVIYgy/AWTlQbwbe98
         Jbq0KNdwBOaddRDLnBcObCB8HvKJYNcG9G4vqH4o=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5C8E9602F1;
        Mon, 24 Sep 2018 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537790541;
        bh=MqUWBtKgDTnMkd+dXqt/8H+YzwELxi3xqYhR6M/XuPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XwTJXss1XzFHx/q9D8aQfC94ossV8oYmbQDykvuWAacGuZ2oVWTIn9rS26gG0QVJm
         ai0TLihYJ3XHsOi6ll3lDGmJKBiUn3ZQ8hCPGwHxvkrcm01Z2AOGO2YqT5FtiGgsSc
         IfW5kGvoSp5LI9rfXjOpitZovnnTzbosl9Y/I32o=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 24 Sep 2018 17:32:21 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rohit Kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/2] remoteproc: qcom: Introduce Non-PAS ADSP PIL
 driver
In-Reply-To: <614ab0e7-b751-4bf9-72f9-33fdd57594ec@codeaurora.org>
References: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
 <1535975560-8200-3-git-send-email-rohitkr@codeaurora.org>
 <a93b3178a09584dc0b4bed55ca4816a3@codeaurora.org>
 <79bee282-e8a4-a1e6-56e3-6ea7e20c0233@codeaurora.org>
 <614ab0e7-b751-4bf9-72f9-33fdd57594ec@codeaurora.org>
Message-ID: <d1ae539b2d06d9c3185ec4a2b56d1e68@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-24 12:38, Rohit Kumar wrote:
> On 9/24/2018 12:19 PM, Rohit Kumar wrote:
>> Thanks Sibi for reviewing.
>> 
>> 
>> On 9/22/2018 1:11 AM, Sibi Sankar wrote:
>>> Hi Rohit,
>>> 
>>> On 2018-09-03 17:22, Rohit kumar wrote:
>>>> This adds Non PAS ADSP PIL driver for Qualcomm
>>>> Technologies Inc SoCs.
>>>> Added initial support for SDM845 with ADSP bootup and
>>>> shutdown operation handled from Application Processor
>>>> SubSystem(APSS).
>>>> 
>>>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>>>> ---
>>> ....
> ...
>>> ....
>>> Also I see the following warns on stopping the adsp remoteproc, 
>>> couldn't root cause it though:
>> 
>> It should be issue in Q6 drivers. I will check and update q6 drivers. 
>> Thanks for reporting.
>> 
> 
> Checked this warning. This is a core driver issue fixed with
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/base/core.c?h=next-20180924&id=2ec16150179888b81717d1d3ce84e634f4736af2
> 

Thanks for pointing this out.

>>>  device_del+0x84/0x29c
>>>  platform_device_del+0x2c/0x88
>>>  platform_device_unregister+0x1c/0x30
>>>  of_platform_device_destroy+0x98/0xa8
>>>  device_for_each_child+0x54/0xa4
>>>  of_platform_depopulate+0x38/0x54
>>>  q6asm_remove+0x1c/0x2c
>>>  apr_device_remove+0x38/0x70
>>>  device_release_driver_internal+0x124/0x1c8
>>>  device_release_driver+0x24/0x30
>>>  bus_remove_device+0xcc/0xe4
>>>  device_del+0x1f8/0x29c
>>>  device_unregister+0x1c/0x30
>>>  apr_remove_device+0x1c/0x2c
>>>  device_for_each_child+0x54/0xa4
>>>  apr_remove+0x28/0x34
>>>  rpmsg_dev_remove+0x48/0x70
>>>  device_release_driver_internal+0x124/0x1c8
>>>  device_release_driver+0x24/0x30
>>>  bus_remove_device+0xcc/0xe4
>>>  device_del+0x1f8/0x29c
>>>  device_unregister+0x1c/0x30
>>>  qcom_glink_remove_device+0x1c/0x2c
>>>  device_for_each_child+0x54/0xa4
>>>  qcom_glink_native_remove+0x54/0x15c
>>>  qcom_glink_smem_unregister+0x1c/0x30
>>>  glink_subdev_stop+0x1c/0x2c [qcom_common]
>>>  rproc_stop+0x40/0xc0
>>>  rproc_shutdown+0x6c/0xc0
>>>  rproc_del+0x28/0xa0
>>>  adsp_remove+0x20/0x5c [qcom_adsp_pil]
>>>  platform_drv_remove+0x28/0x50
>>>  device_release_driver_internal+0x124/0x1c8
>>>  driver_detach+0x44/0x80
>>>  bus_remove_driver+0x78/0x9c
>>>  driver_unregister+0x34/0x54
>>>  platform_driver_unregister+0x1c/0x28
>>>  cleanup_module+0x14/0x6bc [qcom_adsp_pil]
>>>  SyS_delete_module+0x1c4/0x214
>>> 
>> 
>> Thanks,
>> Rohit
> Thanks

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
