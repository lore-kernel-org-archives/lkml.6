Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221202171F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546959213;
	bh=dDcLr7PFigttfu9qxS0LqYl7q6wlG7peD973QvNyd3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fn3adAfhrYsng+RSZseeFqDiOQbQ4LRDIaGLrKcVqySu4AlwMnmDtIj/N++Y5aQTg
	 dKWko0Y0WNC4wMuOUVMaM1UdwiV4BPoTm1h8VWJ+5jWU7ChLwwLOSHNaimyJ0A0+mt
	 9yguXza29RFTT1XpxoUzNVBAzJeF3RFUFvysAPCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfAHOxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:53:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfAHOxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:53:31 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B50A21019;
        Tue,  8 Jan 2019 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546959211;
        bh=dDcLr7PFigttfu9qxS0LqYl7q6wlG7peD973QvNyd3Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0aslcSEgIrTXWD0Jf+6BfY8Uw5IVTffG8q3wYlIjdy2YP54yzUHGzJ+y3zNpxtGZp
         zHIYp5y3b71eh6hdl0gObNjJADDz33Ct2NWTcRoFw6QOLst40pwcnSN4+Z9M80zruU
         +E07QYjYEKhH6T5e8um41fKaMmL30xN9XW33lSTE=
Received: by mail-qt1-f169.google.com with SMTP id k12so4607821qtf.7;
        Tue, 08 Jan 2019 06:53:31 -0800 (PST)
X-Gm-Message-State: AJcUukc3Aqbtpy3Wy1iK2grG4bnbbPlID0ob+Chldne/un24cHdO0y7U
        +NaIFgSCItP3xaEmCzTkefVD+aqAIcb6XvXVPw==
X-Google-Smtp-Source: ALg8bN5OGxu5emk9VpVjTgAoC4e6gwhWHhsD3YnTCVEEKOtdKzPp/ZPdgcSJuVjtVLcbXZzMwNYR1Pw/XH2yiZHeTms=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr1872256qtd.257.1546959210219;
 Tue, 08 Jan 2019 06:53:30 -0800 (PST)
MIME-Version: 1.0
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus> <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
 <353b8f62-e265-c3c1-e352-d33c204eb6dc@ysoft.com>
In-Reply-To: <353b8f62-e265-c3c1-e352-d33c204eb6dc@ysoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Jan 2019 08:53:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+k3BvjP=oY=yGRiHgvy+yXjnzfT6H8V9HjVGf8MOQAYA@mail.gmail.com>
Message-ID: <CAL_Jsq+k3BvjP=oY=yGRiHgvy+yXjnzfT6H8V9HjVGf8MOQAYA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa boards
To:     =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 8:25 AM Vok=C3=A1=C4=8D Michal <Michal.Vokac@ysoft.c=
om> wrote:
>
> On 8.1.2019 12:43, Vok=C3=A1=C4=8D Michal wrote:
> > On 29.12.2018 00:25, Rob Herring wrote:
> >> On Tue, Dec 18, 2018 at 02:42:11PM +0000, Vok=C3=A1=C4=8D Michal wrote=
:
> [...]
> >>> +&i2c3 {
> >>> +   clock-frequency =3D <100000>;
> >>> +   pinctrl-names =3D "default";
> >>> +   pinctrl-0 =3D <&pinctrl_i2c3>;
> >>> +   status =3D "disabled";
> >>> +
> >>> +   gpio_oled: gpio@41 {
> >>> +           compatible =3D "nxp,pca9536";
> >>> +           gpio-controller;
> >>> +           #gpio-cells =3D <2>;
> >>> +           reg =3D <0x41>;
> >>> +           vcc-supply =3D <&sw2_reg>;
> >>> +           status =3D "disabled";
> >>> +   };
> >>> +
> >>> +   oled: oled@3d {
> >>> +           compatible =3D "solomon,ssd1305fb-i2c";
> >>
> >> Not documented.
> >
> > OK, I will send a separate patch for that.
>
> Rob, I double checked that and it actually is already documented.
> Not in a way that you would find the whole compatible string though..
>
> See https://elixir.bootlin.com/linux/v5.0-rc1/source/Documentation/device=
tree/bindings/display/ssd1307fb.txt#L4
>
> Are you OK with that as it is?

Ah, okay. It's fine.

Rob
