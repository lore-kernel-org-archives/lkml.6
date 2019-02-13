Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C9FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEAD21872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vqf0GKKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392333AbfBMV5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:57:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46178 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392301AbfBMV5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:57:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so1788504pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=h0Tt7SZyTDJ6DflBzZW46vY/WCNY5xb1qWVxyZRRry8=;
        b=Vqf0GKKyzNkk4nQm+4Xbx9oKn4obU6LQiO6pE1hKrlrIj4xj4e/mz2ygDTD+y2zeQh
         X3TuRdLAGNV205LVrDX4AAp+B0u4ZjFNs9I/C3WVhgXT/4QO7H1vQgmYq4DRyAXPkfJQ
         gLiYQ8M82F8N8pIbiMd3LcgfC+mdq1Y+1nx99C1EzhtKGE4Beun6oQ0AAxETw9ql02ro
         VQCN5K6tMgSi26tsAAkV29bU+hlGyVuKBl3OdFCyjfRXx3/ffKAA0gDkSB4/98noOevR
         8gNhlGcDpdQUOWLrOjCNvVXO/J9wJCVzcE011GRmlSDtHD/Ij1WDXR96HM//MvYEA93r
         xgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=h0Tt7SZyTDJ6DflBzZW46vY/WCNY5xb1qWVxyZRRry8=;
        b=ts74WEz1myp0rnCNH2hlrtKHv0a8Wil5cpEh6a85p6xfK/ThoMPqGjOvxWz5E8zkIm
         AnT7JX7Z583uug8bT9dyrzT0WjnqbzIthwhmxF+uJzXHIzTrW5rCy6ehGiU2PnDL0XPz
         RLjBZcBZ5XJty3E7sQ9hGvD/uS1F8xGSJA5Sqeeg48d2umHsTi9P0h338v4FsjZUJKcy
         pJC1EsbjCIu0YUtcctxtOgPPhyhyfGuBendipBAeS3bIlO/WqasMXyuFHPmen+tZ0Zwn
         8Ntaa3QEP/wFt6PxjipunDC+c9Cy/4DuXzVoYYkkFdSBMXpfC9MB64nJADB1epYrm1BM
         4E0w==
X-Gm-Message-State: AHQUAuZxIhTMzo22JPSqd2E1AUawIcD1/YmpoEDCdurXx7qfnZLquFYX
        UpwKLCtq6LKtx9n1RBqe69NDzQ==
X-Google-Smtp-Source: AHgI3IahHRtXpofHtjjbypHnnY7Tj9D7QERZaFKffAubePpNTQsXnXATfP9TX1zXO7ZCRQrIedHtvA==
X-Received: by 2002:a63:d49:: with SMTP id 9mr338847pgn.27.1550095072073;
        Wed, 13 Feb 2019 13:57:52 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 15sm432030pfs.113.2019.02.13.13.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:57:50 -0800 (PST)
Date:   Wed, 13 Feb 2019 13:57:50 -0800 (PST)
X-Google-Original-Date: Wed, 13 Feb 2019 13:57:35 PST (-0800)
Subject:     Re: [PATCH 1/2] asm-generic/io: Pass result on inX() accessor to __io_par()
In-Reply-To: <CAK8P3a1-CA_d+tRRKh50+7-PU14AV=9S1JUSF4d-VUxZ+DcW4g@mail.gmail.com>
CC:     Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew.murray@arm.com,
        catalin.marinas@arm.com, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-30e76674-df9d-4689-8c77-3a3b4723ee24@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 12:59:28 PST (-0800), Arnd Bergmann wrote:
> On Wed, Feb 13, 2019 at 6:46 PM Will Deacon <will.deacon@arm.com> wrote:
>
>> On Tue, Feb 12, 2019 at 12:55:17PM +0100, Arnd Bergmann wrote:
>>
>> > For all I can see, this should not conflict with the usage of the
>> > same macros on RISC-V, though it does make add a significant
>> > difference, so I'd like to see an Ack from the RISC-V folks as
>> > well (added to Cc), or possibly a change to arch/riscv/include/asm/io.h
>> > to do a corresponding change.

Thanks, the original patches didn't make it through my filters.

>> There's already a comment in that header which says that the accesses are
>> ordered wrt timer reads, so I don't think anything needs to change there.
>> For consistency with the macro arguments, I could augment their __io_par to
>> take the read value as an unused argument, if that's what you mean?

FWIW, we don't really have a way to mandate this in the ISA yet as there's no 
formal model for either CSR orderings or the IO memory space.  

> Yes, that's what I meant, I should have been clearer there.

That sounds reasonable to me.  It looks like we can also go ahead and delete a 
bunch of arch/riscv/include/asm/io.h now that this stuff is in asm-generic, 
which would cause us to actually start using these things.  I didn't know this 
had all been moved to asm-generic otherwise I would have cleaned this up 
earlier.

I think this should do it, but this does bring up a bit of an issue: the RISC-V 
versions of reads and friends put barriers outside the loop, while the 
asm-generic version don't.  What are these actually supposed to do?

Either way that resolves, feel free to consider something like

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index b269451e7e85..378975f180a7 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -198,20 +198,20 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * writes.
  */
 #define __io_pbr()	__asm__ __volatile__ ("fence io,i"  : : : "memory");
-#define __io_par()	__asm__ __volatile__ ("fence i,ior" : : : "memory");
+#define __io_par(v)	__asm__ __volatile__ ("fence i,ior" : : : "memory");
 #define __io_pbw()	__asm__ __volatile__ ("fence iow,o" : : : "memory");
 #define __io_paw()	__asm__ __volatile__ ("fence o,io"  : : : "memory");

-#define inb(c)		({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(); __v; })
-#define inw(c)		({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(); __v; })
-#define inl(c)		({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(); __v; })
+#define inb(c)		({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
+#define inw(c)		({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
+#define inl(c)		({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })

 #define outb(v,c)	({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
 #define outw(v,c)	({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
 #define outl(v,c)	({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })

 #ifdef CONFIG_64BIT
-#define inq(c)		({ u64 __v; __io_pbr(); __v = readq_cpu((void*)(c)); __io_par(); __v; })
+#define inq(c)		({ u64 __v; __io_pbr(); __v = readq_cpu((void*)(c)); __io_par(__v); __v; })
 #define outq(v,c)	({ __io_pbw(); writeq_cpu((v),(void*)(c)); __io_paw(); })
 #endif

@@ -261,9 +261,9 @@ __io_reads_ins(reads, u32, l, __io_br(), __io_ar())
 #define readsw(addr, buffer, count) __readsw(addr, buffer, count)
 #define readsl(addr, buffer, count) __readsl(addr, buffer, count)

-__io_reads_ins(ins,  u8, b, __io_pbr(), __io_par())
-__io_reads_ins(ins, u16, w, __io_pbr(), __io_par())
-__io_reads_ins(ins, u32, l, __io_pbr(), __io_par())
+__io_reads_ins(ins,  u8, b, __io_pbr(), __io_par(addr))
+__io_reads_ins(ins, u16, w, __io_pbr(), __io_par(addr))
+__io_reads_ins(ins, u32, l, __io_pbr(), __io_par(addr))
 #define insb(addr, buffer, count) __insb((void __iomem *)(long)addr, buffer, count)
 #define insw(addr, buffer, count) __insw((void __iomem *)(long)addr, buffer, count)
 #define insl(addr, buffer, count) __insl((void __iomem *)(long)addr, buffer, count)

as

Revewied-by: Palmer Dabbelt <palmer@sifive.com>

when included along with the other diff.  That way we can at least keep the 
macro signatures matching, the cleanup can come later...

Thanks!
