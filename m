Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D77C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E840920843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="fazlc9tT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E840920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeIZMGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:06:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42474 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeIZMGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:06:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id b11-v6so9395298wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6F//37tKLAYgXDjZTgenOShggxid6AOcFiyV450DGso=;
        b=fazlc9tTakpyeTjpQB8Y46E0moKh2rkThqLTUduPf0eczWUUFKqXBnBXdVUXnBeSQB
         U9eQr20gZO3VUPsCcVh5BiJWED1Cls76PmV5wkJU+7SGuhEV+jW5XqrvUqEV7plpE7XU
         adPKFaPbq2v7shb1IcikY8JSvA8zxd4+tklW3KUZnhNitXMJO0lD2bPnjZAgJsSE8ZV1
         xRVd1QfvDYVZSUVQ8BoYcFcOjNhJCZLIni7VAiEOipAX8yVvERnM8G8IMwbu5dj//8+F
         XSepkFXb/XuWuxoX+PPhPBH+0MjyI+IeeCsjprdDuPCv8HNUTW97h6xOJVAnNFDYZcO+
         MQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6F//37tKLAYgXDjZTgenOShggxid6AOcFiyV450DGso=;
        b=EukAeKENRqvaUi93vQhBSKXf6df4XQaXj3lxDz/hd/dMH98ziCAwApwiHr5UouYXea
         3kTiZo+AM0Ju4enSTEI+IFtOesfJRNgRbGHqhbW5pjdm+t8nHXsiaQjMFfG6P4FVwmqP
         FDUVAgEG3FEaI2s5bm+TbRjKmjKOVFUPSawIv751fh4nGwt2mBSjfbR+Zhc48odTcx+T
         Vi6OgtVuuBkefnqGAH6zyingn/gnndANE9vJGuBpEkPx+BT/Gn/gfFvRYZOhc0i4Dq8K
         sYowC0J9OMNQVIwsvZBjpwex/hgkrpL4mMyEaJ51C50DT/1kVBVjWlISMpNzwpQqkfmD
         Ta4A==
X-Gm-Message-State: ABuFfogp0JA/Ixj2mrCflw0bbJjjzTDfELVCzTAYEz6yWrhlaZ2+x6lN
        508YDjCvUWEpeWSA3zslDoL+X5+q54Pbyth3cX5InQ==
X-Google-Smtp-Source: ACcGV62kiW7eNzgKy0Q6aeyPDO5KuJIZH/Yk2JZlQdQ9ABpp+uepapJkTUDTngfJ6+hKxtOK7Jr20VlYqLW/vP3oR+E=
X-Received: by 2002:adf:f5ce:: with SMTP id k14-v6mr3587533wrp.59.1537941299876;
 Tue, 25 Sep 2018 22:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org> <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org> <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <20180910161328.GA13171@infradead.org> <CAAhSdy2Y-XTZ12i5aV+SzraMZP1YQBhAArpER-YssPcBJNOPOA@mail.gmail.com>
 <20180910163543.GA13052@infradead.org> <CAAhSdy2PSLjrtmSbkJ4w-v-zWm2hjii3XL6HE5Pe7u3wz4BmZA@mail.gmail.com>
 <20180917141436.GB2821@infradead.org> <CAAhSdy1gD3tZLmBzfpJV1qQKsG4GKgLkoBC7v5Kycw8KX+YeLg@mail.gmail.com>
In-Reply-To: <CAAhSdy1gD3tZLmBzfpJV1qQKsG4GKgLkoBC7v5Kycw8KX+YeLg@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 26 Sep 2018 11:24:48 +0530
Message-ID: <CAAhSdy3unGBSS9Xgozwt4so_RBOr1WSugiP-4J49q-GOub2mDQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
To:     Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 7:58 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Sep 17, 2018 at 7:44 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Sep 10, 2018 at 10:08:58PM +0530, Anup Patel wrote:
> > > > They could in theory IFF someone actually get the use case through
> > > > the riscv privileged spec working group.
> > >
> > > Their is no point in having each and every possible local interrupts
> > > defined by RISC-V spec because some of these will be CPU
> > > implementation specific in which case these local interrupts will
> > > be described in platform specific DT passed to Linux.
> >
> > Again, to legally have implementation specific local interrupt types
> > you'll first need to convice the spec to change the status for those
> > fields from reserved to implementation specific.
>
> I agree, this needs to be first clarified in RISC-V spec. May be this is
> a good topic for discussion in any upcoming RISC-V meetup.
>
> Until then anyone can try these patches from riscv_intc_v2 branch of
> https://github.com/avpatel/linux
>

I released that CLIC is going to be available for both M-mode and S-mode.
Software can choose to use HLIC or CLIC based on it's own preference.

If we are going to support both HLIC and CLIC in Linux kernel for per-CPU
local interrupts then we should definitely have irqdomain and irqchip for
per-CPU local interrupts. The selection between HLIC and CLIC will be
based on which driver gets probed via DT.

Regards,
Anup
