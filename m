Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6F8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5630B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5q4y7x8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeLQNqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:46:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40112 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeLQNqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:46:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so6402619pfo.7;
        Mon, 17 Dec 2018 05:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2uEjPQuS0HLTi1XjBlP1UfFHbWYKDzx11LLrTyQE7zw=;
        b=C5q4y7x8GMdKMrygxbCEP3dLIXY7/q+cRSQMU3k7eeoxKGQVgGSuFjGtcE97Yw0aLs
         Nrp1E+EbWv0jY3dawd4+huExA3C1KGVzv6ltaJFYJ/yd/xeDUOKDb03vYrv7/kAf58Wp
         EkjmGQFlNbuY53x6AJDdA0xckDgg2mtO833MODjtSl2F23gR6mydd739Ifo6S6+ZncqG
         3q2XExjJMb1gjWpruiDF8nJ1o9XpkpIEz3MsdQjBAFvo3eUmKdfKtXvOPmVVzer0ujb6
         ibQ0nIzH+uTUXqgicLdRBSb80XOcgVRTsVzkyAOUmd7oJd2+xQGBGoeOS1oa3FsK7FSN
         RX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2uEjPQuS0HLTi1XjBlP1UfFHbWYKDzx11LLrTyQE7zw=;
        b=pqtS5qWqJloKlr+08cDOX2Xk0fKzun+dgocPnG7VrkVvb1riEi2DQPYyAISPaSIld1
         ykt+ajLNFZBdsGedJTkmePREjeQXdvjh+LRPoYE3Ti12JysTCoI6Smp2MMjgjmHnSoZT
         ct2dmbd38jrFC6zZ+IREzD+h4hwy1cj1dHUt5zWj6OWsP5YO86jGjuZxBW1huxpucUMs
         LG+zP1MJnNWqlwpMIt8bPYtOCzKSrIA0Ib3ji/Vgc/7JNnpiRDmYn5vP19nYGd8k41vr
         sT/uP9QWORIpQroxRRH2cUw6HFSBVPPOXdY+bl1bYdqWUl6gs7UnTSa1oU03qke5IbOH
         Vmfw==
X-Gm-Message-State: AA+aEWZfAvKraioMC3yAwKvsBYuaYwDtxfaaQIe9pl5475mmDGnTt+Ck
        Q6WWwq4DbC9GMQtYLyP1aXGDelik
X-Google-Smtp-Source: AFSGD/XbblPY8X5ZBJXE/gZLJvFEL4m5k6KUGiBGMuzP2TqUbuJSs2otS/33p++05LX7mGBWTOIRPw==
X-Received: by 2002:a63:2315:: with SMTP id j21mr12344232pgj.297.1545054364442;
        Mon, 17 Dec 2018 05:46:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n7sm21049230pff.36.2018.12.17.05.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 05:46:02 -0800 (PST)
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20181214115702.151309521@linuxfoundation.org>
 <dfd49bfd-359a-7f5e-8332-5e6ad6da21cd@roeck-us.net>
 <20181215080729.GG10074@kroah.com>
 <c5862b36-beae-4810-fb33-4b646e96378b@roeck-us.net>
 <1545004693.19315.66.camel@codethink.co.uk>
 <20181217090533.GA12938@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ca64083a-158f-7faf-d6e7-566336ad03d0@roeck-us.net>
Date:   Mon, 17 Dec 2018 05:46:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217090533.GA12938@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 1:05 AM, Greg Kroah-Hartman wrote:
> On Sun, Dec 16, 2018 at 11:58:13PM +0000, Ben Hutchings wrote:
>> On Sat, 2018-12-15 at 07:45 -0800, Guenter Roeck wrote:
>>> On 12/15/18 12:07 AM, Greg Kroah-Hartman wrote:
>>>> On Fri, Dec 14, 2018 at 06:10:29PM -0800, Guenter Roeck wrote:
>>>>> On 12/14/18 3:59 AM, Greg Kroah-Hartman wrote:
>>>>>> This is the start of the stable review cycle for the 4.4.168 release.
>>>>>> There are 88 patches in this series, all will be posted as a response
>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>> let me know.
>>>>>>
>>>>>> Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
>>>>>> Anything received after that time might be too late.
>>>>>
>>>>> Build results:
>>>>> 	total: 170 pass: 145 fail: 25
>>>>> Failed builds:
>>>>> 	arm:allnoconfig
>>>>> 	arm:tinyconfig
>>>>> 	arm:efm32_defconfig
>>>>> 	blackfin:defconfig
>>>>> 	blackfin:BF561-EZKIT-SMP_defconfig
>>>>> 	c6x:dsk6455_defconfig
>>>>> 	c6x:evmc6457_defconfig
>>>>> 	c6x:evmc6678_defconfig
>>>>> 	h8300:allnoconfig
>>>>> 	h8300:tinyconfig
>>>>> 	h8300:edosk2674_defconfig
>>>>> 	h8300:h8300h-sim_defconfig
>>>>> 	h8300:h8s-sim_defconfig
>>>>> 	m68k:allnoconfig
>>>>> 	m68k:tinyconfig
>>>>> 	m68k:m5272c3_defconfig
>>>>> 	m68k:m5307c3_defconfig
>>>>> 	m68k:m5249evb_defconfig
>>>>> 	m68k:m5407c3_defconfig
>>>>> 	microblaze:nommu_defconfig
>>>>> 	microblaze:allnoconfig
>>>>> 	microblaze:tinyconfig
>>>>> 	sh:defconfig
>>>>> 	sh:allnoconfig
>>>>> 	sh:tinyconfig
>>>>> Qemu test results:
>>>>> 	total: 288 pass: 288 fail: 0
>>>>>
>>>>> mm/nommu.c: In function '__get_user_pages_unlocked':
>>>>> mm/nommu.c:211:49: error: 'write' undeclared (first use in this function)
>>>>> mm/nommu.c:211:56: error: 'force' undeclared (first use in this function)
>>>>> mm/nommu.c:212:9: warning: passing argument 7 of 'get_user_pages' from incompatible pointer type [enabled by default]
>>>>> mm/nommu.c:185:6: note: expected 'struct vm_area_struct **' but argument is of type 'struct page **'
>>>>> mm/nommu.c:212:9: error: too many arguments to function 'get_user_pages'
>>>>> mm/nommu.c:185:6: note: declared here
>>>>>
>>>>> Details are available at https://kerneltests.org/builders/.
>>>>
>>>> Ugh, I'll dig through this later on today, we must be missing something
>>>> with those backports that Ben did...
>>>>
>>>
>>> 69ce144e5c3a ("mm: replace get_user_pages() write/force parameters
>>> with gup_flags") seems to have missed converting a call of
>>> get_user_pages().
>>
>> Right.  This was changed earlier upstream in commit cde70140fed8
>> "mm/gup: Overload get_user_pages() functions", but I don't think it
>> makes sense to apply all of that.  I'm attaching a minimal patch
>> (tested with an arm allnoconfig build) which should ideally be inserted
>> before mm-replace-get_user_pages-write-force-parameters-with-
>> gup_flags.patch.
>>
>> Ben.
>>
>> -- 
>> Ben Hutchings, Software Developer                         Codethink Ltd
>> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>>                                       Manchester, M1 2HF, United Kingdom
> 
>>  From 0d0afe933f60f5736c984e9171214aa34b18764c Mon Sep 17 00:00:00 2001
>> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
>> Date: Sun, 16 Dec 2018 23:50:08 +0000
>> Subject: [PATCH] mm/nommu.c: Switch __get_user_pages_unlocked() to use
>>   __get_user_pages()
>>
>> Extracted from commit cde70140fed8 "mm/gup: Overload get_user_pages()
>> functions".  This is needed before picking commit 768ae309a961
>> "mm: replace get_user_pages() write/force parameters with gup_flags".
>>
>> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
>> ---
>>   mm/nommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/nommu.c b/mm/nommu.c
>> index fa1560c218d5..2360546db065 100644
>> --- a/mm/nommu.c
>> +++ b/mm/nommu.c
>> @@ -208,8 +208,8 @@ long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
>>   {
>>   	long ret;
>>   	down_read(&mm->mmap_sem);
>> -	ret = get_user_pages(tsk, mm, start, nr_pages, write, force,
>> -			     pages, NULL);
>> +	ret = __get_user_pages(tsk, mm, start, nr_pages, gup_flags, pages,
>> +			       NULL, NULL);
>>   	up_read(&mm->mmap_sem);
>>   	return ret;
>>   }
> 
> Thanks for the patch.  I've added it to the queue and pushed out a -rc2
> with this in it.
> 
> Let's see what the builders say :)
> 

v4.4.167-89-g9c558d7fe359 seemed to be happy. v4.4.167-89-g50a0280f2f7e
replaced it and will take a while.

Guenter
