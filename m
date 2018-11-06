Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BAAC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71AD2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71AD2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbeKGCKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:10:51 -0500
Received: from foss.arm.com ([217.140.101.70]:36932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387685AbeKGCKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:10:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F25FA78;
        Tue,  6 Nov 2018 08:44:48 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B22B3F5CF;
        Tue,  6 Nov 2018 08:44:47 -0800 (PST)
Subject: Re: linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576: possible cut'n'paste
 error
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     David Binderman <dcb314@hotmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR08MB3342D4ADBFBC43F2BE2FD34D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <20181106162014.GH30658@n2100.armlinux.org.uk>
 <77f6e853-2d6d-1149-f2f2-d23ddad6c611@arm.com>
 <20181106163959.GL30658@n2100.armlinux.org.uk>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <f03de303-041c-a183-40b8-6afc2a872af2@arm.com>
Date:   Tue, 6 Nov 2018 16:44:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181106163959.GL30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/18 16:39, Russell King - ARM Linux wrote:
> On Tue, Nov 06, 2018 at 04:29:54PM +0000, Julien Thierry wrote:
>> Hi Russel, David,
>>
>> On 06/11/18 16:20, Russell King - ARM Linux wrote:
>>> On Mon, Nov 05, 2018 at 01:53:13PM +0000, David Binderman wrote:
>>>> Hello there,
>>>>
>>>> 2nd try. Plain text might help.
>>>
>>> Yep, Linux kernel development generally doesn't like wasteful html
>>> emails, sorry.
>>>
>>>> linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576]: (warning) Redundant assignment of 'ufp_exc->fpinst2' to itself.
>>>>
>>>> Source code is
>>>>
>>>>         ufp_exc->fpexc = hwstate->fpexc;
>>>>         ufp_exc->fpinst = hwstate->fpinst;
>>>>         ufp_exc->fpinst2 = ufp_exc->fpinst2;
>>>
>>> Thanks for the report - it most certainly is a bug introduced by
>>> Julien's patches, but I don't get your warning here.  Which compiler
>>> produces that warning?
>>>
>>
>> Hmmm, silly typo/copy-paste from my end. Last line should be:
>>
>> 	ufp_exc->fpinst2 = hwstate->fpinst2;
>>
>> Sorry about that.
>>
>>> Julien - unfortunately, I've just asked Linus to take another fix
>>> for Spectre, so we're going to have to wait a bit before I can
>>> submit something for this.
>>>
>>
>> It is just a one line fix, should I submit a patch to the LAKML or patch
>> system?
> 
> Both I guess.
> 
>> Otherwise let me know when is it best for you to receive the fix then to
>> send to Linus.
> 
> As mentioned, I'll have to wait a while, it's not fair to send a pull
> request for one patch followed immediately by another pull request for
> another patch on top of the same pull request.
> 

Makes sense. I'll send the fix in a short time.

Thanks,

-- 
Julien Thierry
