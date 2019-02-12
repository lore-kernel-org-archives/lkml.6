Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70727C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 04:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4064921773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 04:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i8NMczHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfBLEie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 23:38:34 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10768 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfBLEid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 23:38:33 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c624da60000>; Mon, 11 Feb 2019 20:37:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 20:38:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 11 Feb 2019 20:38:33 -0800
Received: from [192.168.88.246] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 04:38:30 +0000
Subject: Re: [PATCH v2 0/4] Add max77620 charging & low battery support
To:     Lee Jones <lee.jones@linaro.org>
CC:     <blaws05@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <20190129085531.32364-1-markz@nvidia.com>
 <20190207084836.GF4672@dell>
From:   Mark Zhang <markz@nvidia.com>
Message-ID: <a43eb007-c984-a209-2b4e-6672807029aa@nvidia.com>
Date:   Tue, 12 Feb 2019 12:38:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207084836.GF4672@dell>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549946278; bh=TDMZOlz50aZkVcMc1Ji5nQAt8OQY2zsQ9tzJKhPeoLA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=i8NMczHRrlN47owXeDqUJV3OzkTDawjRkJvQg0mZO3L29ESpKa2pMNAj7QS1Q6463
         XR9s0w8w1Tt/O0eJW/NwOhnDSd6l9SJZarCE15VKqKooYMtUY02DrHs1374V1v+V2l
         teD9W6hKONqjmj26mTebi8uv10RMgGc5FkbCsuubPOiyfQdVceKvK+PpNc6LNhk5fX
         YlO/2zMCEaJspRnqwX9QVuT3QDG+ybWk2GwFRm9sAo9aBjlBH/PR9+k5SE0l5zdytw
         ienuAeBITlSy6O/3WlItnI5/djmS0xLV4CXF3Iv9KwPF3hj1vG0PUrA0PLZQXGUCB6
         exv4Nss1D/LiA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/2019 4:48 PM, Lee Jones wrote:
> On Tue, 29 Jan 2019, Mark Zhang wrote:
> 
>> This patch set adds support for max77620 backup battery charging and
>> low battery monitoring.
>>
>> Changes in v2:
>> - Add devicetree binding documentation
>>
>> Mark Zhang (4):
>>   mfd: max77620: Add backup battery charger support
>>   mfd: max77620: add documentation for backup battery charging
>>   mfd: max77620: Add low battery monitor support
>>   mfd: max77620: add documentation for low battery monitoring
>>
>>  .../devicetree/bindings/mfd/max77620.txt      |  34 +++++
>>  drivers/mfd/max77620.c                        | 137 +++++++++++++++++-
> 
> All of this needs moving out to the correct subsystem.
> 
> drivers/power/supply/max77620-battery.c looks right.

Actually max77620 is not a power supply device. This patch set adds 2
features:
- Backup battery charger. The RTC in max77620 is supplied from a backup
battery and consumes 2.0uA when no other power sources are available. So
basically this is not a system battery charger, it's just for RTC.
- Low battery monitoring. This is for monitoring the system main battery
voltage, so max77620 can shutdown or reset the SoC accordingly. But I
think this doesn't conform the idea of "power supply" driver as well.

Mark
> 
>>  2 files changed, 170 insertions(+), 1 deletion(-)
> 
