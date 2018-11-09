Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71804C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA9520825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="a6tlwzca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA9520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeKIQXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:23:14 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4346 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeKIQXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:23:14 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5be52ca50002>; Thu, 08 Nov 2018 22:43:49 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 08 Nov 2018 22:44:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Nov 2018 22:44:06 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Nov
 2018 06:44:04 +0000
Subject: Re: [PATCH v1 4/4] thermal: tegra: fix coverity defect
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <daniel.lezcano@linaro.org>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <1541410354-19090-1-git-send-email-wni@nvidia.com>
 <1541410354-19090-5-git-send-email-wni@nvidia.com>
 <20181108123709.GC1340@ulmo>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <fea5b5d3-83f0-17b3-9d2d-1f2b7a266b4f@nvidia.com>
Date:   Fri, 9 Nov 2018 14:44:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108123709.GC1340@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541745830; bh=tTueu11R/PNCDU4V9PphvaVcV/VYKgFDqtfBgN9Cm5Q=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=a6tlwzcaXiwtao/3GGHi6xVR1wq50o/zlG2B98tnfkB2TFBCXv0c026dInQfmijmT
         8IAaZUzFiczQhlP6QUoFptuRn0BVBzVMWOLbrIR8zYt0iJXzQTrfHFMJa3vGpFCvPz
         vs3CglQrsQjEbXuE3wr3RmQ77Er1BSGCGPSDta2pvcegwPMeg9vc6Ys4qNkzNessMS
         uu11NtYfRtCiFpnw3JW0kbEVO1kVO6Nxbip0VG/yHJ9cAKU+38xFjyKGZxJ60pMv+u
         ea6e5auN1UsaDa6lr0D81dejwAn0MU0H5A4eWD8OqEXSHpfeLq74eSgYc06twZ6fkH
         g8sv18qOKe+cQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2018 8:37 PM, Thierry Reding wrote:
> On Mon, Nov 05, 2018 at 05:32:34PM +0800, Wei Ni wrote:
>> Fix dereference dev before null check.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/tegra/soctherm.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index 3042837364e8..96527df91f2a 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -397,7 +397,7 @@ static int throttrip_program(struct device *dev,
>>  			     struct soctherm_throt_cfg *stc,
>>  			     int trip_temp)
>>  {
>> -	struct tegra_soctherm *ts = dev_get_drvdata(dev);
>> +	struct tegra_soctherm *ts;
>>  	int temp, cpu_throt, gpu_throt;
>>  	unsigned int throt;
>>  	u32 r, reg_off;
>> @@ -405,6 +405,8 @@ static int throttrip_program(struct device *dev,
>>  	if (!sg || !stc || !stc->init)
>>  		return -EINVAL;
>>  
>> +	ts = dev_get_drvdata(dev);
> 
> I think coverity is wrong. How is dev ever going to be NULL in this
> case? We allocate all of these struct tegra_thermctl_zone structures in
> tegra_soctherm_probe() and assign zone->dev = &pdev->dev, which can
> never be NULL.
> 
> And even if it could, the code would've crashed earlier in
> tegra_soctherm_probe() already.
> 
> Furthermore, I fail to see how your patch would fix the defect. None of
> the checks in the conditional above actually check the dev value.
> 
Yes, you are right, we doesn't need this change. The driver would not
pass null dev in any case.
And this driver already had a change "1fba81cc09bd thermal: tegra:
remove null check for dev pointer" which remove this "dev" checking.

Thank.
Wei.

> Thierry
> 
