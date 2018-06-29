Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0F1C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC44214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="X3YpAEGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC44214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755233AbeF2RoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:44:19 -0400
Received: from vern.gendns.com ([206.190.152.46]:50523 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbeF2RoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4TCexlhIPRkv9ov81n6UPSmoRFaUou6aoS3yWt3YtRE=; b=X3YpAEGRFx6pbCx9DDybkKSryH
        FKeHc3nTKOLLH5Bc0OZ3ixFSpDDR4S16RagnbH9rGYjm3M6Dh9YH+FJemGmYL4XA+Ka04W5GFeCRY
        gJEEQ7qn66CKGzwI2scyYkKZLPFTd6NK8XWw9MQjcvMNGgZiqSdQNEba8IFeIUhAgeM3avU0rLXm1
        q5gklmJrP2JTzqH584QPdYcicxaMlwEkoRIJzU+Y3zEYStPXlrbjJPTJTvOYQMDpT91qi4Bzj4Uw/
        GMQPtgL1RzM0ftWn8cTH9/hE4s3F208+TUx4Ub9MaU+Au6njSThSp1pdTBwJCgWx++Dt6Uxcf85lu
        0LVivbkg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:40128 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fYxRO-002VRb-OT; Fri, 29 Jun 2018 13:44:14 -0400
Subject: Re: New remoteproc driver for TI PRU
To:     Roger Quadros <rogerq@ti.com>, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, "Anna, Suman" <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <e0a883af-8228-5b06-3186-f57d8f898aaa@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <8fc18d40-72f5-9215-26f0-1492e3a6c0e7@lechnology.com>
Date:   Fri, 29 Jun 2018 12:44:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e0a883af-8228-5b06-3186-f57d8f898aaa@ti.com>
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

On 06/29/2018 04:58 AM, Roger Quadros wrote:
> +Suman & Tero
> 
> Hi David,
> 
> On 24/06/18 00:08, David Lechner wrote:
>>
>> Date: Sat, 23 Jun 2018 15:43:59 -0500
>> Subject: [PATCH 0/8] New remoteproc driver for TI PRU
>>
>> This series adds a new remoteproc driver for the TI Programmable Runtime Unit
>> (PRU) that is present in some TI Sitara processors. This code has been tested
>> working on AM1808 (LEGO MINDSTORMS EV3) and AM3358 (BeagleBone Green).
> 
> This is great. We have been working on something similar and I think it would
> be great if we can collaborate to get all our needs addressed.

Yes, I have used the PRU with the TI kernel on BeagleBone so I've seen the TI
implementation. My primary interest is in the AM1808, which has a far simpler
PRU than other SoCs. So, I was hoping I could get away with just implementing
the basic stuff that I need and let TI add the more complex stuff later.

> 
> Our primary requirement is that it should be possible for a user (e.g. kernel driver) to
> - request a specific PRU core load a specific firmware blob and boot/stop the PRU.

For this, I was thinking of suggesting a generic remoteproc provider/consumer
binding that is similar to other subsystems. For example:

Provider node has:

	#remoteproc-cells = <1>;

And consumer has:

	remoteprocs = <&pruss 0>, <&pruss 1>;
	remoteproc-names = "pru0", "pru1";

The consumer device would be responsible for determining the firmware file
and for calling the rproc boot function.


> - configure INTC interrupt mapping based on either resource table or DT
> - use request_irq to request and use an interrupt.

I didn't consider creating a new interrupt controller in device tree, but
that makes sense. I will have to look into it some more.


> - request access to DRAM/SRAM

Can the existing device tree bindings for reserved-memory be used for this?
I would expect the consumer nodes to use this and not the PRUSS provider node.


> - configure gpimode/miirt/xfr (CFG space)

I have no idea what this stuff is. :-)

(This is what I was referring to when I said I was hoping that someone
else could add more later).

