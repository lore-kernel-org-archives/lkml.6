Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AE4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3F3217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A+3Piv5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbeLTODf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:03:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58224 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732864AbeLTODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:03:34 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBKE3VWe022372;
        Thu, 20 Dec 2018 08:03:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545314611;
        bh=JWSGjMbkUmwdxkMAq1a+c2I7ain33LQm86W/1CINhkc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=A+3Piv5hLI5F8NvJDjLMiiExQxlRn+cO3Byaec0Mk7dfnWY16/i1aSd2VHHIaLLa8
         fPqHsdZD31vmlIECIJXdp/in/fFHPLGcrPzsSiwKKZ0WpYg9jzjapWiK9z6i2MZMU4
         m8l/4BAWACn8noSNu3kC8pub+/oCr5eArV9oZsvg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBKE3V45057650
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 08:03:31 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 20
 Dec 2018 08:03:31 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 20 Dec 2018 08:03:31 -0600
Received: from [172.22.89.160] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBKE3U8I028828;
        Thu, 20 Dec 2018 08:03:30 -0600
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <jacek.anaszewski@gmail.com>, <linux-leds@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20181219162626.12297-3-dmurphy@ti.com>
 <20181219193455.GA21159@amd> <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
 <20181219201047.GA23448@amd> <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com> <20181219220326.GA28244@amd>
 <a3214ab3-9281-19d6-7fcc-5abae9a60ebd@ti.com> <20181219222737.GB30496@amd>
 <d7edfd57-20df-bd83-b616-5b18e8bc2c64@ti.com> <20181220090612.GA21972@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <8bc77441-eb22-8748-b00b-59d403794c24@ti.com>
Date:   Thu, 20 Dec 2018 08:03:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181220090612.GA21972@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/2018 03:06 AM, Pavel Machek wrote:
> Hi!
> 
>>> Anyway, if your 36 channels can be set independently, I believe you
>>> just want them to export as 36 LEDs.
>>
>> I am not sure that is what the "customers" would want to have to set 36 different nodes or even declare those 36 nodes.
>> That is 36 independent user space to kernel space calls that are very expensive just to set a LED color and brightness.
>>
> 
> No, 36 independend calls to kernel space are not that expensive.

But they are time consuming.

Also note that even if I set the OUTX color mix register the LEDX brightness register controls the output intensity.

So if the brightness is 0x0 and the Mix register is 0xff then the LED is still off.

I am sticking with the driver as is.  I think this is a better representation of the part and its capability then presenting x number of
sysfs nodes that will have no affect on the LED if set until the corresponding brightness register is not set properly.

This will also keep the device tree entries down to a minimum.  The LEDx brightness register actually
controls the output and there are only 7 of these.

Dan

> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
