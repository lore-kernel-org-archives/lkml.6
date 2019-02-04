Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBEAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715F42080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jiklRi5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfBDR5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:57:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDR5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7tshRj6Lu3Pz8wo7ULj2GmKAvIvCz7rT4v4mw0bBty8=; b=jiklRi5EwrqrwZX8sZM5Vg7Ce
        bPdO/1fNo2iNpFyreky7NGWyn3TZzXhRZRLeGq17/jKwsKdreGKnILMtplqRwBYW5iACHwhVF9wJQ
        aFWwN93/HuhuL5YpA0tnsAk7Nd/XXFYIDMVhmniecobAZ497tM1XscF590y9+hr1xc7DYpVxQlJk1
        9yx0Pgze9dVP7k+9Ci/SdvMq5/KJ1wT07FUS6jRZ8xlNbpBcO6wtyTdsrb4PfcU5btKSsSPvaCXZT
        CNyH8fZ6GfRs17m1u/cT8wCRB7ycQTIou/OETg/ucuZo0SXS8V/H70OdRPqDvV22QFIdbyR1ACAUQ
        +paxOYNnw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqiUP-0002mL-1j; Mon, 04 Feb 2019 17:57:01 +0000
Subject: Re: Build regressions/improvements in v5.0-rc5
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20190204134234.13636-1-geert@linux-m68k.org>
 <33e58393-97f1-321e-5ee0-a1242c7c7a26@infradead.org>
Message-ID: <5ccff302-3986-5892-d072-5c334484f990@infradead.org>
Date:   Mon, 4 Feb 2019 09:57:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <33e58393-97f1-321e-5ee0-a1242c7c7a26@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 9:46 AM, Randy Dunlap wrote:
> On 2/4/19 5:42 AM, Geert Uytterhoeven wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v5.0-rc5[1] compared to v4.20[2].
>>
>> Summarized:
>>   - build errors: +2/-4
>>   - build warnings: +113/-14843
>>
>> JFYI, when comparing v5.0-rc5[1] to v5.0-rc4[3], the summaries are:
>>   - build errors: +0/-0
>>   - build warnings: +56/-59
>>
>> Note that there may be false regressions, as some logs are incomplete.
>> Still, they're build errors/warnings.
>>
>> Happy fixing! ;-)
>>
>> Thanks to the linux-next team for providing the build service.
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8834f5600cf3c8db365e18a3d5cac2c2780c81e5/ (238 out of 240 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8fe28cb58bcb235034b64cbbb7550a8a43fd88be/ (all 240 configs)
>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f17b5f06cb92ef2250513a1e154c47b78df07d40/ (238 out of 240 configs)
>>
>>
>>
>> *** WARNINGS ***
>>
>> 113 warning regressions:
> 
>>   + warning: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS:  => N/A
> 
> Hi Geert,
> 
> I am trying to find the above warning (needle) in the haystack.
> Can you please direct me to which config/build it is in?
> 
> Is there a good way for me to find it?
> 
> thanks.
> 

Working backwards, it probably comes from this:

config CURRITUCK
	bool "IBM Currituck (476fpe) Support"
	depends on PPC_47x
	select SWIOTLB
	select 476FPE
	select PPC4xx_PCI_EXPRESS

This is the only similar Kconfig segment that does not select FORCE_PCI
but PPC4xx_PCI_EXPRESS depends on PCI but
# CONFIG_PCI is not set

This could be related to a recent series of patches that allows ACPI to
be built without having PCI enabled.

Michael?

-- 
~Randy
