Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFF3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033E82063F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QRClviIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbfAPIcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:32:43 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50132 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731724AbfAPIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:32:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G8WefY098470;
        Wed, 16 Jan 2019 02:32:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547627560;
        bh=3ibsyr83iipdhoNZrrPGcXCFQK9fmcjIFaoVEItsY+4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QRClviIqjBADvZ0tsyyMn4BFw4zG2hTKMYzb8RM4cRpln9qlvJisADA/PiHBrRgRC
         ZqEVm8ajYJilJfcuxgRAieXR67remnnQ51VPOX9rcByqL5mvOU8XZZBSYbHD2shlOk
         kbJo/IR0CuzoVuFXDK3RV2+8Xtc18sURrwB+L/hc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G8WeUw111800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 02:32:40 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 02:32:40 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 02:32:40 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G8WcDe002182;
        Wed, 16 Jan 2019 02:32:38 -0600
Subject: Re: [PATCH 0/4] phy: ti: Add AM654 USB2 support
To:     Roger Quadros <rogerq@ti.com>
CC:     <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
 <5C35BB6D.2030509@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d842caba-191c-b10e-14b4-60a749d8dc81@ti.com>
Date:   Wed, 16 Jan 2019 14:02:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C35BB6D.2030509@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/01/19 2:44 PM, Roger Quadros wrote:
> Hi Kishon,
> 
> On 05/12/18 17:03, Roger Quadros wrote:
>> Hi Kishon,
>>
>> This series extends omap-usb2 PHY driver to be used
>> for AM654 USB2 PHY.
> 
> Any comments on this series? If it looks fine, could you please
> queue this for -next. Thanks.

Sorry for the delay. Merged now to -next.

Thanks
Kishon
> 
> cheers,
> -roger
> 
>>
>> cheers,
>> -roger
>>
>> Roger Quadros (4):
>>   phy: ti: usb2: Fix logic on -EPROBE_DEFER
>>   phy: ti: Don't depend on OMAP_OCP2SCP
>>   dt-bindings: phy: ti: Add support for AM654x USB2 PHY
>>   phy: ti: usb2: Add support for AM654 USB2 PHY
>>
>>  Documentation/devicetree/bindings/phy/ti-phy.txt |   1 +
>>  drivers/phy/ti/Kconfig                           |   6 +-
>>  drivers/phy/ti/phy-omap-usb2.c                   | 105 ++++++++++++++---------
>>  3 files changed, 67 insertions(+), 45 deletions(-)
>>
> 
