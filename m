Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECADC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6871F2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="atpTXFAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6871F2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeI2GS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:18:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34883 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeI2GS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:18:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so5320624pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=OnT54z5lgaA9LYwi8+7ZPe4Iw8qJqNThCDiT5afzxE4=;
        b=atpTXFAEOoVV2Tvoe/9xuQpRmltCARrRutFpFsk+ykbLsKU5ERcJDUx1mp5ld5ifgu
         nUDEkY2DxLclyHaElK90g6rSNPRbOjFghnN5hhZR8jqzX/ioy859l8mV1OJsD2Kl6kfe
         Qu3yrg8O2uQQHcTG2Kag09wMY0DAWashv7IuPzaSstz5WNaBaRJuZ+STIkiKI7awiJRV
         LEkyBqs9nCStga4WUsICeU+YwXOrXEvE6hcjtsftkw5wFqpv83IwDb2TxoHVwZuQfkZx
         cgAwNrTL/Htwdv7NYY3pr7tBfXE7sjeMkW1J+vSXUTdFQtX7MiB9E8irxCDm2AbQ8zvR
         ZCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=OnT54z5lgaA9LYwi8+7ZPe4Iw8qJqNThCDiT5afzxE4=;
        b=YHEFwGPsq23dW4UGvlPLvcDcJLp0RUWAxQ8+dVC2d/KHU1wJriaxHEDFUzrf+Ts2yi
         Xv4ag5FFZoFd20bxzW/dYq+R7otp+7zz/UcT69GJhaFCZXFYB5XAhOLXJECKu16+D/E6
         l5kNiifcQdN/i/L65A3aSEzqa63nsilBkW0iKjDKbscssnIuyi1xv7O19SbLggAnlVk2
         3LBf+dyVJLOPNs9xTnn1uZJNu9otCGm8qv3Pjl9B2sAkcHr9A1B0rb1GUov0x9QMf7np
         tBqUeNRIrZOnP/Uih74vV0fXu7mq9SE4WE/7jRan/gOPd24Jm0yxtJ8vkK2SM94xMrF5
         gTAg==
X-Gm-Message-State: ABuFfoh9zEZeP73CRjHrbVKtRo1NIUx60YiiuAc5in+Se4EcnN8z+5Dv
        7mZk72f/rb2ciNfPePNJCqAJVA==
X-Google-Smtp-Source: ACcGV61Pix4ATLo985K1Eza8oxcyndnQwfnEvur90Met3eYk/2XQiDEm1cxLA8k4Mr07M6SNzmNiJw==
X-Received: by 2002:a62:34c4:: with SMTP id b187-v6mr826125pfa.15.1538178740272;
        Fri, 28 Sep 2018 16:52:20 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y3-v6sm10237794pfi.24.2018.09.28.16.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:52:19 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:52:19 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Sep 2018 16:51:53 PDT (-0700)
Subject:     Re: [PATCH v2 0/5] Fix some bugs on RV32 build fail and issue
In-Reply-To: <cover.1537949825.git.zongbox@gmail.com>
CC:     aou@eecs.berkeley.edu, zong@andestech.com, vincentc@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zongbox@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     zongbox@gmail.com, Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-1934187c-6fab-4000-af19-23a80173669d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 01:31:09 PDT (-0700), zongbox@gmail.com wrote:
> This patches contain the modificaion as follows:
> 1. Fix up the building fail on RV32.
> 2. Add umoddi3 and udivmoddi4 functions for RV32.
> 3. Fix ioremap problem on RV32.
>
> Changes in v2:
>  - Retain the copyright notices from libgcc in umoddi3.c and udivmoddi4.c.
>
> Vincent Chen (1):
>   RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap
>
> Zong Li (4):
>   RISC-V: Build tishift only on 64-bit
>   RISC-V: Use swiotlb on RV64 only
>   lib: Add umoddi3 and udivmoddi4 of GCC library routines
>   RISC-V: Select GENERIC_LIB_UMODDI3 on RV32
>
>  arch/riscv/Kconfig        |   1 +
>  arch/riscv/kernel/setup.c |   3 +
>  arch/riscv/lib/Makefile   |   3 +-
>  arch/riscv/mm/ioremap.c   |   2 +-
>  lib/Kconfig               |   3 +
>  lib/Makefile              |   1 +
>  lib/udivmoddi4.c          | 309 ++++++++++++++++++++++++++++++++++++++++++++++
>  lib/umoddi3.c             |  34 +++++
>  8 files changed, 354 insertions(+), 2 deletions(-)
>  create mode 100644 lib/udivmoddi4.c
>  create mode 100644 lib/umoddi3.c

I like what this does, but there's a license issue here that Christoph pointed 
out.  It'd be great to have RV32I systems booting 4.19, do you think there's a 
chance you can sort this out next week so we can get it into the last RC?  That 
would help with the rv32i glibc process, as we'll actually be able to boot an 
upstream kernel.

It looks like the functions we have an issue with come from libgcc2.c, which 
doesn't change very much.  As far as I can tell we might be able to get away 
with these functions from 4.2.1, which was licensed under the GPLv2.  Here's 
the relevant functions on GCC's github mirror

    https://github.com/gcc-mirror/gcc/blob/gcc-4_2_1-release/gcc/libgcc2.c#L559
    https://github.com/gcc-mirror/gcc/blob/gcc-4_2_1-release/gcc/libgcc2.c#L844

These look very similar to what you send out.  As far as I can tell, if you 
base your code on the GPLv2 version then this should be fine to include.

Thanks!
