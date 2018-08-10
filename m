Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B59C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27ED223E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lnVjC37G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27ED223E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeHJG2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 02:28:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45768 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeHJG2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 02:28:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so3858071pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 21:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XPMQxzeY71UyDpvQZB/KMO/0Cg4GV/PgraiTsilAc00=;
        b=lnVjC37G9lreeV901LzojhGpDgBQ3QVr9bemlAZ629gTITHHTVvI92DxVlfW1D9Znv
         R0snDZdh3DiVJBXIRlT/TxYm/+zN3H3ziessuIhiOHlL9iJ4OzFQbbrnnAU9zZNJN3pq
         UpZk9V8x5U+Gb1XwP0uWQiuEpHOPKrqSGv9aK6/L1DV9iAIIpsmwJI531beMYiU7/Ori
         HfZaYRzFRG0boNSaXNNSFYoufjh36t7Qrc/TcxGDSIhYwD7XSQHN+uH0HDVkYJVcEYqE
         QOzzyro1XDT2ul++DRxoBFFP4U0ygC4r2B2rxAm1PLtxDBqP64aVjjaQBweeARZ172vr
         nMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XPMQxzeY71UyDpvQZB/KMO/0Cg4GV/PgraiTsilAc00=;
        b=IJ13FE6XfCFPE6aBjLsgNTEL2vwB9HY4n99yX7J+Db4no2CoQKiWQA4NQnRSIaw4Zx
         rTJhELfXEPnb4OhupkFwgu/aBhppXnJKArSd/6peFq963OqN28VsFS2l7gq6/FKKBCkF
         zPmKIFzy+hi3N3ELzuPdlasJTEFOXToOqAHnig2YY74AX8aMFzS4oFBNrumkxBU4BOdA
         84Vj8LJkD17MR3aV6f97XST+s647IA8dK7w7XXx51T8oA63ScAXzNAgX8wBMComaIuuF
         VKdfnpDbbdh5+MaPdwFMe6j0hW3cZXN1b2H3A1pgXxoYJ1zPe67yB00jdVgwwolL5HEf
         Yfkg==
X-Gm-Message-State: AOUpUlGgN8oed6qjSKUDDoTPBLZiZjGp8l93oW/SbYZomgRq2xRiO+HQ
        MbdouKaiejoJ6LmAsDkCfcqMOg==
X-Google-Smtp-Source: AA+uWPxaQFk7qw5DinCO4hpxgqV43ZZsmKr+jRYSSl67OOa4xMnjzwc9oB/hMOQk1sB5K6dUwf2k6A==
X-Received: by 2002:a63:f002:: with SMTP id k2-v6mr4615627pgh.8.1533873600674;
        Thu, 09 Aug 2018 21:00:00 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id t30-v6sm13785570pgm.81.2018.08.09.20.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:59:59 -0700 (PDT)
Date:   Thu, 09 Aug 2018 20:59:59 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 20:59:44 PDT (-0700)
Subject:     Re: [PATCH v2 2/2] RISC-V: Don't use a global include guard for uapi/asm/syscalls.h
In-Reply-To: <7f1a254d-58b0-1581-ea71-582bae131d3a@roeck-us.net>
CC:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        Andrew Waterman <andrew@sifive.com>, dan.carpenter@oracle.com,
        linux@dominikbrodowski.net, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, marcus@mc.pp.se
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-ef018453-7a99-48b3-bda5-5408383d9566@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Aug 2018 19:40:55 PDT (-0700), linux@roeck-us.net wrote:
> On 08/09/2018 06:03 PM, Palmer Dabbelt wrote:
>> On Thu, 09 Aug 2018 14:24:22 PDT (-0700), linux@roeck-us.net wrote:
>>> On Thu, Aug 09, 2018 at 01:25:24PM -0700, Palmer Dabbelt wrote:
>>>> This file is expected to be included multiple times in the same file in
>>>> order to allow the __SYSCALL macro to generate system call tables.  With
>>>> a global include guard we end up missing __NR_riscv_flush_icache in the
>>>> syscall table, which results in icache flushes that escape the vDSO call
>>>> to not actually do anything.
>>>>
>>>> The fix is to move to per-#define include guards, which allows the
>>>> system call tables to actually be populated.  Thanks to Macrus Comstedt
>>>> for finding and fixing the bug!
>>>>
>>>> I also went ahead and fixed the SPDX header to use a //-style comment,
>>>> which I've been told is the canonical way to do it.
>>>>
>>>> Cc: Marcus Comstedt <marcus@mc.pp.se>
>>>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>>
>>> [Compile-]Tested-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> on top of linux-next after reverting the version of the patch there.
>>>
>>> I also tried to run the resulting image (defconfig) with qemu (built
>>> from https://github.com/riscv/riscv-qemu.git), but that still doesn't
>>> work. I assume there are still some patches missing ?
>>
>> Do you have the PLIC patches?  They'll be necessary to make this all work, and there's a v4 out now that when combined with for-next should get you to userspace.
>>
>>     https://lore.kernel.org/lkml/20180809075602.989-1-hch@lst.de/T/#u
>>
> Yes, after merging that branch on top of linux-next I can boot into Linux.
> If I add my "riscv: Drop setup_initrd" patch as well, I can boot using
> initrd, otherwise I have to use virtio-blk-device.

Awesome!  If you patch isn't on for-next then I must have missed it, do you 
mind sending me a pointer?  I can't find any references in my email.

>> Also, what is your methodology?  I follow
>>
>>     https://wiki.qemu.org/Documentation/Platforms/RISCV
>>
>> and could could natively compile and run hello world with an earlier version of Christoph's patch set, which is really only cosmetically different than the v4. I use qemu's master branch as well, which when I tried was exactly 3.0.0-rc3.
>>
>
> That doesn't work for me, possibly because I don't specify a bbl
> image with -kernel but vmlinux (using -bios for the bbl image).
> I use branch qemu-for-upstream of https://github.com/riscv/riscv-qemu.git.
>
> Guenter
