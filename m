Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C477C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E1A214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCUDmpPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E1A214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeHUQTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbeHUQTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:19:20 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6429821772
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534856356;
        bh=7J5QD5z+MP5ZDD6cvPh0llP+QdxeqZcvPa36xg9D0To=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iCUDmpPVOGcD6f+Kcq/AwW/M5gjJFN3nMGV+lfsKVeSSiAmG6fEsnImZB56hKit4f
         xYmobENTkE7np/dTETsEKhMdPQRQHYPwW5Q8LiWU2aHzyVwTdyBkKvmdDyTCKhAQlb
         1DTBr2WH5MbcStQr0sGCMalWIcmXsGFqlM3Ams2g=
Received: by mail-wm0-f46.google.com with SMTP id s9-v6so2834552wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 05:59:16 -0700 (PDT)
X-Gm-Message-State: AOUpUlHAUA6piupSWsi4GGfzOsoD8csQEEicbSXNkyH8ri4BK9o57zcV
        FNi+sBsoRxSP7kJ9nkV32ZxRMJm4ggaexE85dD7mtw==
X-Google-Smtp-Source: AA+uWPxoMuQWzUyBpmGsyNqCx4obZh5oJvyG7KgJjHOhIEBFdYLW7FWI/nAL7YhjrkXTqVwv+JNtlRCie5V8GFfR2b0=
X-Received: by 2002:a1c:9091:: with SMTP id s139-v6mr11646720wmd.146.1534856354788;
 Tue, 21 Aug 2018 05:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180820230011.25368-1-palmer@sifive.com> <51924de4-4a16-07a0-f499-753e0df49678@wdc.com>
In-Reply-To: <51924de4-4a16-07a0-f499-753e0df49678@wdc.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 Aug 2018 07:59:03 -0500
X-Gmail-Original-Message-ID: <CABGGisyZ=kuWesNkKRQQATsSf6_aiWTscmW1OANLtTSJAKQ0EA@mail.gmail.com>
Message-ID: <CABGGisyZ=kuWesNkKRQQATsSf6_aiWTscmW1OANLtTSJAKQ0EA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: riscv,cpu-intc: Cleanups from a missed review
To:     atish.patra@wdc.com
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hch@infradead.org, merker@debian.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 6:10 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> On 8/20/18 4:01 PM, Palmer Dabbelt wrote:
> > I managed to miss one of Rob's code reviews on the mailing list
> > <http://lists.infradead.org/pipermail/linux-riscv/2018-August/001139.html>.
> > The patch has already been merged, so I'm submitting a fixup.
> >
> > Sorry!
> >
> > Fixes: b67bc7cb4088 ("dt-bindings: interrupt-controller: RISC-V local interrupt controller")
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Karsten Merker <merker@debian.org>
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > ---
> >   .../bindings/interrupt-controller/riscv,cpu-intc.txt       | 14 +++++++++++---
> >   1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> > index b0a8af51c388..265b223cd978 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> > @@ -11,7 +11,7 @@ The RISC-V supervisor ISA manual specifies three interrupt sources that are
> >   attached to every HLIC: software interrupts, the timer interrupt, and external
> >   interrupts.  Software interrupts are used to send IPIs between cores.  The
> >   timer interrupt comes from an architecturally mandated real-time timer that is
> > -controller via Supervisor Binary Interface (SBI) calls and CSR reads.  External
> > +controlled via Supervisor Binary Interface (SBI) calls and CSR reads.  External
> >   interrupts connect all other device interrupts to the HLIC, which are routed
> >   via the platform-level interrupt controller (PLIC).
> >
> > @@ -25,7 +25,15 @@ in the system.
> >
> >   Required properties:
> >   - compatible : "riscv,cpu-intc"
>
> Since this is a fix up patch, we should update the compatible string
> with the sifive specific one as well. no?

I think it is fine as is if my understanding is correct. Given this is
part of the RISC-V spec(s), then using 'riscv' here for riscv,cpu-intc
is fine. It was only the PLIC which didn't have any standard
definition that I had issue with. Plus, with the SoC specific string,
I'm not too worried about what the fallback is.

However, sifive,fu540-c000-cpu-intc does need to be documented.
Putting it in the example is not documenting it.

Rob
