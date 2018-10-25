Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7502EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDA02084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDA02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJZCf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:35:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44328 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJZCf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:35:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9PI212c099845;
        Thu, 25 Oct 2018 13:02:01 -0500
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9PI21Hd082512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 13:02:01 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 25
 Oct 2018 13:02:01 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 25 Oct 2018 13:02:01 -0500
Received: from [172.22.66.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9PI20hj005370;
        Thu, 25 Oct 2018 13:02:01 -0500
Subject: Re: [PATCH v4 5/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3633
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <lee.jones@linaro.org>,
        <tony@atomide.com>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-5-dmurphy@ti.com> <20181024092328.GD24997@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <57f73b8f-3eab-642d-5b4e-c7c6c890006b@ti.com>
Date:   Thu, 25 Oct 2018 13:01:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024092328.GD24997@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 10/24/2018 04:23 AM, Pavel Machek wrote:
> On Tue 2018-10-23 12:06:21, Dan Murphy wrote:
>> The LM3633 is a single function LED driver. The single function LED
>> driver needs to reside in the LED directory as a dedicated LED driver
>> and not as a MFD device.  The device does have common brightness and ramp
>> features and those can be accomodated by a TI LMU framework.
>>
>> The LM3633 dt binding needs to be moved from the ti-lmu.txt and a dedicated
>> LED dt binding needs to be added.  The new LM3633 LED dt binding will then
>> reside in the Documentation/devicetree/bindings/leds directory and follow the
>> current LED and general bindings guidelines.
> 
> What?
> 
>>  .../devicetree/bindings/leds/leds-lm3633.txt  | 102 ++++++++++++++++++
>>  .../devicetree/bindings/mfd/ti-lmu.txt        |  48 ---------
>>  2 files changed, 102 insertions(+), 48 deletions(-)
>>  create mode 100644
>>  Documentation/devicetree/bindings/leds/leds-lm3633.txt
> 
>> index 920f910be4e9..573e88578d3d 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> @@ -7,7 +7,6 @@ TI LMU driver supports lighting devices below.
>>    LM3532       Backlight
>>    LM3631       Backlight and regulator
>>    LM3632       Backlight and regulator
>> -  LM3633       Backlight, LED and fault monitor
>>    LM3695       Backlight
> 
> Are you seriously proposing to take one binding and split it into 6
> copy&pasted ones?

No that is not what I am proposing.  And never have.  I support keeping the MFD
devices in the MFD directory and only pulling out the single function devices as we have
debated over and over again.

> 
> That's not the way we do development. NAK.
> 
> We don't want to have copy & pasted code. We also don't want to have
> copy & pasted bindings. Nor changelogs, for that matter.
> 

Change was copy and pasted don't know why I need to rephrase the same exact
change only for a different part but I can modify it.

I do see what I can update here.  As you said I will fix up the ti-lmu binding in
such a way that the dedicated LED driver bindings point to the common binding for the TI-LMU
framework.

Dan

> Thank you,
> 								Pavel
> 


-- 
------------------
Dan Murphy
