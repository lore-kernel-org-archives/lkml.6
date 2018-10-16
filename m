Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9789DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D413208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gIglVaj4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aLo0Rl5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D413208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeJPNkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:40:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbeJPNkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:40:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5067460BFA; Tue, 16 Oct 2018 05:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539669105;
        bh=5MA/R6NENq7QZwyW9eyUVbHYSvmt+mV9Viwh9lgekV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gIglVaj44bh1JzRDkZzNh2t+UneOjvavzWnQepim1LCVcfzhAHO6a/A3y5yux2zLT
         r7b4UoXnIDt7XKRkeW+q7AuYcNtVUJYaVNhM6Mqk7qeRwhLzRRVWmVXLjyOUatvja1
         TAKZelT8aSbC6p02pz4XGB51Fz4L9PvFJZK2fHj0=
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C0FF61308;
        Tue, 16 Oct 2018 05:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539669104;
        bh=5MA/R6NENq7QZwyW9eyUVbHYSvmt+mV9Viwh9lgekV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aLo0Rl5xt5jE8CnDzlo3hqzmu4ytPXhozzSDwTiJTtQAtceuT0g36NhfoX5EfFGAi
         y6v0KLBFADmgudRQrs0GCIlYtye1kuCBdkuwM1yVkkfA+GmAfWnsQs27vc9cElckPt
         50yYZqAp4lvmyTdcAIc2o4MXWZF4wOP/qdzTKiNI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C0FF61308
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f173.google.com with SMTP id m8-v6so13382364qka.12;
        Mon, 15 Oct 2018 22:51:43 -0700 (PDT)
X-Gm-Message-State: ABuFfogRJxXTarfbf2IXUYSFnr46LYS156g8+QitKXg5a1i8LftwpGEB
        JzWAYeOgEx9iIyuXmPmbkh3e+qSqLXbeCZU45WI=
X-Google-Smtp-Source: ACcGV62zXmPVXuaHWoaIw3yEGfWNPFsIFiit/LQ2UAzTGMcpxARqO1fCsZMt+9jkOFnU4Vo7quYofho1xoy+JqduUpw=
X-Received: by 2002:a37:6388:: with SMTP id x130-v6mr18425394qkb.118.1539669103173;
 Mon, 15 Oct 2018 22:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181012213926.253765-1-dianders@chromium.org>
 <CAFp+6iFy8V34cs6pEOie_tBX5wJqM7teUnH_XLLZ7cioPrX_hA@mail.gmail.com> <CAD=FV=WYM5OOigy+81cVzPtAJXhvrhB1znr9zHzMf3q5iFOtFw@mail.gmail.com>
In-Reply-To: <CAD=FV=WYM5OOigy+81cVzPtAJXhvrhB1znr9zHzMf3q5iFOtFw@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 16 Oct 2018 11:21:30 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGxvDoptnjM18ggnHqX6MV0+HFqsnCMi61b8gquBxaYmw@mail.gmail.com>
Message-ID: <CAFp+6iGxvDoptnjM18ggnHqX6MV0+HFqsnCMi61b8gquBxaYmw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ufs: Fix the compatible string definition
To:     Doug Anderson <dianders@chromium.org>
Cc:     "robh+dt" <robh+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Can Guo <cang@codeaurora.org>, evgreen@chromium.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sayalil@codeaurora.org, asutoshd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, liwei213@huawei.com,
        open list <linux-kernel@vger.kernel.org>, malat@debian.org,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:54 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Vivek,
>
> On Mon, Oct 15, 2018 at 8:23 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> >
> > Hi Doug,
> >
> > On Sat, Oct 13, 2018 at 3:09 AM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > If you look at the bindings for the UFS Host Controller it says:
> > >
> > > - compatible: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
> > >               also list one or more of the following:
> > >                  "qcom,msm8994-ufshc"
> > >                  "qcom,msm8996-ufshc"
> > >                  "qcom,ufshc"
> > >
> > > My reading of that is that it's fine to just have either of these:
> > > 1. "qcom,msm8996-ufshc", "jedec,ufs-2.0"
> > > 2. "qcom,ufshc", "jedec,ufs-2.0"
> > >
> > > As far as I can tell neither of the above is actually a good idea.
> > >
> > > For #1 it turns out that the driver currently only keys off the
> > > compatible string "qcom,ufshc" so it won't actually probe.
> > >
> > > For #2 the driver won't probe but it's not a good idea to keep the SoC
> > > name out of the compatible string.
> > >
> > > Let's update the compatible string to make it really explicit.  We'll
> > > include a nod to the existing driver and the old binding and say that
> > > we should always include the "qcom,ufshc" string in addition to the
> > > SoC compatible string.
> > >
> > > While we're at it we'll also include another example SoC known to have
> > > UFS: sdm845.
> > >
> > > Fixes: 47555a5c8a11 ("scsi: ufs: make the UFS variant a platform device")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt       | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> > > index 2df00524bd21..69a06a1b732e 100644
> > > --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> > > +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> > > @@ -4,11 +4,14 @@ UFSHC nodes are defined to describe on-chip UFS host controllers.
> > >  Each UFS controller instance should have its own node.
> > >
> > >  Required properties:
> > > -- compatible           : must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
> > > -                         also list one or more of the following:
> > > -                                         "qcom,msm8994-ufshc"
> > > -                                         "qcom,msm8996-ufshc"
> > > -                                         "qcom,ufshc"
> > > +- compatible           : must contain "jedec,ufs-1.1" or "jedec,ufs-2.0"
> > > +
> > > +                         For Qualcomm SoCs must contain, as below, an
> > > +                         SoC-specific compatible along with "qcom,ufshc" and
> > > +                         the appropriate jedec string:
> > > +                           "qcom,msm8994-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> > > +                           "qcom,msm8996-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> > > +                           "qcom,sdm845-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> >
> > Thanks for the patch. It looks good to me.
> > Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>
> Thanks for the review!
>
>
> > P.S.: While you are at it, can you please move 'ufs-qcom.txt'
> > to Documentation/devicetree/bindings/phy/qcom,ufs-phy.txt.
> > The current name and file location is misleading.
>
> I'd rather someone at Qualcomm do this.  Do you have a suggested
> person?  The reason I feel that Qualcomm needs to get involved is that
> I see that when I look at the file you refer to says it's for:
>
>   "qcom,ufs-phy-qmp-20nm" for 20nm ufs phy,
>   "qcom,ufs-phy-qmp-14nm" for legacy 14nm ufs phy,
>   "qcom,msm8996-ufs-phy-qmp-14nm" for 14nm ufs phy
>   present on MSM8996 chipset.
>
> ...but there's another Qualcomm file, 'qcom-qmp-phy.txt'.  That
> handles the compatible string:
>
>        "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
>
> So I'm a little confused.  Should the SDM845 UFS PHY been handled by
> the older UFS PHY driver?  ...or should all the older UFS PHYs be
> moved to be handled by the newer QMP PHY driver?  ...or are they
> really different hardware blocks, in which case how would you describe
> the difference (both are described as UFS QMP PHYs I think).

As you rightly said "ufs/ufs-qcom.txt" describes the bindings for
14nm, and 20nm ufs phy. These phys are however handled by the older
ufs phy driver present at:
drivers/phy/qualcomm/phy-qcom-ufs-qmp-{14nm,20nm}.c
The sdm845 UFS phy driver is handled by the new consolidated qmp phy
driver: drivers/phy/qualcomm/phy-qcom-qmp.c whose bindings are
described by 'qcom-qmp-phy.txt'.
We didn't attempt to move the 14nm phy to new driver as we already had
8996 using the bindings.

So, really these are two separate drivers with different bindings. I
believe it should be okay to move the file. If you are fine, I can
attempt to post a small patch to do that.
Thanks.

>
> BTW: I have a patch attempting to fixup the QMP PHY bindings at
> <https://lkml.kernel.org/r/20181012213632.252346-1-dianders@chromium.org>.

Sure, I will review this as well. Thanks for reminiding.

Best regards
Vivek


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
