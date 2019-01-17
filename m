Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27C8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2BF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="frOO8pkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfAQN10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:27:26 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39258 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfAQN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:27:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0HDRICS103805;
        Thu, 17 Jan 2019 07:27:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547731638;
        bh=djCWpJC0UGwknF/eUj9PjPdjxt6eoD0syV3BsrAw1yM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=frOO8pkcVWPV/twrpxb/LWTLBoD5jVAPdv/OhH6APP2wXwQY9tT/vns1mnfbAkKF9
         CmBMNRwnly7zX/ImZxmpPV6Uqh1TW/4AMwj5vn8gY34/GkBOAHD2e550226L7BdBWg
         r1NAEfRsb0X6kk+dmD00pQRXg8RczOxPHZI9BZfU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0HDRI5d111524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 07:27:18 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 17
 Jan 2019 07:27:18 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 17 Jan 2019 07:27:18 -0600
Received: from [172.22.123.101] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0HDRIvP021638;
        Thu, 17 Jan 2019 07:27:18 -0600
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dachaac@gmail.com>,
        <robh+dt@kernel.org>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com> <20190116220401.GA28024@amd>
 <8c7dde3e-5f3c-80a5-ec57-73ce8e39deef@ti.com> <20190117100651.GB17930@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <8def5414-9170-7034-34f9-70e6c71f8161@ti.com>
Date:   Thu, 17 Jan 2019 07:27:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117100651.GB17930@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 1/17/19 4:06 AM, Pavel Machek wrote:
> Hi!
> 
>>>>> You know what? First, submit driver with similar functionality to
>>>>> existing RGB drivers, using same interface existing drivers are
>>>>> using. When that is accepted, we can talk about extending
>>>>> kernel<->user interfaces.
>>>>>
>>>>
>>>> I could do that but then there is no way for users to have any other color but "white" with this driver.
>>>> That defeats the purpose of the device itself.
>>>
>>> No, that is not what I meant.
>>>
>>> We do have RGB drivers in tree, they just present three separate LEDs
>>> -- red, green and blue. I ask you to do the same for initial
>>> submission.
>>>
>>
>> For clarification you are asking me to register a LED class per
>> output pin?
> 
> Yes.
> 

OK I can do that but I would like to get Jacek to align with this as he
suggested creating the code as I submitted based on the review of the
devices data sheet.

LED class registration per LED module or for the single Banked output.

>> As explained before the Master brightness register has absolute control over the output current
>> to the LED outputs regardless of the color control setting.
>>
> 
> Yes, just set master brightness to 255 and you can ignore it.

OK Sounds fine.  Will just need to do an init that sets the color
register to 0 and brightness to 0 so we don't have a flash.

> 
>>> You'll still be able to set brightness independently on the
>>> red/green/blue LEDs...
>>>
>>
>> But which one would control the overall brightness of the cluster?
> 
> You would not have that control in initial version of the patch.
> 

See above on alignment

Dan

> 								Pavel
> 


-- 
------------------
Dan Murphy
