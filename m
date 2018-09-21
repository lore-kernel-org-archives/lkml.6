Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D3AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5186F206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A4ydsM++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5186F206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389683AbeIUSdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:33:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60074 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbeIUSdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:33:09 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LCiIC3063129;
        Fri, 21 Sep 2018 07:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537533859;
        bh=RrJgsigsRqZ5+kY2WBYBqcFtOdKxa65nus+h2sXqqt0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=A4ydsM++A3gHuxl+Pg/7RaueAKd/GZ6eHUT8DMndjVYTj0OiYTJevmE7mZwRQ+e0e
         rm8lE9vueZD2yOiVeyB5WISIlm+c6Y2tQ6j+CuBYQ1gEJ3oJQ75/2eEcBxSiqmpgeZ
         3TTvykuHFMewsiCTiBdfQIe9i78DFuh8E9hlGAQU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LCiI1G013436;
        Fri, 21 Sep 2018 07:44:18 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 07:44:18 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 07:44:18 -0500
Received: from [172.22.169.25] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LCiI3j018666;
        Fri, 21 Sep 2018 07:44:18 -0500
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux-omap@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20180911170825.17789-2-dmurphy@ti.com>
 <20180911200530.GA28290@amd> <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
 <20180912214938.GA30654@amd> <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
 <20180914081822.GA21830@amd> <9c14ee7c-f172-bb0c-d9a8-8aeee408f716@gmail.com>
 <20180914214220.GA2081@amd> <be2ee681-7ae0-6545-0208-6ae5c1b7affd@gmail.com>
 <5a249ae3-e3f7-8eff-4022-ed982e364326@ti.com>
 <20180920220443.GB27468@xo-6d-61-c0.localdomain>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <50e9aa50-99fb-0a1f-e395-c52bf91e8a7f@ti.com>
Date:   Fri, 21 Sep 2018 07:44:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920220443.GB27468@xo-6d-61-c0.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 09/20/2018 05:04 PM, Pavel Machek wrote:
> Hi!
> 
>>>>> Easy to maintain will be a dedicated LED class driver.
>>>>
>>>> You mean, 3 dedicated LED class drivers and 3 MFD drivers with LED
>>>> parts? We'll need complex driver anyway, and I'd really like to have
>>>> just one.
>>>
>>> In the LED subsystem we can wrap common functionalities
>>> into a library object. MFD driver will be able to reuse it then.
>>
>> I am currently working on that code now.  I expect a RFC on this this week.
> 
> Looking forward to that.
> 
> But you really need acks for the bindings, and since Rob is usually quite slow
> acking them, it is easiest to use the existing binding... if it is wrong it
> needs to be fixed, anyway.
> 

OK I am in the midst of creating the code now. I have the common code done I just need to
make sure that it scales to other devices in the list.

The bindings will need to be updated to follow the LED bindings binding style.

I am wondering for the non-MFD parts if we should move the bindings to the LED
directory to make them easier to find.

Dan 

> THanks,
> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
