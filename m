Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE6AC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EBC2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PYJtp5M0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfAaC3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:29:32 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9013 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaC3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:29:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c525d6f0000>; Wed, 30 Jan 2019 18:29:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 30 Jan 2019 18:29:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 Jan 2019 18:29:31 -0800
Received: from [192.168.88.246] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 02:29:29 +0000
Subject: Re: [PATCH v2 4/4] mfd: max77620: add documentation for low battery
 monitoring
To:     Rob Herring <robh@kernel.org>
CC:     <lee.jones@linaro.org>, <blaws05@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20190129085531.32364-1-markz@nvidia.com>
 <20190129085531.32364-5-markz@nvidia.com> <20190130195355.GA1652@bogus>
From:   Mark Zhang <markz@nvidia.com>
Message-ID: <a6cd5f7c-d8a5-3f93-b1cf-4da3e4760dff@nvidia.com>
Date:   Thu, 31 Jan 2019 10:29:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130195355.GA1652@bogus>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548901743; bh=aU9iv/DVTZJ2By+4W5JOhbUw5pGwVHJIZGZX5o+emzU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PYJtp5M0XWbtbzm22i4TuSjzzI9o4gmik0JDwyzuv3RyBDBmgafaRxd/Ysu91rSM+
         66Keg6T3Ko+NdNhoxJkWczGqy3HiYHT9URZK8ethTUEWtYFGuWVfBcCAsKmXSjkzkF
         PYrQN+XOum3vyjTUSU00W3mRV2Y8aG6uwcZoWCuZc80WYkDhUESrEBuY6mCt+jMxUR
         xsuaTSyEFvwhtrH237XZ1zLAVinpwQhoZhpj+tBRrF+6dRySAmzX7oKXmwD7iUAqmN
         2jPrp4vvXm1pQzOjPa9GklePuTdIuI8t83VJslOcC8qAq9+xTFK6drnDNE+jmLBmP8
         TkBpwp4fdLo2g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2019 3:53 AM, Rob Herring wrote:
> On Tue, Jan 29, 2019 at 04:55:31PM +0800, Mark Zhang wrote:
>> Adding documentation for low battery monitor properties:
>> - maxim,low-battery-dac-enable
>> - maxim,low-battery-dac-disable
>> - maxim,low-battery-shutdown-enable
>> - maxim,low-battery-shutdown-disable
>> - maxim,low-battery-reset-enable
>> - maxim,low-battery-reset-disable
>>
>> Signed-off-by: Mark Zhang <markz@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/max77620.txt | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
>> index 484b17e4fba5..5fed0a463b80 100644
>> --- a/Documentation/devicetree/bindings/mfd/max77620.txt
>> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
>> @@ -142,6 +142,20 @@ Optional properties:
>>  			Device supports 100/1000/3000/6000 Ohms.
>>  			Default will be set to 1000 Ohm.
>>  
>> +Low-Battery Monitor:
>> +==================
>> +This sub-node configure low battery monitor configuration registers. Device has
>> +support for low-battery monitor configuration through child DT node
>> +"low-battery-monitor".
>> +
>> +Optional properties:
>> +	- maxim,low-battery-dac-enable: Enable low battery DAC.
>> +	- maxim,low-battery-dac-disable: Disable low battery DAC.
>> +	- maxim,low-battery-shutdown-enable: Enable low battery shutdown.
>> +	- maxim,low-battery-shutdown-disable: Disable low battery shutdown.
>> +	- maxim,low-battery-reset-enable: Enable low battery reset.
>> +	- maxim,low-battery-reset-disable: Disable low battery reset.
> 
> Do you really need 3 states with the 3rd being prop not present.

Yeah, so I think we can just keep 3 of them and shorten the names a little bit
(lbm stands for "low battery monitoring"):
- maxim,lbm-dac-enable
- maxim,lbm-shutdown-enable
- maxim,lbm-reset-enable

Does this look good to you?
Mark

> 
> Rob
> 
