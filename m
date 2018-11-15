Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5819CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297F821582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297F821582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeKOQfj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:35:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33630 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeKOQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:35:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id r27so12766090eda.0;
        Wed, 14 Nov 2018 22:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4bwTAilbi4z++fpF+JxS/KHlrzwuL6AU6WY5nQmoTz8=;
        b=V/D/yUyUNOO+lO7+L+HhHOmvp/NvUih0VvRw1EpDrFNoqa77N+WAbVNUlirdYSOYHo
         VQGe38zMAeMvNWvohrZ3aZNgfL/9Vi/2MgqBIq7ifbvlVVTXjrvR2KORm6QUqZRqNw8q
         Pc/IwVWKu4/pRYQ4OE7WfCnYtZSUoA2aslRswt5ziJIWpF7EVOISRudRTjFjtHvS486N
         fnNjSoGYln6b4fZ6HwXT/+Ad3d7NaPOqvA5KoNRYoqFIvGVVrUczxi/HbPIYByJ6k6qx
         Q1HXrKTUppIjnYny10smNVkZPPPK4Es2/BXxRMNdWpZuBgrSeNsdGAG+2DR6L2jS4sjE
         kryg==
X-Gm-Message-State: AGRZ1gLzuQ6FJ8kluzpcMnRs7W05UdO+uDzwX7GNPd7pxp9lzoN3MCMH
        osu407TERKhdZuhFbv5EhN9Mq4EQUfQ=
X-Google-Smtp-Source: AJdET5etk7yGYmin3HGv4yyiM+KN3x0bC2XOyXFAIbLJwHSFGUxnEnRIw8cU+3vLZRECYXFA7crkVQ==
X-Received: by 2002:a17:906:10c2:: with SMTP id v2-v6mr4343145ejv.40.1542263346021;
        Wed, 14 Nov 2018 22:29:06 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id b26-v6sm6772455edw.0.2018.11.14.22.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 22:29:05 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id f10-v6so17566945wme.3;
        Wed, 14 Nov 2018 22:29:05 -0800 (PST)
X-Received: by 2002:a1c:13d2:: with SMTP id 201-v6mr3952081wmt.58.1542263344873;
 Wed, 14 Nov 2018 22:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20181004122855.22981-1-icenowy@aosc.io> <20181004122855.22981-5-icenowy@aosc.io>
 <CAGb2v668dozjLm9mWUw_Y12AZ6DM2ku9dgQ8B8feABNeFf3QSw@mail.gmail.com>
 <4B5BD39B-22E2-4DEA-A199-29094DB8C317@aosc.io> <CAGb2v66Lndq1GMRDda3+2go1snGVS1fKTJTrHpP-B20FtG6VZA@mail.gmail.com>
In-Reply-To: <CAGb2v66Lndq1GMRDda3+2go1snGVS1fKTJTrHpP-B20FtG6VZA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 15 Nov 2018 14:28:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v64_=YhrDPYAoPxO4YH6OZENAM-nDDhqnCD0Fj26sKwQ7Q@mail.gmail.com>
Message-ID: <CAGb2v64_=YhrDPYAoPxO4YH6OZENAM-nDDhqnCD0Fj26sKwQ7Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 04/10] arm64: allwinner: dts: h6: add
 USB2-related device nodes
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:16 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Nov 14, 2018 at 6:31 PM Icenowy Zheng <icenowy@aosc.io> wrote:
> > 于 2018年11月14日 GMT+08:00 下午6:21:33, Chen-Yu Tsai <wens@csie.org> 写到:
> > >Hi,
> > >
> > >On Thu, Oct 4, 2018 at 8:30 PM Icenowy Zheng <icenowy@aosc.io> wrote:
> > >>
> > >> Allwinner H6 has two USB2 ports, one OTG and one host-only.
> > >>
> > >> Add device tree nodes related to them.
> > >>
> > >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > >> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > >> ---
> > >> No changes in v4.
> > >>
> > >> Changes in v3:
> > >> - Removed the wrongly introduced usb3phy node.
> > >> - Added Chen-Yu's Review tag.
> > >>
> > >>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 81
> > >++++++++++++++++++++
> > >>  1 file changed, 81 insertions(+)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > >b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > >> index 040828d2e2c0..3d60af6cb3ae 100644
> > >> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > >> @@ -258,6 +258,87 @@
> > >>                         status = "disabled";
> > >>                 };
> > >>
> > >> +               usb2otg: usb@5100000 {
> > >> +                       compatible = "allwinner,sun8i-a33-musb";
> > >
> > >I added an SoC-specific compatible: "allwinner,sun50i-h6-musb".
> > >
> > >I'm also curious as to whether the MUSB controller was tested or not,
> > >since Allwinner now has EHCI/OHCI host pairs for host mode, and the
> > >Pine H64
> > >only does host mode.
> >
> > USB plug-in detection relays on MUSB if it's enabled.
>
> That's not what I meant. Have you actually used the MUSB core in either
> device or host mode to know that it is compatible with the A33? And
> that it works correctly?
>
> IIRC ID detection is done by the PHY driver, using the GPIO lines.
> In host mode, since it's already directly routed to the host pair,
> it's the host pair that does plug-in detection. The MUSB core is
> completely unused. It should be quite clear if you look at the times
> each interrupt line fired.

I forced the routing to use MUSB and it looks like it works OK.
And the BSP figures for the number of endpoints looks correct.
I'll push the patches out. Thanks.

ChenYu
