Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD7FC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932ED207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pd4HGz51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932ED207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeJXUES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:04:18 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49766 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeJXUES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:04:18 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9OBaHh1075196;
        Wed, 24 Oct 2018 06:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540380977;
        bh=8D5JPRyxZwzLuzDbvWVS/rB6XrJcc8c2j+tFbk+4fSM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Pd4HGz519pBRJoKMk5vPY4eZZlaEbVphA6jL+6CjJQDi49P7FH/YR1ypa85AasWYQ
         hX1M67dYDXQdosG83OjDiNyTkhvi4WuJUHfXdxLjjTiV7hmkQC/DUTzifte9/2bhN4
         eNeE8kQoNsP5dGApwGfA+WxqCb719V6dcHYYUdbo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9OBaH19029964;
        Wed, 24 Oct 2018 06:36:17 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 24
 Oct 2018 06:36:17 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 24 Oct 2018 06:36:17 -0500
Received: from [172.22.136.76] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9OBaHIu008147;
        Wed, 24 Oct 2018 06:36:17 -0500
Subject: Re: [RFC PATCH 0/3] M_CAN Framework rework
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181010142055.25271-1-dmurphy@ti.com>
 <e8485e2e-df04-0905-7055-c2228c0f1fa4@ti.com>
 <8d7fcd11-b537-97c1-ee50-ba30f236b5ec@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <1db25e4b-9b83-a234-b98f-e3c0c72d5e31@ti.com>
Date:   Wed, 24 Oct 2018 06:36:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8d7fcd11-b537-97c1-ee50-ba30f236b5ec@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 10/24/2018 02:43 AM, Wolfgang Grandegger wrote:
> Hallo Dan,
> 
> I will have a closer look later this week. Unfortunately you already
> renamed file names and structs making the patch almost unreadable. More
> soon..
> 

I tried to format the patch to eliminate the massive change but format patch kept 
giving me the same result.

It is a massive change regardless not sure how else to make is smaller.

I guess this is why I opt'd to just create the dedicated TCAN driver.

Dan


> Thanks for you patience,
> 
> Wolfgang.
> 
> Am 17.10.2018 um 22:21 schrieb Dan Murphy:
>> Bump
>>
>> On 10/10/2018 09:20 AM, Dan Murphy wrote:
>>> All
>>>
>>> This patch series creates a m_can core framework that devices can register
>>> to.  The m_can core manages the Bosch IP and CAN frames.  Each device that
>>> is registered is responsible for managing device specific functions.
>>>
>>> This rewrite was suggested in a device driver submission for the TCAN4x5x
>>> device
>>> Reference upstream post:
>>> https://lore.kernel.org/patchwork/patch/984163/
>>>
>>> For instance the TCAN device is a SPI device that uses a specific data payload to
>>> determine writes and reads.  In addition the device has a reset input as well
>>> as a wakeup pin.  The register offset of the m_can registers differs and must
>>> be set by the device attached to the core.
>>>
>>> The m_can core will use iomapped writes and reads as the default mechanism for
>>> writing and reading.  The device driver can provide over rides for this.
>>>
>>> This patch series is not complete as it does not handle the CAN interrupts
>>> nor can perform a CAN write.  If this patch series is deemed acceptable I will
>>> finish debugging the driver and post a non RFC series.
>>>
>>> Finally I did attempt to reduce the first patch with various git format patch
>>> directives but none seemed to reduce the patch.
>>>
>>> Dan
>>>
>>> Dan Murphy (3):
>>>   can: m_can: Create m_can core to leverage common code
>>>   dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
>>>   can: tcan4x5x: Add tcan4x5x driver to the kernel
>>>
>>>  .../devicetree/bindings/net/can/tcan4x5x.txt  |   34 +
>>>  drivers/net/can/m_can/Kconfig                 |   18 +
>>>  drivers/net/can/m_can/Makefile                |    4 +-
>>>  drivers/net/can/m_can/m_can.c                 | 1683 +----------------
>>>  .../net/can/m_can/{m_can.c => m_can_core.c}   |  479 +++--
>>>  drivers/net/can/m_can/m_can_core.h            |  100 +
>>>  drivers/net/can/m_can/tcan4x5x.c              |  321 ++++
>>>  7 files changed, 722 insertions(+), 1917 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>>  copy drivers/net/can/m_can/{m_can.c => m_can_core.c} (83%)
>>>  create mode 100644 drivers/net/can/m_can/m_can_core.h
>>>  create mode 100644 drivers/net/can/m_can/tcan4x5x.c
>>>
>>
>>


-- 
------------------
Dan Murphy
