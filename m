Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F57C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD7A2173B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546650619;
	bh=izqCTOdMtM2Q4k4QJclyd2lx3suw6mEz/I9wnXl1lI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JeEufBpdFip3deZF2A361KYL0/nwveoaGMRlBXnTSodMz1L7eHuA6Q//KHmHu4LGL
	 /VRZkgK2pCsoxcMR61yO7vQZmM60Ta8GmfbeozmdqUVtbdqLEHspj2v7CuSEL0j/DM
	 FE7UQNWK4YTLfoKHgt5tXkkrNGGhawzvoMtxr6ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAEBKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 20:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfAEBKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 20:10:18 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48AA3218E0;
        Sat,  5 Jan 2019 01:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546650617;
        bh=izqCTOdMtM2Q4k4QJclyd2lx3suw6mEz/I9wnXl1lI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wKUjabnnUaYNqbBdb8BvEbsUEOHOtgZfL6//PYG152G8VNgJGZFofVwdCHY6M0Ixk
         AO424sV6TfBoiGGMAiJirdQo+5x5Ute0XwVF7TpI+BWOxaEmpUHlYv1yXvZocDu9TX
         xpd6fQxtsT+Np+ht9goCueLK1nOD/B7GJ5J35GZw=
Received: by mail-qt1-f176.google.com with SMTP id v11so42303320qtc.2;
        Fri, 04 Jan 2019 17:10:17 -0800 (PST)
X-Gm-Message-State: AA+aEWaLvH1yLat7Dec64CuxwRFg7FCKzeWNxlUast/FJ/jbH6A2CYSE
        SbIk/8unHVNjqB26U76VAaxeoEDtfDc7Kq8h6w==
X-Google-Smtp-Source: AFSGD/XGVGSj9p+Ls1/9D55m9I/CN1kaUL2qQfZQM/84hVp5JSvi6I5zKDA5gSuoz81xa+Kf5xtTAN2MGMGBosCpD14=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr52668314qts.144.1546650616425;
 Fri, 04 Jan 2019 17:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20181220210141.GA17198@bogus> <mhng-199961ff-1c6e-41f4-b7e4-66c1bbba15e3@palmer-si-x1c4>
In-Reply-To: <mhng-199961ff-1c6e-41f4-b7e4-66c1bbba15e3@palmer-si-x1c4>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Jan 2019 19:10:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL_M-_L3LdiE9htSCsQt40pXNYMBN+BCKpqB8L-5TDrNg@mail.gmail.com>
Message-ID: <CAL_JsqL_M-_L3LdiE9htSCsQt40pXNYMBN+BCKpqB8L-5TDrNg@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: riscv: cpus: add E51 cores to the list
 of documented CPUs
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 4:46 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 20 Dec 2018 13:01:41 PST (-0800), robh@kernel.org wrote:
> > On Fri, Dec 14, 2018 at 09:21:50PM -0800, Paul Walmsley wrote:
> >> Add compatible strings for the SiFive E51 family of CPU cores to the
> >> RISC-V CPU compatible string documentation.  The E51 CPU core is
> >> described in:
> >>
> >> https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> >>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Palmer Dabbelt <palmer@sifive.com>
> >> Cc: Albert Ou <aou@eecs.berkeley.edu>
> >> Cc: devicetree@vger.kernel.org
> >> Cc: linux-riscv@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> >> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> >> ---
> >>  Documentation/devicetree/bindings/riscv/cpus.txt | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
> >> index adf7b7af5dc3..fb9d4f86f41f 100644
> >> --- a/Documentation/devicetree/bindings/riscv/cpus.txt
> >> +++ b/Documentation/devicetree/bindings/riscv/cpus.txt
> >> @@ -68,8 +68,9 @@ described below.
> >>          - compatible:
> >>                  Usage: required
> >>                  Value type: <stringlist>
> >> -                Definition: must contain "riscv", may contain one of
> >> -                            "sifive,rocket0"
> >> +                Definition: must contain "riscv", may contain one or
> >> +                        more of "sifive,rocket0", "sifive,e51",
> >> +                        "sifive,e5"
> >
> > I can't really tell what are valid combinations from this. It reads that
> > I could list every string here and that would be valid. It is basically
> > 'riscv' plus any other combinations of strings.
>
> I think that's actually the correct interpretation: if it's a RISC-V CPU then
> it must have "riscv" listed in compatible, but it can also be anything else.

But is '"sifive,rocket0", "sifive,e51", "sifive,e5", "riscv"' valid?
What about '"sifive,rocket0", "sifive,e5", "riscv"'?

If they are, is there really any value in specifying all of them or
different variations? I'd suggest keeping things simple because
writing a json-schema gets messy when there's arbitrary combinations
of compatible values.

> There's some concrete examples here (a "sifive,e51" is a type of "riscv"), but
> I don't think it's realistic to count on us being able to enumerate all RISC-V
> implementations here.

I think you'll find that "riscv" will become pointless as it is not
specific enough to mean anything. It would be like having "arm" as a
compatible on Arm based systems.

OTOH, you only really need to enumerate what you can't discover. For
example, how are optional features (SIMD inst a common example)
discovered? On Arm, we generally just have the CPU model in the
compatible, but it's generally not even used because that, cpu
revision, instruction set features, etc. are all discoverable.

Rob
