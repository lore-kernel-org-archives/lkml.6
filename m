Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804DFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39257222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550009562;
	bh=8GDkVuy3MACgHCoYVUcueaQTbaJwUTc6VdtfYkEp8zU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CJqOsvKijXpR9v0CeEjpaDa5qQYYm5IWi2HsydHBji3YsLBcQkt8DUZ8fawKGMkO9
	 lhTWRr764HYVIUQcbU1L2Gk3SCF5YcWOEDxhTTHw40vNNwBLe4zI9LGYzLJV/aYszd
	 RPYfZbG/IM1M0yiIUBtRyiFdWSzLwPGl8GWoYuJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbfBLWMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfBLWMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:12:39 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ABF9222C7;
        Tue, 12 Feb 2019 22:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550009557;
        bh=8GDkVuy3MACgHCoYVUcueaQTbaJwUTc6VdtfYkEp8zU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DUZfXm9zTCzZwUiVWJ4rFegHfBQwUOGacBTql7scSV3QSnpywyf9oL93lBy8BQ+49
         1coHuqft7a6vR5pFRwk6vKkkSIbKN65ml79h83QG30hVsSl+qyziObQH1PnHBNXd9W
         x9fuUMbXSZM6B2vTy4lW053styamA77wRx0/mY4o=
Received: by mail-qk1-f179.google.com with SMTP id x6so180614qki.6;
        Tue, 12 Feb 2019 14:12:37 -0800 (PST)
X-Gm-Message-State: AHQUAuZi2D7bhhQcKi3ES50Q7zFJzgHWpK5Iyl88INBIZX84D/LvZp46
        5GwhUJgaRDje9loGp539LIAh2BHNgdGRzMu/Zg==
X-Google-Smtp-Source: AHgI3IYRZQMTmMf4ELKsgO2u3/PJMlW8oqmzGoPBLLKHaPdrLE+bjaSYBB0qgyRnQV5ZGRc4BATQQGIdAO6y5AaYDDU=
X-Received: by 2002:ae9:dc45:: with SMTP id q66mr4366979qkf.147.1550009556731;
 Tue, 12 Feb 2019 14:12:36 -0800 (PST)
MIME-Version: 1.0
References: <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com> <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
 <20190121143704.GE29504@arrakis.emea.arm.com> <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
 <20190121174234.GC26461@rapoport-lnx> <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
 <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr> <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx> <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx> <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
 <617e0d57-342d-4162-bd21-ece18e481d87@free.fr> <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
 <20190213085028.6199594b@canb.auug.org.au>
In-Reply-To: <20190213085028.6199594b@canb.auug.org.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 Feb 2019 16:12:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com>
Message-ID: <CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in
 early memory reservation
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 3:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Tue, 12 Feb 2019 10:03:09 -0600 Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Mon, Feb 11, 2019 at 10:47 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> > >
> > > On 04/02/2019 15:37, Marc Gonzalez wrote:
> > >
> > > > Cc: stable@vger.kernel.org # 3.15+
> > > > Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
> > > > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Acked-by: Prateek Patel <prpatel@nvidia.com>
> > > > Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > ---
> > > > Resend with DT CCed to reach robh's patch queue
> > > > I added CC: stable, Fixes, and Prateek's ack
> > > > Trim recipients list to minimize inconvenience
> > >
> > > I'm confused over commit 3532b3b554a216f30edb841d29eef48521bdc592 in linux-next
> > > "memblock: drop __memblock_alloc_base()"
> > >
> > > It's definitely going to conflict with the proposed patch
> > > over drivers/of/of_reserved_mem.c
> > >
> > > Rob, what's the next step then?
> >
> > Rebase it on top of what's in linux-next and apply it to the tree
> > which has the above dependency. I'm guessing that is Andrew Morton's
> > tree.
>
> Yeah, that is in Andrew's "post linux-next" patch series, so if you
> rebase it on top of linux-next and then send it to Andrew with some
> explanation.
>
> ...
>
> Actually, if it is intended for the stable trees, then presumably it is
> intended to go to Linus for the current release?  In which case, the
> patch in Andrew's tree will have to be changed to cope after your patch
> appears in Linus' tree (and therefore, linux-next).

At this point in the cycle, I wasn't planning to send this for 5.0.
It's not fixing something introduced in 5.0 and it is a debug feature.

Rob
