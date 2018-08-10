Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DCEC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F4C223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoypJKSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F4C223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeHJFIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:08:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40772 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeHJFIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:08:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id e13-v6so3777538pff.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 19:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R99PNny+xo8pMVDaU7xLrKI+jxHfQh60gBN+B3TfPAw=;
        b=hoypJKSFZoZbUxvFjjtM0Ghdh5P+FwQ3j2rmdIFwi3ItaheZXct6gMBGCsvh3QpPIG
         clMM/4oIwEwklTs3XhSE766mYpyGf1vZ5NtgTVORpA8INsXC9cTcvpK0SuqTiksn17ZT
         O/SRHv0VvU2EeZzAhXx5bsi6o1Vw8xUodQUeXhn9XhlfJooFDm0GhFtY0NC93NbSpakj
         pSbUziQQWFal3JjZT3QUFzKGx/SpFLk9e8uPGWOsxzpokrLgl2N0bUyOhQFoKmGHFFBc
         27Ox+UhNLtIB7wCoTEkH//QuPnDzfggW7QzmU59O47s0+P75ACDI/S8YZ7TWA5RePUv5
         Ct7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R99PNny+xo8pMVDaU7xLrKI+jxHfQh60gBN+B3TfPAw=;
        b=D5N5PoxSAl4J1AyEzbM7ZnQcMNl26oYg1EQFcvGCM9cYDz5wQbxlkMvsIr6qfwsL0z
         Ep1SpBBB/q7FwD01YC8uQk0qL+yHioz4kGT4Rj54M8Nn21hozCSdHGAnH0GwDR9dZgCs
         QCyAEOzAq7XfN0q9vMiWhFZZ1gdGyzsN8PUdDmG+57/aAUigsqBXOiVx/m4N2r94ykEg
         nl4+zoqw667EJAIXIlikOfzZVed4ZqK/gc259rkLItBgMzNxdtp8BCYzEIA3/T1575u0
         ZKzQaUH8U3PuLBhYY0WezbqB+MgaTmRMkQUuiQemoEhQVofvCURG4tYKxpAEbS0rNElq
         NkBA==
X-Gm-Message-State: AOUpUlEaOyPZ2x366tnl2PO+POJ0x3D59pk0JKt53OpoDst/DY6uhl8J
        P3c/cS3UO6llJqYh1nWNaws=
X-Google-Smtp-Source: AA+uWPzLNAKtZYwI66DT0CjUQjLyqem+gAqOIPeFanwL10yciM8fs1/sNXjTvLRsjDJuzsvc3N9bLw==
X-Received: by 2002:a63:f50a:: with SMTP id w10-v6mr4512788pgh.23.1533868859027;
        Thu, 09 Aug 2018 19:40:59 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g85-v6sm22460172pfk.39.2018.08.09.19.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 19:40:57 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        Andrew Waterman <andrew@sifive.com>, dan.carpenter@oracle.com,
        linux@dominikbrodowski.net, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, marcus@mc.pp.se
References: <mhng-80aa1c8e-e2ed-4662-8715-4bb9e6ba7598@palmer-si-x1c4>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7f1a254d-58b0-1581-ea71-582bae131d3a@roeck-us.net>
Date:   Thu, 9 Aug 2018 19:40:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <mhng-80aa1c8e-e2ed-4662-8715-4bb9e6ba7598@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 06:03 PM, Palmer Dabbelt wrote:
> On Thu, 09 Aug 2018 14:24:22 PDT (-0700), linux@roeck-us.net wrote:
>> On Thu, Aug 09, 2018 at 01:25:24PM -0700, Palmer Dabbelt wrote:
>>> This file is expected to be included multiple times in the same file in
>>> order to allow the __SYSCALL macro to generate system call tables.  With
>>> a global include guard we end up missing __NR_riscv_flush_icache in the
>>> syscall table, which results in icache flushes that escape the vDSO call
>>> to not actually do anything.
>>>
>>> The fix is to move to per-#define include guards, which allows the
>>> system call tables to actually be populated.  Thanks to Macrus Comstedt
>>> for finding and fixing the bug!
>>>
>>> I also went ahead and fixed the SPDX header to use a //-style comment,
>>> which I've been told is the canonical way to do it.
>>>
>>> Cc: Marcus Comstedt <marcus@mc.pp.se>
>>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>
>> [Compile-]Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
>> on top of linux-next after reverting the version of the patch there.
>>
>> I also tried to run the resulting image (defconfig) with qemu (built
>> from https://github.com/riscv/riscv-qemu.git), but that still doesn't
>> work. I assume there are still some patches missing ?
> 
> Do you have the PLIC patches?  They'll be necessary to make this all work, and there's a v4 out now that when combined with for-next should get you to userspace.
> 
>     https://lore.kernel.org/lkml/20180809075602.989-1-hch@lst.de/T/#u
> 
Yes, after merging that branch on top of linux-next I can boot into Linux.
If I add my "riscv: Drop setup_initrd" patch as well, I can boot using
initrd, otherwise I have to use virtio-blk-device.

> Also, what is your methodology?  I follow
> 
>     https://wiki.qemu.org/Documentation/Platforms/RISCV
> 
> and could could natively compile and run hello world with an earlier version of Christoph's patch set, which is really only cosmetically different than the v4. I use qemu's master branch as well, which when I tried was exactly 3.0.0-rc3.
> 

That doesn't work for me, possibly because I don't specify a bbl
image with -kernel but vmlinux (using -bios for the bbl image).
I use branch qemu-for-upstream of https://github.com/riscv/riscv-qemu.git.

Guenter
