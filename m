Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37042ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCB3214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ecYAHt+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCB3214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeIQT4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:56:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37471 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbeIQT4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:56:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so17517850wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpdacyBz7Aitu7rQFkryLBnVX+BIbr+xu4zAGh9/7vY=;
        b=ecYAHt+ENKUPw1PZXPUxeKC0OzWIJObXEB60hMrR8LjMWTV2p1lyyOstztL/KGL7hu
         blSrS9JKJkRMKfPv4Wv4ZuS05rPnq1rWvSdJiMxcG1j10BxjQVyGtzM38SsEqeWjtn6T
         Ccya0jnkulnqJedTHFRsTZu2Yr/phXBFAjnXyt895xkzeCn7A/Q9jZ/s1owpOrgPdVSX
         rbQHsmw8oA4KdWIjRHdbRN7p3thmHTBp4muz89ORbyUuWDvNrNjvWn6bQvKCeIWYY1yb
         6Mv141yxf02bamJwdKSFP315WHHTVofk/YCBP9hsOhCXvOT/VRBlUgehqhCeyoZ98B+k
         1QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpdacyBz7Aitu7rQFkryLBnVX+BIbr+xu4zAGh9/7vY=;
        b=aySKST7wzHcMcFbs+u4LbDLkFba2EhBULSuWT5N9dvI9K4q9LG5hUzdChKL06IidQa
         e1yCOQeMCvvBpjxVpQq0upfSiZtAE+b67lp5eIaK7ZdAqmlrPU5nuJ53ZuwDdIYBd5u3
         vJysnMNVnxpl861RUg5CK/P0NOZRU2qwGAT//EwstW8W5ad98QS0pMiOU8Cs4F+nYzKj
         J8x3gggFmb+jsSVQEdCuk044NZNVYjbysPxDZJ3PjmD1RQZ1F8H32coySNgC16GZREgr
         fa5EmWACS259JenFK/GASzwh7Jo2sY3XZEYrBfZIl+OcGlnACnjenKSOvrzZtTX9azIG
         ktgQ==
X-Gm-Message-State: APzg51DVS2MOdisidUgFTCdqWARkLxIc11SvwH0eTBPyouvEaXDSbBCU
        ihwGUkFxmij3nACzEVkFxsF6KoEfRMVVUEG0Taiwdr3vJ8c=
X-Google-Smtp-Source: ANB0VdYJGmKgwmLl1ksmnigkZZm1b6NnYE+T1nBZRS4fJ78zD/QJn3uhXI3PNqldGs6fr3Fb1j8oxwxbTUnLn6mUkYk=
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr18260318wrf.46.1537194513352;
 Mon, 17 Sep 2018 07:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org> <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org> <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <20180910161328.GA13171@infradead.org> <CAAhSdy2Y-XTZ12i5aV+SzraMZP1YQBhAArpER-YssPcBJNOPOA@mail.gmail.com>
 <20180910163543.GA13052@infradead.org> <CAAhSdy2PSLjrtmSbkJ4w-v-zWm2hjii3XL6HE5Pe7u3wz4BmZA@mail.gmail.com>
 <20180917141436.GB2821@infradead.org>
In-Reply-To: <20180917141436.GB2821@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 17 Sep 2018 19:58:21 +0530
Message-ID: <CAAhSdy1gD3tZLmBzfpJV1qQKsG4GKgLkoBC7v5Kycw8KX+YeLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 7:44 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Sep 10, 2018 at 10:08:58PM +0530, Anup Patel wrote:
> > > They could in theory IFF someone actually get the use case through
> > > the riscv privileged spec working group.
> >
> > Their is no point in having each and every possible local interrupts
> > defined by RISC-V spec because some of these will be CPU
> > implementation specific in which case these local interrupts will
> > be described in platform specific DT passed to Linux.
>
> Again, to legally have implementation specific local interrupt types
> you'll first need to convice the spec to change the status for those
> fields from reserved to implementation specific.

I agree, this needs to be first clarified in RISC-V spec. May be this is
a good topic for discussion in any upcoming RISC-V meetup.

Until then anyone can try these patches from riscv_intc_v2 branch of
https://github.com/avpatel/linux

Regards,
Anup
