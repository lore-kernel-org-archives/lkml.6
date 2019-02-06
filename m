Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A71AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37573218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pa1xIMuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfBFKRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:17:14 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60854 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfBFKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:17:14 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16AH4fu008204;
        Wed, 6 Feb 2019 04:17:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549448224;
        bh=OvVD/K/0CGIrgyIeNJx4VP6E0uJKF0/nd+3Iycu91Q0=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=Pa1xIMukwGjNAg6VV+dlrFHSjX+7eXEIaj+WyrIARLe8eGq4c3vJtFRsF41ESeTol
         DeX9YnU0+unOzzb6yLltnrTyJbKeZtcsj9wJuBCylBmmKrFN9xYvmY3xZ5suwuTdGd
         O+F8Q06EvOciG6tG0Pqa9RH+KnKu5dVDYAlf94C8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16AH4ZL091340
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 04:17:04 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 04:17:03 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 04:17:02 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16AH0UU030449;
        Wed, 6 Feb 2019 04:17:01 -0600
Subject: Re: [PATCH] usb: dwc3: Enable GBit Ethernet on Odroid XU4
To:     Jochen Sprickerhof <jochen@sprickerhof.de>
References: <20190121140204.GA2360@vis> <5C5A9DCB.8040507@ti.com>
 <20190206093830.GS26157@vis>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vivek Gautam <gautam.vivek@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <m.szyprowski@samsung.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C5AB41C.9080402@ti.com>
Date:   Wed, 6 Feb 2019 12:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190206093830.GS26157@vis>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Marek

As Vivek's and Andrzej's Samsung IDs bounced back.

On 06/02/19 11:38, Jochen Sprickerhof wrote:
> * Roger Quadros <rogerq@ti.com> [2019-02-06 10:41]:
>> Hi,
>>
>> On 21/01/19 16:02, Jochen Sprickerhof wrote:
> [..]
>>> I'm not sure why this it only works with the driver compiled into the
>>> kernel nor why it needs a hard reset or why it was the line was dropped
>>> when the patch was accepted. Would be great to get some feedback of the
>>> authors.
>>
>> When XHCI driver is compiled into the kernel are the relevant PHY drivers
>> compiled in as well?
> 
> Only CONFIG_USB_PHY=y (I took the config from the linux-image-4.19.0-1-armmp_4.19.13-1_armhf.deb Debian package as a basis where this is the default).
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
