Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37B7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFF02086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLRWVSTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbeLOPpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:45:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42988 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbeLOPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:45:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so4105642plp.9;
        Sat, 15 Dec 2018 07:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xwClP/uQmP4/rMDDM9HQmf2+q8UkuRT9OObTYTFe7Vc=;
        b=PLRWVSTOCqQvqINUiWlk8xrYUD+kTxnU7Fl117iAw9/vSLxKr/SRDocULYVTTQyKfd
         zAwiEEe+vG4Dabyrj8LoWXXUFpOFbk4iTNzexnAqBb0kyKJ35weX0ZcnBW97yY0zfCh5
         rT/oPmtVLgir7e+A9J4Tfc+877I0BxgrwbMH9M0TBgmaJCfOzbJiATyeuBHLHz58q4y7
         OUpGtPYndnY8ZsBnJqwEHdYIClks1RgH8HzQQg/182Dg0256QjvrLZiz5joDWOxr8vby
         C7Z4gVtcXyF67QH7Orh8d+kgEKGSlNbRLtisZCM/iYG5kUBSDM4gION+WQxzQdCMTYLs
         L9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xwClP/uQmP4/rMDDM9HQmf2+q8UkuRT9OObTYTFe7Vc=;
        b=uR6jieJGIW/lapingCVb1jLo4ddAAqsWg1ME5z5Mi8rQ5SsKB1jkuyyByRO+NwAtwY
         llWM1prz5ivviTBvY50Uj9BCL5VMoczyPgRv8ReW82V/4NKRaX/aU5PuLuB9QfdqKdB0
         qDPkU/1Rukm+j9O8uK7BXiIdaku85bXAtqtr36g3Tu4WsjuoZC+O/A6RfD/DM5AWzagg
         9PkOXW98w+E7vxvJFAhooFaX0WBYt1/XeJhH96501QzIdigW5s+q4qcQhTSKoQOQeOcT
         A98c287hbCBL2PNoer/49O+1sfEiXKr171a6UiP0W1yzHOdmEkaGt5iebb5Hq23xbInI
         WjbQ==
X-Gm-Message-State: AA+aEWb1dEgrddQ4UMNWp+B7NUgBWtm4fWNSD3pyvWzuaJlwe2gWqeY2
        6FXX7mzGtE/7KNkq4FHRD/t68kmV
X-Google-Smtp-Source: AFSGD/UMBDGxybMMhE5AGPZ/f+8PIQHDFoXtGcmVXftoXdIMfVC3vk7UHqb9g/6XpYmgIHWjuW+a/Q==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr6484861pln.224.1544888710875;
        Sat, 15 Dec 2018 07:45:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u69sm18407579pfj.116.2018.12.15.07.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 07:45:10 -0800 (PST)
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181214115702.151309521@linuxfoundation.org>
 <dfd49bfd-359a-7f5e-8332-5e6ad6da21cd@roeck-us.net>
 <20181215080729.GG10074@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c5862b36-beae-4810-fb33-4b646e96378b@roeck-us.net>
Date:   Sat, 15 Dec 2018 07:45:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181215080729.GG10074@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/18 12:07 AM, Greg Kroah-Hartman wrote:
> On Fri, Dec 14, 2018 at 06:10:29PM -0800, Guenter Roeck wrote:
>> On 12/14/18 3:59 AM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.4.168 release.
>>> There are 88 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
>>> Anything received after that time might be too late.
>>
>> Build results:
>> 	total: 170 pass: 145 fail: 25
>> Failed builds:
>> 	arm:allnoconfig
>> 	arm:tinyconfig
>> 	arm:efm32_defconfig
>> 	blackfin:defconfig
>> 	blackfin:BF561-EZKIT-SMP_defconfig
>> 	c6x:dsk6455_defconfig
>> 	c6x:evmc6457_defconfig
>> 	c6x:evmc6678_defconfig
>> 	h8300:allnoconfig
>> 	h8300:tinyconfig
>> 	h8300:edosk2674_defconfig
>> 	h8300:h8300h-sim_defconfig
>> 	h8300:h8s-sim_defconfig
>> 	m68k:allnoconfig
>> 	m68k:tinyconfig
>> 	m68k:m5272c3_defconfig
>> 	m68k:m5307c3_defconfig
>> 	m68k:m5249evb_defconfig
>> 	m68k:m5407c3_defconfig
>> 	microblaze:nommu_defconfig
>> 	microblaze:allnoconfig
>> 	microblaze:tinyconfig
>> 	sh:defconfig
>> 	sh:allnoconfig
>> 	sh:tinyconfig
>> Qemu test results:
>> 	total: 288 pass: 288 fail: 0
>>
>> mm/nommu.c: In function '__get_user_pages_unlocked':
>> mm/nommu.c:211:49: error: 'write' undeclared (first use in this function)
>> mm/nommu.c:211:56: error: 'force' undeclared (first use in this function)
>> mm/nommu.c:212:9: warning: passing argument 7 of 'get_user_pages' from incompatible pointer type [enabled by default]
>> mm/nommu.c:185:6: note: expected 'struct vm_area_struct **' but argument is of type 'struct page **'
>> mm/nommu.c:212:9: error: too many arguments to function 'get_user_pages'
>> mm/nommu.c:185:6: note: declared here
>>
>> Details are available at https://kerneltests.org/builders/.
> 
> Ugh, I'll dig through this later on today, we must be missing something
> with those backports that Ben did...
> 
69ce144e5c3a ("mm: replace get_user_pages() write/force parameters
with gup_flags") seems to have missed converting a call of
get_user_pages().

Guenter
