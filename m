Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02C0C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D77120676
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Vld+L0Jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D77120676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeHUUZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:25:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38740 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeHUUZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:25:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id w11-v6so13898555wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FKzjo54RIPB2NUwiG8mqiZqKdVRLyqbjaLowygDU56k=;
        b=Vld+L0JxZxo+mrq0OvOJj9avcJSX2GthVC6gqtZ+S1gh8TgTZLsW6FFO7KfscUZSbL
         vRg2GgRGeLG0+vmSjoG2DvxMeuHRzZhU++aVyj6kKDwWHFjOUm2nNioNWuYJSeVNM+oM
         gKrY5lZsRCbNA92GJ5B4QB9BJCgspBp9JIizPJio0tvEzZ6MEmIpOqojoXWy9KG8R4+0
         Pqh8A0y1kRhHh0DtJ91GZo/qfUp7ryHYwURMGBuipPEK/ijozloaQSr2pS8JZj+2TYlC
         iSpjrJu7yfj6jh5EqdH6X+ZHrSezhCUftUboeQEUH9vvcW/8uua/5y/228sYheGjmVmS
         9GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FKzjo54RIPB2NUwiG8mqiZqKdVRLyqbjaLowygDU56k=;
        b=NZlINc6BuSiUvIKWaeqy8hU6wXSwElTHpwCP6YBg304lKt77KMV2QpGMUIhk/C23Uh
         M59i5H/pyJoYpuM12ebc28sBwbSTwmRCYUxRboLi/OrIKmKGiywSIAziMOmV09wSbD7p
         JTMeHHn3XsdGLFQlhTGjPmSL/Zc5vosyBQMV9zL9r9t6hx3uiFV8R0tN6X+kdE04bs38
         NjInHYkrbV2/DqSF7PlXsuNmwlBRLwPaObqwY2IebH00IaHvX6hMT+3xSdconxSU9Rm2
         QPUE4X4Dop0BS0PplKGLtYsVBBjocFZ7ftnECR+p3gMUpu7r9g20hVpVySlRi6kq95Cy
         mtAQ==
X-Gm-Message-State: APzg51ABWzIAPRnOUw3EPbdfADjMiLS2VxMGnFbUvlMbe+mJKpkhyRJu
        chQiHFs2cg1YMVw7eobMpoSzJNcCGHxnN8/ydlBajw==
X-Google-Smtp-Source: ANB0VdY/R4e1XmD8+UZfZDY7XNiPNmWXoObKx51ZO0Uy73F4zWz5kvlxlfMPo+HMUFPAOdJmEyySlro4QhRjnuhVQAs=
X-Received: by 2002:adf:f5c9:: with SMTP id k9-v6mr7121745wrp.59.1534871079271;
 Tue, 21 Aug 2018 10:04:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 10:04:38
 -0700 (PDT)
In-Reply-To: <20180821074826.GA28079@infradead.org>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-4-git-send-email-atish.patra@wdc.com> <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
 <ce39a215-3bb1-d866-0d84-76642acb70bc@wdc.com> <CAAhSdy30Fz0Ki5zMws6hspgn=xwcFLj3VVixH88UWGU+oehBQg@mail.gmail.com>
 <20180821074826.GA28079@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 21 Aug 2018 22:34:38 +0530
Message-ID: <CAAhSdy2NP4raXXPVvEJyAO127=J9jR3NNEHLF=vigBz=v-Qqkw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 1:18 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Aug 16, 2018 at 11:51:03AM +0530, Anup Patel wrote:
>> Having thought about this more, I think cpu_ops should be an pointer array
>> of NR_CPUS size. This means its not necessary to have have same ops for
>> all CPUs. The ARM64 implementation of CPU operations also allows separate
>> CPU operations for each CPU.
>>
>> For example, let's us assume that we have an SOC where we 2 cores
>> per-cluster and N clusters. All CPUs of cluster0 comes up at the same time
>> whereas cluster1 onwards we have to bring-up CPUs using special HW
>> mechanism.
>
> All this (including the patch itself) seems a little hypothetical.
> I'd rather only add all this infrastructure once it actually is needed.

The cpu_operations is certainly required because SOC vendors will add
vendor-specific mechanism to selectively bringing-up CPUs/HARTs instead
of all CPUs entering Linux kernel simultaneously. In fact, we might also end-up
having CPU ON/OFF operations in SBI.

Having separate cpu_operations for each CPU is good for flexibility because
CPU clusters might have different way of bringing up CPUs (for example, take
any Hetrogeneous Multiprocessor Systems (HMP)).

IMHO, RISCV Linux port is new and this the right time to implement critical
infrastructure things (such as cpu_operations). Also, its not something radical
because we are taking inspiration from existing Linux ports (such as ARM64).

Regards,
Anup
