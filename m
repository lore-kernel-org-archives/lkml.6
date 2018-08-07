Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E65C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DF921A5D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kHOfrFF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DF921A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbeHGCWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:22:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39767 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731092AbeHGCWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:22:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id a11-v6so6930678pgw.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 17:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=WYh3TP+aFTuH38RANMbVqr3t10nTvi/WqpwHfU67tRU=;
        b=kHOfrFF4jOLctRShVDXXOnzmjiTgrj95sDTYu937QWczj//NVSovHvAunm/N8ho22e
         6m2LurYF0z0i+mU6AJK6+jBWx7cI0u92zchch174gg68oPo6bFfz6p+gYsarC/wNeDUu
         4/yDcVZQIMZMM3asFGp7sQW6rJbdqb3p5Rxe+2O35A0uLad7eQb8HPGRhgaXFnOAmJvP
         CvvUU1rxmmg79oNCJbEStQfupqvQR82HFAwVe7KINAqAuwnH2Wo/Kbz0hVyIPkkOwgQY
         SrbwEiq70rr4dQLi28gMT3eY0k2tb0wuUM/4JnBR3RQy10niJGmgxtKG7fi2rgJJKFeX
         q6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=WYh3TP+aFTuH38RANMbVqr3t10nTvi/WqpwHfU67tRU=;
        b=erfWkEfJFA89VBIu5kQoVl/r1Hlt+5xtEaf+LLWq82bnY8+h1Yf+1k7hV4inU68EiZ
         YtIw/0XSQO6z9ZPxgHuRPUnBfLXVsl/9i3VxiHkzbEugNaVRAyRom3Fl55Oo0tXohvmv
         SAX3Ikst+f5VJIRO14RQy+6CGTI/bF7RyVp0bLOJUkRRgleW2Qr1wSbSqvLc0Rbz7Gni
         XQusrg2e6cpo/v0Vhz4XtBsQ6zlI1bzVa2dhJibpJ5Sd04CpzlIYqlN/W/O2hoRx3+SZ
         /XvMyEgR5y7vXxtUI6hZcHXTj4R3pVMdK9so/HMCXXBpP9t4b0oNAvTGWxn0mgV6aWRY
         hvHg==
X-Gm-Message-State: AOUpUlFmD+c3llpMY2Jn3XGZUtVgzx56MUwnvD8tXXtc3iUylfm1ChH/
        RG76W4RwJjAlgwT9CrT8F9aZWPOatTI=
X-Google-Smtp-Source: AAOMgpdSUllGcJXrKUtXR2q77h9j8UhUY+Kxa8t2z+05BrODbnSJcJ0qHEx9fKGayj0yLODZ0IJIUg==
X-Received: by 2002:a63:704f:: with SMTP id a15-v6mr16357084pgn.443.1533600672086;
        Mon, 06 Aug 2018 17:11:12 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y3-v6sm30698908pfi.24.2018.08.06.17.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 17:11:10 -0700 (PDT)
Date:   Mon, 06 Aug 2018 17:11:10 -0700 (PDT)
X-Google-Original-Date: Mon, 06 Aug 2018 16:55:28 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Don't use a global include guard for uapi/asm/syscalls.h
In-Reply-To: <ba59adba-29d3-1559-e2f2-58f1149ba58c@infradead.org>
CC:     linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        linux-kernel@vger.kernel.org, marcus@mc.pp.se
From:   Palmer Dabbelt <palmer@sifive.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-91dc598c-2e14-4fd9-9113-e38d8c037162@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Aug 2018 14:00:53 PDT (-0700), rdunlap@infradead.org wrote:
> On 08/06/2018 01:42 PM, Palmer Dabbelt wrote:
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
>> ---
>>  arch/riscv/include/asm/unistd.h        |  5 +++++
>>  arch/riscv/include/uapi/asm/syscalls.h | 15 +++++++++------
>>  2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
>> index 080fb28061de..508be1780323 100644
>> --- a/arch/riscv/include/asm/unistd.h
>> +++ b/arch/riscv/include/asm/unistd.h
>> @@ -11,6 +11,11 @@
>>   *   GNU General Public License for more details.
>>   */
>>
>> +/*
>> + * There is explicitly no include guard here because this file is expected to
>
> to .. be .. included

Thanks.  I'm not going to spin a v3 unless there's more feedback, but I'll 
include it in the PR.

>
>> + * included multiple times.  See uapi/asm/syscalls.h for more info.
>> + */
>> +
>>  #define __ARCH_WANT_SYS_CLONE
>>  #include <uapi/asm/unistd.h>
>>  #include <uapi/asm/syscalls.h>
>> diff --git a/arch/riscv/include/uapi/asm/syscalls.h b/arch/riscv/include/uapi/asm/syscalls.h
>> index 818655b0d535..690beb002d1d 100644
>> --- a/arch/riscv/include/uapi/asm/syscalls.h
>> +++ b/arch/riscv/include/uapi/asm/syscalls.h
>> @@ -1,10 +1,13 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +// SPDX-License-Identifier: GPL-2.0
>>  /*
>> - * Copyright (C) 2017 SiFive
>> + * Copyright (C) 2017-2018 SiFive
>>   */
>>
>> -#ifndef _ASM__UAPI__SYSCALLS_H
>> -#define _ASM__UAPI__SYSCALLS_H
>> +/*
>> + * There is explicitly no include guard here because this file is expected to
>> + * be included multiple times in order to define the syscall macros via
>
> like that one :)
>
>> + * __SYSCALL.
>> + */
>>
>>  /*
>>   * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
