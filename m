Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1AFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF65F216E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yc7WkgZL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DGpzmvIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF65F216E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbeHNUxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:53:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49986 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbeHNUxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:53:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D59D60B13; Tue, 14 Aug 2018 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534269889;
        bh=Cb93PO8rLzuejVc4IWpZLfZ0LbGjwq2WJOGSM1cxHCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yc7WkgZLwSLiaewmlo18ujMAYe7fsQlzwKoWBF3OPVBSvK3jw7TpTNAyogjjaJIa/
         Do+mR3rEMSDZkMv3qJKm4BTexAXcngmZYf2mud4URsqFCzFk5G2M40XSLHJIYj1c/o
         maXwq2X8vOP9Xm1MVJWuWAihWgP7sM/uBhyhagbo=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B93360710;
        Tue, 14 Aug 2018 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534269888;
        bh=Cb93PO8rLzuejVc4IWpZLfZ0LbGjwq2WJOGSM1cxHCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGpzmvIBSK0ttmiVbnDLiMN+DADvyM4PmHcCEkghDxW5YjvZT8AgfUjhOu/AwoXAh
         mO8SyHusf+QZyea7DXqrc6fdp1fT7RNYRGdo0UFJ5NzZNWVwqfpWw738q8bQQ9Pr2U
         zNGTanqOTalQMjm5KkyZcsmvkEIRpML9ZWO/+U1U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B93360710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 14 Aug 2018 12:04:47 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rkumbako@codeaurora.org
Subject: Re: [PATCH] drivers: thermal: do not clobber cooling dev state from
 userspace
Message-ID: <20180814180447.GJ5081@codeaurora.org>
References: <20180507175505.2389-1-ilina@codeaurora.org>
 <1532595308.2358.45.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532595308.2358.45.camel@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Ram, so he can respond.
-- Lina

On Thu, Jul 26 2018 at 02:55 -0600, Zhang Rui wrote:
>On 一, 2018-05-07 at 11:55 -0600, Lina Iyer wrote:
>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>
>> Let userspace be another voter for cooling device state instead of
>> the
>> overriding authority. It is possible that the thermal governor may
>> find
>> a higher cooling state desirable than what is recommended by the
>> userspace. Separate out the current cooling device state from the
>> userspace request and aggregate the userspace request with the
>> governors' recommendation.
>>
>
>hmmm, I don't understand this.
>If the governor does not work well, we should either improve the
>governor or use userspace governor instead.
>do you have any examples that the kernel governor chooses improper
>cooling state?
>
>thanks,
>rui
>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/thermal/thermal_core.c    | 1 +
>>  drivers/thermal/thermal_helpers.c | 2 +-
>>  drivers/thermal/thermal_sysfs.c   | 8 +++++++-
>>  include/linux/thermal.h           | 1 +
>>  4 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c
>> index 589925ac0994..c2e13e122934 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -970,6 +970,7 @@ __thermal_cooling_device_register(struct
>> device_node *np,
>>  	cdev->updated = false;
>>  	cdev->device.class = &thermal_class;
>>  	cdev->devdata = devdata;
>> +	cdev->sysfs_req = 0;
>>  	thermal_cooling_device_setup_sysfs(cdev);
>>  	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>>  	result = device_register(&cdev->device);
>> diff --git a/drivers/thermal/thermal_helpers.c
>> b/drivers/thermal/thermal_helpers.c
>> index 2ba756af76b7..f550fdee0f9b 100644
>> --- a/drivers/thermal/thermal_helpers.c
>> +++ b/drivers/thermal/thermal_helpers.c
>> @@ -166,7 +166,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_set_trips);
>>  void thermal_cdev_update(struct thermal_cooling_device *cdev)
>>  {
>>  	struct thermal_instance *instance;
>> -	unsigned long target = 0;
>> +	unsigned long target = cdev->sysfs_req;
>>  
>>  	mutex_lock(&cdev->lock);
>>  	/* cooling device is updated*/
>> diff --git a/drivers/thermal/thermal_sysfs.c
>> b/drivers/thermal/thermal_sysfs.c
>> index 275ffee292bf..eddada715ad2 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -719,7 +719,13 @@ thermal_cooling_device_cur_state_store(struct
>> device *dev,
>>  	result = cdev->ops->set_cur_state(cdev, state);
>>  	if (result)
>>  		return result;
>> -	thermal_cooling_device_stats_update(cdev, state);
>> +
>> +	cdev->sysfs_req = state;
>> +	mutex_lock(&cdev->lock);
>> +	cdev->updated = false;
>> +	mutex_unlock(&cdev->lock);
>> +	thermal_cdev_update(cdev);
>> +
>>  	return count;
>>  }
>>  
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 5f4705f46c2f..7a133bd6ff86 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -139,6 +139,7 @@ struct thermal_cooling_device {
>>  	struct mutex lock; /* protect thermal_instances list */
>>  	struct list_head thermal_instances;
>>  	struct list_head node;
>> +	unsigned long sysfs_req;
>>  };
>>  
>>  struct thermal_attr {
