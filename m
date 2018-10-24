Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7735C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670E22082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lPy1p2Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670E22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeJXP62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:58:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58122 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbeJXP62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:58:28 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9O7VOf2105345;
        Wed, 24 Oct 2018 02:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540366284;
        bh=dMXhnGzyH123ROxiWCj2JQgk7QJuEQqZTcE+Yw3Kdl0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lPy1p2Jjb99IIBjvIVPnymnQjdA2KmohyL0GoN6iRrPqk4dj3+pRszt++KmB7eQZy
         9v6ZEPxRlLAWbMPBCqZaZAY4chRJ3hbO6Uiwvk7kCQ4wtJsyH+EykGKvRihL+StcaZ
         l5oOnFr2hucQHcri0tvoWRkdYbDkpPoSs4eoWD8M=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9O7VO1N018057;
        Wed, 24 Oct 2018 02:31:24 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 24
 Oct 2018 02:31:24 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 24 Oct 2018 02:31:24 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9O7VLT9029054;
        Wed, 24 Oct 2018 02:31:22 -0500
Subject: Re: [RFC PATCH 0/3] M_CAN Framework rework
To:     Dan Murphy <dmurphy@ti.com>, <wg@grandegger.com>,
        <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181010142055.25271-1-dmurphy@ti.com>
 <e8485e2e-df04-0905-7055-c2228c0f1fa4@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <8247a28f-ae33-1ab1-b6d1-c89b839d357c@ti.com>
Date:   Wed, 24 Oct 2018 13:03:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e8485e2e-df04-0905-7055-c2228c0f1fa4@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thursday 18 October 2018 01:51 AM, Dan Murphy wrote:
> Bump
> 
> On 10/10/2018 09:20 AM, Dan Murphy wrote:
>> All
>>
>> This patch series creates a m_can core framework that devices can register
>> to.  The m_can core manages the Bosch IP and CAN frames.  Each device that
>> is registered is responsible for managing device specific functions.
>>
>> This rewrite was suggested in a device driver submission for the TCAN4x5x
>> device
>> Reference upstream post:
>> https://lore.kernel.org/patchwork/patch/984163/
>>
>> For instance the TCAN device is a SPI device that uses a specific data payload to
>> determine writes and reads.  In addition the device has a reset input as well
>> as a wakeup pin.  The register offset of the m_can registers differs and must
>> be set by the device attached to the core.
>>
>> The m_can core will use iomapped writes and reads as the default mechanism for
>> writing and reading.  The device driver can provide over rides for this.
>>
>> This patch series is not complete as it does not handle the CAN interrupts
>> nor can perform a CAN write.  If this patch series is deemed acceptable I will
>> finish debugging the driver and post a non RFC series.
>>
>> Finally I did attempt to reduce the first patch with various git format patch
>> directives but none seemed to reduce the patch.
>>
>> Dan
>>
>> Dan Murphy (3):
>>   can: m_can: Create m_can core to leverage common code
>>   dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
>>   can: tcan4x5x: Add tcan4x5x driver to the kernel
>>
>>  .../devicetree/bindings/net/can/tcan4x5x.txt  |   34 +
>>  drivers/net/can/m_can/Kconfig                 |   18 +
>>  drivers/net/can/m_can/Makefile                |    4 +-
>>  drivers/net/can/m_can/m_can.c                 | 1683 +----------------
>>  .../net/can/m_can/{m_can.c => m_can_core.c}   |  479 +++--
>>  drivers/net/can/m_can/m_can_core.h            |  100 +
>>  drivers/net/can/m_can/tcan4x5x.c              |  321 ++++
>>  7 files changed, 722 insertions(+), 1917 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>  copy drivers/net/can/m_can/{m_can.c => m_can_core.c} (83%)
>>  create mode 100644 drivers/net/can/m_can/m_can_core.h
>>  create mode 100644 drivers/net/can/m_can/tcan4x5x.c
>>

Patch 1/3 never arrived for me. Its not there on lkml either.
https://lkml.org/lkml/2018/10/10/611

Can you resend the complete series?

Thanks,
Faiz
