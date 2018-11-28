Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D87C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A896020989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="h2qeV0o6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A896020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeK2Csg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:48:36 -0500
Received: from vern.gendns.com ([98.142.107.122]:57402 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbeK2Csf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v3BZ8eaPDm65dVhGJtsCUly7WdWzUe2LOR4BBYB8E+8=; b=h2qeV0o6fH5DhI4dGyH8YCWYq9
        DyOSYANaTq+R1Ju4MvbzUyLgErzdDqmj/sNWxK9R1NG1Yx0q3/74OMcuaOZ8b7Gzyz8v7nsjmYCBe
        Sc2P5F/ANp6h17+AE3l7l7D51t75RIXZ90tmLe0nKWKMMbd8UzPj0iQmbe1sSCo6o+usQ2yYIGjPW
        1J1neHsPAWk04xM1RuKhva2JQaTDOlQT4kxzZdNoXD5HdKPTGHQEdVo23jMZjmKLBLkmffCdMI3cr
        u7qfPk4dvKvmSmu9bzCeXrX4ySlVpm2me6jt0FG488wiOYP5qFG3PxEcH0kIqtY0zpeTgUGOtuu+K
        OEvDuXOA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:48980 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gS21r-0000y8-Ow; Wed, 28 Nov 2018 10:45:31 -0500
Subject: Re: [PATCH 08/17] soc: ti: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-9-git-send-email-rogerq@ti.com>
 <af2f8ce3-923b-aa27-59b2-2ebb848c28c9@lechnology.com>
 <5BFD651C.7020903@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <421ca9ad-1816-021e-76af-b719f80a5531@lechnology.com>
Date:   Wed, 28 Nov 2018 09:46:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BFD651C.7020903@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 9:39 AM, Roger Quadros wrote:
> 
> On 26/11/18 23:17, David Lechner wrote:
>> On 11/22/18 5:39 AM, Roger Quadros wrote:
>>> From: Suman Anna <s-anna@ti.com>
>>>
>>> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
>>> interrupt controller (INTC) that can handle various system input
>>> events and post interrupts back to the device-level initiators.
>>> The INTC can support upto 64 input events with individual control
>>> configuration and hardware prioritization. These events are mapped
>>> onto 10 interrupt signals through two levels of many-to-one mapping
>>> support. Different interrupt signals are routed to the individual
>>> PRU cores or to the host CPU.
>>>
>>> The PRUSS INTC platform driver manages this PRUSS interrupt
>>> controller and implements an irqchip driver to provide a Linux
>>> standard way for the PRU client users to enable/disable/ack/
>>> re-trigger a PRUSS system event. The system events to interrupt
>>> channels and host interrupts relies on the mapping configuration
>>> provided through a firmware resource table for now. This will be
>>> revisited and enhanced in the future for a better interface. The
>>> mappings will currently be programmed during the boot/shutdown
>>> of the PRU.
>>
>> Does this mapping table take up space in the PRU IRAM or DRAM? If
>> so, that can be a problem on the AM18xx because it has such limited
>> resources - every byte counts.
> 
> Currently the entire resource table is being placed in DRAM.
> But that is only because the current rpmsg vdev implementation depends on the
> rpmsg channel information and vring buffers to be in DRAM.
> 
> I think the right way is to split up the 2 things.
> i.e. separate out rpmgs channel DRAM allocation from resource table
> and don't copy the resource table to DRAM.
> 
> This way if there is no rpmsg channel in the resource table we won't eat
> any DRAM.
> 
> I'm not sure if there are any bottlenecks. I will only know when I work on it.

Sounds good to me.
