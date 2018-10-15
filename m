Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D03C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C592089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="afw/VZD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C592089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJPHEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 03:04:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44127 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeJPHED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 03:04:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id p25-v6so10003189pli.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 16:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zY5FRFGJ1x+0u/V5mm5L6gboapti4teFd3k5CuR3lYA=;
        b=afw/VZD3n/lVtV9SV2RTXfAcuuZiK/C3lzJa7Yyar09LteLgZHDnw8mJXPSm3dxOo1
         RbFqJHtz5PUWT8ZxTH16C061i1grp8bJD2EriKxetMboEwPgYMa59si5UEFu3/8cYREN
         owS+O2OFgwfmi2DJiLZOb89g4cICP9kWyizmYS3zVRkM5ZxTtzl8FQk2bAGiaQlSa/X5
         2bnSmza3zY5wBaNT1njlN/hUO3CQpxBfo/eWMPBOCAoOJTR/eqHJRVdcgHVoW2LevK5P
         pA/K0RpN5EQ2iGl9zInUWKUOUO4N7s9CVQv9Q/k4fCPWUYo/ZW4asBdn0nfJ15e1FeTo
         gezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zY5FRFGJ1x+0u/V5mm5L6gboapti4teFd3k5CuR3lYA=;
        b=krrPJ/r8SI5LtuNeZG9S6UI+OA7juifN/fnneK61eH2L2vDBLcFzLLqOABIKZfKY5O
         ZonuL79hNtEMdupWuIf5ZCHohOF/vCOBfgfaKRjJtu9MoJCoeClwRuxk1me7fu1VbVjw
         y2x2xl2ks4l0AuVSmhs436Ly3+rEeuSUVMxLybov1lR34xitll1Pt4gflEnu5BcdKf/y
         D2YRmpecZ3TIRMZ4pI4ikcH1utOBWrh4iOhTfKsRZdrY8+ozxXM2RPnWYFqTW+YSdtko
         JSeMXe+LMqvuHt0WrCRhnKfigB6SGLy/KPTYMwSTLai0Mq0N3cXtnCVOOKuYzqiKM9mD
         aZ4A==
X-Gm-Message-State: ABuFfojpFC7flQhYHx+8o2Leub4q+ac/63o+QlQTWI7T+qKFUwuJIyn7
        5FlsYaiNulDKPgu7k8S5THDU5M5wEJc=
X-Google-Smtp-Source: ACcGV61fuQQ0iW5aZeqcft2ermAFW27Wr/C+O6CPP7Vp30IhvtlV2VWS798LYnIlRwfhU2zx8xTnOw==
X-Received: by 2002:a17:902:b403:: with SMTP id x3-v6mr19232609plr.237.1539645398172;
        Mon, 15 Oct 2018 16:16:38 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x20-v6sm20505698pfe.131.2018.10.15.16.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 16:16:37 -0700 (PDT)
Date:   Mon, 15 Oct 2018 16:16:37 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 15:51:51 PDT (-0700)
Subject:     Re: [PATCH v4 0/5] Fix some bugs on RV32 build fail and issue
In-Reply-To: <CA+ZOyaig6dwzfhUn5CQ92P__yay2-aAgA4Nh+VxTs50FCbECwQ@mail.gmail.com>
CC:     aou@eecs.berkeley.edu, Christoph Hellwig <hch@infradead.org>,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     zongbox@gmail.com
Message-ID: <mhng-4a97b34b-cb44-42cb-9fd8-d62b95edfa7e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 05:33:17 PDT (-0700), zongbox@gmail.com wrote:
> Zong Li <zongbox@gmail.com> 於 2018年10月3日 週三 上午11:12寫道：
>>
>> This patches contain the modificaion as follows:
>> 1. Fix up the building fail on RV32.
>> 2. Add umoddi3 and udivmoddi4 functions for RV32.
>> 3. Fix ioremap problem on RV32.
>>
>> Thanks all for review these code and modify the copyright description.
>>
>> Changes in v4:
>>  - Retain the complete copyright description.
>>  - Modify commit message.
>>  - Rebase upstream code.
>>
>> Changes in v3:
>>  - Change the copyright notices to GPLv2 from  gcc 4.2.1.
>>
>> Changes in v2:
>>  - Retain the copyright notices from libgcc in umoddi3.c and udivmoddi4.c.
>>
>> Vincent Chen (1):
>>   RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap
>>
>> Zong Li (4):
>>   RISC-V: Build tishift only on 64-bit
>>   RISC-V: Add preprocessor directive for swiotlb
>>   lib: Add umoddi3 and udivmoddi4 of GCC library routines
>>   RISC-V: Select GENERIC_LIB_UMODDI3 on RV32
>>
>>  arch/riscv/Kconfig        |   1 +
>>  arch/riscv/kernel/setup.c |   3 +
>>  arch/riscv/lib/Makefile   |   3 +-
>>  arch/riscv/mm/ioremap.c   |   2 +-
>>  lib/Kconfig               |   3 +
>>  lib/Makefile              |   1 +
>>  lib/udivmoddi4.c          | 326 ++++++++++++++++++++++++++++++++++++++++++++++
>>  lib/umoddi3.c             |  48 +++++++
>>  8 files changed, 385 insertions(+), 2 deletions(-)
>>  create mode 100644 lib/udivmoddi4.c
>>  create mode 100644 lib/umoddi3.c
>>
>> --
>> 2.7.4
>>
>
> ping

Oh, sorry about that -- I took them into my local tree but they didn't make it 
to kernel.org.  They should be in for-next now.
