Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710A2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D652145D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LvTpo0cU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D652145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeK1Ccz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:32:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53171 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbeK1Ccz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:32:55 -0500
Received: by mail-it1-f196.google.com with SMTP id i7so34832496iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 07:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQqn0UySG0VyTcloD3VBMyBlar7CtKy372pTNEiM0KA=;
        b=LvTpo0cUfO8QfNM7oLkS68eb+9B3No4rMfHUFzztTaYHfv4WRFP+GrOvuIqU6jUNSg
         p9YiJbxsK9Aj5npoqZrpE4d8JELmh6yawPUxb3e2keRllAAqGzMXdKrno7aupnU4Z8bV
         HRHIwhHyk1e09KpfUqpuXKOJkpBOM00hXt+MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQqn0UySG0VyTcloD3VBMyBlar7CtKy372pTNEiM0KA=;
        b=IcBctroacZgMdKT6oncWhVMtJQdp3qdroP5gTLWZ0eGbQR5MT57eYFaxk1la6q8YJB
         FkCiH0tFCV/62HMw3oAMXxBIsrvCx6o7cDwIEMlkFSeKn5CQulJnHrCUSw+9zsSV/ihz
         vWLujdNPRiKnMsUCsXlg3PnhUiJVOr8oOYw9RNEwkiUXBLUnlbqsKJaobBrkLEJRW+Xj
         RkkPJdkXGMG8fsDE0JMmhdJzD3gQ8cwHWcFckr33ahpj/ddsy60G8S/Iduh3ToEmaa5Y
         VxW9qnNS4bR84Q+CNohhnUcoPLAbNJmAt9XAPslYrwq3L+nLW80BqAxh1Jw/M0MOtPZn
         6/zg==
X-Gm-Message-State: AA+aEWbsgo71sNOmH2WCPZNYHjggm4sGxnuR4w7Bsh8eW2CuvsrYWmcz
        SppLsckPOyZM07wDkZguGPOvxiEFLUmwzGf7h7UCbA==
X-Google-Smtp-Source: AFSGD/VVyxUfO9ThPOOc5IgptgeK0X+ftqkK39liWMxC1H01IqJ49kKCTek8eXpNqeEh3AJYuAMARqVgDgkbOqK+ckc=
X-Received: by 2002:a24:10cb:: with SMTP id 194mr6364404ity.173.1543332878109;
 Tue, 27 Nov 2018 07:34:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <12093630fdd7d8b43ebcb0340691e0f2200e26c6.1542097288.git-series.maxime.ripard@bootlin.com>
 <CAMty3ZBO6B=vgduv5u28zC8P1DOm1TYGFAVjDtJOpU8dozrk=A@mail.gmail.com>
 <20181127103106.vykudp36vkyy5vme@flea> <CAMty3ZAhGAN2nEJkiRLHqFHz9Oi1WboiyqLL4ox+-0z7NhbG8w@mail.gmail.com>
 <20181127151948.gaqodlnkiuh3vkud@flea>
In-Reply-To: <20181127151948.gaqodlnkiuh3vkud@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 27 Nov 2018 21:04:25 +0530
Message-ID: <CAMty3ZC4LtAAb-09em8Cm8HTUtiK3oHvL8mynn8bhJr3Sgdvsg@mail.gmail.com>
Subject: Re: [PATCH 5/5] DO NOT MERGE: ARM: dts: bananapi: Add Camera support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        laurent.pinchart@ideasonboard.com,
        linux-media <linux-media@vger.kernel.org>, a.hajda@samsung.com,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 8:49 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Nov 27, 2018 at 04:30:55PM +0530, Jagan Teki wrote:
> > > > > +&i2c1 {
> > > > > +       pinctrl-names = "default";
> > > > > +       pinctrl-0 = <&i2c1_pins_a>;
> > > > > +       status = "okay";
> > > > > +
> > > > > +       camera: camera@21 {
> > > > > +               compatible = "ovti,ov5640";
> > > > > +               reg = <0x21>;
> > > > > +                clocks = <&ccu CLK_CSI0>;
> > > > > +                clock-names = "xclk";
> > > > > +               assigned-clocks = <&ccu CLK_CSI0>;
> > > > > +               assigned-clock-rates = <24000000>;
> > > > > +
> > > > > +                reset-gpios = <&pio 7 14 GPIO_ACTIVE_LOW>;
> > > > > +                powerdown-gpios = <&pio 7 19 GPIO_ACTIVE_HIGH>;
> > > > > +                AVDD-supply = <&reg_cam_avdd>;
> > > > > +                DOVDD-supply = <&reg_cam_dovdd>;
> > > > > +                DVDD-supply = <&reg_cam_dvdd>;
> > > > > +
> > > > > +                port {
> > > > > +                        ov5640_to_csi: endpoint {
> > > > > +                                remote-endpoint = <&csi_from_ov5640>;
> > > > > +                                bus-width = <8>;
> > > > > +                                data-shift = <2>;
> > > > > +                                hsync-active = <1>; /* Active high */
> > > > > +                                vsync-active = <0>; /* Active low */
> > > > > +                                data-active = <1>;  /* Active high */
> > > > > +                                pclk-sample = <1>;  /* Rising */
> > > > > +                        };
> > > > > +                };
> > > > > +       };
> > > >
> > > > Does ov5640 need any further patches, wrt linux-next? I'm trying to
> > > > test this on top of linux-next but the slave id seems not detecting.
> > > >
> > > > [    2.304711] ov5640 1-0021: Linked as a consumer to regulator.5
> > > > [    2.310639] ov5640 1-0021: Linked as a consumer to regulator.6
> > > > [    2.316592] ov5640 1-0021: Linked as a consumer to regulator.4
> > > > [    2.351540] ov5640 1-0021: ov5640_init_slave_id: failed with -6
> > > > [    2.357543] ov5640 1-0021: Dropping the link to regulator.5
> > > > [    2.363224] ov5640 1-0021: Dropping the link to regulator.6
> > > > [    2.368829] ov5640 1-0021: Dropping the link to regulator.4
> > > >
> > > > Here is the full log [1], please let me know if I miss anything, I
> > > > even tried to remove MCLK pin
> > >
> > > You seem to have made local modifications to your tree, what are they?
> > > This indicates that the communication over i2c doesn't work, what is
> > > your setup?
> >
> > I just used your commits on linux-next [2], with the setup similar in
> > Page 5 on datasheet[3]. The only difference is csi build issue, I have
> > updated similar fix you mentioned on sun6i_csi [4]
> >
> > [2] https://github.com/amarula/linux-amarula/commits/CSI-A20
> > [3] https://www.tme.eu/gb/Document/187887186b98a8f78b47da2774a34f4c/BPI-CAMERA.pdf
> > [4] https://github.com/amarula/linux-amarula/commit/a6762ecd38f000e2bd02dd255f6fd0c1ae755429#diff-0809a7f97ca58771c1cda186e73ec657
>
> That branch doesn't have any commit with the same ID that you have in
> your boot log.

I have created this branch for your reference, here is the clean log on this [5]

[5] https://paste.ubuntu.com/p/4bkFs5WG6c/
