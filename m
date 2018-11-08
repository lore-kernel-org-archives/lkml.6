Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DEEECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FF62081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UemQzDjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FF62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeKIGpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:45:38 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57340 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeKIGpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:45:38 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8L842I102428;
        Thu, 8 Nov 2018 15:08:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541711284;
        bh=MlaUlKrjYIJefiXlZWY+jsWDZbVPJmf+oZrOCRLez64=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UemQzDjZ+UOw7ZjLBqKBMHCcmKqgMhH6+iAKI8G2Th02F8n9wgfIcr4w0UgyvqXvQ
         vf0809fEZFd1pKFwuzB4ZBwQSy1OH9nRh30IE3bK+tX7se7QuquFZ4vHHmRmD+zAan
         G3fJWclpDpek42/ufkJPytnko6s/eAzeYR15XI0I=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8L84fs005116
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 15:08:04 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 15:08:03 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 15:08:03 -0600
Received: from [172.22.187.225] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8L83oP028418;
        Thu, 8 Nov 2018 15:08:03 -0600
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <26714494-06f8-163d-1ef8-75f75c25a467@ti.com>
 <c650a9eb-afae-2a27-e39c-d448a5b3eadd@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <81884969-956c-9d21-4114-4cb10d1e90e3@ti.com>
Date:   Thu, 8 Nov 2018 15:08:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c650a9eb-afae-2a27-e39c-d448a5b3eadd@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 11/08/2018 02:47 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 11/08/2018 07:00 PM, Dan Murphy wrote:
>> Jacek
>>
>> On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
>>> Introduce dedicated properties for conveying information about
>>> LED function and color. Mark old "label" property as deprecated.
>>>
>>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>> Cc: Baolin Wang <baolin.wang@linaro.org>
>>> Cc: Daniel Mack <daniel@zonque.org>
>>> Cc: Dan Murphy <dmurphy@ti.com>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>>> Cc: Simon Shields <simon@lineageos.org>
>>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>>> ---
>>>  Documentation/devicetree/bindings/leds/common.txt | 52 +++++++++++++++++++----
>>>  1 file changed, 44 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
>>> index aa13998..3efc826 100644
>>> --- a/Documentation/devicetree/bindings/leds/common.txt
>>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>>> @@ -10,14 +10,20 @@ can influence the way of the LED device initialization, the LED components
>>>  have to be tightly coupled with the LED device binding. They are represented
>>>  by child nodes of the parent LED device binding.
>>>  
>>> +
>>>  Optional properties for child nodes:
>>>  - led-sources : List of device current outputs the LED is connected to. The
>>>  		outputs are identified by the numbers that must be defined
>>>  		in the LED device binding documentation.
>>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
>>> +	    from the header include/dt-bindings/leds/functions.h.
>>> +	    If there is no matching LED_FUNCTION available, add a new one.
>>> +- color : Color of the LED.
>>
>> Should we define the colors too?  There are only really 4.  Red, green, blue and white.
>>
>> Generally varying colors are created base on the primary colors.  Even the amber color
> 
> No problem, I can add LED colors. However, I don't quite follow how
> the mix of base color strings would give "amber" ? :-)
> 

Amber or yellow.  Red and green with a hint of blue or no blue depending on how dark you want it.

You don't always have to turn the LED on full to mix.  Sometimes lowering the level of the stronger colors like red 
and upping weaker colors like green you can different color

Dan

-- 
------------------
Dan Murphy
