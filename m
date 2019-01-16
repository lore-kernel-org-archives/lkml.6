Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99444C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5710420840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XclubeIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfAPT3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:29:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36669 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730883AbfAPT3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:29:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so3489335plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-id;
        bh=RAu4eV14vLpBzsP4krmBFF9G7i8PwwT0ayyHlmOy1Qs=;
        b=XclubeIf0BYCHxHW05MV1PSQGGKDfXajfK31ePm4QgvbkLVKjfzuLNdRnMwO6Nxc6J
         XaxQPJV6WTEXrSytV2VsK5wYKM+t7QFFtqDrlS7JatP6n8M9l9tgJtX+lrUsssrX0agp
         P2OJFWJsuZDnFOLPVMR4zNhni12CoI3973FxWGBFrQqshcVBuU+zFQITF2oH0sSAnjgO
         XBfvwrivvFr2TVxZvxR5O/zjCoWHwlfRTVMhP+XDaH45vQtxsuKA0NtQz2ZeZuYZBV0/
         pbFmqWAR4AwZn1DflrKwrMcsTyS/kLeeoIGIukUMbwr1OdE6T7GvSFo2KBXyjePufyPX
         rmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-id;
        bh=RAu4eV14vLpBzsP4krmBFF9G7i8PwwT0ayyHlmOy1Qs=;
        b=MgVIW2us37vBbh74RkXUC2PdL/lvgHJ0Apy/Z4SbGoQO9+dSuVKVhnks0huikTA1Vj
         KiOjGqvva/tj9FYGToKgTze//Q9+IPKeeCi0sYPQXIxQp6kpONNuwzu5TBDuLOwdIORi
         LzTIZRX/35GzW5pKwPoJMw/sSs3atqOz47FPRx4IVCZwQGsuOabhkO1w3xkc5lRji21T
         OzADIG4anRjHdYBBOq4qY+M5UiRIiWbIEpKmLVlhS3aE1r3JOxdc0j2aZHCIMMtjd/M1
         jhHu57tbvFGSGzNlLzo4CrEUPgQznuIwZkXNd65txzZ1OHv9S+RLhtOj5fR6FbZNqb4p
         Zb1w==
X-Gm-Message-State: AJcUukc/MxXA09DU5dM5CeE9WDzNpygYdyTs0GaB3kAGCMn9luCTPLNP
        3FZsC120zY8SBF2KKfmQTn8OYA==
X-Google-Smtp-Source: ALg8bN5Py2xaAdyugqsxBRY2PE9rGGBIL5NC+1fpGvkAc/eFjdcHpK/tKf5hr+LpPIT0l1KZDfKtWw==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr11328254pln.324.1547666977478;
        Wed, 16 Jan 2019 11:29:37 -0800 (PST)
Received: from localhost ([2607:f598:b382:d300::14ef])
        by smtp.gmail.com with ESMTPSA id q5sm10990596pfi.165.2019.01.16.11.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:29:36 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Wed, 16 Jan 2019 11:29:35 -0800 (PST)
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
In-Reply-To: <20190116172849.h5qdfa5wc3vaprbn@pengutronix.de>
Message-ID: <alpine.DEB.2.21.9999.1901161015400.19681@viisi.sifive.com>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com> <1547194964-16718-3-git-send-email-yash.shah@sifive.com> <20190115220046.etgbno6ymsux75dk@pengutronix.de> <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de> <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com> <20190116172849.h5qdfa5wc3vaprbn@pengutronix.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-266195263-1547665898=:19681"
Content-ID: <alpine.DEB.2.21.9999.1901161115270.19681@viisi.sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-266195263-1547665898=:19681
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.21.9999.1901161115271.19681@viisi.sifive.com>



On Wed, 16 Jan 2019, Uwe Kleine-K=F6nig wrote:

> On Wed, Jan 16, 2019 at 09:18:45AM -0800, Paul Walmsley wrote:
> > On Wed, 16 Jan 2019, Uwe Kleine-K=F6nig wrote:
> >=20
> > > On Wed, Jan 16, 2019 at 04:40:42PM +0530, Yash Shah wrote:
> > > > On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-K=F6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > > > index a8f47df..3bcaf6a 100644
> > > > > > --- a/drivers/pwm/Kconfig
> > > > > > +++ b/drivers/pwm/Kconfig
> > > > > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > > > > >         To compile this driver as a module, choose M here: the =
module
> > > > > >         will be called pwm-samsung.
> > > > > >
> > > > > > +config PWM_SIFIVE
> > > > > > +     tristate "SiFive PWM support"
> > > > > > +     depends on OF
> > > > > > +     depends on COMMON_CLK
> > > > >
> > > > > I'd say add:
> > > > >
> > > > >         depends on MACH_SIFIVE || COMPILE_TEST
> > > > >
> > > > > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean=
=2E)
> > > >=20
> > > > As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
> > > > @Paul, Do you have any comments on this?
> > >=20
> > > If this is not going to be available at least protect it by
> > >=20
> > > =09depends RISCV || COMPILE_TEST
> >=20
> > There's nothing RISC-V or SiFive SoC-specific about this driver or IP=
=20
> > block.  The HDL for this IP block is open-source and posted on Github. =
=20
> > The IP block and driver would work unchanged on an ARM or MIPS SoC, and=
 in=20
> > fact, SiFive does design ARM-based SoCs as well.  Likewise, any other S=
oC=20
> > vendor could take the HDL for this IP block from the git tree and=20
> > implement it on their own SoC.
> >=20
> > More generally: it's a basic principle of Linux device drivers that the=
y=20
> > should be buildable for any architecture.  The idea here is to prevent=
=20
> > developers from burying architecture or SoC-specific hacks into the=20
> > driver.  So there shouldn't be any architecture or SoC-specific code in=
=20
> > any device driver, unless it's abstracted in some way - ideally through=
 a=20
> > common framework.
> >=20
> > So from this point of view, neither "depends MACH_SIFIVE" nor "depends=
=20
> > RISCV" would be appropriate.  Similarly, the equivalents for other=20
> > architectures (e.g. "ARCH_ARM") or SoC manufacturers (e.g.,=20
> > "MACH_SAMSUNG") wouldn't be appropriate for any generic IP block device=
=20
> > driver like this one.
>=20
> The dependency serves two purposes:
>=20
>  a) ensure that the build requirements are fulfilled.
>  b) restrict configuration to actually existing machines
>=20
> When considering b) it doesn't make sense to enable the driver for (say)
> a machine that is powered by an ARM SoC by TI. If you still want to
> compile test the sifive driver for ARM, enable COMPILE_TEST. That's what
> this symbol is there for.

COMPILE_TEST made slightly more sense before the broad availability of=20
open-source soft cores, SoC integration, and IP; and before powerful,=20
inexpensive FPGAs and SoCs with FPGA fabrics were common.

Even back then, COMPILE_TEST was starting to look questionable.  IP blocks=
=20
from CPU- and SoC vendor-independent libraries, like DesignWare and the=20
Cadence IP libraries, were integrated on SoCs across varying CPU=20
architectures.  (Fortunately, looking at the tree, subsystem maintainers=20
with DesignWare drivers seem to have largely avoided adding architecture=20
or SoC-specific Kconfig restrictions there - and thus have also avoided=20
the need for COMPILE_TEST.)  If an unnecessary architecture Kconfig=20
dependency was added for a leaf driver, that Kconfig line would either=20
need to be patched out by hand, or if present, COMPILE_TEST would need to=
=20
be enabled.

This was less of a problem then.  There were very few FPGA Linux users,=20
and they were mostly working on internal proprietary projects. FPGAs that=
=20
could run Linux at a reasonable speed, including MMUs and FPUs, were=20
expensive or were missing good tool support.  So most FPGA Linux=20
development was restricted to ASIC vendors - the Samsungs, Qualcomms,=20
NVIDIAs of the world - for prototyping, and those FPGA platforms never=20
made it outside those companies.

The situation is different now.  The major FPGA vendors have inexpensive=20
FPGA SoCs with full-featured CPU hard macros.  The development boards can=
=20
be quite affordable (< USD 300 for the Xilinx Ultra96).  There are also=20
now open-source SoC HDL implementations - including MMUs, FPUs, and=20
peripherals like PWM and UART - for the conventional FPGA market.  These=20
can run at mid-1990's clock rates - slow by modern standards but still=20
quite usable.

So or vendor-specific IP blocks that are unlikely to ever be reused by=20
anyone else, like the NVIDIA or TI PWM blocks, maybe there's still some=20
justification for COMPILE_TEST.  But for drivers for open-source,=20
SoC-independent peripheral IP blocks - or even for proprietary IP blocks=20
from library vendors like Synopsys or Cadence - like this PWM driver, we=20
shouldn't add unnecessary architecture, SoC vendor, or COMPILE_TEST=20
Kconfig dependencies.  They will just force users to patch the kernel or=20
enable COMPILE_TEST for kernels that are actually meant to run on real=20
hardware.


- Paul

--8323329-266195263-1547665898=:19681--
