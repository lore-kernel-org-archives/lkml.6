Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B68E20645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SbzsC7GQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B68E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeJCStF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:49:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33408 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeJCStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:49:05 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w93C0pSH010552;
        Wed, 3 Oct 2018 07:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538568051;
        bh=ye2XyGfY17A4A3VADPys3W4aiEpWYEcRD6tBsYvGDQI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SbzsC7GQD7N1A1Cnk/2bBqLGf9DKj8OuOtS/laWtuK3B25KU8szkmY8olpmLyo5T1
         bvBvrPrtE09iZ+E7eRd/kglbASnVfumZiIjTML1IMVNf7zxhlbc36tRuhxZcQgMI/B
         ey0KwFauoWc72RvlME1/PZdQu+iUq2blVoB5ck78=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93C0pKC010116;
        Wed, 3 Oct 2018 07:00:51 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 07:00:51 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 07:00:51 -0500
Received: from [172.22.137.207] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93C0pGh008562;
        Wed, 3 Oct 2018 07:00:51 -0500
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux-omap@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com> <20181002075629.GB19677@amd>
 <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
 <0be423a9-174c-60ce-0c67-7193c6af3063@gmail.com> <20181002220754.GA20413@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6f96a5bd-27df-7906-73bf-67bdf848308a@ti.com>
Date:   Wed, 3 Oct 2018 07:00:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002220754.GA20413@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 10/02/2018 05:07 PM, Pavel Machek wrote:
> Hi!
> 
>>> We have debated this over and over and now we have 3 different implementations
>>> available we need to collude on which one we want to support.
>>>
>>> Jacek I defer to you and Pavel since you are both LED maintainers.
>>>
>>> I can support the dedicated LED drivers but I cannot support the TI LMU only implementation.
>>
>> I uphold my previous opinion - please go ahead with moving the support
>> for non-MFD devices from MFD subsystem to the LED subsystem. And yes -
>> along with the bindings. This is semantically correct, and yet we don't
>> have mainline users.
>>
>> Pavel - you will have to engage more people for your crusade to prevail.
>> For now, to speed up the things, I am forced to ignore your NAK.
>> So NAK to your NAK. Sorry.
> 
> No need to be sorry :-).
> 
> Lets ignore the code for now, as code can be changed easily.
> 
> Bindings are not something you or I maintain, so we don't have final
> word there, and I have feeling this is not going to go past device
> tree maintainers. [AFAICT: you can move binding in Documentation/ to
> different place, that's not a problem; but creating a new binding when
> old one exists is.]
> 
> If you and Dan feel that is okay, you are welcome to try to get the
> patches past Rob, just please retain the NAK so that he remembers the
> discussion, and so that it is clear that I don't like the changes.
> 
> I believe smart thing to do is to try to do that before working
> further on the code, but of course, its all up to you :-).

I was looking for the review for the ti-lmu.txt binding on patchworks to see what
the comments were on the review or any explanation from reviewers to
why this implementation was done in the MFD.

Maybe there is some historical context that needs to be learned from here from
1.5 years ago.

I cannot seem to find any review posted in the patchworks archive.
I see reviews posted for the ti-lmu-backlight binding but none from
the ti-lmu.txt base binding.

Does anyone have a reference to the review?

If there is no review then I am wondering how this binding was accepted.
If there is no review and no current users then I would think that binding
 modification should be allowed.  But thats just my opinion.

Dan


> 
> Friends,
> 									Pavel
> 


-- 
------------------
Dan Murphy
