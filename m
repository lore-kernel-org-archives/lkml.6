Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A7EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E4B219F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E4B219F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeHHSvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:51:54 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:42977 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeHHSvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:51:54 -0400
Received: by mail-qt0-f170.google.com with SMTP id z8-v6so3096600qto.9;
        Wed, 08 Aug 2018 09:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPypXWx+EYspLqawQLLHa9UTTkyJSSoYu+cUi7S+7Xw=;
        b=F+xh5KDDEqFIWqTWd6XLjrZ4Jq3pHXNPiZS9DUSO8iDPdTwsGaLT7y4SX5E9dHB0G8
         jIev6thciidY204OtQMzocsayJrbEIPa8OvDT4gR8ZxMUsHhNjectX8SXilHbRqDAQXm
         v84+T/Ch4PME8t4kE+nPRRphi1cO8CiwS/i3bZDpgvr2nzp4B0oE9nOACGQf0LipotL4
         /8m9GNpzAjt/TdxpzaoJ7cz5f1WAQw/jpJvjf44UUEjJ/wqBfBf60zMY1mM5h331j8EM
         GntNLkFpC79OmiWG3ykytsvdAhccuyH92ViWeOsbk683SahrITeBqfh+wEzE0ddDFvZg
         CDfg==
X-Gm-Message-State: AOUpUlGFZ4/NN165nuSiXqDXgEuDWl0wgg4/h6DrFo1fX/o+DJXlkclS
        9meDTQn0DCyKdWVu4gQMzqGXW9x/FzgmgiqiJLw=
X-Google-Smtp-Source: AA+uWPw0Oo1yXx58W/GCt5XU2zr3i1KodPAePSCtWn3dxxiEju5/gfhB+4qmXmUBl4+a9MLC+c6gVqRhf5mNWHJlrPc=
X-Received: by 2002:ac8:274a:: with SMTP id h10-v6mr3501502qth.187.1533745886372;
 Wed, 08 Aug 2018 09:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <20180808121641.GB24736@iMac.local> <b1de49af14d941979977af07dc81e1c2@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808080939180.3325@file01.intranet.prod.int.rdu2.redhat.com>
 <19c70d2a0b224db78f72dd316ad006b8@AcuMS.aculab.com> <20180808145017.GE24736@iMac.local>
 <alpine.LRH.2.02.1808081215120.31259@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808081215120.31259@file01.intranet.prod.int.rdu2.redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Aug 2018 18:31:09 +0200
Message-ID: <CAK8P3a3iURkU8LThO3xLtaNjkYArdpw+6_WqJQog4EgrcQy23g@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>, neko@bakuhatsu.net,
        Jingoo Han <jingoohan1@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 6:22 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> On Wed, 8 Aug 2018, Catalin Marinas wrote:
>
> > On Wed, Aug 08, 2018 at 02:26:11PM +0000, David Laight wrote:
> > > From: Mikulas Patocka
> > > > Sent: 08 August 2018 14:47
> > > ...
> > > > The problem on ARM is that I see data corruption when the overlapping
> > > > unaligned writes are done just by a single core.
> > >
> > > Is this a sequence of unaligned writes (that shouldn't modify the
> > > same physical locations) or an aligned write followed by an
> > > unaligned one that updates part of the earlier write.
> > > (Or the opposite order?)
> >
> > In the memcpy() case, there can be a sequence of unaligned writes but
> > they would not modify the same byte (so no overlapping address at the
> > byte level).
>
> They do modify the same byte, but with the same value. Suppose that you
> want to copy a piece of data that is between 8 and 16 bytes long. You can
> do this:
>
> add src_end, src, len
> add dst_end, dst, len
> ldr x0, [src]
> ldr x1, [src_end - 8]
> str x0, [dst]
> str x1, [dst_end - 8]
>
> The ARM64 memcpy uses this trick heavily in order to reduce branching, and
> this is what makes the PCIe controller choke.

So when a single unaligned 'stp' gets translated into a PCIe with TLP
with length=5 (20 bytes) and LastBE = ~1stBE, write combining the
overlapping stores gives us a TLP with a longer length (5..8 for two
stores), and byte-enable bits that are not exactly a complement.

If the explanation is just that of the byte-enable settings of the merged
TLP are wrong, maybe the problem is that one of them is always
the complement of the other, which would work for power-of-two
length but not the odd length of the TLP post write-combining?

      Arnd
