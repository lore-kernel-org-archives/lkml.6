Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EA3206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RRrgeD/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfAPXdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:33:52 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36642 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfAPXdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:33:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GNXi8M104365;
        Wed, 16 Jan 2019 17:33:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547681624;
        bh=V9NhfUdS/bYNjGYupxozJTvEiyke8rLDljlj74ibOko=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RRrgeD/fvP8jvi3SaLrm5ZiBctB+GtLEeKFQChEgqKq8CFkzhZxRDULrBzcQD8Xhx
         xf3TBWOyqVyY/TUVQRk6loEKXsmxELWrx6XHWmcd34enJlTjAQW3dK5APMdwa3YNnm
         gXH9zF+klY/yeNljUakPVy95ew6rXrNGgtuZtp/0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GNXiPu057472
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 17:33:44 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 17:33:44 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 17:33:44 -0600
Received: from [172.22.103.16] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GNXiRb001591;
        Wed, 16 Jan 2019 17:33:44 -0600
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
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <8c7dde3e-5f3c-80a5-ec57-73ce8e39deef@ti.com>
Date:   Wed, 16 Jan 2019 17:33:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116220401.GA28024@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 1/16/19 4:04 PM, Pavel Machek wrote:
> Hi!
> 
> ..snip. Let me read it and reply when I have a time.
> 
>>> You know what? First, submit driver with similar functionality to
>>> existing RGB drivers, using same interface existing drivers are
>>> using. When that is accepted, we can talk about extending
>>> kernel<->user interfaces.
>>>
>>
>> I could do that but then there is no way for users to have any other color but "white" with this driver.
>> That defeats the purpose of the device itself.
> 
> No, that is not what I meant.
> 
> We do have RGB drivers in tree, they just present three separate LEDs
> -- red, green and blue. I ask you to do the same for initial
> submission.
> 

For clarification you are asking me to register a LED class per output pin?

If that is not you mean can you point me to an example because looking through the code I see the
lp5562, bd2802 and lp3944 of which none are equivalent to the LP50xx devices.  Each one
of those devices have a dedicated register per LED output which makes perfect sense to do what
you are asking.

If it is what you are asking then this was already explained and it was agreed in the email chain to provide
a Class with a "brightness" file that maps to the Master brightness register and
the "color" file that would map to the respective color control register.
These registrations would be per LED Module output and Banked output and not per LED output.

RED LED Color Control Register------|					 |------| RED LED OUTPUT
Green LED Color Control Register----|--- LED Master Brightness register--|------| Green LED OUTPUT
Blue LED Color Control Register-----|					 |------| Blue LED OUTPUT

As explained before the Master brightness register has absolute control over the output current
to the LED outputs regardless of the color control setting.

> You'll still be able to set brightness independently on the
> red/green/blue LEDs...
> 

But which one would control the overall brightness of the cluster?

Dan

>> I am not sure if you are aware of this or care but I found this recent blog on this effort:
>> https://www.phoronix.com/scan.php?page=news_item&px=Linux-RGB-LED-Interface
>> See some of the comments.
> 
> I went through the comments quickly, but see nothing really
> interesting.
> 
> Best regards,
> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
