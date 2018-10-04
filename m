Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBE2C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127FA2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RT/zZoID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127FA2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJDUUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:20:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56490 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeJDUUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:20:19 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94DQtUd034144;
        Thu, 4 Oct 2018 08:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538659615;
        bh=GDXwjCNTID0IvHwglAz4GPWyhAy/bhG7BIv1S2DstWY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RT/zZoIDEF99NOoaU1fkbXFyldhN/RA2pDLXbJ4U0oUELy3uwD+wmZYH6Iau9KQvF
         c1bGqSdRXediSsfHgb671KzJVJxYmwoXBSVoCySPwzxJqzJmP9iutumWFzO1ygNsXP
         ndUn+XiGj4OlchhsRAtyD0XU2m5czWtVxtAYX99A=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94DQtBp004948;
        Thu, 4 Oct 2018 08:26:55 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 08:26:55 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 08:26:55 -0500
Received: from [172.22.163.235] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94DQtQq008161;
        Thu, 4 Oct 2018 08:26:55 -0500
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux-omap@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-3-dmurphy@ti.com> <20181002072827.GA19677@amd>
 <fef2c612-ac35-126e-669e-335fb3075f64@ti.com> <20181003130154.GA20418@amd>
 <f4ed1450-6c99-e4c6-0092-f355ab3278f7@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e14aeedb-e58b-f3e0-72f6-2bfb04a29e3c@ti.com>
Date:   Thu, 4 Oct 2018 08:26:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f4ed1450-6c99-e4c6-0092-f355ab3278f7@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 10/03/2018 03:46 PM, Jacek Anaszewski wrote:
> On 10/03/2018 03:01 PM, Pavel Machek wrote:
>> On Wed 2018-10-03 07:24:23, Dan Murphy wrote:
>>> Hello
>>>
>>> On 10/02/2018 02:28 AM, Pavel Machek wrote:
>>>> On Fri 2018-09-28 13:29:47, Dan Murphy wrote:
>>>>> Remove support for the LM3697 LED device
>>>>> from the ti-lmu.  The LM3697 will be supported
>>>>> via a stand alone LED driver.
>>>>>
>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>
>>>> NAK, for reasons I explained before. Please add it to the patch so
>>>> that it does not get applied by mistake. Ouch and AFAICT Rob was not
>>>> happy with this either.
>>>>
>>>> Yes, you are creating new drivers, ok; but that does _not_ mean you
>>>> should create new binding.
>>>
>>> I am copying my comment here on the review of this original binding for
>>> records
>>>
>>> I found the review or at least the reference for the ti-lmu.txt binding.
>>>
>>> https://lore.kernel.org/patchwork/patch/764180/
>>>
>>> Does not appear that the binding was sent to the device tree mail list.
>>> (Maybe that email list did not exist in Feb 2017).
>>
>> Quick google shows:
>>
>> https://lwn.net/Articles/666023/
> 
> This link refreshed my memory and allowed me to recall Milo's patch set
> from the end of 2015, and the related discussion. I had an impression
> that I had had some request regarding the bindings but there was no
> follow-up.
> 
> I've googled that thread [0] and it proved I was right [1].
> 
> From Milo's messages we can infer that there will be next
> version of the patch set and it appeared but over a year later [2],
> and without the leds-lm3633 driver and related bindings, and without
> drivers/video/backlight/ti-lmu-backlight-core.c.
> 
> Patch set gets merged despite dangling DT references.
> 
> Dan, I propose you to resend the patch removing the bindings from
> MFD, and explain the rationale in the patch below commit message
> after "---" .
> 
>> Now can we stop this nonsense? If there is a problem with the binding,
>> submit patches to fix the problem.
> 
> [0]
> https://lore.kernel.org/lkml/1448521025-2796-1-git-send-email-milo.kim@ti.com/
> [1] https://lore.kernel.org/lkml/56656468.8020300@samsung.com/
> [2]
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1341860.html
> 

Sounds good I will clean this up and submit a v3 non-RFC edition

Dan

-- 
------------------
Dan Murphy
