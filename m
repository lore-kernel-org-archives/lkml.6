Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2591C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DD220823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lHtn4Iux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfBFU5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:57:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfBFU5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LaAAoEOE7jc7juGzKjfulVEaVqpDUXbt3XIRNzLGhwM=; b=lHtn4IuxC/u35lBEGZKEIq18e
        lsfupS2+XRH/Y0FgQXp5N99i/XA6q4TjR3T2hAkgrb7g3ZOuRyzHMlygLy6hR6+Srqb5UjYog8onG
        mlq69pXHUhtHGcdgnqPPvXFJFsHYswZFceNWyj056A+v0YDDG8zq+XiNLK7iEk4+unfxxsJLd9hAj
        ZlGf69Xd+i4bZ9QMZ6r1WnfyFhiyIYPwEyvezO1VUSs1qlde4J8Me+oqERbqFgSVrqewG8i1ktsC9
        24OJERA8d3x16/81ys9auPjeo1ZDmpsW73GEH8Unhztgon9YVUFc0JHF6eqW8IsSIgFqRqQ0WIwom
        vxGl40b2Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grUGL-0004XN-8X; Wed, 06 Feb 2019 20:57:41 +0000
Subject: Re: Build regressions/improvements in v5.0-rc5
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <20190204134234.13636-1-geert@linux-m68k.org>
 <33e58393-97f1-321e-5ee0-a1242c7c7a26@infradead.org>
 <5ccff302-3986-5892-d072-5c334484f990@infradead.org>
 <87zhr9kza2.fsf@concordia.ellerman.id.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fba03b4d-0086-21f9-d38c-3e22d44b5ce3@infradead.org>
Date:   Wed, 6 Feb 2019 12:57:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <87zhr9kza2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 2:05 AM, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
>> On 2/4/19 9:46 AM, Randy Dunlap wrote:
>>> On 2/4/19 5:42 AM, Geert Uytterhoeven wrote:
>>>> Below is the list of build error/warning regressions/improvements in
>>>> v5.0-rc5[1] compared to v4.20[2].
>>>>
>>>> Summarized:
>>>>   - build errors: +2/-4
>>>>   - build warnings: +113/-14843
>>>>
>>>> JFYI, when comparing v5.0-rc5[1] to v5.0-rc4[3], the summaries are:
>>>>   - build errors: +0/-0
>>>>   - build warnings: +56/-59
>>>>
>>>> Note that there may be false regressions, as some logs are incomplete.
>>>> Still, they're build errors/warnings.
>>>>
>>>> Happy fixing! ;-)
>>>>
>>>> Thanks to the linux-next team for providing the build service.
>>>>
>>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8834f5600cf3c8db365e18a3d5cac2c2780c81e5/ (238 out of 240 configs)
>>>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8fe28cb58bcb235034b64cbbb7550a8a43fd88be/ (all 240 configs)
>>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f17b5f06cb92ef2250513a1e154c47b78df07d40/ (238 out of 240 configs)
>>>>
>>>>
>>>>
>>>> *** WARNINGS ***
>>>>
>>>> 113 warning regressions:
>>>
>>>>   + warning: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS:  => N/A
>>>
>>> Hi Geert,
>>>
>>> I am trying to find the above warning (needle) in the haystack.
>>> Can you please direct me to which config/build it is in?
>>>
>>> Is there a good way for me to find it?
>>>
>>> thanks.
>>>
>>
>> Working backwards, it probably comes from this:
>>
>> config CURRITUCK
>> 	bool "IBM Currituck (476fpe) Support"
>> 	depends on PPC_47x
>> 	select SWIOTLB
>> 	select 476FPE
>> 	select PPC4xx_PCI_EXPRESS
>>
>> This is the only similar Kconfig segment that does not select FORCE_PCI
>> but PPC4xx_PCI_EXPRESS depends on PCI but
>> # CONFIG_PCI is not set
>>
>> This could be related to a recent series of patches that allows ACPI to
>> be built without having PCI enabled.
>>
>> Michael?
> 
> There isn't really an easy way to do it sorry.
> 
> If you download the page for the revision:
>   http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8834f5600cf3c8db365e18a3d5cac2c2780c81e5/
> 
> With a lot of grep/sed/awk you can get a list of the URLs for all the
> builds eg. one would be:
> 
>   http://kisskb.ellerman.id.au/kisskb/buildresult/13676551/
> 
> And then you can just tack on "log/" to get:
> 
>   http://kisskb.ellerman.id.au/kisskb/buildresult/13676551/log/
> 
> Which you can wget and grep.
> 
> But that's all a bit of a pain.
> 
> I have on my todo list to add json formatted build results and revision
> pages, which would make it quite a bit simpler. But of course I haven't
> had time to do it yet :/

No problem.

However, I was trying to ask you about the kconfig problem above:

>>>>   + warning: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS

and not the "search the build results" problem.  ;)


-- 
~Randy
