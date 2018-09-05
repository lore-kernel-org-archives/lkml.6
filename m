Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17964C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C390E206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="VulkXkyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C390E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeIEMuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:50:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35146 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeIEMuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:50:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so6771928wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8K1I8xc2w8AOJe7r3dRzbBGSdnCPfuIEXe71xRHHcnk=;
        b=VulkXkyon7b59NFZ9E11H0GO+W7Nz+DxfcMDb22y9q+AC8OStL9DjcUxxuIla90pWk
         ZcqXuWGOSA0NwPjJErtyeTcuj6UVptWTAduXZW0Vja82cKA63q8JJLV79+IVso+LrWDx
         Ij0H7zVG3XeNckCxnH3Ri7ZaYw4fN0iJxPq7nqH/UCHg266Oex2KIbZomYBm1FlNrFeO
         fHxzsNEL92cS8AmYQwer3/2f6sb3aaj/Fe8KmnIOGfr2iJhQIbriu0Llhg/5AO5uvioE
         KIDy5v00sfzwpN4MtbRHUg7rcHV46SW46/sec6/0fVAr3VKlR410wTDggl/Lkbyvb7M0
         f8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8K1I8xc2w8AOJe7r3dRzbBGSdnCPfuIEXe71xRHHcnk=;
        b=Lx5e34M+bQ50mSeH99hZoY3q9lwWTyRrn12WcFfZhg7Po5iIO/elCnK1GIi+Unljax
         i16jxnRQH05XEcx/6JTPGXOx4NTl7x5eGJcS3mbddmbqL8WQOLCYf77StaG1YkFCpiUc
         YXk2/sqXK/xVrM3e0DfV6RuyH/A/ri4iLDLtZfzCd228zkrIhZL4jVmY/6aKAwP9wSXc
         RieOKfwn1+06D4wdoiYBUFdlGIofHxoRk3OrZbERKVxLXIiVrRDZy761NnhDkPfNJ4eU
         Vikce4LjoPMqqJcsZviZFL8CZq3nuuHUJICqPnRMTKPBeh0ugUnd8kEo2dIUdUbJTU/M
         Xpfg==
X-Gm-Message-State: APzg51C5yoKWzzAprjTRMs9ktXyhf9A/hZAX2obBr5z+2YaPjRAMY6dM
        DHgqgLOVHga+IwoDO3CV/bQAr4MpKKXcIYIneTK9Jw==
X-Google-Smtp-Source: ANB0Vdap1FVUievUrSA/sxRi7JLxNiw6281xGbdpEmNiYwHwMM9Vhtqf62eJH87JCJ2lP6i4/GJWD0UtdcXycAdr0og=
X-Received: by 2002:a1c:3a08:: with SMTP id h8-v6mr10789736wma.126.1536135660716;
 Wed, 05 Sep 2018 01:21:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 01:21:00 -0700 (PDT)
In-Reply-To: <20180904185826.GE25119@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org> <20180904124514.6290-6-anup@brainfault.org>
 <20180904185826.GE25119@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 5 Sep 2018 13:51:00 +0530
Message-ID: <CAAhSdy2BBuuJbT5Rp8GG2baOXM++ERr1JuZoKTrmWqxhPxu5Cg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] clocksource: riscv_timer: Make timer interrupt as
 a per-CPU interrupt
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 12:28 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Sep 04, 2018 at 06:15:14PM +0530, Anup Patel wrote:
>> Instead of directly calling RISC-V timer interrupt handler from
>> RISC-V local interrupt conntroller driver, this patch implements
>> RISC-V timer interrupt as a per-CPU interrupt using per-CPU APIs
>> of Linux IRQ subsystem.
>
> And the point of that is?  Except for introducing lots of pointless
> code of course..

Instead of short-circuiting timer interrupt from low-level IRQ handler, we use
Linux per-CPU IRQ handling for timer interrupt.

Without this patch, output of "cat /proc/interrupts" looks as follows:
           CPU0       CPU1       CPU2       CPU3
  8:          8         12         18          6  SiFive PLIC   8  virtio0
 10:          9         11          3          5  SiFive PLIC  10  ttyS0

With this patchset, output of "cat /proc/interrupts" looks as follows:
           CPU0       CPU1       CPU2       CPU3
  5:        995       1012        997       1015  RISC-V INTC   5 Edge
     riscv_timer
  8:         23          6         10          7  SiFive PLIC   8 Edge
     virtio0
 10:          9         10          5          4  SiFive PLIC  10 Edge
     ttyS0

Regards,
Anup
