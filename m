Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980DCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C487222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfBLVwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:52:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfBLVwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:52:51 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 47AB5E678;
        Tue, 12 Feb 2019 21:52:50 +0000 (UTC)
Date:   Tue, 12 Feb 2019 13:52:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in
 early memory reservation
Message-Id: <20190212135249.7d37876449980fa378e49314@linux-foundation.org>
In-Reply-To: <20190213085028.6199594b@canb.auug.org.au>
References: <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
        <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
        <20190121143704.GE29504@arrakis.emea.arm.com>
        <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
        <20190121174234.GC26461@rapoport-lnx>
        <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
        <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
        <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
        <20190123055414.GA4747@rapoport-lnx>
        <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
        <20190123123143.GE4747@rapoport-lnx>
        <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
        <617e0d57-342d-4162-bd21-ece18e481d87@free.fr>
        <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
        <20190213085028.6199594b@canb.auug.org.au>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 08:50:28 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

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

Yup, just do whatever needs to be done and I'll figure it out ;)
