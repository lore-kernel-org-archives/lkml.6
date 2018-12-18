Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628C2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0E6214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ckuzd2hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeLRIZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:25:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33554 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:25:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so6549621wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IpykpJoy63zv5Qr2sa4YjvLcDK9nBwqseXtSqQ+mgA4=;
        b=ckuzd2hi1aO4C8vNbcH8WxP+w7qciNjsquy0ycxsGqWOI6gOBgVIjVsQFl6ZSWQVGs
         lWwHW3bTLXqVisGxPiE7aBUIiVdI+837SUHideezgE207xsd/2/kLnpW8MteUDN2czcn
         y2pOL5akqm2QyqUN56z4gTA9xBjpfEh8qRdvJnKolRUHnuNXCOgDZNf9ysTBluFn4DbE
         IQUqgG5rZsVbpyIaIMTj68UDbNv1B//FsMx4v7xa3mYtvYseeTsSV8qNXFnV8+EyrEb2
         /YCC20RwHcB3p7U0NcG116a4U5Vix0bff50v5bt27uB+wHPeJBv1D+eNYVyg4yZwV7XZ
         bgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpykpJoy63zv5Qr2sa4YjvLcDK9nBwqseXtSqQ+mgA4=;
        b=UTZAYSfpPGUttPCHpPJ3ryo0oD2eM5ZBTGwpc/mc2hp2GUHVn5QHKt1UCX4DyOMZMX
         lm7pGLkzti4HdhlzMQdFLWf520xkm5AO9OFLtSEyIYv1sZInKhWs79CvklUjyd2r7LGY
         v6S+fTHtL3ATXDoB10XogpjVWE3Kkdo5uHJM+TzTxLXOk6GAzMD+zDno0lQtztt+iGCZ
         tLxBPTolinPsDZcTklh1O+jaELIH4Bdnd/65pT8pqNpeRDbtoZVM8Ae85/428Kpu91wq
         OhXTi18DWtlBn/QaSiZdAhz1f1bVBl34gTklQnrfBPMhKbUqGE1XNJgqIVpZopHy8llR
         54xQ==
X-Gm-Message-State: AA+aEWb7kSKw/q8AL6ynL15B30zIlM+TGkLME1b13wHMzkcpba/hZN1x
        m5gxl2bFFpRMxyI62lJgHgL3dAH8WjZdHUNbZTFwHA==
X-Google-Smtp-Source: AFSGD/Xp7ENy9UfdLu8zRnlO/IIwh2pr5bRJHzoRtpL31TWpNg0VyqLScnkpaYCx3/pvVXpDDqt+B2rDV0m3mLJp3yw=
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr2205887wme.16.1545121511510;
 Tue, 18 Dec 2018 00:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20181130080207.20505-1-anup@brainfault.org> <20181130080207.20505-3-anup@brainfault.org>
 <20181217182415.GA7086@infradead.org>
In-Reply-To: <20181217182415.GA7086@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 18 Dec 2018 13:55:00 +0530
Message-ID: <CAAhSdy0_m-TfBYTEBw_k5+n9WC8c_ASg0A=_0S2TPHppCFCWgw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] irqchip: sifive-plic: Add struct plic_hw for
 global PLIC HW details
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

On Mon, Dec 17, 2018 at 11:54 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +struct plic_hw {
> > +     u32                     nr_irqs;
> > +     u32                     nr_handlers;
> > +     u32                     nr_mapped;
> > +     void __iomem            *regs;
> > +     struct irq_domain       *irqdomain;
> > +};
> > +
> > +static struct plic_hw plic;
>
> Please use local variables instead of a single instance struct.
> And only add these variables in the patches where you actually need
> them.

I am sure it will be useful in-future but for now I will
remove the struct instance.

Regards,
Anup
