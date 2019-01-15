Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07CAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580FB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yoj98ryD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfAOWL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:11:59 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43778 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfAOWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:11:59 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so2650492vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 14:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TKyaFDmQAKD+EnxBfOreshxoe5ExtPGbqNZUQXeAWUg=;
        b=Yoj98ryD5rdl0NH2FiGV0H0X0JJvSWF5uuc3oJ2sJ2gl9SwiHgXnHqIqTcrm/iXmRt
         I3eGC2aZnyamto3emSPzKI8mW3jfzcDEOjr7zGX8w8Q+7V04HUgEveNiszE8vdaYrAoZ
         qzQLeT9Gj4+MVEDGhX42hkqLlud63bAUK7k3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TKyaFDmQAKD+EnxBfOreshxoe5ExtPGbqNZUQXeAWUg=;
        b=I7JqNUa0GhRzYgA0sqZuQir+dOnHf79TzhMCP2hYAe8+J46MjcwUuCRCo/CJzHhJqG
         RWBRm/eLHA4KqVEOYk7Nz1/rZErrDshUbrl6BmJxljQ3mx2V1maygt4MBIyw5VLixAzq
         vhNTos8a0sQ3/KCuwKr4FIjFforR4ObOxwdXDNt5vHVXxsTkEt4cX+gEGNuqDJlpi63t
         ss70BSQVMj4Z+ebjEHodoafx+z3Jv55wmgzmOc3VqCfyrHLAHzv53dh8/GYh4fdcgSBH
         34nRCFhIme1zCVI3A1xqYjzagafQtxQWNcLT5N/u4+AnPgZB54t9ts1AlA+oC79Ts/9L
         bwYw==
X-Gm-Message-State: AJcUukd1nU+b6BVsxmXOmz+gDj1DMuaZ4VeC+XY7Uc0KuJG+XNvLkBGl
        UvdunDQ6gIe06ym4IPknTi80AQhzCQY=
X-Google-Smtp-Source: ALg8bN5T2+c8QoIvmwaHySQgAx4oWA7rgNStzqNI1cM6Gt/0vrLyeSjsbvN6RqXj94Vg/KoekcLh7Q==
X-Received: by 2002:a67:47cf:: with SMTP id b76mr2575027vsg.184.1547590317679;
        Tue, 15 Jan 2019 14:11:57 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id l13sm76729288vka.16.2019.01.15.14.11.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 14:11:56 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id u11so2640530vsp.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 14:11:56 -0800 (PST)
X-Received: by 2002:a67:f598:: with SMTP id i24mr2362846vso.87.1547590315700;
 Tue, 15 Jan 2019 14:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20190114211824.2320-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190114211824.2320-1-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Jan 2019 14:11:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Um0TBXc_DFrs6YATDOwiqmTXnCFjXXO_mqwEc5QHXk9w@mail.gmail.com>
Message-ID: <CAD=FV=Um0TBXc_DFrs6YATDOwiqmTXnCFjXXO_mqwEc5QHXk9w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Expand soc bus address range
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 14, 2019 at 1:19 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> DMA memory allocations for devices on the soc bus must be constrained to
> the 36 address bits that the bus provides, which without IOMMU is taken
> care of by the addresses being direct physical allocations.

The above confuses me each time I read it because the thing that
you're talking about limiting isn't where memory allocations come from
but really what virtual address range is allocated.  Maybe instead:

DMA addresses for devices on the soc bus must be constrained to the 36
address bits that the bus provides.  When no IOMMU is present then
this is easy--DMA addresses are just physical addresses and physical
addresses are (by definition) within the address bits of the bus.
When an IOMMU is present, however, DMA addresses are virtual
addresses.  Despite these addresses being virtual, however, they still
must be within the 36 bits due to SoC's implementation.


> Unless the bus_dma_mask is defined DMA allocations for devices will use
> all 40 bits available by the SMMU. Causing addresses to be truncated on
> the bus.

It would be interesting to document in the commit message where this
40 comes from.  As far as I can tell "smmu->va_size" in the ARM iommu
code is 48.  I thought maybe it was being truncated in
arm_smmu_init_domain_context(), but even there I see "ias=3D48" and
"oas=3D48" on each boot.


> By the current choice of specifying #address-cells and #size-cells to 1,
> it's possible to define the region of DMA allocations to the lower 32
> bits. But the SMMU implementation requires that it can 1:1 map the page
> table, which might be allocated above 32 bits (as we have RAM there).

I didn't dig into the above paragraph because I'm nearly certain we
wouldn't want it anyway.  Eating the one-time cost of converting
everyone is better than arbitrarily limiting addresses.


> So this patch increases the #size-cells to 2, in order to be able to add
> a dma-ranges that defines the 36 bit DMA capability of the bus, and
> bumps #address-cells to 2 for symmetry. Then defines the dma-ranges to
> 36 bits.
>
> While touching all reg properties, addresses are padded to 8 digits.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> This applies to and is tested on 0f60e6fb54fb ("arm64: dts: qcom: pm8916:=
 Add
> PON watchdog node") of:
> https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=
=3Dfor-next
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 265 ++++++++++++++-------------
>  1 file changed, 133 insertions(+), 132 deletions(-)
>
>         soc: soc {
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
> -               ranges =3D <0 0 0 0xffffffff>;
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges =3D <0 0 0 0 0 0xffffffff>;
> +               dma-ranges =3D <0 0 0 0 0x10 0>;

Shouldn't you also be increasing "ranges"?  While I agree that it
seems to work OK as you have coded it, it seems logically wrong.
Reading 0.2 of the Device Tree Spec I see that the length "specifies
the size of the range in the child=E2=80=99s address space".  Making this
larger than the size of ranges seems wrong.

I think the "ranges" is supposed to be the full size of the overall
accessible bus from the SoC which should contain all memory (even if
memory isn't actually listed as a sub-node of the SoC).  Right?  As I
understand it memory actually starts at 0x80000000 which means that
our current SoC "range" contains some but not all of memory...

Speaking of which, it seems like ranges shouldn't be a mask but should
be a size.  To sum that all up you probably want:

ranges =3D <0 0 0 0 0x10 0>;


>                         usb_2_ssphy: lane@88eb200 {
> -                               reg =3D <0x88eb200 0x128>,
> -                                     <0x88eb400 0x1fc>,
> -                                     <0x88eb800 0x218>,
> -                                     <0x88e9600 0x70>;
> +                               reg =3D <0 0x088eb200 0 0x128>,
> +                                     <0 0x088eb400 0 0x1fc>,
> +                                     <0 0x088eb800 0 0x218>,
> +                                     <0 0x088e9600 0 0x70>;

To avoid a known conflict, maybe worth fixing above before landing
your patch?  Specifically see:

https://lkml.kernel.org/r/20181025172318.31353-1-mgautam@codeaurora.org

...so you'd want that last number to be:

0 0x088eb600 0 0x70

...in general it seems worthwhile to track down a few of the
outstanding patches first before doing your big translation because
otherwise you're going to either need to do manual fixups when landing
those patches or you'll have to ask everyone to re-post.



Overall, I have confirmed that:

* getting rid of dma-ranges (but leaving the iommu for UFS) breaks
UFS, as you have observed.

* changing the dma-ranges size to something higher (0x100 0 or even
0x20 0) breaks UFS, giving evidence that the 36-bit value you came up
with is the right one.


I've also checked the contents of your commit for typos and as far as
I can tell all your translations are correct.  I've tested your commit
on the (out of tree) sdm845-cheza after fixing up the additional
device tree bits that you haven't landed yet.


I've also spent a bit of time poking through the code paths here.
While I won't claim any huge expertise here, it seems like your patch
is the right thing to do.


Thanks!

-Doug
