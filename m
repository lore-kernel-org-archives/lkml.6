Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBFAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C0A21473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SALPKXYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfA2VrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:47:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39024 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfA2VrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:47:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0TLl1aG013190;
        Tue, 29 Jan 2019 15:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548798421;
        bh=fuSPMBPfAN+cmw7RT9nXyVON+64zu1s3qv+wdj10DRM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SALPKXYvL26IoVgFRF+vhan+IXHhcv2RXE0rpzAo/Oz4JSr8z5cyXhfclpib+lHXg
         md/9NWD1zZx++akRc5TXWfps6j9AuYMbktcXDrJcVroUMtE/ADuL6MH2hlbDAHt8NC
         Pk5p8hTTcc9ELsutGQg/UjAIcdi4xLRW/n46kew8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0TLl1Cw125411
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 15:47:01 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 29
 Jan 2019 15:47:00 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 29 Jan 2019 15:47:00 -0600
Received: from [172.22.85.211] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0TLl0sD004409;
        Tue, 29 Jan 2019 15:47:00 -0600
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
References: <4a20b14c-9514-25b8-affe-20f9ede4d4d8@ti.com>
 <8fac6aeb-28a8-d136-c654-9d1b5d4f7ddb@gmail.com>
 <27318c48-f84a-5129-ac88-545edd549101@gmail.com>
 <21d3e21a-e50e-ee46-6f81-5a22db878c15@ti.com>
 <1c7680d3-6926-d837-dcd9-254aca23df39@gmail.com>
 <3e804986-89ef-2465-51ad-86e793b39b7e@ti.com>
 <f7ad8d5a-2998-f6f0-be4b-b47237b3397f@gmail.com>
 <4d80cc7f-1f18-ec5b-d312-a6a0da2a4506@ti.com>
 <ca8b4251-afd4-ddde-96f2-6e3fc72e3b55@gmail.com>
 <a097bfc8-cdee-67bb-6c30-6a31142d01ab@ti.com> <20190129214513.GA8692@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <0dc95321-85cd-a1fe-cbf2-4b1f73c35b7e@ti.com>
Date:   Tue, 29 Jan 2019 15:46:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129214513.GA8692@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 1/29/19 3:45 PM, Pavel Machek wrote:
> Hi!
> 
> Could you, trim the parts of email you do not need in the reply? This
> is quite annoying to follow:
> 

Agreed.

> On Tue 2019-01-29 14:26:20, Dan Murphy wrote:
>> Jacek
>>
>> On 1/29/19 2:19 PM, Jacek Anaszewski wrote:
>>> Hi Dan,
>>>
>>> On 1/29/19 2:56 PM, Dan Murphy wrote:
>>>> Jacek
>>>>
>>>> On 1/24/19 3:55 PM, Jacek Anaszewski wrote:
>>>>> Dan
>>>>>
>>>>> On 1/24/19 10:00 PM, Dan Murphy wrote:
>>>>>> Jacek
>>>>>>
>>>>>> On 1/23/19 3:52 PM, Jacek Anaszewski wrote:
>>>>>>> Dan,
>>>>>>>
>>>>>>> On 1/22/19 11:44 PM, Dan Murphy wrote:
>>>>>>>> Jacek
>>>>>>>>
>>>>>>>> On 1/22/19 3:39 PM, Jacek Anaszewski wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> On 1/20/19 7:42 AM, Vesa Jääskeläinen wrote:
>>>>>>>>>> Hi Dan,
>>>>>>>>>>
>>>>>>>>>> On 18/01/2019 15.58, Dan Murphy wrote:
>>>>>>>>>>> Jacek
>>>>>>>>>>>
>>>>>>>>>>> On 1/18/19 7:45 AM, Dan Murphy wrote:
>>>>>>>>>>>> Jacek
>>>>>>>>>>>>
>>>>>>>>>>>> On 1/17/19 3:10 PM, Jacek Anaszewski wrote:
>>>>>>>>>>>>> Hi Dan,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 1/16/19 7:41 PM, Dan Murphy wrote:
>>>>>>>>>>>>>> Hello
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 1/16/19 4:55 AM, Pavel Machek wrote:
>>>>>>>>>>>>>>> Hi!
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 1/15/19 4:22 PM, Pavel Machek wrote:
>>>>>>>>>>>>>>>>> Hi!
>>>>>>>>>>>>>>>>>
> ...
> 
>>>> If this is OK I can post the patch with this update.
>>>>
>>>> But I would rather put the file creation in a class and have the colors directory.
>>>
>>> Yes, please post your work when it is ready.
>>
>> OK.  I will derive the class and try to post it by the EOW.
> 
> You can do that, but if you post the description of kernel<->user
> interface, first, you may save yourself a bit of coding...
> 

OK I will put together the interface doc first and push a RFC.
Then put some code together

Dan

> Thanks,
> 									Pavel
> 


-- 
------------------
Dan Murphy
