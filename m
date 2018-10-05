Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70589C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19204206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ixN9a6v1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19204206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeJESoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:44:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32840 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbeJESoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:44:20 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w95Bjik3069103;
        Fri, 5 Oct 2018 06:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538739944;
        bh=6I7XOBjzOSiWrDEFD3Dn1ZWREv34CviA/GrLzq1OWnY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ixN9a6v1+o+ev8fJqDaajPmrLvaXqqp2qf43XVgiERW+9ZMrwTF2iGpJzJWuViVzL
         QZaU5exlv3TtbHPOJzLcTqUX2GvE3H3ca2s7DTotvCq6smVm3v1SxAV0lFBQFQ0vmR
         RIV8jNp4f7eYwJBfdpl905ApTl/QWi4BpBDd1qa0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95BjiA7023388;
        Fri, 5 Oct 2018 06:45:44 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 5 Oct
 2018 06:45:44 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 5 Oct 2018 06:45:44 -0500
Received: from [172.22.155.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95BjhnX015283;
        Fri, 5 Oct 2018 06:45:43 -0500
Subject: Re: [PATCH 2/2] can: tcan4x5x: Add tcan4x5x driver to the kernel
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Mario.Huettel" <Mario.Huettel@de.bosch.com>
References: <20180910201241.24092-1-dmurphy@ti.com>
 <20180910201241.24092-2-dmurphy@ti.com>
 <631340c2-78a6-eec3-0ab2-713dddd8e84f@ti.com>
 <45621ef7-bc87-3d1e-efca-e6387fdebf9a@grandegger.com>
 <7a75a096-d07f-693e-74b6-74a76c00acf5@ti.com>
 <6f055cd9-9452-0b4c-2df2-3d0cc06f9e68@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <5e0d5a5b-dfe0-a2b5-8ca2-733579bda216@ti.com>
Date:   Fri, 5 Oct 2018 06:45:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6f055cd9-9452-0b4c-2df2-3d0cc06f9e68@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 10/05/2018 12:56 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> Am 04.10.2018 um 22:26 schrieb Dan Murphy:
>> Wolfgang
>>
>> On 09/26/2018 12:54 PM, Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> I wonder why you do not extend the existing MCAN driver by implementing
>>> an interface to access the hardware. Would that be feasible?
>>>
>>
>> I have created a m_can_core code base that can be used by other hardware that
>> have special needs.
>>
>> So I have created the m_can_core, m_can and the tcan4x5x drivers.
> 
> Great, I still think it's a good idea to have just one "m_can" driver.

The m_can and tcan4x5x provide the device level implementations.  The m_can_core
deals specifically with handling of the m_can IP and protocol.

> 
>> I can RFC the code to see if this is what is expected.
>> It is not 100% working but it is close enough for a directional call.
> 
> That would be nice! Most of the SPI accesses are pure register accesses.
> A few read/write more bytes at a time (for data, etc.) but that could be
> handled by appropriate interface functions. One general problem is that
> SPI accesses are not possible from interrupt context requiring threads
> or work queues. Also NAPI is usually not used.
> 
> Other opinions?

agreed. Is there any issue with moving the request_irq to a threaded_irq?
Not sure how that would affect the timing.

> 
> Wolfgang.
> 
> PS: I have added Mario to the CC. Maybe he could test a common driver on
> his M_CAN hardware.
> 

I found that our am5/dra76 EVM also uses this IP stack.  So I am working with
our experts there to test and review the code as well.

Dan

-- 
------------------
Dan Murphy
