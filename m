Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909BAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463DE20645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="QWNUzYxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463DE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeIJVdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:33:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44340 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbeIJVdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:33:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so22632816wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eT67aDDJX41BI/4OE8SPSYWviBYvqnHeXdNuaYmyZ1U=;
        b=QWNUzYxQ3z30rXNqI/j5w5dZry0roe5YdO6CFiT9qLdjN9YOTw6NyzdkA74L7E0Lpt
         Y+eyBDYG70Y6FtvU9tLNp59X4DIAtOfhH4HXAogiyAQIoPfGb4MXQlIrD1wyWhv5FvKY
         8meEZ4bbAV2ScuXekIyBE0UmG3UqTDx0dFGD8HZ01vXmKo+jAVaeQT3EwZDSSLL81dWD
         gGU94bt5L5lj3ReF4WhUGHypza/RFSeK0iTBYla04A25Ey4VEzC4Zt80YYzKtTGAmvjU
         Wzsl6rCaeC3xCzQa4kz2ENZaR+j5qy1S+NgrhygdO+AuLDuom9qt3FA1SyT6FvP77/8w
         X2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eT67aDDJX41BI/4OE8SPSYWviBYvqnHeXdNuaYmyZ1U=;
        b=oY2e7Q/LvMkj24RgRmEK8NDcpM/TiCa4WbLIIzKil5ojp80Md0PMrECnLj85YSnidb
         1fJI/SanbEMJm7hSr7/57R4bPMIKuPI/CRyn24UdIICRtfvg+Q7qQZSdNEoXnEaRGuo2
         7YLyyWxfUtH38ZCgjWZCVnom9dlTWB9utN1jg0n99oz/0QEjCBWO5LOzWf0ZHHWvgmFW
         DgMopYQdiSgevg8F965L25cX11noy+iV0kdj6xXZQtZeo3abNumuGg+ZGAYgmcqv3qrq
         58KHEtwxLKqsD9qZ9atlfTvLb1CmVraNRGjK/lv0dNpKk6FWJuQ/37R+Vmx+3HqZX2lG
         rfew==
X-Gm-Message-State: APzg51Dd4u/4PMCCxPBO+9fmsQ633L6Nr60asmEWU+16lfK+PIYZlzsM
        hXzTfJPwyN9zM7Ph9fMUlSWpIwX67LxeMMZ8/c318A==
X-Google-Smtp-Source: ANB0VdaCIiLQCqw/d2XS1VztgR8GvzmKyZny1pyMd/RiS9hQrWa/IT5yIFO5vVj2dxvJ11Ozx2CqQA7pNig0ktD0++w=
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr15056980wrf.46.1536597539091;
 Mon, 10 Sep 2018 09:38:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 09:38:58
 -0700 (PDT)
In-Reply-To: <20180910163543.GA13052@infradead.org>
References: <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de>
 <20180910132924.GA6987@infradead.org> <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org> <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org> <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <20180910161328.GA13171@infradead.org> <CAAhSdy2Y-XTZ12i5aV+SzraMZP1YQBhAArpER-YssPcBJNOPOA@mail.gmail.com>
 <20180910163543.GA13052@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 10 Sep 2018 22:08:58 +0530
Message-ID: <CAAhSdy2PSLjrtmSbkJ4w-v-zWm2hjii3XL6HE5Pe7u3wz4BmZA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:05 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Sep 10, 2018 at 10:02:09PM +0530, Anup Patel wrote:
>> You are thinking very much in-context of SiFive CPUs only.
>
> No.  I think in terms of the RISC-V spec.  I could care less about
> SiFive to be honest.
>
>> Lot of SOC vendors are trying to come-up with their own CPUs
>> and RISC-V spec does not restrict the use of local interrupts.
>
> Yes, it does.
>
>> The mie/mip/sie/sip/uie/uip are all machine word size so on
>> riscv64 we can theoretically have maximum 64 local interrupts.
>
> They could in theory IFF someone actually get the use case through
> the riscv privileged spec working group.

Their is no point in having each and every possible local interrupts
defined by RISC-V spec because some of these will be CPU
implementation specific in which case these local interrupts will
be described in platform specific DT passed to Linux.

Regards,
Anup
