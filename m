Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AEBC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C8520865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="dfY1Ccis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C8520865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeIKIzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 04:55:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56196 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeIKIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 04:55:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so23518548wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 20:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Md5Drb81F2xVjAzduHW8JE6+LJwiuyyOBmL4TAOEDWw=;
        b=dfY1Ccish/6sDxv4O78jmcPOe4gOYKNaOEmmNkoBTprTxG/sCeJdcivkaYo2jnplhG
         LrDVpXbZzmnLFKlRvyZitttX0rc7HsahFgz/D8IQhLG3rbnMg+QNCpDNG69IKU8HTBS5
         JKvaXQ+vZm9zDGq+rpKVF4wn0EuWj4SgaM0VCqwnln+gQX9FOrkRaPKgc5Au/mc5x/36
         XwuTk9c/2A32GNFmkZMAIwQulcBaTWlsEYHJh4AOgIh7cSFyX5a3kMPh0QbcS0VcBbp6
         2+Fh7T87FNO0gPrZxhCnmyyKHYMwd/HBUFJ7kUYFJmGESEjG4z44XMSPaHnLhec8bKEw
         M4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Md5Drb81F2xVjAzduHW8JE6+LJwiuyyOBmL4TAOEDWw=;
        b=PpuDWkUqUqbM4uWtm3SAhWlji5w85wG99RKnqwHtOpfmwMNVdWB914EfJ41C24Vd/q
         sXTOIu925OSmnQIKl13p/XeaLVNLBMwO0qB6O5hUE63YCoFIQNUHOaj0LIUb9paA2cxu
         aq5P3Yaiv+120ZOp/8ivRqv9GMC8L9RDZ8WosApnMIAL5IZUyX8vQehspQqYl0BsTqgF
         RnM2Y82+smlj09DRQ/KVv+NzvbY3ja63vNHyZkOx61nekjfsv70v89JAwLB+o95woY/h
         ZntUmnenhkW5okBsWE3Wma48zla4qQiVdARjvBe3qIyt5LeoYVxvp7O3CS7ZfGLdC/bh
         FjBQ==
X-Gm-Message-State: APzg51Af+jYXSNsBdLheCgVeXTfKvDBNZs+pocOXAnIvxDiHG+L9lTmL
        iFs4xK3O7ioCvKRq4oHWhQ6108Im0ej6Z9O4+/rgfA==
X-Google-Smtp-Source: ANB0VdaYiB1DKZRI5SbnjWHG4MF5ChJgSVBDLf8TSIdgsdbLjDQvgrn4lguqovmY7Ro5Oii/2UnTBM28+ICAmkvgXn4=
X-Received: by 2002:a1c:ac04:: with SMTP id v4-v6mr2759426wme.51.1536638266324;
 Mon, 10 Sep 2018 20:57:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 20:57:45
 -0700 (PDT)
In-Reply-To: <20180910221902.GB7368@infradead.org>
References: <20180910133902.GB21593@infradead.org> <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org> <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <alpine.DEB.2.21.1809101805110.1419@nanos.tec.linutronix.de>
 <20180910161143.GA1053@infradead.org> <CAAhSdy0kgsy0QFDQGYeVy6vxu8v7UwRGbdJC9Hhz+36TNYjyGA@mail.gmail.com>
 <20180910163936.GA18699@infradead.org> <CAAhSdy3AN4YTaAJCR50WMB8CgaoZNeT9uOZt2GH2O6i8Y6z6ew@mail.gmail.com>
 <alpine.DEB.2.21.1809102133240.1419@nanos.tec.linutronix.de> <20180910221902.GB7368@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 11 Sep 2018 09:27:45 +0530
Message-ID: <CAAhSdy2uAqOQohmx_HDgR1MbtWeOdc0MTFxToMK2Ak9-za1evg@mail.gmail.com>
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

On Tue, Sep 11, 2018 at 3:49 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Sep 10, 2018 at 09:37:59PM +0200, Thomas Gleixner wrote:
>> Processor local interrupts really should be architected and there are
>> really not that many of them.
>
> And that is what they are.
>
>> But well, RISC-V decided obvsiouly not to learn from mistakes made by
>> others.
>
> I don't think that is the case.  I think Atup misreads what reserved
> means - if you look at section 2.3 of the RISC-V privileged spec
> it clearly states that reserved fields are for future use and not
> for vendor specific use.

I think I understood what reserved means here. If reserved bits are
not for vendor specific or implementation specific stuff then it should
be mentioned clearly which is not the case.

The list of currently defined RISC-V local interrupts will definitely grow
based on my experience from ARM/ARM64 world.

Like Thomas mentioned, we will definitely end-up having separate
irqchip and irq_domain for RISC-V local interrupts for flexibility. Better
do it now with separate RISC-V INTC driver.

Regards,
Anup
