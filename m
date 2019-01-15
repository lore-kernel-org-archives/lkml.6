Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4DEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216AB20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKahjAY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391504AbfAOXoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:44:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39241 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391490AbfAOXoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:44:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so2039714pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HWf/aQtJ7+C0BPKBy1KRqi9AI9v+28dx+aGYgpB99RI=;
        b=SKahjAY4owtZFisrLu/siqYGXIxesLW2B7cgrjRoVs6NE0ZrmJkWzkhdWtc+1pRsRX
         oBOIm9xkbh+J4H5KToJ+sfbxmxDkQUuLkBqoFLO+5qi0cA9NQQBiau0NtIdgRfyxe+rc
         AfU/j3LSXYh1UzFuwD7g66OzCZx14d531T9bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HWf/aQtJ7+C0BPKBy1KRqi9AI9v+28dx+aGYgpB99RI=;
        b=ppufuUGJNxKvqO2nVZ0i41m18emjEreUC77Hvt0k8kKLNO4f9S1BrHiKpSu3PoNnbY
         lNcYgm13WdHUpTveY3yLPuSjEqj657GwUXiriga80MfiJ3tNgYQ7KwEMAjhIfnMxYtYS
         GyXfGL2osYJfa+6lTjRM4P0XoSnWhL7iC+fj/fw2UUs1gR+GSKg2mI5wKuLxfeF4uBgd
         Mw/Tw7OxWp7IAvI+X0atiUsXPCCWgzssGL/RJFy5tBQzA4tc6FBm9g8dKNL/Ov/rXIhp
         W583L9ANucDvmORH3isreRnr0iil4XHovENTDsArlJ40bbrIEOEv5/ftpIQ+F/O3SJFf
         69PA==
X-Gm-Message-State: AJcUukfN8oCWZtvFHqXVi0/Ryyb5Ya2iVAoK/tjOdN2wXAdHzPYs5F4q
        vlXWEJFT0kHwgrc+WHKfHIk9kA==
X-Google-Smtp-Source: ALg8bN4DkXh7iXg9WpBa6fub2swF/1hIhZxUMQ29/Pi/URi+zCcXAiiXT4+qQZSGevRj4XOBucsXpw==
X-Received: by 2002:a17:902:ab92:: with SMTP id f18mr6486447plr.221.1547595858406;
        Tue, 15 Jan 2019 15:44:18 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b4sm4505483pgq.65.2019.01.15.15.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 15:44:17 -0800 (PST)
Date:   Tue, 15 Jan 2019 15:44:14 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Expand soc bus address range
Message-ID: <20190115234414.GV9278@minitux>
References: <20190114211824.2320-1-bjorn.andersson@linaro.org>
 <CAD=FV=Um0TBXc_DFrs6YATDOwiqmTXnCFjXXO_mqwEc5QHXk9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Um0TBXc_DFrs6YATDOwiqmTXnCFjXXO_mqwEc5QHXk9w@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15 Jan 14:11 PST 2019, Doug Anderson wrote:

> Hi,
> 
> On Mon, Jan 14, 2019 at 1:19 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > DMA memory allocations for devices on the soc bus must be constrained to
> > the 36 address bits that the bus provides, which without IOMMU is taken
> > care of by the addresses being direct physical allocations.
> 
> The above confuses me each time I read it because the thing that
> you're talking about limiting isn't where memory allocations come from
> but really what virtual address range is allocated.  Maybe instead:
> 
> DMA addresses for devices on the soc bus must be constrained to the 36
> address bits that the bus provides.  When no IOMMU is present then
> this is easy--DMA addresses are just physical addresses and physical
> addresses are (by definition) within the address bits of the bus.
> When an IOMMU is present, however, DMA addresses are virtual
> addresses.  Despite these addresses being virtual, however, they still
> must be within the 36 bits due to SoC's implementation.
> 

This is good, I'll rework the last sentence slightly and update the
message.

> 
> > Unless the bus_dma_mask is defined DMA allocations for devices will use
> > all 40 bits available by the SMMU. Causing addresses to be truncated on
> > the bus.
> 
> It would be interesting to document in the commit message where this
> 40 comes from.  As far as I can tell "smmu->va_size" in the ARM iommu
> code is 48.  I thought maybe it was being truncated in
> arm_smmu_init_domain_context(), but even there I see "ias=48" and
> "oas=48" on each boot.
> 

I wrote 48 first, then checked the driver and concluded that it's 40,
but you're right it's 48 in this case. It seems like there's some
configurability here and some hard restrictions, but from what I can see
48 is a sensible choice.

I'll update it.

> 
> > By the current choice of specifying #address-cells and #size-cells to 1,
> > it's possible to define the region of DMA allocations to the lower 32
> > bits. But the SMMU implementation requires that it can 1:1 map the page
> > table, which might be allocated above 32 bits (as we have RAM there).
> 
> I didn't dig into the above paragraph because I'm nearly certain we
> wouldn't want it anyway.  Eating the one-time cost of converting
> everyone is better than arbitrarily limiting addresses.
> 
> 
> > So this patch increases the #size-cells to 2, in order to be able to add
> > a dma-ranges that defines the 36 bit DMA capability of the bus, and
> > bumps #address-cells to 2 for symmetry. Then defines the dma-ranges to
> > 36 bits.
> >
> > While touching all reg properties, addresses are padded to 8 digits.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > This applies to and is tested on 0f60e6fb54fb ("arm64: dts: qcom: pm8916: Add
> > PON watchdog node") of:
> > https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 265 ++++++++++++++-------------
> >  1 file changed, 133 insertions(+), 132 deletions(-)
> >
> >         soc: soc {
> > -               #address-cells = <1>;
> > -               #size-cells = <1>;
> > -               ranges = <0 0 0 0xffffffff>;
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges = <0 0 0 0 0 0xffffffff>;
> > +               dma-ranges = <0 0 0 0 0x10 0>;
> 
> Shouldn't you also be increasing "ranges"?  While I agree that it
> seems to work OK as you have coded it, it seems logically wrong.
> Reading 0.2 of the Device Tree Spec I see that the length "specifies
> the size of the range in the child’s address space".  Making this
> larger than the size of ranges seems wrong.
> 
> I think the "ranges" is supposed to be the full size of the overall
> accessible bus from the SoC which should contain all memory (even if
> memory isn't actually listed as a sub-node of the SoC).  Right?  As I
> understand it memory actually starts at 0x80000000 which means that
> our current SoC "range" contains some but not all of memory...
> 
> Speaking of which, it seems like ranges shouldn't be a mask but should
> be a size.  To sum that all up you probably want:
> 
> ranges = <0 0 0 0 0x10 0>;
> 

So the DT spec is where I find the definition. That makes more sense,
thanks.

> 
> >                         usb_2_ssphy: lane@88eb200 {
> > -                               reg = <0x88eb200 0x128>,
> > -                                     <0x88eb400 0x1fc>,
> > -                                     <0x88eb800 0x218>,
> > -                                     <0x88e9600 0x70>;
> > +                               reg = <0 0x088eb200 0 0x128>,
> > +                                     <0 0x088eb400 0 0x1fc>,
> > +                                     <0 0x088eb800 0 0x218>,
> > +                                     <0 0x088e9600 0 0x70>;
> 
> To avoid a known conflict, maybe worth fixing above before landing
> your patch?  Specifically see:
> 
> https://lkml.kernel.org/r/20181025172318.31353-1-mgautam@codeaurora.org
> 

I was looking for pending patches, but missed that one. Will pick it up
as well, and take another look for others.

> ...so you'd want that last number to be:
> 
> 0 0x088eb600 0 0x70
> 
> ...in general it seems worthwhile to track down a few of the
> outstanding patches first before doing your big translation because
> otherwise you're going to either need to do manual fixups when landing
> those patches or you'll have to ask everyone to re-post.
> 

Well, either I apply them and then update this patch or I apply this and
then update the patches as I apply them. But I'll take another tour of
the mailing list.

> 
> 
> Overall, I have confirmed that:
> 
> * getting rid of dma-ranges (but leaving the iommu for UFS) breaks
> UFS, as you have observed.
> 
> * changing the dma-ranges size to something higher (0x100 0 or even
> 0x20 0) breaks UFS, giving evidence that the 36-bit value you came up
> with is the right one.
> 

Thanks for verifying this.

> 
> I've also checked the contents of your commit for typos and as far as
> I can tell all your translations are correct.  I've tested your commit
> on the (out of tree) sdm845-cheza after fixing up the additional
> device tree bits that you haven't landed yet.
> 

Thanks.

> 
> I've also spent a bit of time poking through the code paths here.
> While I won't claim any huge expertise here, it seems like your patch
> is the right thing to do.
> 

Thanks,
Bjorn
