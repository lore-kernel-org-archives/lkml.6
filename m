Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B8C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A449B2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqQ7MtQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfAJO1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:27:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40041 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfAJO1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:27:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so5379077pfo.7;
        Thu, 10 Jan 2019 06:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8JaoZtTvlHiu+Okl2DH/LYU6cbzQA4EwN96F3Y/V0ww=;
        b=LqQ7MtQ6aCPxl1s1Cfh+tzUS2N851E/ernf68BEjbR3k1LIVEvvWBl3L2P1wP0ZEWx
         7M5QI3tY0ElZVW2Cty+y7jzJ0dOZ0MwPM6P4fJvP8KcKUYQlhWjOOXLDUldBDssnUOJ/
         zB6n4Hg7wa9Zcg+5U1Vq8OzbhMAN7j8Ad5GGdPS/adCCFMBjJyYhfr7wjj3eeLiW+tgb
         FXCXgi7QsKqaQXIyQKwkt3gFowB3USXFWR9z56IwNccgcXb87sPk6C7NY2UWkoJIdDRj
         FKOeGjnBISEsuw7ZLNKRPdgTXz3MGHVb5TsJJNNIL9Hkfu2TsbGfIWZaspplDzv5VscV
         fgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8JaoZtTvlHiu+Okl2DH/LYU6cbzQA4EwN96F3Y/V0ww=;
        b=RKKaB4qpUiECYwU/842q//EnwvgQEgwAAvgZ2e39wK4amTGCbY4xrDjyr/duz3unG2
         IMTCv6H4IVPu5VZVLfRuVP/qhFIDx6S0zmGa32T6cW/mGPlpgpUjC7qnZnVg+3QWZ/72
         N7IAQZJxuWqShp7n3Z9FRhsd7QbnWUH7dyLga0EYP84Ilak+FKoKValT38I9j7t/4ImA
         2tgIkxZ+A8HkRJa5VJnKlscyrBurOjDynHzyCPeVwlpxgxvazW4LQKWzljVwExKLKeds
         VUeiJ1FTbcntdL3+4D439l4XkQUxQ4dS8M7tC1s/uTY5AjLyQ5mGIcZafn3B0oznqgNQ
         VP8g==
X-Gm-Message-State: AJcUukfNdrxiLfoEa9UOevYuBEPFI2pGS+DU1ZqnCMa9nl//qIbcRYuI
        3WwAswqZ0g87AsKXnwIpO/rk14sQ
X-Google-Smtp-Source: ALg8bN7T8za63vXWY2bLLTu6ew7uxZugibMT2Zal7pH2FTLRWg6e5TEP5kEBNHQIyyJITAi8KsQAvA==
X-Received: by 2002:a63:2643:: with SMTP id m64mr9397929pgm.35.1547130458005;
        Thu, 10 Jan 2019 06:27:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l85sm135246953pfg.161.2019.01.10.06.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 06:27:35 -0800 (PST)
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Breno Leitao <leitao@debian.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108230731.GC20519@roeck-us.net> <20190109143811.GB29274@kroah.com>
 <20190109194048.GA11505@roeck-us.net> <20190110065207.GA17195@kroah.com>
 <20190110131743.GE20217@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <36da999f-fa06-a8a0-7ab5-e0666db00640@roeck-us.net>
Date:   Thu, 10 Jan 2019 06:27:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110131743.GE20217@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 5:17 AM, Greg Kroah-Hartman wrote:
> On Thu, Jan 10, 2019 at 07:52:07AM +0100, Greg Kroah-Hartman wrote:
>> On Wed, Jan 09, 2019 at 11:40:48AM -0800, Guenter Roeck wrote:
>>> On Wed, Jan 09, 2019 at 03:38:11PM +0100, Greg Kroah-Hartman wrote:
>>>> On Tue, Jan 08, 2019 at 03:07:31PM -0800, Guenter Roeck wrote:
>>>>> On Mon, Jan 07, 2019 at 01:30:27PM +0100, Greg Kroah-Hartman wrote:
>>>>>> This is the start of the stable review cycle for the 4.19.14 release.
>>>>>> There are 170 patches in this series, all will be posted as a response
>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>> let me know.
>>>>>>
>>>>>> Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
>>>>>> Anything received after that time might be too late.
>>>>>>
>>>>>
>>>>> For v4.19.13-171-gc68ce175c3b8:
>>>>>
>>>>> Build results:
>>>>> 	total: 155 pass: 152 fail: 3
>>>>> Failed builds:
>>>>> 	powerpc:ppc64e_defconfig
>>>>> 	powerpc:cell_defconfig
>>>>> 	powerpc:maple_defconfig
>>>>> Qemu test results:
>>>>> 	total: 332 pass: 319 fail: 13
>>>>> Failed tests:
>>>>> 	ppc64:mac99:ppc64_book3s_defconfig:nosmp:initrd
>>>>> 	ppc64:mac99:ppc64_book3s_defconfig:smp:initrd
>>>>> 	ppc64:mac99:ppc64_book3s_defconfig:smp:ide:rootfs
>>>>> 	ppc64:mac99:ppc64_book3s_defconfig:smp:mmc:rootfs
>>>>> 	ppc64:mac99:ppc64_book3s_defconfig:smp:nvme:rootfs
>>>>> 	ppc64:mac99:ppc64_book3s_defconfig:smp:scsi[DC395]:rootfs
>>>>> 	ppc64:mpc8544ds:ppc64_e5500_defconfig:nosmp:initrd
>>>>> 	ppc64:mpc8544ds:ppc64_e5500_defconfig:smp:initrd
>>>>> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:initrd
>>>>> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:nvme:rootfs
>>>>> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:mmc:rootfs
>>>>> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:scsi[53C895A]:rootfs
>>>>> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112:rootfs
>>>>
>>>> Ugh, I thought this was just the cell build, didn't realize it hit more.
>>>>
>>>> Ok, I've dropped the patch from all queues.  Odd that it only causes
>>>> problems on 4.19.y :(
>>>>
>>> I don't know what you dropped, but v4.19.14 fails to build with
>>> the same error. Did you drop it after the release ?
>>
>> No, I should have dropped it before the release.  Let me go see what I
>> messed up...
> 
> I dropped e1c3743e1a20 ("powerpc/tm: Set MSR[TS] just prior to recheckpoint")
> from the stable trees, which is what I was told was the commit that was
> causing the problems by Christoph and Breno (on to: now).
> 
> Was that not the offending commit?  If so, what one was?
> 
$ git describe
v4.19.14
groeck@server:~/src/linux-stable$ git log --oneline v4.19.13.. arch/powerpc/
a9935a127688 powerpc/tm: Unset MSR[TS] if not recheckpointing
34fc09193486 powerpc/fsl: Fix spectre_v2 mitigations reporting
groeck@server:~/src/linux-stable$

a9935a127688 is the culprit.

Guenter
