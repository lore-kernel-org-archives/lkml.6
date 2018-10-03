Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DEA20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EhtCWmfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DEA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJCS7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:59:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48420 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeJCS7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:59:22 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w93CB4Ku047882;
        Wed, 3 Oct 2018 07:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538568664;
        bh=xhZe2PuM4ERqpcJDOWcrx3c3OiW+efa+nlrqX25AuL8=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=EhtCWmfCLdfqjQHUwr+Uk9rIeiOsnuWiy7xV5RO76welLps2/PhS3eNSZqMcJp71M
         IX/8ug3OMbjDNW34cm3V7uZOQdKBFIQyrQqafxb0T30bzX7ukmPzom9Jt6D4UBtnC1
         MPG6LH8yWIQv693c1OL+ZXUXT/HCJLo9+ShSHg+0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93CB40X032692;
        Wed, 3 Oct 2018 07:11:04 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 07:11:04 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 07:11:04 -0500
Received: from [172.22.137.207] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93CB3EF027502;
        Wed, 3 Oct 2018 07:11:03 -0500
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
From:   Dan Murphy <dmurphy@ti.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux-omap@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Lee Jones <lee.jones@linaro.org>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com> <20181002075629.GB19677@amd>
 <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
 <0be423a9-174c-60ce-0c67-7193c6af3063@gmail.com> <20181002220754.GA20413@amd>
 <6f96a5bd-27df-7906-73bf-67bdf848308a@ti.com>
Message-ID: <b8f8c1e2-64fb-57ea-4b48-1e4738e9cb6b@ti.com>
Date:   Wed, 3 Oct 2018 07:10:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6f96a5bd-27df-7906-73bf-67bdf848308a@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 10/03/2018 07:00 AM, Dan Murphy wrote:
> Hello
> 
> On 10/02/2018 05:07 PM, Pavel Machek wrote:
>> Hi!
>>
>>>> We have debated this over and over and now we have 3 different implementations
>>>> available we need to collude on which one we want to support.
>>>>
>>>> Jacek I defer to you and Pavel since you are both LED maintainers.
>>>>
>>>> I can support the dedicated LED drivers but I cannot support the TI LMU only implementation.
>>>
>>> I uphold my previous opinion - please go ahead with moving the support
>>> for non-MFD devices from MFD subsystem to the LED subsystem. And yes -
>>> along with the bindings. This is semantically correct, and yet we don't
>>> have mainline users.
>>>
>>> Pavel - you will have to engage more people for your crusade to prevail.
>>> For now, to speed up the things, I am forced to ignore your NAK.
>>> So NAK to your NAK. Sorry.
>>
>> No need to be sorry :-).
>>
>> Lets ignore the code for now, as code can be changed easily.
>>
>> Bindings are not something you or I maintain, so we don't have final
>> word there, and I have feeling this is not going to go past device
>> tree maintainers. [AFAICT: you can move binding in Documentation/ to
>> different place, that's not a problem; but creating a new binding when
>> old one exists is.]
>>
>> If you and Dan feel that is okay, you are welcome to try to get the
>> patches past Rob, just please retain the NAK so that he remembers the
>> discussion, and so that it is clear that I don't like the changes.
>>
>> I believe smart thing to do is to try to do that before working
>> further on the code, but of course, its all up to you :-).
> 
> I was looking for the review for the ti-lmu.txt binding on patchworks to see what
> the comments were on the review or any explanation from reviewers to
> why this implementation was done in the MFD.
> 
> Maybe there is some historical context that needs to be learned from here from
> 1.5 years ago.
> 
> I cannot seem to find any review posted in the patchworks archive.
> I see reviews posted for the ti-lmu-backlight binding but none from
> the ti-lmu.txt base binding.
> 
> Does anyone have a reference to the review?

I found the review or at least the reference for the ti-lmu.txt binding.

https://lore.kernel.org/patchwork/patch/764180/

Does not appear that the binding was sent to the device tree mail list.
(Maybe that email list did not exist in Feb 2017).
Especially with the amount of change that is being submitted in the
newer patchsets.

Dan

> 
> If there is no review then I am wondering how this binding was accepted.
> If there is no review and no current users then I would think that binding
>  modification should be allowed.  But thats just my opinion.
> 
> Dan
> 
> 
>>
>> Friends,
>> 									Pavel
>>
> 
> 


-- 
------------------
Dan Murphy
