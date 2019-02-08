Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CADC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C3E20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e/e3aXFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfBHQzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:55:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39630 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfBHQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:55:23 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18GtHhO076694;
        Fri, 8 Feb 2019 10:55:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549644917;
        bh=H7+hhsGxj/YT0EJAAWQuJRhFHIY1pu+0A0dgS6/Kddo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e/e3aXFf7MebVhQ9fEsFEFSnftLQGLPR/07liSF1MBDJbZyJ7rUlmNa1/pzQ6VBfP
         2hUuXsyR2dUwMfFr/skSj+psoXkVl19VGHbjmxMJO76pqGU3hIgrB4jLeflCLWbUQP
         63/rElzt79giKFmBVVlgkO/g57Yk2PZa2mDVNYIU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18GtHcR088529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 10:55:17 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 10:55:16 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 10:55:16 -0600
Received: from [172.22.111.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18GtGrc000335;
        Fri, 8 Feb 2019 10:55:16 -0600
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190130183005.833-1-dmurphy@ti.com> <20190130223542.GA22040@amd>
 <6afa674b-9c4e-2568-c758-030e93aebd06@gmail.com>
 <6d50b09c-87be-d48f-cfe5-f5143c18d38c@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <cf99d7f3-5e79-bd18-094f-54efca5f576c@ti.com>
Date:   Fri, 8 Feb 2019 10:55:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <6d50b09c-87be-d48f-cfe5-f5143c18d38c@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Veas

On 2/7/19 11:09 PM, Vesa Jääskeläinen wrote:
> Hi All,
> 
> On 08/02/2019 6.55, Vesa Jääskeläinen wrote:
>> Hi All,
>>
>> On 31/01/2019 0.35, Pavel Machek wrote:
>>> On Wed 2019-01-30 12:30:05, Dan Murphy wrote:
>>>> Add a documentation of LED Multicolor LED class specific
>>>> sysfs attributes.
>>>
>>> No, sorry. This does not most of the requirements.
>>>
>>>                                 Pavel
>>>
>>> Requirements for RGB LED interface:
>>
>> ...
>>
>> I have tried to capture relevant parts of ideas and requirements and usage in a wiki page in github:
>>
>> https://github.com/vesajaaskelainen/linux-multicolor-leds/wiki
>>
>> I believe the discussion is good to perform in mailing list -- I am happy to update or give you access to update the wiki so we could have easy to use summary/details source during discussions.
>>
>> Ideas on the interface seem to be a bit drifting so I apologize if some of Your ideas were not captured.
>>
>> There has been at least two direct proposals for userspace interface and I tried to provide usage example also for Dan's proposal. Feel free to correct me if I made a mistake.
>>
>> I believe it is a good to create summary page as there seems to many aspects to be though out. What do you feel on this approach?
> 
> And should we perhaps move this discussion only to linux-leds mailing list for successive replies :) ? So we don't generate too broad traffic.
> 

Thank you for this.  I have posted updated documentation and posted updated code that includes a test file that does
nothing but register a dummy node.  This was tested on raspberry pi 5.0-rc kernel.

Also the code is updated for the LP50xx and a HACK for Droid4.

brightness-model is still an open topic on the best way to implement this so we have not introduced the code yet.

Here is the ABI doc
http://git.ti.com/gitweb/?p=ti-analog-linux-kernel/dmurphy-analog.git;a=blob;f=Documentation/ABI/testing/sysfs-class-led-multicolor;h=45629199791285200e3775fc0b4dde1dfebb130f;hb=ce08183aa24edc0d883550339eef93fd72b4ac45

Here is the class description
http://git.ti.com/gitweb/?p=ti-analog-linux-kernel/dmurphy-analog.git;a=blob;f=Documentation/leds/leds-class-multicolor.txt;h=357f045a826aac71d65704891c18e7fb31e5cb9b;hb=refs/heads/multicolor_class


Dan

> Thanks,
> Vesa Jääskeläinen


-- 
------------------
Dan Murphy
