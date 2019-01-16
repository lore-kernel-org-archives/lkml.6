Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC6BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210A6206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRfvauWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbfAPWuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:50:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41788 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbfAPWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:50:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so3468542pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=9Lb0grlbl7cvJ5nYx2PBr/3Bkyw9sYbmHUIbh2yCnZE=;
        b=LRfvauWlMydpuDvxpnmc5U61tscpH+OQV13gJLnhkomnsJXm2MdCGFewORgWwdGT2+
         VsTtWAHwJ+ERQPYAJpttV6t8aiGOv7Cb1XR4F77ILh2ag8ZelPQ7Qjcemkp4JRtHjjmI
         XxC+7easpXZH+dY8l1k4nDWGEilG9lOBodx5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=9Lb0grlbl7cvJ5nYx2PBr/3Bkyw9sYbmHUIbh2yCnZE=;
        b=dOSbQ2AqkRyFNMAIwDU5DKSvQ9vtx6eeg320J20ckTdvBeO+drvrHZZ2ZTUBczUawT
         jmIIe/qPl39abRmnfCPOdSf0f1oUZ1bJ7lBOgNujceerwqPRrJUC+9lOj7K9+h5Y4Yir
         /mfBo6noNDasZZnDDhIFU7KlU0LXhG89k9ojv3Bl1VsvBBhLnQE3GDJWbhXNJn7NTHcl
         XgHhn6SaOGWnpn1VCCqQHRbbAKeEFVa9PszlGJ/2Q6sgsVM9m+hOgPxAz/FnjA5Vdzxa
         I8KRjyVCkOMgNWKIYZaJLWTb6wbURAfH8cMGVnpegJ+uffLHCqDZSuygxOC+T/cPzugZ
         EGEQ==
X-Gm-Message-State: AJcUukdl/Gxn40cwiFLbuZMBiD11Aq/4xRGwPfIrAhMyP8o4l/YlYPti
        n0E6UC1hEZs5SwrZ5OMWo+7CtA==
X-Google-Smtp-Source: ALg8bN4YiQXKQSqMHjDJtYjrDHV7WgTzaFaufXHgHUB4ERg16FT6yz+NGUaAxX0EcJnTJPx8zybJrA==
X-Received: by 2002:a62:670f:: with SMTP id b15mr12210772pfc.212.1547678999988;
        Wed, 16 Jan 2019 14:49:59 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l22sm11558682pfj.179.2019.01.16.14.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 14:49:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] arm64: dts: qcom: sdm845: Expand soc bus address range
User-Agent: alot/0.8
In-Reply-To: <20190116221003.GW9278@minitux>
References: <20190116071939.23136-1-bjorn.andersson@linaro.org> <154767410807.169631.11634052870112778681@swboyd.mtv.corp.google.com> <20190116221003.GW9278@minitux>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Message-ID: <154767899836.169631.10485468432153568181@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Wed, 16 Jan 2019 14:49:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-16 14:10:03)
> On Wed 16 Jan 13:28 PST 2019, Stephen Boyd wrote:
>=20
> > Quoting Bjorn Andersson (2019-01-15 23:19:39)
> > > DMA addresses for devices on the soc bus must be constrained to the 36
> > > address bits that the bus provides.  When no IOMMU is present then th=
is
> > > is easy--DMA addresses are just physical addresses and physical
> > > addresses are (by definition) within the address bits of the bus.  Wh=
en
> > > an IOMMU is present, however, DMA addresses are virtual addresses.
> > > Despite these addresses being virtual, however, they are still
> > > constrained by the 36 address bits of the bus.
> > >=20
> > > Unless dma-ranges is specified, which causes bus_dma_mask to be set, =
DMA
> > > allocations for devices on the platform_bus will use all 48 address b=
its
> > > available by the ARM SMMU. Causing addresses to be truncated on the b=
us.
> >=20
> > I read it three times and still got confused by the statement that DMA
> > addresses are virtual addresses. There are CPU virtual addresses, DMA
> > addresses, IOVAs, and physical addresses. Stating that DMA addresses are
> > virtual addresses makes it sound like we're talking about CPU virtual
> > addresses.
> >=20
>=20
> The addresses used behind the TBU are virtual and are referred to that
> in the context of the SMMU. But I guess we can use one of the other
> names for it, to distinguish it from the virtual addresses we normally
> refer to my that name.
>=20
> And you do it yourself in the first sentence below ;)

Sure. I'm mostly asking for explicitly stating these aren't CPU virtual
addresses we're talking about here.

>=20
>=20
> I'll grab a new cup of coffee and see what I can do to update this
> section again...
>=20
> > Maybe it would be clearer if it stated that DMA addresses are 1:1 with
> > IOVAs (IO virtual addresses) when a device has an iommus property and
> > 1:1 with physical addresses when that property is absent? When devices
> > use an iommus property the DMA addresses that are generated in the
> > absence of a dma-ranges property can have as many as 48 bits, as opposed
> > to the default of 32 bits in the absence of an iommus property.
> > Therefore we need to constrain the DMA addresses that devices which
> > reside in the SoC node (including the SMMU) can use to be at most 36
> > bits because that's the largest physical address the internal bus
> > supports. This expands the size of DMA addresses that devices without an
> > iommus property can use while also limiting the size that devices using
> > SMMU can use.
> >=20
>=20
> For devices not attached to the SMMU allocations are done from System
> RAM, so afaict that means we use 33 address bits. So let's stick to some
> form of "IOVA are physical addresses".

Ok, sounds good.

>=20
> > >=20
> > > This patch increases the #size-cells to 2, in order to be able to def=
ine
> > > dma-ranges describe the 36 bit DMA capability of the bus, and bumps
> >=20
> > Did the commit text get cut off here?
> >=20
>=20
> Looks like it, sorry about that.
>=20
> > >=20
> > > While touching all reg properties, addresses are padded to 8 digits.
> > >=20
> >=20
> > I liked the paint the way it was without the padding. It matched the
> > unit address that way and didn't make anyone think they should pad that
> > out in the node name with leading zeros so that 'reg' and unit address
> > match.
> >=20
>=20
> I agree with aesthetic aspect of this, but it does make sorting the
> nodes faster - and I merely introduce what was already decided upon.

Hmph ok. I don't see how it makes sorting faster but alright.

>=20
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/d=
ts/qcom/sdm845.dtsi
> > > index c98b1937353b..fc01b1c93fe4 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -346,14 +346,15 @@
> > >         };
> > > =20
> > >         soc: soc {
> > > -               #address-cells =3D <1>;
> > > -               #size-cells =3D <1>;
> > > -               ranges =3D <0 0 0 0xffffffff>;
> > > +               #address-cells =3D <2>;
> > > +               #size-cells =3D <2>;
> >=20
> > Do we need #size-cells =3D <2>? Maybe it could be #size-cells =3D <1> a=
nd we
> > can avoid having to specify a second size entry that's always going to
> > be 0 because we don't have devices with huge IO regions in the SoC. Or
> > does it need to be 2 for the large size of the size element of
> > dma-ranges and ranges here? Looking at the code I think we can rely on
> > the size-cells of the parent node so I think it will work with size of 1
> > here.
> >=20
>=20
> The "length" part of dma-ranges is described using #size-cells number of
> cells, so with 1 there's no way we can describe this being 36 bits.

Yes, but doesn't the #size-cells of the parent node (i.e. root node in
this case) dictate the number of cells of the "length" part of the
dma-ranges property here? I hope that we don't need to push down the
larger size of 2 just for this reason, but I admit I haven't run the
code to understand this all properly.

>=20
> As all hardware resides within the first 31 bits we could have stayed
> with #address-cells =3D <1>, but that looks odd.
>=20
> > > +               ranges =3D <0 0 0 0 0x10 0>;
> > > +               dma-ranges =3D <0 0 0 0 0x10 0>;
> > >                 compatible =3D "simple-bus";
> >=20
> > It might also be a good idea to split the patch into two. The first
> > patch would expand the reg properties and the second one would do the
> > 0x10 change and add dma-ranges. Then if anything goes wrong with the
> > second patch a quick revert is easier and smaller vs. the obviously good
> > reg property expanding patch that should be a no-op.
> >=20
>=20
> A revert of the dma-ranges comes with the result of all devices with an
> iommu specified stops working, so the benefit would be to be able to
> revert from a state that works in my testing to a state of e.g. not
> working at all.
>=20
> But splitting of the two concerns might bring clarity to the commit
> message.

Agreed the state may be broken still, but at least the amount of diff is
minimized so it would be easier to perform a revert if necessary.

>=20
> [..]
> > >                 timer@17c90000 {
> > > -                       #address-cells =3D <1>;
> > > -                       #size-cells =3D <1>;
> > > +                       #address-cells =3D <2>;
> > > +                       #size-cells =3D <2>;
> > >                         ranges;
> >=20
> > These could be written with ranges to remap the child nodes into the
> > address space of the parent. It would be nice to not change these
> > wrapper nodes and reduce the diff in this patch by using different
> > ranges properties.
> >=20
>=20
> Do you mean to use ranges to map them down to 32-bits, or do you mean to
> map them relative to the APPS_HM block?
>=20
> If you mean the prior, I think the benefit of using the same addressing
> format for all devices on the "platform bus" out weights the hassle of
> changing these few lines.

It's the prior.

