Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4817C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEC3223DC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL85tJLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEC3223DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHJGjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 02:39:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45138 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeHJGjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 02:39:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so3746999pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 21:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1Rzv+HTJJBNXaZgrdJsIg6qus31JjJa/Xum3kfG0GPU=;
        b=ZL85tJLzhzjcscjjtC6kVHnIkk/9AIzza8Svd9IL2H5NP46FxG2lSvksJpVJ6FemNC
         bpb0i9lopwW/KFtfuByJQn1rlqFeW49DoXtjRbw1QhxQI31WnshNLQLiTPrZXSM1Xsvr
         Wn6SVi3qgIbbQ5dOejC6JxINoFoo7wZLa6feu+GBcq1f9s/mzlBru7XpDqPC9q+TWNbL
         2UrjoKDUrTz0H+2oJZwNOhLcnDrkXpj+17aOq/OYvyQlI7UBmrXlz0D/Q/pCdA61AZan
         CYHkp+ptbuU7la7x76fnuZRIgfuTEOSdGZAs0L/USVlkVyKJZT8pndVtQ2JLjSshUZ5K
         enxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Rzv+HTJJBNXaZgrdJsIg6qus31JjJa/Xum3kfG0GPU=;
        b=nwQY6WZ01aHlScTTaUmMXBmz7sDUPzOfbR+sGqcGByFDXVIL5axankoVUmTIv7XJLs
         toF+bAOxOAOa0xwrsYXIuq3u1muKiBYymY2atE0Dpuj05FwjYyyWa9OzkCmLrE+bzlWe
         Nl9t4Ul5vCMoulZXqwFxMHfxaShpaNDfK1B8VNARFWBL3xZY9epkgmxqsNLo1rRk2CMz
         oyrvcYnfNPbUEzxpiK4TstwG+ijfRyPUW3nd+HePJ/PTjDp+AENNcKCIN3qlUgJV37jR
         SoXZELhYUNCUQmu2MuvokTudtaXmGORfZcD99QecdNZU6UlR3JBFPCv76G7queF3ZAAM
         qZwA==
X-Gm-Message-State: AOUpUlE1aPUyDKXhdY+W6PTV8rdWgJEQkkz1cgwmgx5THybod5GpVIiI
        sLmuGG0rSAZmM8HfBUahoV8=
X-Google-Smtp-Source: AA+uWPwQinSrh2zqYI78sLxagJHYMOzz9/ipjvV0w82I6EihyyV7Ny7yTa/EAQRNrLLE3zGry64CYQ==
X-Received: by 2002:a65:5545:: with SMTP id t5-v6mr4729917pgr.157.1533874296960;
        Thu, 09 Aug 2018 21:11:36 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g5-v6sm14673612pfc.77.2018.08.09.21.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 21:11:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        Andrew Waterman <andrew@sifive.com>, dan.carpenter@oracle.com,
        linux@dominikbrodowski.net, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, marcus@mc.pp.se
References: <mhng-ef018453-7a99-48b3-bda5-5408383d9566@palmer-si-x1c4>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <988c739c-a275-c018-2502-08f817b2f818@roeck-us.net>
Date:   Thu, 9 Aug 2018 21:11:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <mhng-ef018453-7a99-48b3-bda5-5408383d9566@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 08:59 PM, Palmer Dabbelt wrote:
> On Thu, 09 Aug 2018 19:40:55 PDT (-0700), linux@roeck-us.net wrote:
>> On 08/09/2018 06:03 PM, Palmer Dabbelt wrote:
>>> On Thu, 09 Aug 2018 14:24:22 PDT (-0700), linux@roeck-us.net wrote:
>>>> On Thu, Aug 09, 2018 at 01:25:24PM -0700, Palmer Dabbelt wrote:
>>>>> This file is expected to be included multiple times in the same file in
>>>>> order to allow the __SYSCALL macro to generate system call tables.  With
>>>>> a global include guard we end up missing __NR_riscv_flush_icache in the
>>>>> syscall table, which results in icache flushes that escape the vDSO call
>>>>> to not actually do anything.
>>>>>
>>>>> The fix is to move to per-#define include guards, which allows the
>>>>> system call tables to actually be populated.  Thanks to Macrus Comstedt
>>>>> for finding and fixing the bug!
>>>>>
>>>>> I also went ahead and fixed the SPDX header to use a //-style comment,
>>>>> which I've been told is the canonical way to do it.
>>>>>
>>>>> Cc: Marcus Comstedt <marcus@mc.pp.se>
>>>>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>>>
>>>> [Compile-]Tested-by: Guenter Roeck <linux@roeck-us.net>
>>>>
>>>> on top of linux-next after reverting the version of the patch there.
>>>>
>>>> I also tried to run the resulting image (defconfig) with qemu (built
>>>> from https://github.com/riscv/riscv-qemu.git), but that still doesn't
>>>> work. I assume there are still some patches missing ?
>>>
>>> Do you have the PLIC patches?  They'll be necessary to make this all work, and there's a v4 out now that when combined with for-next should get you to userspace.
>>>
>>>     https://lore.kernel.org/lkml/20180809075602.989-1-hch@lst.de/T/#u
>>>
>> Yes, after merging that branch on top of linux-next I can boot into Linux.
>> If I add my "riscv: Drop setup_initrd" patch as well, I can boot using
>> initrd, otherwise I have to use virtio-blk-device.
> 
> Awesome!  If you patch isn't on for-next then I must have missed it, do you mind sending me a pointer?  I can't find any references in my email.
> 
Hmm ... weird. I don't find it either. Maybe I sent it only in my dreams.
I'll send it out for review.

Guenter

>>> Also, what is your methodology?  I follow
>>>
>>>     https://wiki.qemu.org/Documentation/Platforms/RISCV
>>>
>>> and could could natively compile and run hello world with an earlier version of Christoph's patch set, which is really only cosmetically different than the v4. I use qemu's master branch as well, which when I tried was exactly 3.0.0-rc3.
>>>
>>
>> That doesn't work for me, possibly because I don't specify a bbl
>> image with -kernel but vmlinux (using -bios for the bbl image).
>> I use branch qemu-for-upstream of https://github.com/riscv/riscv-qemu.git.
>>
>> Guenter
> 

