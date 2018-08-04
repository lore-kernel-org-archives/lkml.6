Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A85C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF69621782
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKY/ERAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF69621782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbeHDDMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 23:12:00 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40610 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbeHDDMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 23:12:00 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so12971983oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 18:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYiUqYyZxJJi4RvmRgHSRW9vOzuAZYSY5bJyIaHed3o=;
        b=lKY/ERAAGj2nvNmjYdXwhc0CmmWfZNch2h7/LFORx6SheeHVboy9falw9JOkPyhNxi
         df8zJQz1ZmvvPe75oL0QQm4MeQBTrXwHRa8I4HlKfncjedkJCf7psWUqIZlQFCPmaVy5
         QPRE+6/etk1KyscSVWNh3Kw5cRdpvkdsQs0BdkJFCUhIQwoXKm3MAFDN9+IhrNN/urP+
         seswgWHQtfMxP9/+41eBvAs+ly0NG0GKsc/yJhEOaj9j49wb9A0B1lZzDs49CFWDDM1E
         4qV5fISBGY2fawHSzcqdteQOaEHnsWFibLiIQS4qwdtzmiY3dZth8cs0uBZYYzYSiUEn
         kFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYiUqYyZxJJi4RvmRgHSRW9vOzuAZYSY5bJyIaHed3o=;
        b=VeqIrkKh5B2lNf2sxzKSaxUGK56loNP64Ukezz4bWVzGpU0rS3kSc5cw7BOLL47h5q
         yD/7hJ8YsgSGUHaIwGxlr8yMv4APF1ny6B5KfIVLoUDVdqau8HpIiNOb7ukV+sZLqlBN
         VbEN9KG4hLhVcQmSLxn7ykbG0xFRzwesifOCO4n5gNiKTEXFqUi8Pu8eANIQ/4IUaiw+
         ORDVERfaVA9hqqfPO/Xw0ot2O1hh2XZ3lh55YJmHoloRsK8JTpdaaZ1/B9yDz+JMux0l
         F3BIEXaKxIUYY8DdkgES7Zc57eiZljT43voDfZHtecF4gJhEo+fWut2381mgQp7cuNDS
         lH6Q==
X-Gm-Message-State: AOUpUlFgkhvQy7Uqi2lKMjKJYsRREW/rXWtNsGvVuCPFM2KgwSEM+gz/
        nsFHxfVHGhh2FMcdYEz1tKADa6+YVRcO7mutvYs=
X-Google-Smtp-Source: AAOMgpdDyYfGQKHPVAyOZofG6X1Cv2WNVvQAmbmfD5C4XM/jGKhPZKKr78D6F82fiCwqdraRPlWAGDb1eHEM/MzGoBA=
X-Received: by 2002:aca:1719:: with SMTP id j25-v6mr5253185oii.138.1533345198911;
 Fri, 03 Aug 2018 18:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com> <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
From:   Andrew Pinski <pinskia@gmail.com>
Date:   Fri, 3 Aug 2018 18:13:05 -0700
Message-ID: <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     mpatocka@redhat.com
Cc:     Richard Earnshaw <Richard.Earnshaw@arm.com>,
        ard.biesheuvel@linaro.org,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Florian Weimer <fweimer@redhat.com>,
        thomas.petazzoni@free-electrons.com,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 5:58 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Fri, 3 Aug 2018, Richard Earnshaw (lists) wrote:
>
> > Whoa, hold on.
> >
> > Memcpy should never be used on device memory.  Period.  Memcpy doesn't
> > know anything about what size of access is needed for accessing a device.
> >
> > But why is the buffer in device memory rather than some other form of
> > uncached memory?
> >
> > If you change memcpy to deal with an aspect of the system hardware,
> > you'll end up hosing performance EVERYWHERE.  DON'T DO IT!
>
> memcpy in glibc uses ifunc selection and it already has optimized variants
> for Falkor and Thunder-X. You can add just another variant for Armada-8040
> that works around this bug and you won't be harming anyone but users of
> Armada-8040.

Except it is not a bug in the ARMADA at all.  It is a bug in thinking
memcpy will work on non-DRAM memory.
Can you run the test program on x86 using the similar framebuffer
setup?  Does doing two writes (one aligned and one unaligned but
overlapping with previous one) cause the same issue?  I suspect it
does, then using memcpy for frame buffers is wrong.

Thanks,
Andrew

>
> Furthermore, you can detect in the kernel that the PCI bus has some device
> with prefetchable BAR and activate the workaround only if there is
> videocard plugged in the PCIe slot.
>
> > If you must, create a new API with tighter semantics, but don't change
> > memcpy to accommodate this.
> >
> > Anyway, back to the original report.  What memory mapping is being used?
> >  In detail?
>
> It is PCI prefetchable BAR. It is mapped using pgprot_writecombine, which
> results in MT_NORMAL_NC page attributes. (the MT_DEVICE_nGnRE can't be
> used because it results in crashes due to unaligned accesses to videoram).
>
> > R.
>
> Mikulas
