Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF0C20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s4toArgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbeLSWJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:09:04 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47992 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeLSWJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:09:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJM8wWg054279;
        Wed, 19 Dec 2018 16:08:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545257338;
        bh=W3EEFYV+J3vUW/Ks/s4mmOj3yL7xFlZ5v9QVFnBbeis=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s4toArgFJE54MwkvaNIxn8HmSM9Pqg+hOx1kEd9MttMiI3GEamWBud8C6iX/UPZCx
         LbZxfUJfML/q/nl81K7EgPgXOpjl3SUwmlx6KNhdZe6a3NP2a1u/EZjNV17FlYHOWa
         jrU7vqHG4neFGkRD21e00kRJpO/76UfkD5Jxz3t8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJM8wH6117899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 16:08:58 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 16:08:58 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 16:08:58 -0600
Received: from [172.22.106.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJM8wLZ026476;
        Wed, 19 Dec 2018 16:08:58 -0600
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com> <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com> <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com> <20181219220326.GA28244@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <a3214ab3-9281-19d6-7fcc-5abae9a60ebd@ti.com>
Date:   Wed, 19 Dec 2018 16:08:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181219220326.GA28244@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/2018 04:03 PM, Pavel Machek wrote:
> Hi!
> 
>>> I don't think a user needs nor would want to have 24 different LED nodes with 24 different brightness files.
>>> Or with the LP5036 that would have 36 LED nodes.
>>>
>>> Table 1 in the data sheet shows how the outputs map to the control banks to the LED registers.
>>
>> Some time ago we had discussion with Vesa Jääskeläinen about possible
>> approaches to RGB LEDs [0]. What seemed to be the most suitable
>> variation of the discussed out-of-tree approach was the "color" property
>> and array of color triplets defined in Device Tree per each color.
>>
>> Please refer to [0] for the details.
>>
>> [0] https://lkml.org/lkml/2018/11/9/938
> 
> Yes, plus I also have the set of HSV patches somewhere... and they
> work, but I found out that HSV->RGB conversion results in loss of precision.
> 
> We may want to do something like that.
> 
> But we need to do it once, in a driver core. We obviously don't want
> each driver having different version of RGB support.

True.  But the RGB driver really should not be defining the color palette.

Maybe a "color capability" reported to user space so that the user space can make the decision.

It can report

For GPIO or constant current situations
static red
static blue
static green 

For adjustable configurations it can report:
variable red
variable blue
variable green

or even simpler "static" or "dynamic" as a return to report the RGB configuration.
The LED driver would just need to set the variable.

Dan

> 
> Best regards,
> 									Pavel
> 


-- 
------------------
Dan Murphy
