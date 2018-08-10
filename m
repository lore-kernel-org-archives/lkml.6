Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF55C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB3A223A6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hWXqPmox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB3A223A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeHJDbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 23:31:23 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37450 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeHJDbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 23:31:23 -0400
Received: by mail-pl0-f66.google.com with SMTP id d5-v6so3295413pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xoITewC9Si0Y4zzcf5zfXnr9f3dVkVrC26zOh0ZnN7k=;
        b=hWXqPmoxUr2aYxoGJt2c7+WL3egk7McNitr6SfRUstGlcA2H8ie2rZRBBnPUiFhvEI
         GQRSp38gw5lqY1EisYqWI/WM6ANFbdVbS8SDJp+hW4RzUCJcson1VuvkDZU6+ez2jwS4
         BKzATwGta+3a5/zu8Ftsk+WKvprIth9D9p/ird1LK6uXna8rguY5TATlSsd3Kp/KL9vj
         sTURlgcv08xZwriBeafUqwYYQj8WR1ffdGnZAVr8NQgSprh38FSN+6q8TCuF6chf08D9
         HlvNHeRNbcGjy3EwZezFjfc/l/n3Z1EX+WhvHEOTh8Wp9OSdomAJLyuT3RdzQNST/bFC
         00Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xoITewC9Si0Y4zzcf5zfXnr9f3dVkVrC26zOh0ZnN7k=;
        b=a8dJXvhQXBHhLjePo2SHZZeO0lSE5dfRiAvIdTAup683xZbghc1x2HhY15Veg6Mm+j
         5ltqNu9TZHU1C75ZXk10p56zz51uPpITINXWak5AjyRQKUOXcukcJ6wmt+HvE+WTVp8y
         fuaGcs42102Otvvv1F5sk5T4QeN5/qt4gK3LJk+SISg0Nz9jfjHmjFLfPmZIoRQ5lSH/
         3Jkz7QZs4MT0oUVkQi8xjXUFIBcGkJBkJcC9qWkWeyVQVJb2ECyLuOHpwCmSyDfrfTP2
         fC+RqcebnAmWhfVu16lBqMyR+D9Hv3zPYCI4iXpvYMXsq1nT7/uViCE2tGqYFO+TqRd8
         4RLA==
X-Gm-Message-State: AOUpUlH1ce8wiZQNKPV12WcOD8G0lxHHHcOkD2qYgiBj7xY5mgNuN4by
        uGK8TsdFwRjwikmtg+7bLPzPIw==
X-Google-Smtp-Source: AA+uWPwNcb3vTuXISiaQqPKayDpkDaBpnsE3iORA9RacxoCGW2b4nbLkjPzoJ64To7W+msXj6cxkxw==
X-Received: by 2002:a17:902:7587:: with SMTP id j7-v6mr4008123pll.256.1533863036058;
        Thu, 09 Aug 2018 18:03:56 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l3-v6sm9974822pff.8.2018.08.09.18.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 18:03:54 -0700 (PDT)
Date:   Thu, 09 Aug 2018 18:03:54 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 17:33:55 PDT (-0700)
Subject:     Re: [PATCH v2 2/2] RISC-V: Don't use a global include guard for uapi/asm/syscalls.h
In-Reply-To: <20180809212422.GB13675@roeck-us.net>
CC:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        Andrew Waterman <andrew@sifive.com>, dan.carpenter@oracle.com,
        linux@dominikbrodowski.net, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, marcus@mc.pp.se
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-80aa1c8e-e2ed-4662-8715-4bb9e6ba7598@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Aug 2018 14:24:22 PDT (-0700), linux@roeck-us.net wrote:
> On Thu, Aug 09, 2018 at 01:25:24PM -0700, Palmer Dabbelt wrote:
>> This file is expected to be included multiple times in the same file in
>> order to allow the __SYSCALL macro to generate system call tables.  With
>> a global include guard we end up missing __NR_riscv_flush_icache in the
>> syscall table, which results in icache flushes that escape the vDSO call
>> to not actually do anything.
>>
>> The fix is to move to per-#define include guards, which allows the
>> system call tables to actually be populated.  Thanks to Macrus Comstedt
>> for finding and fixing the bug!
>>
>> I also went ahead and fixed the SPDX header to use a //-style comment,
>> which I've been told is the canonical way to do it.
>>
>> Cc: Marcus Comstedt <marcus@mc.pp.se>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> [Compile-]Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> on top of linux-next after reverting the version of the patch there.
>
> I also tried to run the resulting image (defconfig) with qemu (built
> from https://github.com/riscv/riscv-qemu.git), but that still doesn't
> work. I assume there are still some patches missing ?

Do you have the PLIC patches?  They'll be necessary to make this all work, and 
there's a v4 out now that when combined with for-next should get you to 
userspace.

    https://lore.kernel.org/lkml/20180809075602.989-1-hch@lst.de/T/#u

Also, what is your methodology?  I follow

    https://wiki.qemu.org/Documentation/Platforms/RISCV

and could could natively compile and run hello world with an earlier version of 
Christoph's patch set, which is really only cosmetically different than the v4.  
I use qemu's master branch as well, which when I tried was exactly 3.0.0-rc3.
