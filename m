Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75FAC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F040208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqj8iPOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F040208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJPAeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbeJPAeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:34:36 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1E62064A;
        Mon, 15 Oct 2018 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539622114;
        bh=znxwo/KkYuHQ7BZTi+VB2plhm/XsXVWQ2KyC/W+QbvM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=cqj8iPOmE0KwFpKdbX+XPS0iIcDG2F7RmFYwZnmFdWHEv2canwwM0bYQk7OAqdWgW
         tfNy6Xzn3VcFhdN1j7pB1p9YDeuPrlkh/XVNdObILkeArwMQEQqxBce/C42ZypoCQ4
         YmW7nuNfDVUq6uBl1ynceoY1bGkrDANf+PyLHZ+E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Shawn Guo <shawnguo@kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <VI1PR04MB4800C0AB214B258793AF9ABAF3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "oss@buserror.net" <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Ramneek Mehresh <ramneek.mehresh@nxp.com>,
        Ying Zhang <ying.zhang22455@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-6-git-send-email-vabhav.sharma@nxp.com>
 <20181008054510.GG3587@dragon>
 <VI1PR04MB4800C0AB214B258793AF9ABAF3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
Message-ID: <153962211360.5275.18031876744546062419@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH v4 5/6] arm64: dts: add QorIQ LX2160A SoC support
Date:   Mon, 15 Oct 2018 09:48:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vabhav Sharma (2018-10-14 19:58:15)
> > > +
> > > +   pmu {
> > > +           compatible =3D "arm,cortex-a72-pmu";
> > > +           interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > > +   };
> > > +
> > > +   psci {
> > > +           compatible =3D "arm,psci-0.2";
> > > +           method =3D "smc";
> > > +   };
> > > +
> > > +   memory@80000000 {
> > > +           // DRAM space - 1, size : 2 GB DRAM
> > > +           device_type =3D "memory";
> > > +           reg =3D <0x00000000 0x80000000 0 0x80000000>;
> > > +   };
> > > +
> > > +   ddr1: memory-controller@1080000 {
> > > +           compatible =3D "fsl,qoriq-memory-controller";
> > > +           reg =3D <0x0 0x1080000 0x0 0x1000>;
> > > +           interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > > +           little-endian;
> > > +   };
> > > +
> > > +   ddr2: memory-controller@1090000 {
> > > +           compatible =3D "fsl,qoriq-memory-controller";
> > > +           reg =3D <0x0 0x1090000 0x0 0x1000>;
> > > +           interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> > > +           little-endian;
> > > +   };
> > > +
> > > +   sysclk: sysclk {
> > =

> > Name the node a bit generic like clock-xxx.
> There is only one clock-unit, Bootloader(U-boot) require sysclk node duri=
ng device tree fix-up as different platform support varied platform frequen=
cy as per reset configuration word used.
> Referred other ARM based platform with one clock using name as x: x

Please add a comment above this node with this information. Newcomers
reading this DTS file won't have any idea why this node is specially
named and a comment will help tremendously here.

