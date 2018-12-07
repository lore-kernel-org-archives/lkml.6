Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E1EC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D4720672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DQe7Ioyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D4720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeLGSan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:30:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38558 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeLGSag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:30:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so2077226pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XSSMSULfAytnxie2DsEU0LDybwmkejAR17D3/hDbfbE=;
        b=DQe7Ioyxn4rM5SD2hvHuBSvu2hLQgPkppx8RxtmvCmDTqaOsCGQqxTpHIUhahN9g4r
         cn4xVgPamU190S9Mr3TGbIi+b5ifAOzpxImMvD2tb09UAmbIRLwfEyMPbSK5tBtFl8Ik
         7rb2Qv7TS4RjE8DMasRoOs8ZnUQbfVe+KgjHVMbMeCm/Y18ZZheU1wHWikGH0o0oUVep
         qw8uqx58g+Rr4ceadSs96giLax9zLzQqroB8ZfKA6Rjq11V9ajk3gQkxQdca/8+4f9H8
         6W0D27NHUlz2Fsx4PUmhN8lm8qhYpm/9E1cbGNhMWBygLFqHIcbHJ54Wzfz/IDIHG/QG
         soLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XSSMSULfAytnxie2DsEU0LDybwmkejAR17D3/hDbfbE=;
        b=CVVM6TMSocUQy+PnFT3+c4mxX9SapfCSb/TlD4fTz6AC21yrr7VRxa8xr1VmEulEMH
         s1x1j327XD/0Sx9AjtFFDe4tjN0Ua82AdhziLT1Ee/+fhDoq75ZDaT99Z16UIE+oG4IV
         GzX/+aMyNDVzrKKH27GmXRnNG/cEZ/2PLaAGSJXCBKpgIjJHKF0W2UdkKVMlpVzEZ2Qo
         iVT+Gm0FHf/NrMi5Hxz89Yk24PNZbDkKoy/KxFbh1id3MdpqgVxt7TUMmF3COtIinAVX
         lrOu9WsVqidwsKwWXXceFucCQJg8hPV2B2Q7n9illjY6tRi6diF9pWyoIFb8uaxX6yLx
         xjBg==
X-Gm-Message-State: AA+aEWaJxroCwvX/yJTR2+v1oszO67fBMZOlSEJcDqSI/0BOcr5bhFhI
        0fEKdjRlVbP9RLvxOrYKRc41yg==
X-Google-Smtp-Source: AFSGD/WMxbhCzfK78f+8OkNMEj7eM17qLZcfnCKqIdGsDaDhQm2/NBMpzjABAIFkopUMo/eY+xFVag==
X-Received: by 2002:a62:9111:: with SMTP id l17mr3292831pfe.200.1544207434804;
        Fri, 07 Dec 2018 10:30:34 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id s2sm5867597pfa.167.2018.12.07.10.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:30:33 -0800 (PST)
Date:   Fri, 07 Dec 2018 10:30:33 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 10:30:08 PST (-0800)
Subject:     Re: [PATCH 0/3] RISC-V SBI earlycon
In-Reply-To: <20181204135507.3706-1-anup@brainfault.org>
CC:     jslaby@suse.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org, Greg KH <gregkh@linuxfoundation.org>
Message-ID: <mhng-e67fd38e-d244-43da-817b-0b703347aa83@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018 05:55:04 PST (-0800), anup@brainfault.org wrote:
> This patchset adds RISC-V SBI earlycon and removes RISC-V EARLY_PRINTK.
>
> We should use earlycon over existing EARLY_PRINTK for SBI console because:
> 1. It's a more generic way of implementing early console for debugging
> 2. Current RISC-V EARLY_PRINTK is a compile-time option whereas earlycon
>    is enabled at run-time via kernel parameters.
> 3. To use earlycon with SBI, we have to pass "earlycon=sbi" in kernel
>    parameters. If earlycon kernel parameter is not provided then kernel
>    boots much faster which is very useful in real-world RISC-V deployments.
>
> The patchset is tested on QEMU virt machine. It is based on Linux-4.20-rc5
> and can be found at riscv_earlycon_v1 branch of:
> https://github.com/avpatel/linux.git
>
> Anup Patel (3):
>   tty/serial: Add RISC-V SBI earlycon support
>   RISC-V: defconfig: Enable RISC-V SBI earlycon support
>   RISC-V: Remove EARLY_PRINTK support
>
>  arch/riscv/Kconfig.debug                |  2 --
>  arch/riscv/configs/defconfig            |  1 +
>  arch/riscv/kernel/setup.c               | 28 -------------------------
>  drivers/tty/serial/Kconfig              | 12 +++++++++++
>  drivers/tty/serial/Makefile             |  1 +
>  drivers/tty/serial/earlycon-riscv-sbi.c | 28 +++++++++++++++++++++++++
>  6 files changed, 42 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/tty/serial/earlycon-riscv-sbi.c

I'm adding these to my for-next.

Thanks!
