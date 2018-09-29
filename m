Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDDBC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E7D2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="IeJyw2BF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E7D2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeI2Ndd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:33:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33545 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbeI2Ndd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:33:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id f10-v6so8530588wrs.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 00:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxZ34R8u0YcbHaqttHc8byjj9EW0gSodxQpNWy+NBXk=;
        b=IeJyw2BFZ1Zwwg8Ii3/hDH4Wc5j+u5G7bm63DKyr1xw5xoaIhLDak7zHFtSRNAidny
         6WT9zAy3TrsVkV96Vh4WqqOAid8lOzYFUW4RHEsStBRiDNG+rHQql5aMTa8p62mdJhLl
         bsq6CwoEor2Xbs0YkWv13VmKti7abUiLCd/0gr/1GnSuco4X5C546klQMfQEcZS5fEnN
         0/oZ9AvT6JnKVBapYpYW3hXemin542L0d1HmTd6zzdAELkvA21GuHUA/F1maK6Zvchmx
         l966aB2QLw4QEBXe19kuPQ8JDfD+YA1nsDF6HTFThvma32WxIl4lMOucDmXmvwE6et0v
         se/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxZ34R8u0YcbHaqttHc8byjj9EW0gSodxQpNWy+NBXk=;
        b=RJPODStYZ4xDOo4J26V8VOPX5WOloML2ss96h87PKNEjtj+sI7kIsw0ZarB8PLvMvs
         cWkLAjJ2lnIWB9XhJ1AEoQpIwkg1ahtL0a87VC3y8dhBFxf78IWLxFUP0TLvw+82JY7u
         f1oEf18/ftdJ4xV9+pr79bFc1zLHuVtgKjzf/waf/fCwHBIvJiHts4BX+MmzhMJpop+J
         B9AWq7BNkQZvbXygmXR+3rpis9H1gn494rzcEmW3KnOQstZkQMCGsS/5ntx1MGKjDAdK
         Rqu9lx4vS4lgM7dTf9KaGNJQOxzk2Vd7cNV7iM8qh9SIlc7MwlAgrqvMHEYi1LLQBNyS
         +MeA==
X-Gm-Message-State: ABuFfohP3uPMOO76+Y+0e56D9ahC7gGWh77NywChIYQwdSeXgjs2Jkiw
        hZ02ACfSEU4+6oT3ooI5WIbSVUPUoWJYVxgwATaDxzw1
X-Google-Smtp-Source: ACcGV61Pp3aT6OSlTe6FaG8iNrph4l1mnX/L5m2FzHT85cMKFsCG30wsSrk+wTEcyKmeC7vxvdDravRecTOIY0IkU1w=
X-Received: by 2002:adf:8447:: with SMTP id 65-v6mr1105286wrf.251.1538204774107;
 Sat, 29 Sep 2018 00:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180910133418.GA12330@infradead.org> <mhng-0f237369-b7fb-47cd-a610-be4c577c3c4f@palmer-si-x1c4>
In-Reply-To: <mhng-0f237369-b7fb-47cd-a610-be4c577c3c4f@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 29 Sep 2018 12:36:03 +0530
Message-ID: <CAAhSdy0nmy=vX74e08BOPqC_pyEnRrPz06gTWz8LivOkQscYuw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] RISC-V: Make IPI triggering flexible
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 7:15 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 10 Sep 2018 06:34:18 PDT (-0700), Christoph Hellwig wrote:
> > On Thu, Sep 06, 2018 at 04:15:14PM +0530, Anup Patel wrote:
> >> This patch is doing two things:
> >> 1. Allow IRQCHIP driver to provide IPI trigger mechanism
> >
> > And the big questions is why do we want that?  The last thing we
> > want is for people to "innovate" on how they deliver IPIs.  RISC-V
> > has defined an SBI interface for it to hide all the details, and
> > we should not try to handle systems that are not SBI compliant.
> >
> > Eventuall we might want to revisit the SBI to improve on shortcomings
> > if there are any, but we should not allow random irqchip drivers to
> > override this.
>
> I agree.  The whole point of the SBI is to provide an interface that everyone
> uses so we can the go figure out how to make this fast later.  If each platform
> has their own magic IPI hooks then this will end up being a mess.
>
> We've got some schemes floating around to make the SBI fast (essentially an SBI
> VDSO), I'd prefer to push on that rather than adding a bunch of complexity
> here.

Yes, I have already removed the IPI triggering part from this patchset.

Regards,
Anup
