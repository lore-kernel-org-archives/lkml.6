Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D76C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B0721502
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PY3SbNCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B0721502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIZVPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:15:32 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18847 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeIZVPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:15:32 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bab9f4f0001>; Wed, 26 Sep 2018 08:01:35 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 26 Sep 2018 08:02:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 26 Sep 2018 08:02:11 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 15:02:08 +0000
Subject: Re: [PATCH 1/5] PM / Domains: Export symbol for
 genpd_dev_pm_attach_by_name
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1537964858-30332-1-git-send-email-jonathanh@nvidia.com>
 <1537964858-30332-2-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFrtw1aYg5QbgRi_jp-xd0VLNeRYhb4HvX4P3AfGjgO0VA@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <afd04dd4-4199-9bb8-1b21-11444bb1773a@nvidia.com>
Date:   Wed, 26 Sep 2018 16:02:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrtw1aYg5QbgRi_jp-xd0VLNeRYhb4HvX4P3AfGjgO0VA@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1537974095; bh=tfLfkIcnLllntuKQmiaCofazzdc+aulNG4MmnVbrFz4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PY3SbNCHcrDO4jOmTrZHthLFfjrwXh2n7Yq0K8RIBT3uOYCWtuuceo1qG4SJ2yEy+
         U7hv1yMHU4t2LStEQBow3O9tzLKBcXgreZ1ECqKROOkmJRWERWM8s4sA3V0MeHJm+k
         jo3FUHcHjvJGBPrrN8lOWJtNsjKsphAXmrvPcW+7hyZeW9uKOVhuOHD5W4MZm0p0wm
         OM6s81hXK/C8Ls5kSCxRiShXLwRRxvmHfWUZhuHW5+MR8t+np/m1jd3HMmGN3OVtmY
         zqfAtLAdqsaU+yTK2o7XBJ1ailjYAyF+HUESRdTqamwT9uDObTCIW3sSZglZxwrxlk
         gE9yY6x+LH3jg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/09/18 15:09, Ulf Hansson wrote:
> On 26 September 2018 at 14:27, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Export the symbol for genpd_dev_pm_attach_by_name() so that drivers
>> built as modules can call this function.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/base/power/domain.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 4b5714199490..b2bbe0d848d2 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2397,6 +2397,7 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev, char *name)
>>
>>         return genpd_dev_pm_attach_by_id(dev, index);
>>  }
>> +EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_name);
> 
> Driver's shouldn't be calling this function, but instead use
> dev_pm_domain_attach_by_name().
> 
> Is there any problem with that?

No not at all. Yes that works, sorry it had been a while since I looked
at this and managed to balls it up. OK, I will drop this and correct the
API used by the driver.

Cheers!
Jon

-- 
nvpublic
