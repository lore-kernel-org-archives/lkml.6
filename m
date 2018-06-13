Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E0F68C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE85208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H+S0U4is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE85208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935382AbeFMLP3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:15:29 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:36770 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934512AbeFMLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:15:27 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5DBFFrT008738;
        Wed, 13 Jun 2018 06:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528888515;
        bh=b/FR4SOZjL64r5pPsIvYIKUHAKFEzWAlETp7/bR3gT8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=H+S0U4ismyrG5dkIj0MTj3H9yRTnKFINCVxwojqdCvgozls6UlyL5yBkDeyJiirr8
         iI4FPIuN20UUdgOoJFBGXVNKVkrqPZ20+MxppDgXtqd9mU1ojB443b0avecxu4/Qkp
         QpKC07ezNTU6dR2ufHptTnc0PbarmuXHSFyhoHis=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5DBFFIm010342;
        Wed, 13 Jun 2018 06:15:15 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 13
 Jun 2018 06:15:14 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 13 Jun 2018 06:15:14 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5DBFCbC008145;
        Wed, 13 Jun 2018 06:15:12 -0500
Subject: Re: [PATCH 2/2] usb: dwc3: of_simple: don't call
 pm_runtime_set_active()
To:     Felipe Balbi <balbi@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        "Gerlach, Dave" <d-gerlach@ti.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1527518174-27860-1-git-send-email-rogerq@ti.com>
 <1527518174-27860-2-git-send-email-rogerq@ti.com>
 <87k1rlcok2.fsf@linux.intel.com>
 <d6015f73-358b-1f96-2682-8cbe2423960a@ti.com>
 <87bmcwcl1j.fsf@linux.intel.com>
From:   Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <4a4fd59c-84a6-61c6-5567-50660b07302a@ti.com>
Date:   Wed, 13 Jun 2018 14:15:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87bmcwcl1j.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/18 10:59, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
> 
>> On 30/05/18 15:31, Felipe Balbi wrote:
>>> Roger Quadros <rogerq@ti.com> writes:
>>>
>>>> Don't call pm_runtime_set_active() as it will prevent the device
>>>> from being activated in the next pm_runtime_get_sync() call.
>>>>
>>>> Also call pm_runtime_get_sync() before of_platform_populate().
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>
>>> This patch is wrong.
>>>
>>>> ---
>>>>  drivers/usb/dwc3/dwc3-of-simple.c | 7 +++----
>>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
>>>> index e98d221..2cbb5c0 100644
>>>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>>>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>>>> @@ -121,6 +121,9 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>>>>  	if (ret)
>>>>  		goto err_resetc_assert;
>>>>  
>>>> +	pm_runtime_enable(dev);
>>>> +	pm_runtime_get_sync(dev);
>>>
>>> No, this is the wrong way to do things. My device should be enabled
>>> already from probe, specially since I have already enabled clocks.
>>
>> As far as I understood just enabling clocks (which might not include bus clock)
>> doesn't ensure device is enabled.
>>
>> Did you mean that I don't need to do a pm_runtime_get_sync() to enable my device in probe?
>> Who is enabling by device for me then? Is device core supposed to do it?
> 
> Not device core, but the bus code. Look at how PCI handles it. IIRC,
> only TI's omap_device behaves peculiarly WRT probe & pm runtime.

PCI does it doesn't mean it is a rule that bus code has to enable the device before probe.
At least platform bus doesn't seem to do it as part of of_platform_populate().

see __device_attach() and driver_probe_device() in drivers/base/dd.c

It does a pm_runtime_get_sync() on dev->parent but not on dev.

Also, from section 5 of Documentation/power/runtime_pm.txt

"In addition to that, the initial runtime PM status of all devices is
'suspended', but it need not reflect the actual physical state of the device.
Thus, if the device is initially active (i.e. it is able to process I/O), its
runtime PM status must be changed to 'active', with the help of
pm_runtime_set_active(), before pm_runtime_enable() is called for the device."

"Note, if the device may execute pm_runtime calls during the probe (such as
if it is registers with a subsystem that may call back in) then the
pm_runtime_get_sync() call paired with a pm_runtime_put() call will be
appropriate to ensure that the device is not put back to sleep during the
probe. This can happen with systems such as the network device layer."

So looks like we can't assume that the device is "active" when probe() is called.
Which means, we need to do

pm_runtime_get_sync();
enable optional clocks;

pm_runtime_forbid(); if we don't yet want runtime suspend/resume.
OR
pm_runtime_put(); if we want runtime suspend/resume support.

I don't think we should be calling pm_runtime_set_active() as we can't be sure of the
initial state of the device for different buses.
> 
>> The issue I was facing is that without this patch my device wasn't being enabled
>> as pm_runtime_set_active() is being done _before_ pm_runtime_get_sync().
>> It could be an issue with the platform's PM domain code as well.
> 
> Could be
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
