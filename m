Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C719CC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABF42190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SuJwfuys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390353AbfBMDC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:02:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39302 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbfBMDCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:02:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so1551772otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 19:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMU1/TQWCnMHC5lCOveXcIzdUREG8BzeB87IXaJ0KOE=;
        b=SuJwfuysL5A18uM8XkhFSpoUC6sFu7YwyqKGwB8V6xhIckAUCFxXlYmZHliwI/1+M9
         kpR3EVmH2YQgoTaz3syhgYb7fOG5EU7KP+77YblsaXfDgo/zpuLfFGr+Em4olflplBCB
         drpoRRwFZAd45owdGvzyz/GORgOmZK5KEQMPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMU1/TQWCnMHC5lCOveXcIzdUREG8BzeB87IXaJ0KOE=;
        b=JdNwLsaUE+dlQYACl4LJhSAg97oRuz7vXxpfxrZjkmfIN8Mx+B4nRK5i3c3BIAThEp
         04bjHNUxMrxcR/GzbmN9Kk8bJ2OzpAINw/2e7x6L5VSbfsQb+3+QCK1zI9q4TdiemFUq
         RT687XMiKKHOPb3zmYRHM6BqOKBNy9pXHUctKs03nWnifad3KpynJ4+U32+ki9LbU5FY
         cEUjrKMjGcUPHahWerBKuFBZsJr7MxN0Uvq8LrPfTMbI7w1AAk3drxIF3//XgZWn9pu4
         asVf50HGJpA1u7z12V57uojQ4adrRvdXx2m/z84a00YEh+maoLF/FUtoI9Og53dhaMIw
         PN+A==
X-Gm-Message-State: AHQUAubhGPWBqvQMGUBoPIXtjVkn9PEBVQqGahqkUEe5vZDgv5BgRaqP
        72TOAOZBfaKfrFhs0EkDKOOgfNYFsf8=
X-Google-Smtp-Source: AHgI3IaSKSG+w9gbbcia/mw2Yexkr9uX+vUdUVbX+/cOhS+nXooDfWmJU3lZUDOwfLn9Oig6cn9Anw==
X-Received: by 2002:a05:6830:11cd:: with SMTP id v13mr4717559otq.157.1550026942888;
        Tue, 12 Feb 2019 19:02:22 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id p81sm2176731oia.58.2019.02.12.19.02.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 19:02:20 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id i20so1606556otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 19:02:20 -0800 (PST)
X-Received: by 2002:a9d:7e8b:: with SMTP id m11mr7286136otp.80.1550026939459;
 Tue, 12 Feb 2019 19:02:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5AcqiwAb30ajLxmj6LZoabVygUsAB8A+drpityOAvY60A@mail.gmail.com> <4a1346315224850faf31345b577ce3a29c069f3a.camel@collabora.com>
In-Reply-To: <4a1346315224850faf31345b577ce3a29c069f3a.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 13 Feb 2019 12:02:08 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DE+T6KJ0TXcQUxLSnog5enQf5G0SVM+5t6f60VjcovFw@mail.gmail.com>
Message-ID: <CAAFQd5DE+T6KJ0TXcQUxLSnog5enQf5G0SVM+5t6f60VjcovFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] media: cedrus: Add H264 decoding support
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        jenskuske@gmail.com, Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 6:22 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Hey Tomasz,
>
> On Tue, 2019-02-12 at 21:50 +0900, Tomasz Figa wrote:
> > Hi Maxime,
> >
> > On Mon, Feb 11, 2019 at 11:39 PM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > > Hi,
> > >
> > > Here is a new version of the H264 decoding support in the cedrus
> > > driver.
> >
> > Thanks for working on this. Please see my comments below.
> >
> > > As you might already know, the cedrus driver relies on the Request
> > > API, and is a reverse engineered driver for the video decoding engine
> > > found on the Allwinner SoCs.
> > >
> > > This work has been possible thanks to the work done by the people
> > > behind libvdpau-sunxi found here:
> > > https://github.com/linux-sunxi/libvdpau-sunxi/
> > >
> > > I've tested the various ABI using this gdb script:
> > > http://code.bulix.org/jl4se4-505620?raw
> > >
> > > And this test script:
> > > http://code.bulix.org/8zle4s-505623?raw
> > >
> > > The application compiled is quite trivial:
> > > http://code.bulix.org/e34zp8-505624?raw
> > >
> > > The output is:
> > > arm:    builds/arm-test-v4l2-h264-structures
> > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > > x86:    builds/x86-test-v4l2-h264-structures
> > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > > x64:    builds/x64-test-v4l2-h264-structures
> > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > > arm64:  builds/arm64-test-v4l2-h264-structures
> > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > >
> > > Let me know if there's any flaw using that test setup, or if you have
> > > any comments on the patches.
> > >
> > > Maxime
> > >
> > > Changes from v2:
> > >   - Simplified _cedrus_write_ref_list as suggested by Jernej
> > >   - Set whether the frame is used as reference using nal_ref_idc
> > >   - Respect chroma_format_idc
> > >   - Fixes for the scaling list and prediction tables
> > >   - Wrote the documentation for the flags
> > >   - Added a bunch of defines to the driver bit fields
> > >   - Reworded the controls and data format descriptions as suggested
> > >     by Hans
> > >   - Reworked the controls' structure field size to avoid padding
> > >   - Removed the long term reference flag
> >
> > This and...
> >
>
> Maxime has dropped this because of Ayaka's mail about long term references
> not making much sense in stateless decoders.

I haven't seen any argument confirming that thesis, though. I should
have kicked in earlier, sorry.

>
> I noticed that RK3399 TRM has a field to specify long term refs and
> so was wondering about this item as well.
>
> > >   - Reintroduced the neighbor info buffer
> > >   - Removed the ref_pic_list_p0/b0/b1 arrays that are redundant with the
> > >     one in the DPB
> >
> > these are used in our Rockchip VDEC driver.
> >
> > Could you elaborate on the reasons why they got removed?
> >
>
> If I understood correctly, there are two reference picture lists.
> P-frames will populate ref_pic_list0 and B-frames will populate both.
>
> According to this, v4l2_ctrl_h264_slice_param.ref_pic_list0 and .ref_pic_list1
> should be enough and ref_pic_list_p0/b0/b1 are not needed.
>
> What do you think?

The lists in v4l2_ctrl_h264_slice_param are expected to be past the
per-slice modification stage (which is quite complicated and better
done in userspace), while the ones in v4l2_ctrl_h264_decode_param just
in the original order. Rockchip VPU expects them in the original order
and does the modification in the hardware.

Best regards,
Tomasz
