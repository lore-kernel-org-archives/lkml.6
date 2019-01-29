Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB2D2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EDc3rw5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfA2Hvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:51:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32973 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfA2Hvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:51:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so15447276oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 23:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sg8RsoaeVSyRM13cr5tOwJLRDxxtn7MjroRD+akYFO8=;
        b=EDc3rw5RmGhwyCdR1w79Ob9Bp8OAgfX8H2Y7qobBPURN3XUJWK+gOmWJ1p2Wtl5qjk
         f+mmr6SX/2LFC/j8SpeDPn/FTZ9GKoua45nie5ASbXR99pDf+8V1bMQ2ow5TSyFLV41X
         9yKTUhQpBi+oc6nVNyshshx/POxsjJ2Zn6+sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sg8RsoaeVSyRM13cr5tOwJLRDxxtn7MjroRD+akYFO8=;
        b=N46uwlS3m8+4I4uQava28Ke0BNM12UtlvFfhagNkoncwJvwoUGBcdPvszCKYmDVP+7
         fYac2FP0rvm7FgSGjAX2rzj9hQdrvoxwdTSgABz3VEcP0rBbBSVUcI3hg3M/I0KKpQkw
         pnkLYR65s+Mk1ElY9e5ZyUx6HaGxLNBDK0d/mnGDXXdilrfZgl0f0WU5GMjRY97I8hMk
         Ll/9+QUpymF0UMBrdz4jzicddTSqU7ChTtcwfNrpeI3hrLyZaDHhOqtrzIUCigmokFDG
         9kDSka/uEbaYDG0JNo3g1pcoIL1GePdDyyZdw7ssU8JgYXiXENj9B1+7SYJlrx5hvlM2
         YnIw==
X-Gm-Message-State: AJcUukd5bKeluJwSmL9Az52AEAb9G7DvZ9xnN4tSIn+fxNBC+PKcWnHe
        Jln03suQyJ8vZDgggWyvQ/LADao4O8tmeA==
X-Google-Smtp-Source: ALg8bN62CMpYbpJXsWTa6UYV4P+fjSismosPcFD9Fbi//u8xqqfjR3mig+LLkzneVV/zLKUmnDG5Gg==
X-Received: by 2002:aca:ea57:: with SMTP id i84mr8608746oih.346.1548748301829;
        Mon, 28 Jan 2019 23:51:41 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id h64sm2362142otb.45.2019.01.28.23.51.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 23:51:41 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id n8so17091437otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 23:51:41 -0800 (PST)
X-Received: by 2002:a05:6830:14d6:: with SMTP id t22mr17871926otq.146.1548747887817;
 Mon, 28 Jan 2019 23:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20181123130209.11696-1-paul.kocialkowski@bootlin.com>
 <20181123130209.11696-2-paul.kocialkowski@bootlin.com> <5515174.7lFZcYkk85@jernej-laptop>
 <ffe9c81db34b599f675ca5bbf02de360bf0a1608.camel@bootlin.com>
 <776e63c9-d4a5-342a-e0f7-200ef144ffc4@rock-chips.com> <64c793e08d61181b78125b3956ec38623fa5d261.camel@bootlin.com>
 <D8005130-F7FD-4CBD-8396-1BB08BB08E81@soulik.info> <f982ef378a8ade075bc7077b93640e20ecebf9f4.camel@bootlin.com>
 <82FA0C3F-BC54-4D89-AECB-90D81B89B1CE@soulik.info> <c3619a00-17e7-fb92-a427-a7478b96f356@soulik.info>
 <bdf14f97e98f2fd06307545ab9038ac3c2086ae7.camel@bootlin.com>
 <42520087-4EAE-4F7F-BCA0-42E422170E91@soulik.info> <ab8ca098ad60f209fe97f79bb93b2d1e898da524.camel@bootlin.com>
In-Reply-To: <ab8ca098ad60f209fe97f79bb93b2d1e898da524.camel@bootlin.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 29 Jan 2019 16:44:35 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUJu3cX9A-E32bSSjxc1cvGP83ayzZzUxa5_QMf6niK4g@mail.gmail.com>
Message-ID: <CAPBb6MUJu3cX9A-E32bSSjxc1cvGP83ayzZzUxa5_QMf6niK4g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 1/2] media: v4l: Add definitions for the
 HEVC slice format and controls
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Ayaka <ayaka@soulik.info>, Randy Li <randy.li@rock-chips.com>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:04 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Thu, 2019-01-24 at 20:23 +0800, Ayaka wrote:
> >
> > Sent from my iPad
> >
> > > On Jan 24, 2019, at 6:27 PM, Paul Kocialkowski <paul.kocialkowski@boo=
tlin.com> wrote:
> > >
> > > Hi,
> > >
> > > > On Thu, 2019-01-10 at 21:32 +0800, ayaka wrote:
> > > > I forget a important thing, for the rkvdec and rk hevc decoder, it =
would
> > > > requests cabac table, scaling list, picture parameter set and refer=
ence
> > > > picture storing in one or various of DMA buffers. I am not talking =
about
> > > > the data been parsed, the decoder would requests a raw data.
> > > >
> > > > For the pps and rps, it is possible to reuse the slice header, just=
 let
> > > > the decoder know the offset from the bitstream bufer, I would sugge=
st to
> > > > add three properties(with sps) for them. But I think we need a meth=
od to
> > > > mark a OUTPUT side buffer for those aux data.
> > >
> > > I'm quite confused about the hardware implementation then. From what
> > > you're saying, it seems that it takes the raw bitstream elements rath=
er
> > > than parsed elements. Is it really a stateless implementation?
> > >
> > > The stateless implementation was designed with the idea that only the
> > > raw slice data should be passed in bitstream form to the decoder. For
> > > H.264, it seems that some decoders also need the slice header in raw
> > > bitstream form (because they take the full slice NAL unit), see the
> > > discussions in this thread:
> > > media: docs-rst: Document m2m stateless video decoder interface
> >
> > Stateless just mean it won=E2=80=99t track the previous result, but I d=
on=E2=80=99t
> > think you can define what a date the hardware would need. Even you
> > just build a dpb for the decoder, it is still stateless, but parsing
> > less or more data from the bitstream doesn=E2=80=99t stop a decoder bec=
ome a
> > stateless decoder.
>
> Yes fair enough, the format in which the hardware decoder takes the
> bitstream parameters does not make it stateless or stateful per-se.
> It's just that stateless decoders should have no particular reason for
> parsing the bitstream on their own since the hardware can be designed
> with registers for each relevant bitstream element to configure the
> decoding pipeline. That's how GPU-based decoder implementations are
> implemented (VAAPI/VDPAU/NVDEC, etc).
>
> So the format we have agreed on so far for the stateless interface is
> to pass parsed elements via v4l2 control structures.
>
> If the hardware can only work by parsing the bitstream itself, I'm not
> sure what the best solution would be. Reconstructing the bitstream in
> the kernel is a pretty bad option, but so is parsing in the kernel or
> having the data both in parsed and raw forms. Do you see another
> possibility?

Is reconstructing the bitstream so bad? The v4l2 controls provide a
generic interface to an encoded format which the driver needs to
convert into a sequence that the hardware can understand. Typically
this is done by populating hardware-specific structures. Can't we
consider that in this specific instance, the hardware-specific
structure just happens to be identical to the original bitstream
format?

I agree that this is not strictly optimal for that particular
hardware, but such is the cost of abstractions, and in this specific
case I don't believe the cost would be particularly high?
