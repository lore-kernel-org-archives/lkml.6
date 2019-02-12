Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0FAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BDA2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ECaiGnfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfBLIaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:30:00 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4317 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfBLI37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:29:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6283e40000>; Tue, 12 Feb 2019 00:29:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Feb 2019 00:29:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Feb 2019 00:29:58 -0800
Received: from [192.168.88.246] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 08:29:55 +0000
Subject: Re: [PATCH v2 0/4] Add max77620 charging & low battery support
To:     Lee Jones <lee.jones@linaro.org>
CC:     <blaws05@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <20190129085531.32364-1-markz@nvidia.com>
 <20190207084836.GF4672@dell>
 <a43eb007-c984-a209-2b4e-6672807029aa@nvidia.com>
 <20190212080457.GL20638@dell>
From:   Mark Zhang <markz@nvidia.com>
Message-ID: <4d0a1e3c-becd-70a8-920f-a37ee1ee48cc@nvidia.com>
Date:   Tue, 12 Feb 2019 16:29:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212080457.GL20638@dell>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549960164; bh=GQeBxOd6ThwmqoXA75WhN+bBUUdVmDh5MRQpdqJbka0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ECaiGnfLZrmUnjjtAnKqCBh5Ij2rQ8eQZyHYIC2InJ8BGERdBlCVdOqsRlXwG3Kfk
         adSFxFCDPMc2SXHO2docfXnKKbXSqkHcbIJ5yMszqslRYG31GfYGFb9Ff4oRzxzaXI
         WCbVUMCIkGQfFGRk0XJZVmfHykeSEcmvxouoEl2Ajo8yRRDd8M9WQAqqnJZDifTFUW
         lObxkHoHzRHC9Ap/7wZ/kUTwVN5rXO+cZV4t6BMwC9Di2TJS1/gGqNp7NHyCPB5Lkm
         4I4ka47irR6fF9ctYcueacbxgU1XGUQZaQtFnDnbchyIwI1T6BiO89rvHPoZ2p+b7Y
         iRlxuse42ewTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/2019 4:04 PM, Lee Jones wrote:
> On Tue, 12 Feb 2019, Mark Zhang wrote:
> 
>> On 2/7/2019 4:48 PM, Lee Jones wrote:
>>> On Tue, 29 Jan 2019, Mark Zhang wrote:
>>>
>>>> This patch set adds support for max77620 backup battery charging and
>>>> low battery monitoring.
>>>>
>>>> Changes in v2:
>>>> - Add devicetree binding documentation
>>>>
>>>> Mark Zhang (4):
>>>>   mfd: max77620: Add backup battery charger support
>>>>   mfd: max77620: add documentation for backup battery charging
>>>>   mfd: max77620: Add low battery monitor support
>>>>   mfd: max77620: add documentation for low battery monitoring
>>>>
>>>>  .../devicetree/bindings/mfd/max77620.txt      |  34 +++++
>>>>  drivers/mfd/max77620.c                        | 137 +++++++++++++++++-
>>>
>>> All of this needs moving out to the correct subsystem.
>>>
>>> drivers/power/supply/max77620-battery.c looks right.
>>
>> Actually max77620 is not a power supply device. This patch set adds 2
>> features:
>> - Backup battery charger. The RTC in max77620 is supplied from a backup
>> battery and consumes 2.0uA when no other power sources are available. So
>> basically this is not a system battery charger, it's just for RTC.
>> - Low battery monitoring. This is for monitoring the system main battery
>> voltage, so max77620 can shutdown or reset the SoC accordingly. But I
>> think this doesn't conform the idea of "power supply" driver as well.
> 
> Most other battery handling seems to happen in
> drivers/power/supply/*.battery*.  If that's not the right location,
> then you need to find a place for it to go.  MFDs do not provide
> useful functionality per say - that is the role of the child devices.
> 

Understood. Looking at "enum power_supply_property", battery handling
drivers are able to get battery capacity/current
voltage/temperature/status/... and etc, which is making sense. But my
patch set doesn't do this kind of things at all so I think the power
supply framework doesn't fit here. Let me check other similar device
drivers... hope to get inspired. Thanks Lee.

Mark
