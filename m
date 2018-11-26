Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6040DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4AC205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gikuxULj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4AC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeK0HMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:12:41 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14896 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeK0HMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:12:41 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfc54de0000>; Mon, 26 Nov 2018 12:17:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 26 Nov 2018 12:17:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 26 Nov 2018 12:17:25 -0800
Received: from [10.26.11.165] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 26 Nov
 2018 20:17:22 +0000
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
To:     Tony Lindgren <tony@atomide.com>,
        Thierry Reding <treding@nvidia.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
References: <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com> <20181126093625.GA10878@ulmo>
 <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com> <20181126102541.GC10878@ulmo>
 <20181126193212.GN53235@atomide.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <149b3b6b-e52e-4942-151b-6df4358f5a7a@nvidia.com>
Date:   Mon, 26 Nov 2018 20:17:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126193212.GN53235@atomide.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543263454; bh=eQ3AsTvnGApB+TzqTQICue2aDLm7E+L0Pf/fAoN3WMM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gikuxULjyJZ3mNJNju4wekt96Gmws4XtDGi8IrwIdGwelXN9L/Zu5PTDTFpkHdl8f
         xS5Cum3oH5q5BsC0LEsGpL5Xks32Pys+rWTV21Ro3dIc/OHidgL/Bne53gyIgYRRck
         437UwOxQqgIyNiU/4UI7YaYiTPCY5y8DXY3z66eTRxWwb7QOil7/K8La1kaoFyVZvk
         I13Pb3QgegzzY7eVnaRxWmQIaaMcTHwelKbvk/Hofx/6b5eNV4IuriTn79lsSU9jm5
         t5CEqW85NVOo60kjIbgUxcWUVwV0PSFECDij9FwGWrBDJm/s2qcbNLJa+Fqsv/F+Yb
         sSfuthuGG9nvw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/11/2018 19:32, Tony Lindgren wrote:
> * Thierry Reding <treding@nvidia.com> [181126 10:25]:
>> On Mon, Nov 26, 2018 at 11:49:54AM +0200, Peter Ujfalusi wrote:
>>> The register map documentation I have states the following:
>>> bit7 INT_POLARITY Select the polarity of the INT output line
>>> 0: Interrupt line (INT) is low when interrupt is pending (default) RW
>>> 1: Interrupt line (INT) is high when interrupt is pending
>>>
>>> By default the Palmas irq is active low.
>>
>> That would confirm that the driver code is correct. My understanding is
>> that the PMC on Tegra expects a low-active IRQ from the PMIC, so we need
>> to invert the interrupt again in the PMC.
> 
> But then why Tegra need to set PALMAS_POLARITY_CTRL_INT_POLARITY
> if dts has IRQ_TYPE_LEVEL_HIGH? Shouldn't the Palmas default low
> setting be correct for Tegra if PMC expects active-low interrupt
> and then inverts it for GIC?

So I think what is going on here is ...

1. For Tegra, the interrupt parent the palmas interrupt in DT is the GIC
   not the PMC. The PMC does not register an interrupt controller
   (although to be correct probably should have. I think it had been
    discussed in the past and Stephen W may know the history here). So
   the interrupt polarity has to be HIGH otherwise setting the trigger
   type in the GIC will fail (as it only supports rising edge or level
   high IIRC).
2. However, as Thierry mentioned the Tegra PMC wants an active low
   interrupt and so the PMC inverts it on entering the PMC. However,
   given that the GIC interrupts must be active high, the PMC must
   invert again between the PMC and GIC.

So looking back my description in the change 7e9d474954f4 was not quite
accurate because the interrupt from palmas is active high but the PMC
inverts it. I think that this is quite confusing because we don't have a
good way to describe this in the DT. If we made the PMC an interrupt
controller then it would probably be a lot clearer. However, for
historical reasons this was not done.

Cheers
Jon

-- 
nvpublic
