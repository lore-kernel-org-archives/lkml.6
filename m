Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A2EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA382239B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H3cUuiUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA382239B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeHIXZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:25:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37601 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeHIXZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:25:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so3415646pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9EHOmG0i8twbdzzv8ukf7wzU5eriP5igoCeoarJ0Uwg=;
        b=H3cUuiUhYpFculuTrmnoyzLcBQ0L1DB/vLtZk5SUmHlQFn+7RjxviC8020G7SXK3Pe
         ASDA9KBwNYmZeIrZTZbQTcqFbf5EH7D06UMY2QCk4Z1Jt6zfQ5FHVzRvbkX3jDGRbfFs
         BenRRg7oddzud+R5DUbwUfouUnz5lTkEpHIulnDT3IzIIlWax+VP1YJapI/FbMHqiQU5
         J/xkiCC+O7GyB+xHESZHK4GjjM6hMRUa8AeD0PB3rm6ttjJ2vJLUv+bsHBiogVLlnZcg
         waX1s8ngR5+BOgMt/IamI0MJzKJiP9vE7Mp90BY8S3CHsX2pEPcagcCxgsUVcyd/B8lH
         LlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9EHOmG0i8twbdzzv8ukf7wzU5eriP5igoCeoarJ0Uwg=;
        b=EwGKUB7jPNG//VzHtAcF6U+Xss5cVj0+7sqjK2hGKFTjrDWGeiBVpmkvxZxDfj/cqU
         rhDYSdk3xGqBiKRdqEpC6n2yGLWOkogh/R4RZQnlNu3EdrvhpsHS+iplVFhljzV2FUi/
         dJB0xvuCdGncCutHd1Mzifva00efrw+5I6HZjcwlxPOoJGsmtLN4NparAtzBmMjpmffr
         Dlk0/O7BCw8fy/NkcQDtkQ+yGfXKlW3AHvk4ofL1JTHcV78Yim85Zj6JHVUY0KskzYq1
         Kkt0yI70Cdl2rKy6eZFlTYx40nePTBXmE8lLHsj+RiYWVOlBBn+kLyztdGKcs4/8zdvX
         UEcQ==
X-Gm-Message-State: AOUpUlEHSnkfY3/PIIYS/TovQLZmb9EjvoaALTae81XKuM37FCXQo2cS
        uiGGXlyMwQLuCoqbE297QnFRGxybHYw=
X-Google-Smtp-Source: AA+uWPwvUXem2gsPH+/ggkS0J0LkCesT1BZEwPG1OOs08/TPhqoKp8QOWbPlWv+6DgAOm5L8jGm0EQ==
X-Received: by 2002:a62:3601:: with SMTP id d1-v6mr3957393pfa.41.1533848328147;
        Thu, 09 Aug 2018 13:58:48 -0700 (PDT)
Received: from localhost ([96.76.210.210])
        by smtp.gmail.com with ESMTPSA id a20-v6sm16143153pfc.14.2018.08.09.13.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 13:58:47 -0700 (PDT)
Date:   Thu, 09 Aug 2018 13:58:47 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 13:53:27 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Don't use a global include guard for uapi/asm/syscalls.h
In-Reply-To: <20180809132612.GA31058@roeck-us.net>
CC:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, marcus@mc.pp.se
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-0e048cc1-42e3-4552-88c5-00177db30a5c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Aug 2018 06:26:12 PDT (-0700), linux@roeck-us.net wrote:
> On Fri, Aug 03, 2018 at 12:53:44PM -0700, Palmer Dabbelt wrote:
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
> Fails to build riscv:allnoconfig.
>
> CC      arch/riscv/kernel/syscall_table.o
> ./arch/riscv/include/uapi/asm/syscalls.h:29:36: error:
> ‘sys_riscv_flush_icache’ undeclared here (not in a function); did you mean ‘__NR_riscv_flush_icache’?

Thanks.  I added you to another patch set.
